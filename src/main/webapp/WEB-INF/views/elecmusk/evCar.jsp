<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<c:set var="resources" value="/resources" />
<c:set var="CP_RES" value="${CP}${resources}" />

<fmt:bundle basename="message">
	<%@include file="/resources/asset/jsp/cache.jsp"%>
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
<link rel="stylesheet" href="${CP_RES}/evCar.css">
<style>
</style>
<title>Everything</title>
<script src="${CP_RES}/asset/js/jquery-3.6.1.min.js"></script>
<script src="${CP_RES}/asset/js/jquery-ui.js"></script>
<!-- javascript -->
<script type="text/javascript">
	$(document).ready(function() {

		$(function() {
			let didScroll;
			let lastScrollTop = 0;
			let navbarHeight = $("header").outerHeight();
			$(window).scroll(function(event) {
				didScroll = true;
			});

			setInterval(function() {
				if (didScroll) {
					hasScrolled();
					didScroll = false;
				}
			}); // 스크롤이 멈춘 후 동작이 실행되기 까지의 딜레이

			function hasScrolled() {
				if ($(this).width() > 700) {
					let st = $(this).scrollTop(); // 현재 window의 scrollTop 값
					if ($(window).scrollTop() > 50) {
						$(".logo-area").slideUp("fast"); // header 숨기기
						$(".text-logo-area").addClass("visible");
					} else {
						if ($(window).scrollTop() < 200) {
							$(".logo-area").slideDown("fast"); // header 보이기
							$(".text-logo-area").removeClass("visible");
						}
					}
				}
			}
		});
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="/resources/asset/cmn/main_header.jsp" flush="false" />
	</header>
	<div id="contents">

		<div class="select-area">
		
		<table>
		  <thead>
		    <th>&nbsp;</th>
		    <th>제조사</th>
		    <th>외형</th>
		    <th>차종</th>
		    <th>가격</th>
		    <th>연비</th>
		  </thead>
      <tbody>
        <tr>
          <td>
            <label>키워드</label>
          </td>
          <td>
			      <select>
			        <option value="">전체</option>
			      </select>
          </td>
          <td>
			      <select>
			        <option value="">전체</option>
			      </select>
          </td>
          <td>
			      <select>
			        <option value="">전체</option>
			      </select>
          </td>
          <td>
			      <select>
			        <option value="">전체</option>
			      </select>
          </td>
          <td>
			      <select>
			        <option value="">전체</option>
			      </select>
          </td>
        </tr>
      </tbody>
		</table>
				<div class="subsidy-info">
				  <a href="#">보조금 상세 정보</a>
				</div>
		</div>
		
    <div class="evcar1 evcararea">
      <table class="evcar-table">
        <tr>
          <div class="picture">
          <td rowspan="11"><img src="${CP_RES}/asset/imgs/evcar_imgs/BOLTEV.png" alt="" style="width:700px;"></td>
          </div>
        </tr>
        <tr>
          <td>자동차명</td>
          <td><input type="text" id="evname" name=evname readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>가격</td>
          <td><input type="text" id="evprice" name="evprice" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>제조사</td>
          <td><input type="text" id="manufacture" name="manufacture" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>연식</td>
          <td><input type="text" id="evyear" name="evyear" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>차종</td>
          <td><input type="text" id="cartype" name="cartype" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>모델</td>
          <td><input type="text" id="evmodel" name="evmodel" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>배터리 타입</td>
          <td><input type="text" id="battery-type" name="battery-type" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>배터리 전압</td>
          <td><input type="text" id="battery-w" name="battery-w" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>최대속도</td>
          <td><input type="text" id="max-speed" name="max-speed" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>output</td>
          <td><input type="text" id="output" name="output" readonly="readonly" style="border:0px;"></td>
        </tr>
      </table>
    </div>    
		
    <div class="evcar2 evcararea">
      <table class="evcar-table">
        <tr>
          <div class="picture">
          <td rowspan="11"><img src="${CP_RES}/asset/imgs/evcar_imgs/BOLTEV.png" alt="" style="width:700px;"></td>
          </div>
        </tr>
        <tr>
          <td>자동차명</td>
          <td><input type="text" id="evname" name=evname readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>가격</td>
          <td><input type="text" id="evprice" name="evprice" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>제조사</td>
          <td><input type="text" id="manufacture" name="manufacture" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>연식</td>
          <td><input type="text" id="evyear" name="evyear" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>차종</td>
          <td><input type="text" id="cartype" name="cartype" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>모델</td>
          <td><input type="text" id="evmodel" name="evmodel" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>배터리 타입</td>
          <td><input type="text" id="battery-type" name="battery-type" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>배터리 전압</td>
          <td><input type="text" id="battery-w" name="battery-w" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>최대속도</td>
          <td><input type="text" id="max-speed" name="max-speed" readonly="readonly" style="border:0px;"></td>
        </tr>
        <tr>
          <td>output</td>
          <td><input type="text" id="output" name="output" readonly="readonly" style="border:0px;"></td>
        </tr>
      </table>
    </div>    
    
    
	</div>
	<footer>
		<jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
	</footer>
</body>
	</html>
</fmt:bundle>