<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<c:set var="resources" value="/resources"/>
<c:set var="CP_RES"    value="${CP}${resources}" />

<fmt:bundle basename="message">
<%@include file="/resources/asset/jsp/cache.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initail-scale=1.0">
<meta name="description" content="pcwk html" />
<!-- 키워드 -->
<meta name="keyword" content="html5, css3, javascript6, jQuery">
<meta charset="UTF-8">
<!-- jquery ui -->
<link rel="stylesheet" href="${CP_RES}/asset/css/jquery-ui.css">
<link rel="stylesheet" href="${CP_RES}/main_home.css">
<style>

</style>
<title></title>
<script src="${CP_RES}/asset/js/jquery-3.6.1.min.js"></script>
<script src="${CP_RES}/asset/js/jquery-ui.js"></script>
<!-- javascript -->
<script type="text/javascript">
  $(document).ready(function(){

	    $("#header-area").click(function() {
	        $(".sub-menu").addClass("visible");
	        $(".sub-menu").css("opacity", "1");
	        $(".sub-menu").css("z-index", "1");
	        $(".sub-menu>li").css("z-index", "1");
	        $(".sub-menu>li>a").css("z-index", "1");
	        $(".sub-menu").slideDown("fast");
	    })
	    .mouseleave(function(){
	        $(".sub-menu").slideUp("fast");
	        $(".sub-menu").css("opacity", "0");
	        $(".sub-menu").css("z-index", "-1");
	        $(".sub-menu>li").css("z-index", "-1");
	        $(".sub-menu>li>a").css("z-index", "-1");
	        $(".sub-menu").removeClass("visible");
	    });
	    
	  $("#carsData").on("click",function(){
		  let link = "${CP}/elecmusk/evcar.do"
		  location.href= link;
	  });
	  $("#subsidyData").on("click",function(){
		  let link = "${CP}/subsidy/view.do"
		  location.href= link;
	  });
	  $("#chargerData").on("click",function(){
		  let link = "${CP}/charger/view.do"
		  location.href= link;
	  });
	  $("#feeData").on("click",function(){
		  let link = "${CP}/chargingfee/view.do"
		  location.href= link;
	  });
	  $("#stationSearch").on("click",function(){
		  let link = "${CP}/station/view.do"
		  location.href= link;
	  });
	  
	  $("#mainhome,#logo").on("click",function(){
		  let link = "${CP}/elecmusk/view.do"
		  location.href= link;
	  });
	  
  });
</script>
</head>
<body>
  <div id="container">
    <!-- login-area -->
    <div class="login-area">
      <a href="#">[Mypage]</a>
      <input type="text" placeholder="아이디" required="required">
      <input type="password" placeholder="비밀번호" required="required">
      <button>로그인</button>
    </div>
    <!-- login-area end ------------------------------------------------------->
    
    <!-- logo-area -->
    <div class="logo-area"> 
      <img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo.png" id="logo">
    </div>
    <!-- logo-area end--------------------------------------------------------->
    
    <div class="header-area" id="header-area">
    <div class="text-logo-area">
      <img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo_text.png">
    </div>
    <!-- menu-area -->
    <div id="menu-area">
      <ul class="menu-bar">
        <li id="mainhome" name="mainhome">HOME</li>
        <li>BOARD
          <ul class="sub-menu">
            <li><a href="#">Board 1</a></li>
            <li><a href="#">Board 2</a></li>
            <li><a href="#">Board 3</a></li>
          </ul>
        </li>
        <li>EVCARS
          <ul class="sub-menu">
            <li><a href="#" id="carsData" name="carsData">Cars data</a></li>
            <li><a href="#" id="subsidyData" name="subsidyData">Subsidy data</a></li>
            <li><a href="#" id="chargerData" name="chargerData">Charger data</a></li>
            <li><a href="#" id="feeData" name="feeData">Charging Fee</a></li>
            <li><a href="#">Statistical info</a></li>
          </ul>
         </li>
         
        <li>STATION
          <ul class="sub-menu">
            <li><a href="#" id="stationSearch" name="stationSearch">Station</a></li>
            <li><a href="#">Reviewboard</a></li>
          </ul>
         </li>
         
        <li>NEWS
          <ul class="sub-menu">
            <li><a href="#">Menu 1</a></li>
            <li><a href="#">Menu 2</a></li>
          </ul>
        </li>
      </ul>
    </div>
    
    </div>
</div>
</body>
</html>
</fmt:bundle>