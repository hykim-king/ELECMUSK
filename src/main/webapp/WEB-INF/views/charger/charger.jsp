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
<link rel="shortcut icon" type="image/x-icon" href="${CP_RES}/asset/cmn/favicon.ico"> 
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${CP_RES}/main_home.css">
<style>
.chargerTable{
  width: 100%
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
<title>충전기정보</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  doRetrieve();
	  
	//관리자메뉴 이동
  $("#moveToManagerPage").on("click",function(){
    
    console.log('moveToManagerPage');
    
    window.location.href = "${CP}/charger/moveToManagerPage.do";
    
  //moveToManagerPage
  });
	  
  });//document
	  
	  
	  function doRetrieve(page){
		    console.log('doRetrieve() page:'+page);
		    
		    let method = "GET";
		    let url = "/charger/doRetrieve.do";
		    let async = true;
		    let params  = {
		        searchDiv : $('#searchDiv').val(),
		        searchWord: $("#searchWord").val(),
		        pageSize : $("#pageSize").val(),
		        pageNo: page
		    };
	          
		    PClass.callAjax(method,url,async,params,function(data){
          console.log("data:"+data);
          
          let parsedJson = JSON.parse(data);
          
          let htmlData = "";
          
          //table 데이터 삭제
          $("#chargerTable>tbody").empty();

          
          if(null != parsedJson && parsedJson.length > 0){
        	  
              totalCnt = parsedJson[0].totalCnt;
              pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
              console.log("----------------------------");
              console.log("-totalCnt:"+totalCnt);
              console.log("-pageSize:"+$("#pageSize").val());
              console.log("-pageTotal:"+pageTotal);
              console.log("-page:"+page);
              console.log("----------------------------");
          
              
          $.each(parsedJson, function(index,value){
              //console.log(index+","+value.uId);
              htmlData +=" <tr> ";
              htmlData +=" <div>"
              htmlData +="   <td width='33%' rowspan='4'><img src='"+<c:out value = 'value.image'/>+"' alt='Responsive image' style='width:100%; height:100%;' class='img-rounded img-responsive'></td> ";        
              htmlData +=" </div>"
              htmlData +=" <tr> ";
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>충전기명</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+<c:out value = 'value.connector'/> +"</td> ";        
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>충전전류</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+ value.ev_current +"</td> ";        
              htmlData +=" </tr> ";
              htmlData +=" <tr> ";
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>충전전압</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+ value.ev_voltage +"</td> ";        
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>충전전력</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+ value.ev_power +"</td> ";        
              htmlData +=" </tr> ";
              htmlData +=" <tr> ";
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>충전레벨</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+ value.ev_level +"</td> ";        
              htmlData +="   <td width='11%' height='12.5%' class='text-center bg-success'><strong>지원차량</strong> </td> ";        
              htmlData +="   <td width='22%' height='12.5%' class='text-center'>"+ value.ev_support +"</td> ";        
              htmlData +=" </tr> ";
              htmlData +=" </tr> ";
            });
            //데이터가 없는 경우
          }else{
            htmlData +=" <tr> ";
            htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
            htmlData +=" </tr> ";
          }
        
      //table 데이터 출력
      $("#chargerTable>tbody").append(htmlData);
      
      //paging
      $("#page-selection").empty();//페이저 삭제
      renderingPage(pageTotal,page);
        
    
        });
	          
}
	     //paging
	     function renderingPage(pageTotal, page){
	       console.log("pageTotal:"+pageTotal);
	       console.log("page:"+page);
	       
	       pageTotal = parseInt(pageTotal);
	       
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
	           console.log("num:"+num);
	           doRetrieve(num);
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
    <!-- 제목 -->
    <div class="page-header">
       <h2>충전기 정보</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <input type="hidden" id="pageSize" name="pageSize" value="10">
  <!---------------------------------------- 검색 : 검색 구분(select) 검색어(input) 페이지 사이즈(select) -->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
        <!------------------------------------- 버튼 -->
          <c:choose>
            <c:when test="${2 <= sessionScope.userInfo.status && not empty sessionScope.userInfo}">
              <input type="button" class="btn btn-info btn-sm" value="관리자메뉴" id="moveToManagerPage">
            </c:when>
            <c:otherwise>
            </c:otherwise>
          </c:choose>
        <!------------------------------------- 버튼 -->
      </div>
    </form>
    <!---------------------------------------- 검색 -->
    
  <!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select) ---------------------------------------->
  
  <!-- 충전기 테이블 목록 ---------------------------------------------------------------------------->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover chargerTable" id="chargerTable">
      <tbody>
        
      </tbody>
    </table>
    </div>
  <!-- 테이블 목록 ----------------------------------------------------------------------------->
    
    <!-- 페이징 -->
    <div class="text-center col-sm-12 col-md-12 col-lg-12">
      <div id="page-selection" class="text-center page"></div>    
    </div>
    <!-- 페이징--- -------------------------------------------------------------->
  </div>
  <!-- div container -->
</div>
<!-- div contents -->

<footer>
  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>
</body>
</html>