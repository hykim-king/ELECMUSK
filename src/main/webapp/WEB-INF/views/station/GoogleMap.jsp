<%--
/**
  Class Name: 충전소찾기
  Description:
  
  Modification information
  
    수정일                수정자        수정내용
  -----       -----   -------------------------------------------
  2022.12.03  허승휘        최초작성 
    
    author eclass 개발팀 :ELECMUSK
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="CP" value="${pageContext.request.contextPath }"></c:set>
<c:set var="RES" value="/resources" ></c:set>
<c:set var="CP_RES" value="${CP}${RES}" ></c:set>
<!DOCTYPE html>
<html>  
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="${CP_RES}/asset/cmn/favicon.ico">  
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${CP_RES}/main_home.css">
<style>
  #map{
    width: 100%;
    height: 600px;
    background-color: grey;
  }
</style>

<!-- jQuery -->
<script src="${CP_RES}/bootstrap/js/jquery-1.12.4.js"></script>
<!-- callAjax -->
<script src="${CP_RES}/bootstrap/js/callAjax.js"></script>
<!-- String, Number, Date Util  -->
<script src="${CP_RES}/bootstrap/js/eUtil.js"></script>
<!-- paging -->
<script src="${CP_RES}/bootstrap/js/jquery.bootpag.js"></script>
<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>충전소 찾기</title>
<script >
$(document).ready(function(){
   
   doRetrieve();
    
    //충전소 목록 이동
    $("#moveToManagerPage").on("click",function(){
      
      console.log('moveToManagerPage');
      
      window.location.href = "${CP}/station/moveToManagerPage.do";
      
    //moveToReg
    });
    
    
    
    //리뷰게시판 목록 이동
    $("#moveToRvList").on("click",function(){
      
      console.log('moveToRvList');
      
      window.location.href = "${CP}/review/rvboardView.do?category=9";
      
    //moveToList
    });
    

    
    //리뷰게시판 등록으로 이동
    $("#moveToRvReg").on("click",function(){
      
      console.log('moveToRvReg');
      
      
      window.location.href = "${CP}/review/moveToReg.do?category=9";
      
    //moveToList
    });
    
    

    
    
});



function doRetrieve(page){
    console.log('doRetrieve() page:'+page);
    
    let method = "GET";
    let url = "/station/doRetrieve.do";
    let async = true;
    let params = {
        searchDiv : $('#searchDiv').val(),
        searchWord : $('#searchWord').val(),
        pageSize : $('#pageSize').val(),
        pageNo : page
    };
        
    PClass.callAjax(method,url,async,params,function(data){
      //console.log("data:"+data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      
      
      
      
    if(null != parsedJson && parsedJson.length > 0){
      
      $.each(parsedJson, function(index,value){
          
        });
        //데이터가 없는 경우
      }else{
      }
    
  
    });//PClass.callAjax
        
}





const API_KEY='m8mhLoQ0Q98g4kewmJc%2B3l2PboIiGXBoq8WLOkx1QNqRJzBDzbH2rCRhsBNwTFjbI77pAcduxM3M9%2FwrB%2BKS6Q%3D%3D';
async function getData(){//전기차 충전소 정보 api 받기
    const url = `https://api.odcloud.kr/api/EvInfoServiceV2/v1/getEvSearchList?page=1&perPage=4000&serviceKey=m8mhLoQ0Q98g4kewmJc%2B3l2PboIiGXBoq8WLOkx1QNqRJzBDzbH2rCRhsBNwTFjbI77pAcduxM3M9%2FwrB%2BKS6Q%3D%3D`;
    const response = await fetch(url);
    const data = await response.json();
    console.log("data",data);
    const locations = data.data.map(spot=>[spot.addr,               //주소
                                           spot.chargeTp,           //충전기타입(1:완속,2:급속)
                                           spot.cpId,               //충전기ID : ex)10611
                                           spot.cpNm,               //충전기명칭
                                           spot.cpStat,             //충전기상태(1:충전가능,2:충전중,3:고장/점검,4:통신장애,5:통신미연결)
                                           spot.cpTp,               //충전방식(1:B타입(5핀),2:C타입(5핀),3:BC타입(5핀),4:BC타입(7핀),5:DC차데모,6:AC 3상,7:DC콤보,8:DC차데모+DC콤보,9:DC차데모+AC3상,10:DC차데모+DC콤보,AC3상))
                                           spot.csId,               //충전소ID : ex)4437
                                           spot.csNm,               //충전소명칭
                                           spot.lat,                //위도
                                           spot.longi,              //경도
                                           //spot.spot.statUpdatetime, //업데이트시간
                                    ]);
    console.log("locations",locations);
    
    
    
    drawMap(locations);
}
function drawMap(locations){

    // 첫 시작 위치 - Geolocation기능 추가 전
    const myLatLng = { lat: 37.554075322663984, lng: 126.93576681191617 }; 
    
    //구글지도 생성
    const map = new google.maps.Map(document.getElementById("map"),{
        zoom:15,
        center: myLatLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
    });
    
    //현재 위치 표시
    if(navigator.geolocation){
      navigator.geolocation.getCurrentPosition(function(position){
        let pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        map.setCenter(pos);
      }, function(){
        handleLocationError(false, infoWindow, map.getCenter());
      });
    }else {
      handleLocationError(false, infoWindow, map.getCenter());
    }

    function handleLocationError(browerHasGeolocation, infoWindow, pos){
      infoWindow.setPosition(pos);
      infoWindow.setContent(browserHasGeolocation ?
                            '오류: Geolocation 연결 실패' :
                            '오류: 브라우저에서 Geolocation을 지원하지 않음');
    }
    
    //마커 클릭시 생성되는 인포윈도우
    const infowindow = new google.maps.InfoWindow({
          backgroundColor: "#eee",
          borderColor: "#2db400",
          borderWidth: 5      
    });
    
    let marker, i;
    
    //마커에 충전소들의 위도, 경도 정보를 담아 표시
    for(i = 0; i < locations.length; i++){
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations[i][8],locations[i][9]),//8 : 위도(lat), 9 : 경도(longi) 
            map: map,
        });
        
        //인포윈도우 설정
        google.maps.event.addListener(
            marker,
            "click",
            (function (marker, i) {
                return function () {
                    infowindow.setOptions({
                        pixelOffset: new google.maps.Size(0,-23)
                    });
                    
                    infowindow.setContent("<div>"+
                                            "<h3>"+locations[i][7]+"</h3><br>"+             //충전소명(csnm)
                                            "<p>주소 : "+locations[i][0]+"</p><br>"+          //주소(addr)
                                            "<p>충전기타입 : "+locations[i][3]+"</p><br>"+      //충전기타입(cptp)
                                            "<p>충전상태 : "+locations[i][4]+"</p><br>"+       //충전상태(cpstat)
                                            "<p>충전기 : "+locations[i][5]+"</p><br>"+         //충전방식(cptp)
                                          "</div>"+
                                          "<input type='button' class='btn btn-success btn-sm' value='리뷰보기' onclick='moveToRvList("+"\""+locations[i][7]+"\""+","+"1"+")' style='float:left;'>"+
                                          "<input type='button' class='btn btn-primary btn-sm' value='리뷰쓰기' onclick='doSelectOne("+locations[i][2]+","+locations[i][6]+","+"\""+locations[i][7]+"\""+")' style='float:right;'>"
                                          
                                          );
                    infowindow.open(map, marker);
                };
            })(marker, i)
        );
    }
}
getData();



//==================================================================
//=헤더부분 스크립트 이부분 꼭 넣으세요
//==================================================================

 $(function() {
     let didScroll;
     let lastScrollTop = 0;
     let navbarHeight = $("header").outerHeight();
      $(window).scroll(function(event){
          didScroll = true;
      });
      setInterval(function() {
          if (didScroll) {
              hasScrolled();
              didScroll = false;
          }
      }); // 스크롤이 멈춘 후 동작이 실행되기 까지의 딜레이
      function hasScrolled() {
        if($(this).width() > 700) {       
        let st = $(this).scrollTop(); // 현재 window의 scrollTop 값
            if ($(window).scrollTop() > 50){
                $(".logo-area").slideUp("fast"); // header 숨기기
                $(".text-logo-area").addClass("visible");
            } else {
                if($(window).scrollTop() < 200) {
                    $(".logo-area").slideDown("fast"); // header 보이기
                    $(".text-logo-area").removeClass("visible");
            }
         }
      }
   }
   });
//==================================================================
//=헤더부분 스크립트 이부분 꼭 넣으세요
//==================================================================
	
  //리뷰게시판 등록
  function doSelectOne(cpId,csId,csNm){
    let url = "${CP}/station/stationCheck.do?category=9";
     
    url = url + "&cpId="+cpId+"&csId="+csId+"&csnm="+csNm;
    
    console.log("url : "+url);
    
    location.href = url;
  }
  
  //리뷰게시판 조회
  function moveToRvList(csNm,maptoList){
    let url = "${CP}/review/rvboardView.do?category=9";
    
    url = url + "&searchWord="+csNm+"&maptoList="+maptoList;

    console.log("url:"+url);
    
    location.href = url;      
  };
</script>

</head>
<body>
  <header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  
  
  <div id="contents">
  
      <!-- div container -->
  <div class="container">
    <h1>충전소 찾기</h1>
    
    <!---------------------------------------- 검색 : 검색 구분(select) 검색어(input) 페이지 사이즈(select) -->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
        <!------------------------------------- 버튼 -->
            <c:choose>
              <c:when test="${2 <= sessionScope.userInfo.status && not empty sessionScope.userInfo}">
                <input type="button" class="btn btn-info btn-sm" value="관리자 메뉴" id="moveToManagerPage">
              </c:when>
              <c:otherwise>
              </c:otherwise>
            </c:choose>
        <!------------------------------------- 버튼 -->
      </div>
    </form>
    <!---------------------------------------- 검색 -->
    
    <script src="GoogleMap.js"></script>
    <div id="map"></div>
    <!-- 구글 지도 생성 -->
    <script async defer
    src=
    "https://maps.googleapis.com/maps/api/js?key=AIzaSyAmT5OGbQ4tRnpsb-UqoTBBCmE6tYU42Bc&callback=initMap&v=weekly">
    </script>
  </div>
  
  </div>
  
  
<footer>
  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>
</body>
</html>