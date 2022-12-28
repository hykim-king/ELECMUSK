<%--
/**
  Class Name: board_list.jsp
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 5        최초작성 
    
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
<link rel="shortcut icon" type="image/x-icon" href="${CP_RES}/asset/cmn/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${CP_RES}/main_home.css">

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
<title>블로그</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  doRetrive(1);
	  
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
	  
  });
  
  function doRetrive(page) {
	    console.log("doRetrive page: "+page);
	    
	    let method = "GET";
	    let url    = "/elecmusk/doNaverSearch.do";
	    let async  = true;
	    let param  = {
	        searchDiv : 10,
	        searchWord: $("#searchWord").val(),
	        pageSize : $("#pageSize").val(),
	        pageNo: page
	    };
	    PClass.callAjax(method,url,async,param,function(data){
	          //JSON.parse() 메서드는 JSON 문자열의 구문을 분석하고, 그 결과에서 JavaScript 값이나 객체를 생성합니다.
	          let parsedJson = JSON.parse(data);
	          
	          let htmlData = "";
	          
	          let totalCnt = 0; // 총글수
	          let pageTotal = 0; // 총페이지수
	          
	          $("#blogTableArea").empty();
	          
	          if(null != parsedJson && parsedJson.items.length > 0) {
	            totalCnt = parsedJson.total;
	            pageTotal = Math.ceil(totalCnt/($("#pageSize").val()))
		            $.each(parsedJson.items, function(index, value) {
		                htmlData += "<table id='blogTable' class='table table-striped table-bordered' style='width:45%; margin:10px; max-height:30%;'>                                                     ";
		                htmlData += " <tr style='height:20%;'>                                                                                                                                             ";
		                htmlData += "   <td class='text-left col-sm-2 col-md-2 col-lg-2'>"+<c:out value='value.bloggername'/>+"</td>                                                                       ";
		                htmlData += "   <td class='text-center col-sm-4 col-md-4 col-lg-4'>"+<c:out value='value.title'/>+"</td>                                                                           ";
		                htmlData += "   <td class='text-center col-sm-1 col-md-1 col-lg-1'><a href='"+<c:out value='value.link'/>+"' target='blank'><span class='glyphicon glyphicon-play'/></a></td>";
		                htmlData += " </tr>                                                                                                                                                                ";
		                htmlData += " <tr>                                                                                                                                                                 ";
		                htmlData += "   <td colspan='3' class='text-left col-sm-6 col-md-6 col-lg-6'>"+<c:out value='value.description'/>+"</td>                                                                 ";
		                htmlData += " </tr>                                                                                                                                                                ";
		                htmlData += "</table>                                                                                                                                                              ";		            	
		            })
	          } //json if문 end -----
	          
	          $("#blogTableArea").append(htmlData);
	          
	          $("#page-selection").empty();
	          renderingPage(pageTotal,page);
	    });
	  }
  
	//paging
	function renderingPage(pageTotal, page){
	    pageTotal=parseInt(pageTotal);
	    
	    //연결된 EventHandler제거
	    $('#page-selection').unbind('page');
	    
	    $('#page-selection').bootpag({
	        total: pageTotal,
	        page: page,
	        maxVisible: 10,
	        leaps: true,
	        firstLastUse: true,
	        first: '←',
	        last: '→',
	        wrapClass: 'pagination',
	        activeClass: 'active',
	        disabledClass: 'disabled',
	        nextClass: 'next',
	        prevClass: 'prev',
	        lastClass: 'last',
	        firstClass: 'first'
	    }).on("page", function(event, num){
	        doRetrive(num);
	    });     
	  }  
</script>

</head>
<body>
<header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
</header>
  <!-- div contents -->   
  <div id="contents">   
    <!-- 제목 -->
    <h2>블로그</h2>
    <input type="hidden" id="searchWord" value="전기차">
    <input type="hidden" id="pageSize" value="8">
    <hr/>
    <!-- 테이블 목록 -->
    <div class="table-responsive" id="blogTableArea" style="display:flex; flex-direction: row; flex-wrap: wrap; height:800px;">
    
	    <table id='blogTable' class='table table-striped table-bordered' style='width:45%; margin:10px; max-height:30%;'>
	     <tr style="height:20%;">
	       <td class='text-left col-sm-2 col-md-2 col-lg-2'>블로거 이름</td>
	       <td class='text-center col-sm-4 col-md-4 col-lg-4'>제목</td>
	       <td class='text-center col-sm-1 col-md-1 col-lg-1'><span class="glyphicon glyphicon-play"></span></td>
	     </tr>         
	     <tr>
	       <td colspan="3" class='text-left col-sm-6 col-md-6 col-lg-6'>내용</td>
	     </tr>
	    </table>                                                                                                                         
    
    </div>
    <!-- 테이블 목록 -------------------------------------------------------------->
  </div>   
  <!-- div contents ---------------------------------------------------------->
  
    <!-- 페이징 -->
    <div class="text-center col-sm-12 col-md-12 col-lg-12">
      <div id="page-selection" class="text-center page"></div>    
    </div>
    <!-- 페이징--- -------------------------------------------------------------->    
<jsp:include page ="/resources/asset/cmn/main_footer.jsp" flush="false"/>
</body>
</html>


















