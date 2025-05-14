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
<link rel ="stylesheet" href="/ehr/resources/assets/css/list.css">
<script src="/ehr/resources/assets/js/jquery_3_7_1.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db6b66ee32de5c188c171ffea6d8fe47"></script>

</head>

<body>    
    
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
                      <div class="hospital-box">
                        <div class="hospital-header">
                            <div class="hospital-info">
                                <h3 class="hospital-name">${hospital.hospital_name}</h3>
                                <p class="hospital-departments"><img src="/ehr/resources/assets/image/hospitalimage.png" style="width: 20px; height: 20px;"> ${hospital.hospital_div}</p>
                            </div>
                         </div>  
                        <div class="hospital-details">
                            <p class="hospital-address"><img src="/ehr/resources/assets/image/mapimage.png" class="pngImage"> ${hospital.hospital_addr}</p>
                            <p class="hospital-any">${hospital.hospital_mapimg}</p>
                            <p class="hospital-any">${hospital.hospital_etc}</p>
                            <p class="hospital-any"><img src="/ehr/resources/assets/image/phoneimage.png" class="pngImage"> ${hospital.hospital_tel}</p>
                            <div class="reservationTime" data-index="${hospital.hospital_id}"></div>
                        </div>
                      </div>  
                        <!-- 달력 -->  
                        <div class="calendar-container">
                          <div class="calendar-header">
                            <button class="prevBtn" type="button" data-index="${hospital.hospital_id}">〈</button>
                            <h2 class="currentMonth" data-id="${hospital.hospital_id}" data-index="${hospital.hospital_id}"></h2>
                            <button class="nextBtn" type="button" data-index="${hospital.hospital_id}">〉</button>
                          </div>      
                          <div class="calendar-days">  
                            <div class="days">일</div>
                            <div class="days">월</div>    
                            <div class="days">화</div>
                            <div class="days">수</div>  
                            <div class="days">목</div>  
                            <div class="days">금</div>
                            <div class="days">토</div>
                          </div>
                          <div class="calendar-dates" data-index="${hospital.hospital_id}" data-date="2025-00-00"></div>
                        </div>
                        <div class="hospital-actions">
                            <button class="yellow-button">검진 예약하기</button>
                        </div>  
                    </div>
                </c:forEach>
                <%
                out.print(pageHtml);
                %>
            </div>
            <div class="right_content">
              <div id="map" style="width: 100%; height: 100vh; position: sticky; top: 0; z-index: 1;">
                <div>
                  <button class="reset-button" onclick="setBounds()" >지도 범위 재설정 하기</button> 
                </div> 
              </div>
            </div>  
          <input type="hidden" name="pageNo" id="pageNo" value="${search.pageNo}">
          <input type="hidden" name="pageSize" id="pageSize" value="${search.pageSize}">
        </form>
    </div>
</div> 

<script> 
  function pageDoRetrieve(url, pageNo){
  console.log("doRetrieveButton click!");

  form.pageNo.value =pageNo;
  form.action = url;

  form.submit();
}

  $(document).ready(function () {

    const calendarStates = {}; 

  $('.hospital-card').each(function () {
    const hospital = $(this).data('id');
    console.log(hospital);

    const calendarDates = $(this).find(`.calendar-dates`);
    const currentMonthElement = $(this).find(`.currentMonth`);
    const prevBtn = $(this).find(`.prevBtn`);
    const nextBtn = $(this).find(`.nextBtn`);
    const reservationTimeElement = $(this).find(`.reservationTime`);
   
    const today = new Date();
    calendarStates[hospital] = {
      currentMonth: today.getMonth(),
      currentYear: today.getFullYear(),
    };

    function renderCalendar(hospital) {
      const { currentMonth, currentYear } = calendarStates[hospital];
      const firstDayOfMonth = new Date(currentYear, currentMonth, 1);
      const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
      const startDayOfWeek = firstDayOfMonth.getDay();
      const yesterday = new Date(today);
      yesterday.setDate(yesterday.getDate() - 1);

      
      currentMonthElement.text(currentYear + '년 ' +(currentMonth + 1)+ '월');
      calendarDates.empty();

      for (let i = 0; i < startDayOfWeek; i++) {
        $('<div>')
          .addClass('date empty')
          .appendTo(calendarDates);
      }

      for (let i = 1; i <= daysInMonth; i++) {
        const date = new Date(currentYear, currentMonth, i);
        const dateElement = $('<div>')
          .addClass('date')
          .text(i)
          .attr('data-date', date.toISOString());
  
          if (date <= yesterday) {
            dateElement.addClass('disabled');
          } else if (date.toDateString() === today.toDateString()) {
            dateElement.addClass('today');
            dateElement.on('click', function () {
              const selectedDate = new Date($(this).data('date'));
              const formattedDate = selectedDate.toLocaleDateString("ko-KR", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                  weekday: "long",
                });

              reservationTimeElement
                .text(formattedDate)
                .css({
                  display: "block",
                  opacity: 1,
                  visibility: "visible",
                });
            });
          }else{
            dateElement.on('click', function () {
              const selectedDate = new Date($(this).data('date'));
              const formattedDate = selectedDate.toLocaleDateString("ko-KR", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                  weekday: "long",
                });
                reservationTimeElement
                .text(formattedDate)
            });
          }

        dateElement.appendTo(calendarDates);
      }
    }

    renderCalendar(hospital);

    prevBtn.on('click', function (event) {
      event.preventDefault();
      calendarStates[hospital].currentMonth--;
      if (calendarStates[hospital].currentMonth < 0) {
        calendarStates[hospital].currentMonth = 11;
        calendarStates[hospital].currentYear--;
      }
      renderCalendar(hospital);
    });

    nextBtn.on('click', function () {
      event.preventDefault();
      calendarStates[hospital].currentMonth++;
      if (calendarStates[hospital].currentMonth > 11) {
        calendarStates[hospital].currentMonth = 0;
        calendarStates[hospital].currentYear++;
      }
      renderCalendar(hospital);
    });
  });
});

