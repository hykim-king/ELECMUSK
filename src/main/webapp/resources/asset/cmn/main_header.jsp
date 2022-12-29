<%--
/**
  Class Name: header.jsp
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 13        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath }"></c:set>
<c:set var="RES" value="/resources"></c:set>
<c:set var="CP_RES" value="${CP}${RES}"></c:set>
<script type="text/javascript">
  $(document).ready(function() {

    $(".menu-open").click(function() {
      $(".sub-menu").css("opacity", "1");
      $(".sub-menu").css("z-index", "1");
      $(".sub-menu").css("display", "block");
      $(".sub-menu>li").css("display", "block");
      $(".sub-menu>li>a").css("display", "block");
      $(".sub-menu>li").css("z-index", "1");
      $(".sub-menu>li>a").css("z-index", "1");
      $(".sub-menu").slideDown("slow");
    }).mouseleave(function() {
      $(".sub-menu").slideUp("fast");
      $(".sub-menu").css("opacity", "0");
      $(".sub-menu").css("z-index", "-1");
      $(".sub-menu").css("display", "none");
      $(".sub-menu>li").css("display", "none");
      $(".sub-menu>li>a").css("display", "none");
      $(".sub-menu>li").css("z-index", "-1");
      $(".sub-menu>li>a").css("z-index", "-1");
    });
    
    $("#main_home").on("click", function() {
        let link = "${CP}/elecmusk/view.do"
        location.href = link;
     });

     $("#mainhome,#logo,#text-logo").on("click", function() {
       let link = "${CP}/elecmusk/view.do"
       location.href = link;
     });
    
    onlyLoginUserUse();

  });
  
  function onlyLoginUserUse() {
       $("#carsData").on("click", function() {
         let link = "${CP}/elecmusk/evcar.do"
         location.href = link;
       });
       $("#subsidyData").on("click", function() {
         let link = "${CP}/subsidy/view.do"
         location.href = link;
       });
       $("#chargerData").on("click", function() {
         let link = "${CP}/charger/view.do"
         location.href = link;
       });
       $("#feeData").on("click", function() {
         let link = "${CP}/chargingfee/view.do"
         location.href = link;
       });
       $("#stationSearch").on("click", function() {
         let link = "${CP}/station/moveToMap.do"
         location.href = link;
       });
       $("#rvboard").on("click", function() {
         let link = "${CP}/review/rvboardView.do?category=9"
         location.href = link;
       });
       $("#board01").on("click", function() {
         let link = "${CP}/board/boardView.do?category=1"
         location.href = link;
       });
       $("#board02").on("click", function() {
         let link = "${CP}/board/boardView.do?category=2"
         location.href = link;
       });
       $("#board03").on("click", function() {
         let link = "${CP}/board/boardView.do?category=5"
         location.href = link;
       }); 
       $("#news").on("click", function() {
         let link = "${CP}/elecmusk/naverview.do"
         location.href = link;
       });
       $("#blog").on("click", function() {
         let link = "${CP}/elecmusk/blogView.do"
         location.href = link;
       });
       $("#doLogout").on("click", function() {
         let link = "${CP}/login/doLogout.do";
         location.href = link;
       });
       $("#moveToMyPage").on("click", function() {
         let link = "${CP}/elecmusk/myPage.do";
         location.href = link;
       });
  } 
</script>
<style>
#header-area{
  width: 100%;
  display: flex;
}
</style>
<div class="container-fluid">
  <!-- login-area -->
    <div class="login-area">
    <c:choose>
      <c:when test="${null != sessionScope.userInfo && not empty sessionScope.userInfo}">
        <p>환영합니다. <b>${sessionScope.userInfo.userId}</b>님
        <a id = "doLogout">[Logout]</a>
        <a id = "moveToMyPage">[Mypage]</a></p>
      </c:when>
      <c:otherwise>
        <a href="${CP}/login/login.do">[Login]</a>
      </c:otherwise>
    </c:choose>
    </div>
  <!-- login-area end ------------------------------------------------------->

  <!-- logo-area -->
  <div class="logo-area text-center">
    <img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo.png"
      id="logo" style="cursor:pointer;">
  </div>
  <!-- logo-area end--------------------------------------------------------->

  <div class="header-area" id="header-area">
  <input type="hidden" id="status" name="status" value="${sessionScope.userInfo.status}">
  
    <div class="text-logo-area">
      <img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo_text.png" style="cursor: pointer;" id="text-logo">
    </div>

    <!-- menu-area -->
    <div id="menu-area" class="container-fluid text-center">
      <ul class="menu-bar nav text-center" style="font-weight: bold;">
        <li id="main_home" name="main_home" style="cursor:pointer;"><span class="glyphicon glyphicon-home"></span></li>
        <li style="cursor:pointer;" class="menu-open" id="menu-bar">게시판
          <ul class="sub-menu nav" id="sub-menu">
            <li><a id="board01">자유게시판</a></li>
            <li><a id="board02">결함 게시판</a></li>
            <li><a id="board03">공지사항</a></li>
          </ul>
        </li>
        <li style="cursor:pointer;" class="menu-open" id="menu-bar">EV데이터
          <ul class="sub-menu nav" id="sub-menu">
            <li><a id="carsData" name="carsData">전기차정보</a></li>
            <li><a id="subsidyData" name="subsidyData">보조금정보</a></li>
            <li><a id="chargerData" name="chargerData">충전기정보</a></li>
            <li><a id="feeData" name="feeData">충전요금정보</a></li>
          </ul>
        </li>
        <li style="cursor:pointer;" class="menu-open" id="menu-bar">충전소
          <ul class="sub-menu nav" id="sub-menu">
            <li><a id="stationSearch" name="stationSearch">충전소찾기</a></li>
            <li><a id="rvboard" name="rvboard">리뷰게시판</a></li>
          </ul>
        </li>
        <li style="cursor:pointer;" class="menu-open" id="menu-bar">정보글
          <ul class="sub-menu nav" id="sub-menu">
            <li><a id="news">뉴스</a></li>
            <li><a id="blog">블로그</a></li>
          </ul>
        </li>
      </ul>
    </div>

  </div>
</div>
