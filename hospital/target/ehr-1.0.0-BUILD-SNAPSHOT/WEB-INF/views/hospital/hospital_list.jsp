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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db6b66ee32de5c188c171ffea6d8fe47"></script>
<style>

  .left_content {
    width: 49%;
  }

  .right_content {
    width: 49%;
  }


  /* left-content 병원 div */
  .hospital-card {
    width: 100%;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    font-family: Arial, sans-serif;
    overflow: hidden;
    margin-bottom: 10px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 25px 0;
}

.hospital-card > div {
    margin: 0 20px;
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
  
.action-button {
  flex: 1;
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  font-size: 14px;
  cursor: pointer;
  width: 50%;
  float: right;
}

.yellow-button {
  background-color: #fcf16a;
  color: #333;
  font-weight: bold;
}

.form_wrap {
  display: flex;
  gap: 1rem;
  width: 100%;
  flex-wrap: nowrap;
}

.reset-button {
  position: absolute;
    top: 7%;
    left: 56%;
    transform: translateX(-50%);
    z-index: 10;
    background-color: #ffffff;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 10px 20px;
    font-size: 14px;
    color: #333;
    cursor: pointer;
    transition: all 0.3s ease;
}

</style>
</head>
<body>
 
<header>  
    헤더
</header>
  
<div class="container">
    <div class="banner">
          <label for="gu">구 선택:</label>
          <select name="gu" id="gu">
              <option value="">-- 구를 선택하세요 --</option> 
              <c:forEach var="hospital" items="${guList}">
                <option value="${hospital.hospital_gu}">${hospital.hospital_gu}</option> 
              </c:forEach>
          </select>
          
          <label for="hospitalDiv">병원 종류:</label>
          <select name="hospitalDiv" id="hospitalDiv">
              <option value="">-- 병원종류를 선택하세요 --</option>
              <c:forEach var="hospital" items="${hospitalDivList}">
                <option value="${hospital.hospital_div}">${hospital.hospital_div}</option>
              </c:forEach>
          </select>

          <button type="submit" onclick="findGuAndDiv()">검색</button>
    </div>

    <div class="list_wrap">
        <form action="#" class="form_wrap" name="form" id="form" method="get" enctype="application/x-www-form-urlencoded" >
            <div class="left_content">
                <c:forEach var="hospital" items="${list}" >
                    <div class="hospital-card" data-id="${hospital.hospital_id}">
                        <div class="hospital-header">
                            <div class="hospital-info">
                                <h3 class="hospital-name">${hospital.hospital_name}</h3>
                                <p class="hospital-departments">${hospital.hospital_div}</p>
                            </div>
                         </div>
                        <div class="hospital-details">
                            <p class="hospital-address">${hospital.hospital_addr}</p>
                            <p class="hospital-distance">${hospital.hospital_mapimg}</p>
                            <p class="hospital-distance">${hospital.hospital_etc}</p>
                            <p class="hospital-distance">${hospital.hospital_tel}</p>
                        </div>
                        <div class="hospital-actions">
                            <button class="action-button yellow-button">검진 예약하기</button>
                        </div>
                    </div>
                </c:forEach>
                <%
                out.print(pageHtml);
                %>
            </div>
            <div class="right_content">
              <div id="map" style="width: 100%; height: 100vh; position: sticky; top: 0; z-index: 1;"></div>
              <p>
                <button class="reset-button" onclick="setBounds()" >지도 범위 재설정 하기</button> 
              </p>
          </div>
          <input type="hidden" name="pageNo" id="pageNo" value="${search.pageNo}">
          <input type="hidden" name="pageSize" id="pageSize" value="${search.pageSize}">
        </form>
  
   
    </div>
    <div class="footer">footer</div>

</div>

<script>
  var mapContainer = document.getElementById('map');
  var mapOption = {
      center: new kakao.maps.LatLng(37.5665, 126.9780), 
      level: 6, // 지도 확대 레벨
      draggable: false
  };  

  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
    
  var hospitalData = [];  
  <c:forEach var="hospital" items="${list}">
      hospitalData.push({
          id: '${hospital.hospital_id}',
          name: '${hospital.hospital_name}',
          address: '${hospital.hospital_addr}',
          tel: '${hospital.hospital_tel}',
          lat: ${hospital.hospital_lat},  
          lon: ${hospital.hospital_lon}  
      });
  </c:forEach>  
  
  var selectedMarker = null;
  var bounds = new kakao.maps.LatLngBounds();
  var icon = new kakao.maps.MarkerImage(
    '/ehr/resources/assets/image/kakaomapiconblue.png',
    new kakao.maps.Size(35, 35)  
  )  
  
  var changeIcon = new kakao.maps.MarkerImage(
    '/ehr/resources/assets/image/kakaomapiconred.png',
    new kakao.maps.Size(35, 35)
  )      

  const markers = new Map();  

  hospitalData.forEach(function(hospital){
    var markerPosition = new kakao.maps.LatLng(hospital.lat, hospital.lon);

    var marker = new kakao.maps.Marker({
      position: markerPosition,
      map: map, 
      image: icon 
    });
    
    marker.id = hospital.id;
    markers.set(hospital.id, marker);
  
    kakao.maps.event.addListener(marker, 'mouseover', function() {
      if (!selectedMarker || selectedMarker !== marker) {
            marker.setImage(changeIcon);
        }
    });  

    kakao.maps.event.addListener(marker, 'mouseout', function() {
      if (!selectedMarker || selectedMarker !== marker) {
          marker.setImage(icon);
      }
    });
    

    kakao.maps.event.addListener(marker, 'click', function() {
      map.setLevel(map.getLevel()-8);
      map.setCenter(markerPosition);
      alert('병원명: ' + hospital.name + '\n주소: ' + hospital.address + '\n전화번호: ' + hospital.tel);
    },{once: true});

    bounds.extend(markerPosition);

  })

  function setBounds() {
    map.setBounds(bounds);
  }      

  setBounds();

  $('.hospital-card').on('mouseenter', function (e) {
    const hospital_id = $(e.currentTarget).data('id'); // 병원 ID 가져오기
    const marker = markers.get(hospital_id); // ID로 마커 찾기
    if (marker) {
        marker.setImage(changeIcon); // 마커 아이콘 변경
    }  
});

$('.hospital-card').on('mouseleave', function (e) {
    const hospital_id = $(e.currentTarget).data('id');
    const marker = markers.get(hospital_id);
    if (marker) {  
        marker.setImage(icon); // 마커 아이콘 복원
    }
});

    function  findGuAndDiv() {
        let gu = $('#gu').val()
        let hospitalDiv = $('#hospitalDiv').val()

        console.log(gu, hospitalDiv)

        $.ajax({
            type: "GET",
            url: `/ehr/hospital/hospital/find/condition`,
            async: false,
            data: {
                gu: gu,
                hospitalDiv: hospitalDiv
            },
            dataType: "json",
            success: function(response) {
                console.log("success response:" + response);
                console.log(response)
            },
            error: function(response) {
                console.log("error:" + response);
            }
        });
    }


</script>
</body>  
</html>