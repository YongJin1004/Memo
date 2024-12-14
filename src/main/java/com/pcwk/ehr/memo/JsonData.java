package com.pcwk.ehr.memo;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

public class JsonData {
    public static void main(String[] args) {
        String jsonFile = "C:\\Users\\한용진\\Desktop\\서울시 병의원 위치 정보.json";

        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:XE";
        String dbUser = "scott";
        String dbPassword = "pcwk";

        String insertSQL = "INSERT INTO HOSPITAL_INFO (HOSPITAL_ID, DUTYADDR, DUTYDIVNAM, DUTYETC, DUTYNAME, DUTYMAPIMG, DUTYTEL1, " +
                "WGS84LON, WGS84LAT, DUTYTIME_MON, DUTYTIME_TUE, DUTYTIME_WED, DUTYTIME_THU, DUTYTIME_FRI, DUTYTIME_SAT, DUTYTIME_SUN, DUTYTIME_HOL) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(new File(jsonFile));


            JsonNode dataNode = rootNode.get("DATA");
            if (dataNode == null || !dataNode.isArray()) {
                throw new IllegalArgumentException("What the fuck");
            }

            List<Map<String, Object>> dataList = objectMapper.convertValue(dataNode, new TypeReference<List<Map<String, Object>>>() {});


            try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
                for (Map<String, Object> record : dataList) {
                    String dutyDiv = (String) record.get("dutydiv");
                    if ("B".equals(dutyDiv)) {
                        System.out.println("B 버릴꺼다: " + record.get("dutyname"));
                        continue;
                    }

                    String hospitalId = getStringOrDefault(record, "hpid", "UNKNOWN");
                    String dutyAddr = getStringOrDefault(record, "dutyaddr", "N/A");
                    String dutyDivNam = getStringOrDefault(record, "dutydivnam", "N/A");
                    String dutyEtc = getStringOrDefault(record, "dutyetc", "N/A");
                    String dutyName = getStringOrDefault(record, "dutyname", "N/A");
                    String dutyMapImg = getStringOrDefault(record, "dutymapimg", "N/A");
                    String dutyTel1 = getStringOrDefault(record, "dutytel1", "N/A");
                    Double wgs84Lon = getDoubleOrDefault(record, "wgs84lon", 0.0);
                    Double wgs84Lat = getDoubleOrDefault(record, "wgs84lat", 0.0);

                    //요일
                    String dutyTimeMon = getDutyTime(record, "dutytime1s", "dutytime1c");
                    String dutyTimeTue = getDutyTime(record, "dutytime2s", "dutytime2c");
                    String dutyTimeWed = getDutyTime(record, "dutytime3s", "dutytime3c");
                    String dutyTimeThu = getDutyTime(record, "dutytime4s", "dutytime4c");
                    String dutyTimeFri = getDutyTime(record, "dutytime5s", "dutytime5c");
                    String dutyTimeSat = getDutyTime(record, "dutytime6s", "dutytime6c");
                    String dutyTimeSun = getDutyTime(record, "dutytime7s", "dutytime7c");
                    String dutyTimeHol = getDutyTime(record, "dutytime8s", "dutytime8c");


                    preparedStatement.setString(1, hospitalId);
                    preparedStatement.setString(2, dutyAddr);
                    preparedStatement.setString(3, dutyDivNam);
                    preparedStatement.setString(4, dutyEtc);
                    preparedStatement.setString(5, dutyName);
                    preparedStatement.setString(6, dutyMapImg);
                    preparedStatement.setString(7, dutyTel1);
                    preparedStatement.setDouble(8, wgs84Lon);
                    preparedStatement.setDouble(9, wgs84Lat);
                    preparedStatement.setString(10, dutyTimeMon);
                    preparedStatement.setString(11, dutyTimeTue);
                    preparedStatement.setString(12, dutyTimeWed);
                    preparedStatement.setString(13, dutyTimeThu);
                    preparedStatement.setString(14, dutyTimeFri);
                    preparedStatement.setString(15, dutyTimeSat);
                    preparedStatement.setString(16, dutyTimeSun);
                    preparedStatement.setString(17, dutyTimeHol);

                    preparedStatement.executeUpdate();
                    System.out.println("삽입 성공: " + dutyName);
                }
            }
            System.out.println("^_^");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static String getStringOrDefault(Map<String, Object> record, String key, String defaultValue) {
        return record.get(key) != null ? record.get(key).toString() : defaultValue;
    }

    private static Double getDoubleOrDefault(Map<String, Object> record, String key, Double defaultValue) {
        try {
            return record.get(key) != null ? Double.parseDouble(record.get(key).toString()) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private static String getDutyTime(Map<String, Object> record, String startKey, String endKey) {
        String startTime = record.get(startKey) != null ? record.get(startKey).toString() : "N/A";
        String endTime = record.get(endKey) != null ? record.get(endKey).toString() : "N/A";
        return startTime + "-" + endTime;
    }
}