/* 카카오맵 */
  var mapContainer = document.getElementById('map');
  var mapOption = {
      center: new kakao.maps.LatLng(37.5665, 126.9780), 
      level: 6, 
      draggable: false  
  };  
    
  var map = new kakao.maps.Map(mapContainer, mapOption); 
    
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
      setTimeout(function(){
        alert('병원명: ' + hospital.name + '\n주소: ' + hospital.address + '\n전화번호: ' + hospital.tel);
      },100)
    });

    bounds.extend(markerPosition);
  
  })    

  function setBounds() {  
    map.setBounds(bounds);
  }        
    
  setBounds();

  $('.hospital-card').on('mouseenter', function (e) {
    const hospital_id = $(e.currentTarget).data('id'); 
    const marker = markers.get(hospital_id); 
    if (marker) {
        marker.setImage(changeIcon);   
    }      
});  

$('.hospital-card').on('mouseleave', function (e) {
    const hospital_id = $(e.currentTarget).data('id');
    const marker = markers.get(hospital_id);
    if (marker) {  
        marker.setImage(icon); 
    }
});    

// 구와 의원 종류 찾기  
function findGuAndDiv(callback) {
      let gu = $('#gu').val();  
      let hospitalDiv = $('#hospitalDiv').val();

      console.log(`Selected Gu:`,gu);
      console.log(`Selected HospitalDiv:`,hospitalDiv);
    
      if(validate()) {
          return ""
      }
  
      $.ajax({
          type: "GET",
          url: `/ehr/hospital/hospital/find/condition`,
          data: { gu, hospitalDiv },
          dataType: "json",
          success: function(response) {

              if (!response.list || response.list.length === 0) {
                  console.error("병원 데이터 없음.");
                  alert("검색 결과가 없습니다.");
                  return;
              }
  
              console.log("Success response:", response);
  
              // 병원 카드와 마커 초기화
              resetMarkers();  
              $('.left_content').empty();

              // 병원 목록 렌더링
              response.list.forEach(function(hospital) {
                  var leftContent = document.querySelector('.left_content');

                  // 병원 카드 생성
                  var hospitalCard = document.createElement('div');
                  hospitalCard.className = 'hospital-card';
                  hospitalCard.setAttribute('data-id', hospital.hospital_id);  

                  var box = document.createElement('div');
                  box.className = 'hospital-box';

                  var header = document.createElement('div');
                  header.className = 'hospital-header';

                  var info = document.createElement('div');  
                  info.className = 'hospital-info';

                  var name = document.createElement('h3');  
                  name.className = 'hospital-name';
                  name.textContent = hospital.hospital_name;
  
                  var departments = document.createElement('p');  
                  departments.className = 'hospital-departments';  
                  var departmentsImage = document.createElement('img');
                  departmentsImage.src = '/ehr/resources/assets/image/hospitalimage.png';
                  departmentsImage.style = 'width: 20px; height: 20px;';
                  departments.appendChild(departmentsImage);
                  departments.appendChild(document.createTextNode(' ' + hospital.hospital_div));

                  info.appendChild(name);
                  info.appendChild(departments);
                  header.appendChild(info);
                  box.appendChild(header);  
                  hospitalCard.appendChild(box);

                  var details = document.createElement('div');  
                  details.className = 'hospital-details';    

                  var address = document.createElement('p');  
                  address.className = 'hospital-address';
                  var addressImage = document.createElement('img');
                  addressImage.src = '/ehr/resources/assets/image/mapimage.png';
                  addressImage.className = 'pngImage';
                  address.appendChild(addressImage);
                  address.appendChild(document.createTextNode(' ' + hospital.hospital_addr));    
  
                  var mapimg = document.createElement('p');
                  mapimg.className = 'hospital-any';
                  mapimg.textContent = hospital.hospital_mapimg;

                  var etc = document.createElement('p');  
                  etc.className = 'hospital-any';
                  etc.textContent = hospital.hospital_etc;  

                  var tel = document.createElement('p');  
                  tel.className = 'hospital-any';
                  var telImage = document.createElement('img');
                  telImage.src = '/ehr/resources/assets/image/phoneimage.png';
                  telImage.className = 'pngImage';  
                  tel.appendChild(telImage);
                  tel.appendChild(document.createTextNode(' ' + hospital.hospital_tel));  

                  var reservation = document.createElement('div');
                  reservation.className = 'reservationTime';
                  reservation.setAttribute('data-index', hospital.hospital_id);

                  details.appendChild(address);
                  details.appendChild(mapimg);  
                  details.appendChild(etc);  
                  details.appendChild(tel);
                  details.appendChild(reservation);
                  box.appendChild(details);
                  hospitalCard.appendChild(box);

                  var calendarContainer = document.createElement('div');
                  calendarContainer.className = 'calendar-container';
  
                  var calendarHeader = document.createElement('div');
                  calendarHeader.className = 'calendar-header';
                  
                  var prevBtn = document.createElement('button'); 
                  prevBtn.className = 'prevBtn';  
                  prevBtn.setAttribute('data-index', hospital.hospital_id);
                  prevBtn.textContent = '〈';

                  var currentMonth = document.createElement('h2');  
                  currentMonth.className = 'currentMonth';
                  currentMonth.setAttribute('data-index', hospital.hospital_id);
                  currentMonth.setAttribute('data-id', hospital.hospital_id);

                  var nextBtn = document.createElement('button');
                  nextBtn.className = 'nextBtn';
                  nextBtn.setAttribute('data-index', hospital.hospital_id);
                  nextBtn.textContent = '〉';
  
                  calendarHeader.appendChild(prevBtn);
                  calendarHeader.appendChild(currentMonth);  
                  calendarHeader.appendChild(nextBtn);  
                  calendarContainer.appendChild(calendarHeader);

                  var calendarDays = document.createElement('div');
                  calendarDays.className = 'calendar-days';
                  ['일', '월', '화', '수', '목', '금', '토'].forEach(function(day) {
                    var daysDiv = document.createElement('div');
                    daysDiv.className = 'days';
                    daysDiv.textContent = day;
                    calendarDays.appendChild(daysDiv);
                  });

                  calendarContainer.appendChild(calendarDays);

                  var calendarDates = document.createElement('div');
                  calendarDates.className = 'calendar-dates';
                  calendarDates.setAttribute('data-index', hospital.hospital_id);

                  calendarContainer.appendChild(calendarDates);
                  hospitalCard.appendChild(calendarContainer);


                  var actions = document.createElement('div');
                  actions.className = 'hospital-actions';

                  var button = document.createElement('button');
                  button.className = 'yellow-button';
                  button.textContent = '검진 예약하기';

                  actions.appendChild(button);
                  hospitalCard.appendChild(actions);
                
                  leftContent.appendChild(hospitalCard);
                  addMarker(hospital);  
                  addCalendar(hospital.hospital_id);
              });  
  
              setBounds();

              bindHospitalCardEvents();

              if (typeof callback === 'function') {
                  callback(response);
              }
          },
          error: function(error) {
              console.error("Error fetching hospital data:", error);
          }
      });
  }
  
  // 선택 사항 체크 함수
  function validate() {
      let gu = $('#gu').val();
      let hospitalDiv = $('#hospitalDiv').val();

      let msg = "";
  
      if(gu == '' || gu == null) msg += "구를 선택해주세요 !\n"
      if(hospitalDiv == '' || hospitalDiv == null) msg += "병원종류를 선택해주세요 !\n"


      if(msg.length > 0) {  
          alert(msg);
          return true;  
      } else {  
          return false
      }

  }
  // 마커 초기화 함수
  function resetMarkers() {
      markers.forEach(marker => marker.setMap(null)); 
      markers.clear(); // 마커 데이터 초기화
      bounds = new kakao.maps.LatLngBounds(); 
  }  

  // 마커 추가 함수
  function addMarker(hospital) {
    console.log(hospital);
      let markerPosition = new kakao.maps.LatLng(hospital.hospital_lat, hospital.hospital_lon);
      let marker = new kakao.maps.Marker({
          position: markerPosition,
          map: map,
          image: icon
      });

      markers.set(hospital.hospital_id, marker); 
      bounds.extend(markerPosition); 
  
      kakao.maps.event.addListener(marker, 'mouseover', function () {
          marker.setImage(changeIcon);
      });

      kakao.maps.event.addListener(marker, 'mouseout', function () {
          marker.setImage(icon);
      });

      kakao.maps.event.addListener(marker, 'click', function () {
          map.setLevel(map.getLevel() - 8);
          map.setCenter(markerPosition);
      });
  }

  // 병원 카드 이벤트 바인딩 함수
  function bindHospitalCardEvents() {
      $('.hospital-card').off('mouseenter mouseleave');  
      $('.hospital-card').on('mouseenter', function(e) {
          const hospital_id = $(this).data('id');  
          const marker = markers.get(hospital_id);
          if (marker) {     
              marker.setImage(changeIcon);  
          }       
      });   

      $('.hospital-card').on('mouseleave', function(e) {
          const hospital_id = $(this).data('id');
          const marker = markers.get(hospital_id);
          if (marker) {  
              marker.setImage(icon);
          }  
      });
  }
  const calendarStates = {}; 

  function addCalendar(hospitalId) {
  console.log('Hospital ID:' +hospitalId);

  // 병원별 DOM 요소 찾기
  const calendarDates = $('.calendar-dates[data-index="' + hospitalId + '"]');
  const currentMonthElement = $('.currentMonth[data-index="' + hospitalId + '"]');
  const prevBtn = $('.prevBtn[data-index="' + hospitalId + '"]');
  const nextBtn = $('.nextBtn[data-index="' + hospitalId + '"]');
  const reservationTimeElement = $('.reservationTime[data-index="' + hospitalId + '"]');
  
  console.log('Calendar Element:', calendarDates);
  console.log('Reservation Element:', reservationTimeElement);
  const today = new Date();

  // 병원별 달력 상태 초기화
  const calendarState = {
    currentMonth: today.getMonth(),
    currentYear: today.getFullYear(),
  };

  // 달력 렌더링 함수
  function renderCalendar() {
    const { currentMonth, currentYear } = calendarState;
    const firstDayOfMonth = new Date(currentYear, currentMonth, 1);
    const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
    const startDayOfWeek = firstDayOfMonth.getDay();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    // 현재 월과 연도 표시
    currentMonthElement.text(currentYear + '년 ' +(currentMonth + 1)+ '월');

    // 기존 날짜 제거
    calendarDates.empty();

    // 빈 날짜 추가
    for (let i = 0; i < startDayOfWeek; i++) {
      $('<div>')
        .addClass('date empty')
        .appendTo(calendarDates);
    }

    for (let i = 1; i <= daysInMonth; i++) {
      const date = new Date(currentYear, currentMonth, i);
      const dateElement = $('<div>')
        .addClass('date')
        .text(i)
        .attr('data-date', date.toISOString()); 

      if (date <= yesterday) {
        dateElement.addClass('disabled');
      } else if (date.toDateString() === today.toDateString()) {
            dateElement.addClass('today');
            dateElement.on('click', function () {
              const selectedDate = new Date($(this).data('date'));
              const formattedDate = selectedDate.toLocaleDateString("ko-KR", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                  weekday: "long",
                });

              reservationTimeElement
                .text(formattedDate)
                .css({
                  display: "block",
                  opacity: 1,
                  visibility: "visible",
                });
            });
          }else{
            dateElement.on('click', function () {
              const selectedDate = new Date($(this).data('date'));
              const formattedDate = selectedDate.toLocaleDateString("ko-KR", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                  weekday: "long",
                });
                reservationTimeElement
                .text(formattedDate)
            });
          }

      dateElement.appendTo(calendarDates);
    }
  }

  renderCalendar();

  prevBtn.on('click', function (event) {
    event.preventDefault();
    calendarState.currentMonth--;
    if (calendarState.currentMonth < 0) {
      calendarState.currentMonth = 11;
      calendarState.currentYear--;
    }
    renderCalendar();
  });

  nextBtn.on('click', function (event) {
    event.preventDefault();
    calendarState.currentMonth++;
    if (calendarState.currentMonth > 11) {
      calendarState.currentMonth = 0;
      calendarState.currentYear++;
    }
    renderCalendar();
  });
}
</script>
</body>  
</html>