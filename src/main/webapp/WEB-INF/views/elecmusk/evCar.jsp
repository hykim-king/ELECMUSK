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
<!-- jQuery -->
<script src="${CP_RES}/asset/js/jquery-1.12.4.js"></script>
<!-- callAjax -->
<script src="${CP_RES}/asset/js/callAjax.js"></script>
<!-- String, Number, Date Util -->
<script src="${CP_RES}/asset/js/eUtil.js"></script>
<script src="${CP_RES}/asset/js/jquery-3.6.1.min.js"></script>
<script src="${CP_RES}/asset/js/jquery-ui.js"></script>
<!-- javascript -->
<script type="text/javascript">
	$(document).ready(function() {
		  
		doRetrieve();
		
		$("#keywordRetrive").on("click",function(){
			doRetrieve();
		});
		
		
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
		//document End -------------------------------------------------------------
	});
	
	function doRetrieve() {
		console.log("doRetrieve");
		
		let method = "GET";
		let url    = "/elecmusk/doRetrieve.do";
		let async  = true;
		let params = {
				manufactureKeyword: $("#manufactureKeyword").val(),
				appearanceKeyword: $("#appearanceKeyword").val(),
				modelKeyword: $("#modelKeyword").val(),
				batteryTypeKeyword: $("#batteryTypeKeyword").val(),
		};
		PClass.callAjax(method,url,async,params,function(data){
	      let parsedJson = JSON.parse(data);
	          
	      let htmlData = "";
	      $("#evCar>tbody").empty();
	      
	      if(null != parsedJson && parsedJson.length > 0) {
	    	  $.each(parsedJson, function(index, value) {
	    		   htmlData += "<tr>";
	    		   htmlData += "<div class='picture'>";
	    		   htmlData += "  <td rowspan='11'><img src='"+<c:out value='value.imgUrl'/>+"' alt='' style='width:700px;'></td>";
	    		   htmlData += "</div>";
	    		   htmlData += "</tr>";
	    		   htmlData += "<tr>";
	    		   htmlData += "  <td>자동차명</td>";
	    		   htmlData += "  <td>"+<c:out value='value.carName'/>+"</td>";
	    		   htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>가격</td>";
	    	     htmlData += "  <td>"+<c:out value='value.carPrice'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>제조사</td>";
	    	     htmlData += "  <td>"+<c:out value='value.manufacture'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>연식</td>";
	    	     htmlData += "  <td>"+<c:out value='value.productYear'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>차종</td>";
	    	     htmlData += "  <td>"+<c:out value='value.appearance'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>모델</td>";
	    	     htmlData += "  <td>"+<c:out value='value.carModel'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>배터리 타입</td>";
	    	     htmlData += "  <td>"+<c:out value='value.batteryType'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>배터리 전압</td>";
	    	     htmlData += "  <td>"+<c:out value='value.batteryCapa'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>최대속도</td>";
	    	     htmlData += "  <td>"+<c:out value='value.maxSpeed'/>+"</td>";
	    	     htmlData += "</tr>";
	    	     htmlData += "<tr>";
	    	     htmlData += "  <td>output</td>";
	    	     htmlData += "  <td>"+<c:out value='value.outPut'/>+"</td>";
	    	     htmlData += "</tr>";
	    	  })
	      } else {
	             htmlData += "<tr>";
	             htmlData += "  <td colsapn='2' rowspan='11'>등록된 차 정보가 없습니다.</td>";
	             htmlData += "</tr>";
	      }
	      $("#evCar>tbody").append(htmlData);
		});
		
	}
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
		    <th>배터리종류</th>
		  </thead>
      <tbody>
        <tr>
          <td>
            <label>키워드</label>
          </td>
          <td>
			      <select id="manufactureKeyword" name="manufactureKeyword">
			        <option value="">전체</option>
			        <option value="현대">현대</option>
			        <option value="기아">기아</option>
			        <option value="쌍용">쌍용</option>
			        <option value="르노삼성">르노삼성</option>
			        <option value="쉐보레">쉐보레</option>
			        <option value="대창모터스">대창모터스</option>
			      </select>
          </td>
          <td>
			      <select id="appearanceKeyword" name="appearanceKeyword">
			        <option value="">전체</option>
			        <option value="세단">세단</option>
			        <option value="SUV">SUV</option>
			        <option value="해치백">해치백</option>
			      </select>
          </td>
          <td>
			      <select id="modelKeyword" name="modelKeyword">
              <option value="">전체</option>
              <option value="경형">경형</option>
              <option value="소형">소형</option>
              <option value="준중형">준중형</option>
              <option value="중형">중형</option>
              <option value="준대형">준대형</option>
			      </select>
          </td>
          <td>
			      <select id="batteryTypeKeyword" name="batteryTypeKeyword">
			        <option value="">전체</option>
			        <option value="리튬이온">리튬이온</option>
			        <option value="리튬이온폴리머">리튬이온폴리머</option>
			      </select>
          </td>
          <td>
            <input type="button" class="btn btn-primary btn-sm" value="조회" id="keywordRetrive">
          </td>
        </tr>
      </tbody>
		</table>
				<div class="subsidy-info">
				  <a href="#">보조금 상세 정보</a>
				</div>
		</div>
		
      <table class="evcar-table" id="evCar">
        <tbody>
        </tbody>
      </table>
    
	</div>
	<footer>
		<jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
	</footer>
</body>
	</html>
</fmt:bundle>