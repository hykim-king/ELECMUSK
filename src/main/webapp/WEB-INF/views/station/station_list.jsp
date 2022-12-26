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
<title>관리자_충전소</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	  doRetrieve(1);

	  
	  $("#keywordRetrieve").on("click",function(){
		  doRetrieve(1);
	  });
	  
	  //지도화면으로 이동
    $("#moveToMap").on("click",function(){
      
      console.log('moveToMap');
      
      window.location.href = "${CP}/station/moveToMap.do";
      
    //moveToReg
    });
	  
	  //등록화면으로 이동
    $("#moveToReg").on("click",function(){
      
      console.log('moveToReg');
      
      window.location.href = "${CP}/station/moveToReg.do";
      
    //moveToReg
    });
	  
	  

	  
	  //document  
	 });
	  
	  
	  
	  function doRetrieve(page){
		    console.log('doRetrieve() page:'+page);
		    
		    let method = "GET";
		    let url = "/station/doRetrieve.do";
		    let async = true;
		    let params = {
		        pageSize : $('#pageSize').val(),
		        pageNo : page,
		        addrKeyword : $('#addrKeyword').val(),
		        cpnmKeyword : $('#cpnmKeyword').val(),
		        cptpKeyword : $('#cptpKeyword').val(),
		    };
	          
        PClass.callAjax(method,url,async,params,function(data){
          console.log("data:"+data);
          
          let parsedJson = JSON.parse(data);
          
          let htmlData = "";
          
          //table 데이터 삭제
          $("#stationTable>tbody").empty();
          
          //총글수
          let totalCnt = 0;
          //총페이지수
          let pageTotal = 0;
          
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
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.num'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+<c:out value='value.addr'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-3 col-md-3 col-lg-3'><a href='#' onClick='doSelectOne("+<c:out value='value.station_seq '/>+")'>"+<c:out value='value.csnm'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.csid'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.chargetp'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.cpid'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.cpnm'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.cpstat'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.cptp'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.lat'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.longi'/> +"</td> ";        
              htmlData +="   <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.statupdatetime'/> +"</td> ";        
              htmlData +=" </tr> ";
            });
            //데이터가 없는 경우
          }else{
            htmlData +=" <tr> ";
            htmlData +="   <td colspan='99' class='text-center col-sm-12 col-md-12 col-lg-12'>no data found</td> ";
            htmlData +=" </tr> ";
          }
        
      //table 데이터 출력
        $("#stationTable>tbody").append(htmlData);
          
      //paging
        $("#page-selection").empty();//페이저 삭제
        renderingPage(pageTotal,page);
      
        });//PClass.callAjax
	          
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
	    //=============================doSelectOne함수
  function doSelectOne(station_seq){
     let url = "${CP}/station/doSelectOne.do";

    url = url + "?station_seq="+station_seq;
    console.log("url : "+url);
    location.href = url;
	   }
  //=============================doSelectOne함수 끝  
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
       <h1 style="color: orange;">관리자메뉴</h1><br>
       <h2>충전소 데이터 관리</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!-- 문단  -->
    <dl>
      <dt>데이터 설명</dt>
      <dd>충전기타입(1:완속,2:급속)</dd>
      <dd>충전기상태(1: 충전가능, 2: 충전중, 3:고장/점검, 4:통신장애, 5:통신미연결)</dd>
      <dd>충전방식 (1:B타입(5핀), 2: C타입(5핀), 3:BC타입(5핀),4: BC타입(7핀),5: DC차 데모, 6:AC 3상, 7: DC콤보,8: DC차데모+DC콤보. 9:DC차데모+AC3상, 10: DC차데모+DC콤보, AC3상)</dd>
    </dl>
    <!-- 문단  ------------------------------------------------------->
    <!---------------------------------------- 검색 : 검색 구분(select) 검색어(input) 페이지 사이즈(select) -->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
          
        <!------------------------------------- 버튼 -->
          <input type="button" class="btn btn-success btn-sm" value="지도" id="moveToMap">
          <input type="button" class="btn btn-info btn-sm" value="등록" id="moveToReg">
        <!------------------------------------- 버튼 -->
      </div>
    </form>
    <!---------------------------------------- 검색 -->
    
  <!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select) ---------------------------------------->
    <div class="select-area">
    
    <table>
      <thead>
        <th>&nbsp;</th>
        <th>주소</th>
        <th>충전타입</th>
        <th>충전방식</th>
      </thead>
      <tbody>
        <tr>
          <td>
            <label>키워드</label>
            <input type="hidden" id="pageSize" name="pageSize" value="10">
          </td>
          <td>
            <select id="addrKeyword" name="addrKeyword">
              <option value="">전체</option>
              <option value="서울">서울</option>
              <option value="인천">인천</option>
              <option value="경기">경기</option>
              <option value="강원">강원</option>
              <option value="대전">대전</option>
              <option value="세종">세종</option>
              <option value="대구">대구</option>
              <option value="울산">울산</option>
              <option value="광주">광주</option>
              <option value="부산">부산</option>
              <option value="제주">제주</option>
              <option value="경상북도">경상북도</option>
              <option value="경상남도">경상남도</option>
              <option value="전라북도">전라북도</option>
              <option value="전라남도">전라남도</option>
              <option value="충청북도">충청북도</option>
              <option value="충청남도">충청남도</option>
            </select>
          </td>
          <td>
            <select id="cpnmKeyword" name="cpnmKeyword">
              <option value="">전체</option>
              <option value="완속">완속</option>
              <option value="급속">급속</option>
            </select>
          </td>
          <td>
            <select id="cptpKeyword" name="cptpKeyword">
              <option value="">전체</option>
              <option value="1">B타입(5핀)</option>
              <option value="2">C타입(5핀)</option>
              <option value="3">BC타입(5핀)</option>
              <option value="4">BC타입(7핀)</option>
              <option value="5">DC차 데모</option>
              <option value="6">AC 3상</option>
              <option value="7">DC콤보</option>
              <option value="8">DC차데모+DC콤보</option>
              <option value="9">DC차데모+AC3상</option>
              <option value="10">DC차데모+DC콤보, AC3상</option>
            </select>
          </td>

          <td>
            <input type="button" class="btn btn-primary btn-sm" value="조회" id="keywordRetrieve">
          </td>
        </tr>
      </tbody>
    </table>
    </div>
    <!-- 검색 ----------------------------------------------------------------------------->
  
  <!-- 테이블 목록 ---------------------------------------------------------------------------->
    <div class="table-responsive">
    <table class="table table-striped table-hover" id="stationTable">
      <thead class="bg-success">
        <tr>
          <th class="text-center col-sm-1 col-md-1 col-lg-1">번호</th>        
          <th class="text-center col-sm-2 col-md-2 col-lg-2">주소</th>        
          <th class="text-center col-sm-3 col-md-3 col-lg-3 bg-warning">충전소명</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전소ID</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전기타입</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전기ID</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전기명칭</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전기상태</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">충전방식</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">위도</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">경도</th>        
          <th class="text-center col-sm-1 col-md-1 col-lg-1">갱신시간</th>        
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