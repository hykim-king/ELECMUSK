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

		$("#header-area").click(function() {
			$(".sub-menu").css("opacity", "1");
			$(".sub-menu").css("z-index", "1");
			$(".sub-menu").css("display", "block");
			$(".sub-menu>li").css("display", "block");
			$(".sub-menu>li>a").css("display", "block");
			$(".sub-menu>li").css("z-index", "1");
			$(".sub-menu>li>a").css("z-index", "1");
			$(".sub-menu").slideDown("fast");
			$()
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
			let link = "${CP}/station/view.do"
			location.href = link;
		});
		$("#rvboard").on("click", function() {
			let link = "${CP}/review/rvboardView.do"
			location.href = link;
		});

		$("#mainhome,#logo").on("click", function() {
			let link = "${CP}/elecmusk/view.do"
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
      let link = "${CP}/board/boardView.do?category=3"
      location.href = link;
    });

	});
</script>
<style>
#header-area{
  border-bottom: 1px solid;
  width: 100%;
  display: flex;
}
</style>
<div class="container-fluid">
  <!-- login-area -->
    <div class="login-area">
      <a href="#">[Mypage]</a>
      <input type="text" placeholder="아이디" required="required">
      <input type="password" placeholder="비밀번호" required="required">
      <button>로그인</button>
    </div>
  <!-- login-area end ------------------------------------------------------->

	<!-- logo-area -->
	<div class="logo-area text-center">
		<img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo.png"
			id="logo">
	</div>
	<!-- logo-area end--------------------------------------------------------->

	<div class="header-area" id="header-area">
  
		<div class="text-logo-area">
			<img src="${CP_RES}/asset/imgs/home_imgs/EVerything_logo_text.png" id="text-logo">
		</div>

		<!-- menu-area -->
		<div id="menu-area" class="container-fluid text-center">
			<ul class="menu-bar breadcrumb nav text-center">
				<li id="main_home" name="main_home">Home</li>
				<li>BOARD
					<ul class="sub-menu nav nav-stacked">
						<li><a href="#" id="board01">자유게시판</a></li>
						<li><a href="#" id="board02">결함 게시판</a></li>
						<li><a href="#" id="board03">공지사항</a></li>
					</ul>
				</li>
				<li>EVCARS
					<ul class="sub-menu nav nav-stacked">
						<li><a href="#" id="carsData" name="carsData">Cars data</a></li>
						<li><a href="#" id="subsidyData" name="subsidyData">Subsidy
								data</a></li>
						<li><a href="#" id="chargerData" name="chargerData">Charger
								data</a></li>
						<li><a href="#" id="feeData" name="feeData">Charging Fee</a></li>
						<li><a href="#">Statistical info</a></li>
					</ul>
				</li>
				<li>STATION
					<ul class="sub-menu nav nav-stacked">
						<li><a href="#" id="stationSearch" name="stationSearch">Station</a></li>
						<li><a href="#" id="rvboard" name="rvboard">Review board</a></li>
					</ul>
				</li>
				<li>NEWS
					<ul class="sub-menu nav nav-stacked">
						<li><a href="#">Menu 1</a></li>
						<li><a href="#">Menu 2</a></li>
					</ul>
				</li>
			</ul>
		</div>

	</div>
</div>
