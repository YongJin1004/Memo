<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.cmn.SearchVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int bottomCount = 10;
int pageSize = 10;
int pageNo = 1;

int maxNum = Integer.parseInt(request.getAttribute("totalCnt").toString());//총 글수
//out.print("****:"+maxNum);

SearchVO paramVO = (SearchVO) request.getAttribute("search");
pageSize = paramVO.getPageSize();
pageNo = paramVO.getPageNo();


String cp = request.getContextPath();
String pageHtml = StringUtil.renderingPager(maxNum, pageNo, pageSize, bottomCount, cp+"/hospital/hospital/list", "pageDoRetrieve");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>병원 목록</title>
<!-- <link rel ="stylesheet" href="/ehr/resources/assets/css/list.css"> -->
<script src="/ehr/resources/assets/js/hospital/hospital_list.js"></script>
<script src="/ehr/resources/assets/js/jquery_3_7_1.js"></script>
<style>
    @media screen and (min-width: 1200px) and (max-width: 1200px){
  .body{
      margin: 0px;
      display: block;
  }
  }

  header{
  height: 100px;
  padding: 0 30px;    
  display: flex;
  align-items: center
  }

  .banner,header {  
  background: darkkhaki;
  }

  .banner{
  position: relative;
  height: 3px;
  }

  .banner .option{
  background: white;
  position: absolute;
  width: calc(100% - 60px);
  bottom : -50px;
  left: 0;
  right: 0;
  margin: auto;
  border-radius: 20px;
  box-shadow: 0 3px 7.8px .2px hsla(0, 0%, 66.7%, .3);
  padding: 25px 30px;
  z-index: 2;
  }

  .banner .option .select {
  padding: 15px 29px;
  border-radius: 25px;
  border: 1px solid #888;
  background: #fff;
  float: left;
  font-size: 15px;
  color: #444;
  text-align: center;
  margin-left: 30px;
  cursor: pointer;
  }

  .banner .option .select:first-child {
  margin-left: 0
  }

  .banner .option .select.active {  
  background: #fcf16a;
  border-color: #fcf16a;
  position: relative;
  padding-right: 50px;
  pointer-events: none
  }

  .banner .option .select .close_btn {
  display: none
  }

  .banner .option .select.active .close_btn {
  display: inline-block;
  position: absolute;
  background: #fff;
  border-radius: 100%;
  width: 22px;
  height: 22px;
  line-height: 22px;
  font-size: 12px;
  top: 0;
  bottom: 0;
  margin: auto;
  font-weight: 700;
  right: 15px;
  pointer-events: all
  }

  .list_wrap{
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: flex-start; 
  padding: 0 30px;
  height: calc(100vh - 103px);
  }

  .list_wrap>.left_content {
  width: 50%;
  margin-right: 0px;
  height: 100%;
  overflow-y: auto;
  }

  .list_wrap> .right_content {
  width: 50%;
  height: 100%;
  }

/*   .list_wrap .right_content .map {
  width: 100%;
  height: 100%;
  position: sticky;
  top: 0;
  background-position: 50%;  
  background-size: cover;
  overflow: hidden;
  } */

  /* left-content 병원 div */

  .hospital-card {
    width: 100%; 
    height: 290px; 
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 20px;
    margin-left: auto;
    margin-right: auto;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    font-family: Arial, sans-serif;
    overflow: hidden; 
}

.hospital-header {
  display: flex;
  align-items: center;
}

.hospital-name {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 5px;
}

.hospital-departments {
  font-size: 12px;
  color: #555;
}

.hospital-details {
  margin-top: 10px;
  font-size: 12px;
  color: #333;
}

.hospital-address {
  margin-bottom: 5px;
}

.hospital-distance {
  margin-bottom: 5px;
  font-size: 12px;
  color: #444;
}

.hospital-actions {
  display: flex;
  gap: 10px;
}

.action-button {
  flex: 1;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  font-size: 14px;
  cursor: pointer;
}

.yellow-button {
  background-color: #fcf16a;
  color: #333;
  font-weight: bold;
}
</style>
</head>
<body>
<header>
    헤더
</header>
  
<div class="container">
    <div class="banner">
<!--         <div class="option">
            <div class="select">
                진료과
                <span class="close_btn">X</span>  
            </div>
            <div class="select">
                진료과
                <span class="close_btn">X</span>
            </div>
            <div class="select">
                진료과  
                <span class="close_btn">X</span>
            </div>
            <div class="select">
                진료과
                <span class="close_btn">X</span>
            </div>
        </div> -->
    </div>

    <div class="list_wrap">
        <form action="#" name="form" id="form" method="get">
          <input type="hidden" name="pageNo" id="pageNo">
            <div class="left_content">
	            <c:forEach var="hospital" items="${list }" >
	                <div class="hosptial-card">
	                    <div class="hospital-header">
	                        <div class="hospital-info">
	                            <h3 class="hospital-name">${hospital.hospital_name}</h3>
	                            <p class="hospital-departments">${hospital.hospital_div}</p>
	                        </div>
	                    </div>
	                    <div class="hospital-details">
	                        <p class="hospital-address">${hospital.hospital_addr}</p>
	                        <p class="hospital-distance">${hospital.hospital_mapimg}</p>
	                        <p class="hospital-distance">${hosptial.hospital_etc}</p>
	                        <p class="hospital-distance">${hosptial.hospital_tel}</p>
	                    </div>
	                    <div class="hospital-actions">
	                        <button class="action-button yellow-button">검진 예약하기</button>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </form>
        <div class="right-content">
            <div class="map" id="map" style="width: 100%; height: 100%;">
                <!-- 카카오맵 키 -->
                <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db6b66ee32de5c188c171ffea6d8fe47"></script>
                <script>
                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = { 
                        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                        level: 6 // 지도의 확대 레벨
                    };
                
                    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
                    
                    // 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
                    var points = [
                        new kakao.maps.LatLng(33.452278, 126.567803),
                        new kakao.maps.LatLng(33.452671, 126.574792),
                        new kakao.maps.LatLng(33.451744, 126.572441)
                    ];
                
                    // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
                    var bounds = new kakao.maps.LatLngBounds();    
                
                    var i, marker;
                    for (i = 0; i < points.length; i++) {
                        // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
                        marker =     new kakao.maps.Marker({ position : points[i] });
                        marker.setMap(map);
                        
                        // LatLngBounds 객체에 좌표를 추가합니다
                        bounds.extend(points[i]);
                    }
                
                    function setBounds() {
                        // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
                        // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
                        map.setBounds(bounds);
                    }
                </script>
            </div>
        </div>
    </div>
</div>


</body>
</html>