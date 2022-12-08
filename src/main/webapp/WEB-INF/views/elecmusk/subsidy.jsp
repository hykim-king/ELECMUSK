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
	  
	  doRetrieve(1);
	  
	  $("#doRetrieve").on("click", function(){
	      console.log("#doRetrieve");
	      
	      doRetrieve(1);
	      
	    //doRetrieve  
	    });
	  //document  
	 });
	  
	  
	  
	  function doRetrieve(page){
		    console.log('doRetrieve() page:'+page);
		    
		    let method = "GET";
		    let url = "/subsidy/doRetrieve.do";
		    let async = true;
		    let params = {
		        searchDiv : $('#searchDiv').val(),
		        searchWord : $('#searchWord').val(),
		        pageSize : $('#pageSize').val(),
		        pageNo : page
		    };
	          
        PClass.callAjax(method,url,async,params,function(data){
          console.log("data:"+data);
          
          let parsedJson = JSON.parse(data);
          
          let htmlData = "";
          
          //table 데이터 삭제
          $("#subsidyTable>tbody").empty();
          
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
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'><input type='checkbox' name='chk' value='" +value.uId+"' ></td> ";        
              htmlData +="   <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+value.model +"</td> ";        
              htmlData +="   <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+value.manufacturer +"</td> ";        
              htmlData +="   <td class='text-center col-sm-5 col-md-5 col-lg-5'>"+value.name +"</td> ";        
              htmlData +="   <td class='text-center col-sm-3 col-md-3 col-lg-3'>"+value.subsidy +"</td> ";        
              htmlData +=" </tr> ";
            });
            //데이터가 없는 경우
          }else{
            htmlData +=" <tr> ";
            htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
            htmlData +=" </tr> ";
          }
        
      //table 데이터 출력
        $("#subsidyTable>tbody").append(htmlData);
          
        });
	          
	  }
	    
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
	  
</script>

</head>
<body>
	<header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <div id="contents">
  
  <!-- div container -->
  <div class="container">
  ${list }
  
  <!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select) ---------------------------------------->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
        <select class="form-control input-sm" name="searchDiv" id="searchDiv">
          <c:forEach var="code" items="${BOARD_SEARCH }">
            <option value='<c:out value="${code.detCode }"></c:out>'>
              <c:out value="${code.detName }"></c:out>
            </option>  
          </c:forEach>
        </select>
        <input type="text" class="form-control input-sm" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요.">
        <select class="form-control input-sm" name="pageSize" id="pageSize">
          <option value="10">10</option>
          <option value="20">20</option>
          <option value="30">30</option>
          <option value="50">50</option>
          <option value="100">100</option>
        </select>
        <input type="button" class="btn btn-success btn-sm" value="조회" id="doRetrieve">
        <input type="button" class="btn btn-warning btn-sm" value="삭제" id="doDelete">
        <input type="button" class="btn btn-info btn-sm" value="등록" id="doSave">
      </div>
    </form>
    <!-- 검색 ----------------------------------------------------------------------------->
  
  <!-- 테이블 목록 ---------------------------------------------------------------------------->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover" id="subsidyTable">
      <thead class="bg-primary">
        <tr>
          <th class="text-center col-sm-1 col-md-1 col-lg-1"><input type="checkbox" id="checkAll"></th>
          <th class="text-center col-sm-2 col-md-2 col-lg-2">구분</th>        
          <th class="text-center col-sm-2 col-md-2 col-lg-2">제조/수입사</th>        
          <th class="text-center col-sm-5 col-md-5 col-lg-5">차종</th>        
          <th class="text-center col-sm-3 col-md-3 col-lg-3">지원금액(만원)</th>        
        </tr>
      </thead>
      <tbody>
        
      </tbody>
    </table>
    </div>
    <!-- 테이블 목록 ----------------------------------------------------------------------------->
    
    <!-- 페이징 -->
    <div class="text-center">
      <nav>
        <ul class="pagination">
          <li>
            <a href="#" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
          </li>
          <li><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">4</a></li>
          <li><a href="#">5</a></li>
          <li>
            <a href="#" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
    <!-- 페이징 ---------------------------------------------------->
  </div>
  </div>
  
</body>
</html>