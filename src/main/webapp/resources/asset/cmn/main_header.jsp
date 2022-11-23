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

  });
</script>
</head>
<body>
  <div id="container">
    <!-- login-area -->
    <div class="login-area">
      <a href="#">Mypage</a>
      <input type="text" placeholder="아이디" required="required">
      <input type="password" placeholder="비밀번호" required="required">
      <button>로그인</button>
    </div>
    <!-- login-area end ------------------------------------------------------->
    
    <!-- logo-area -->
    <div class="logo-area"> 
      <img src="${CP_RES}/asset/imgs/EVerything_logo.png" id="logo">
    </div>
    <!-- logo-area end--------------------------------------------------------->
    
    <div class="header-area">
    <div class="text-logo-area">
      <img src="${CP_RES}/asset/imgs/EVerything_logo_text.png">
    </div>
    <!-- menu-area -->
    <div id="menu-area">
      <ul class="menu-bar">
        <li><a href="#">HOME</a></li>
        <li><a href="#">BOARD</a>
          <ul class="sub-menu">
            <li><a href="#">Board 1</a></li>
            <li><a href="#">Board 2</a></li>
            <li><a href="#">Board 3</a></li>
          </ul>
        </li>
        <li><a href="#">EVCARS</a>
          <ul class="sub-menu">
            <li><a href="#">Cars data</a></li>
            <li><a href="#">Subsidy data</a></li>
            <li><a href="#">Charger data</a></li>
            <li><a href="#">Chargingfee data</a></li>
            <li><a href="#">Statistical info</a></li>
          </ul>
         </li>
         
        <li><a href="#">STATION</a>
          <ul class="sub-menu">
            <li><a href="#">Station</a></li>
            <li><a href="#">Searchstation</a></li>
            <li><a href="#">Reviewboard</a></li>
          </ul>
         </li>
         
        <li><a href="#">NEWS</a>
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