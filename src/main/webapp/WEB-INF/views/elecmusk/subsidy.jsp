<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 1        최초작성 
    
    author eclass 개발팀 :ITSC
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
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">

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
<title>보조금</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	  
	  
	  
	  
	    function doRetrieve(page){
	        console.log("doRetrieve");
	          
	          let method = "GET";
	          let url = "/elecmusk/doRetrieve.do";
	          let async = true;
	          let params = {
	              searchDiv : $("#searchDiv").val(),
	              searchWord : $("#searchWord").val(),
	              pageSize : $("#pageSize").val(),
	              pageNo : page
	          };
	          
	          PClass.callAjax(method,url,async,params,function(data){
	            console.log("data:"+data);
	              let parsedJson = JSON.parse(data);
	              
	              let htmlData = "";
	              
	              //table 데이터 삭제
	              $("#userTable>tbody").empty();
	              
	              //총글수
	              let totalCnt = 0;
	              //총페이지수
	              let pageTotal = 1;
	              
	              if(null != parsedJson && parsedJson.length > 0){
	                //총페이지수
	                //총글수/페이수-나머지가 있으면 1증가
	                totalCnt = parsedJson[0].totalCnt
	                pageTotal = Math.ceil(totalCnt/$("#pageSize").val());
	                console.log("=======================");
	                console.log("=totalCnt="+totalCnt);
	                console.log("=pageSize="+$("#pageSize").val());
	                console.log("=pageTotal="+pageTotal);
	                console.log("=======================");
	                
	                
	                $.each(parsedJson, function(index,value){
	                  //console.log(index+","+value.uId);
	                  htmlData +=" <tr> ";
	                  htmlData +="   <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+value.model   +"</td> ";        
	                  htmlData +="   <td class='text-left   col-sm-2 col-md-2 col-lg-2'>"+value.manufacturer   +"</td> ";        
	                  htmlData +="   <td class='text-left   col-sm-6 col-md-6 col-lg-6'>"+value.name  +"</td> ";        
	                  htmlData +="   <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+value.subsidy +"</td> ";        
	                  htmlData +=" </tr> ";
	                });
	                //데이터가 없는 경우
	              }else{
	                htmlData +=" <tr> ";
	                htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
	                htmlData +=" </tr> ";
	              }
	              
	              //table 데이터 출력
	              $("#userTable>tbody").append(htmlData);

	              //paging
	              //paging 데이터 삭제
	              $("#page-selection").empty();
	              renderingPage(pageTotal,1);
	              
	            
	            
	          });
	          
	      }
	    
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
	  
  });
</script>

</head>
<body>
	<header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <div id="contents">
  
  <!-- div container -->
  <div class="container">
  <!-- 테이블 목록 -->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover" id="userTable">
      <thead class="bg-primary">
        <tr>
          <th class="text-center col-sm-2 col-md-2 col-lg-2">구분</th>        
          <th class="text-center col-sm-2 col-md-2 col-lg-2">제조/수입사</th>        
          <th class="text-center col-sm-6 col-md-6 col-lg-6">차종</th>        
          <th class="text-center col-sm-2 col-md-2 col-lg-2">지원금액(만원)</th>        
        </tr>
      </thead>
      <tbody>

      </tbody>
    </table>
    </div>
    <!-- 테이블 목록 ---------------------------------------------------->
  </div>
  </div>
  
</body>
</html>