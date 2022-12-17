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
<title>충전요금정보</title>
<script >
  $(document).ready(function(){
    console.log("document.ready");
    doRetrieve();
    showSlow();
    
    //등록화면으로 이동
    $("#moveToReg").on("click",function(){
      
      console.log('moveToReg');
      
      window.location.href = "${CP}/chargingfee/moveToReg.do";
      
    //moveToReg
    });
    
  });//document
    
  
    
    function doRetrieve(page){
        console.log('doRetrieve() page:'+page);
        
        let method = "GET";
        let url = "/chargingfee/doRetrieve.do";
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
          $("#rapidTable>tbody").empty();
          
          if(null != parsedJson && parsedJson.length > 0){
          
          $.each(parsedJson, function(index,value){
              //console.log(index+","+value.uId);
              htmlData +=" <tr> ";
              htmlData +="   <td width='20%' height='10%' class='text-center'><img src='"+<c:out value = 'value.image'/>+"' alt='image' style='width:50px; height:50px;' class='img-rounded'>"+<c:out value = 'value.enterprenuer'/> +"</td> ";        
              htmlData +="   <td width='20%' height='10%' class='text-center'><a href='#' onClick='doSelectOne("+<c:out value='value.provider_seq '/>+")'>"+ value.rapid_above100 +"원</td> ";        
              htmlData +="   <td width='20%' height='10%' class='text-center'>"+ value.rapid_below100 +"원</td> ";        
              htmlData +=" </tr> ";
            });
            //데이터가 없는 경우
          }else{
            htmlData +=" <tr> ";
            htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
            htmlData +=" </tr> ";
          }
        
      //table 데이터 출력
      $("#rapidTable>tbody").append(htmlData);
        
    
      
      });
            
}
    
    function showSlow(page){
        console.log('showSlow() page:'+page);
        
        let method = "GET";
        let url = "/chargingfee/showSlow.do";
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
          $("#slowTable>tbody").empty();
          
          if(null != parsedJson && parsedJson.length > 0){
          
          $.each(parsedJson, function(index,value){
              //console.log(index+","+value.uId);
              htmlData +=" <tr> ";
              htmlData +="   <td width='20%' height='10%' class='text-center'><img src='"+<c:out value = 'value.image'/>+"' alt='image' style='width:50px; height:50px;' class='img-rounded'>"+<c:out value = 'value.enterprenuer'/> +"</td> ";        
              htmlData +="   <td width='20%' height='10%' class='text-center'><a href='#' onClick='doSelectOne("+<c:out value='value.provider_seq '/>+")'>"+ value.slow_fee +"원</td> ";        
              htmlData +=" </tr> ";
            });
            //데이터가 없는 경우
          }else{
            htmlData +=" <tr> ";
            htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
            htmlData +=" </tr> ";
          }
        
      //table 데이터 출력
      $("#slowTable>tbody").append(htmlData);
        
    
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
      function doSelectOne(provider_seq){
	     let url = "${CP}/chargingfee/doSelectOne.do";
	
	    url = url + "?provider_seq="+provider_seq;
	    console.log("url : "+url);
	    location.href = url;
	    }
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
       <h2>충전요금 정보</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
  <!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select) ---------------------------------------->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
        <!------------------------------------- 버튼 -->
          <input type="button" class="btn btn-info btn-sm" value="등록" id="moveToReg">
        <!------------------------------------- 버튼 -->
      </div>
      <ul class="nav nav-tabs text-left">
        <li role="presentation" class="active" id="showRapid"><a href="">급속요금</a></li>
      </ul>
    </form>
    <!-- 검색 ----------------------------------------------------------------------------->
  
  <!-- 충전기 테이블 목록 ---------------------------------------------------------------------------->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover rapidTable" id="rapidTable">
      <thead class="bg-success">
        <tr>
          <th class="text-center"><strong>사업자명</strong></th>
          <th class="text-center"><strong>급속100kW이상요금</strong></th>
          <th class="text-center"><strong>급속100kW미만요금</strong></th>
        </tr>
      </thead>
      <tbody>
      
      </tbody>
    </table>
    </div>
  <!-- 테이블 목록 ----------------------------------------------------------------------------->
  
  <ul class="nav nav-tabs text-left">
    <li role="presentation" class="active" id="showSlow"><a href="">완속요금</a></li>
  </ul>
      
  <!-- 충전기 테이블 목록 ---------------------------------------------------------------------------->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover slowTable" id="slowTable">
      <thead class="bg-success">
        <tr>
          <th class="text-center"><strong>사업자명</strong></th>
          <th class="text-center"><strong>완속요금</strong></th>
        </tr>
      </thead>
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