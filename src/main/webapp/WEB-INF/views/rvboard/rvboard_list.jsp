<%--
/**
  Class Name: bootList.jsp
  Description: 목록
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 11. 28        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
     //공지사항(10)/자유게시판 구분(20)
     String divValue = request.getParameter("div");
     String title = "";
     if("40".equals(divValue)){
    	 title = "충전소 리뷰게시판";
     }else{
    	 title = "";
     }
     
     request.setAttribute("title", title);
     request.setAttribute("divValue", divValue);
%>
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
<title>${title}</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");

	  //paging
	  renderingPage('${pageTotal}',1);
	  //테이블 클릭
	  $("#boardTable>tbody").on("click","tr",function(e){
		  console.log('#boardTable>tbody');
		  let tdArray = $(this).children();
		  let boardSeq = tdArray.eq(5).text();
		  
		  console.log('boardSeq:'+boardSeq);
	    console.log('#boardTable>tbody');
		  
		  if(confirm("상세 조회를 하시겠습니까?")==false)return;
		  //div,seql
		  window.location.href = "${CP}/rvboard/doSelectOne.do?div="+$("#div").val()+"&seq="+boardSeq;
		  
		  
		//#boardTable>tbody
	  });
	  
	  //등록화면으로 이동
	  $("#moveToReg").on("click",function(){
		  
		  console.log('moveToReg');
		  console.log('div:'+$("#div").val());
		  
		  window.location.href = "${CP}/rvboard/moveToReg.do?div="+$("#div").val();
		  
		//moveToReg
	  });
	  
	  //검색어 enter event
	  $("#searchWord").on("keypress",function(e){
		  
		  if(13==e.which){
			  e.preventDefault();
			  doRetrive(1);
		  }
		  
	  });
	  
	  
	  $("#doRetrive").on("click",function(){
		  console.log('doRetrive');
		  
		  doRetrive(1);
		  
		//doRetrive
	  });  
	
	//document  
  });
  
  function doRetrive(page){
	  console.log('doRetrive() page:'+page);
	  
	  let method  ="GET";
	  let url     ="/rvboard/doRetrive.do";
	  let async   =true;
	  
	  //전체
	  let searchDivValue = $('#searchDiv').val();
	  
	  if('ALL' == searchDivValue){
		  searchDivValue = "";
	  }
	  
	  let params  = {
			  div: $("#div").val(),
			  searchDiv  : searchDivValue,
			  searchWord : $('#searchWord').val(),
			  pageSize : $('#pageSize').val(),
			  pageNo:page			  
	  };
	  
	  PClass.callAjax(method,url,async,params,function(data){
		  console.log(data);
		  let parsedJson = JSON.parse(data);
		  
		  let htmlData = "";
		  
		  //기존 데이터 삭제
		  $("#rvboardTable>tbody").empty();
		  
		  let totalCnt = 0;//총글수  
		  let pageTotal = 0;//총페이지수
		  
		  if(null != parsedJson && parsedJson.length  > 0){
			  
			  totalCnt = parsedJson[0].totalCnt;
			  pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
			  console.log("----------------------------");
			  console.log("-totalCnt:"+totalCnt);
			  console.log("-pageTotal:"+pageTotal);
			  console.log("-page:"+page);
			  console.log("----------------------------");
			  
			  $.each(parsedJson,function(index,value){
				  
				  htmlData += "<tr>";
				  htmlData += "    <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.num'/>+"</td>";    
				  htmlData += "    <td class='text-center col-sm-2 col-md-2 col-lg-2'>"+<c:out value='value.csnm'/>+"</td>";    
				  htmlData += "    <td class='text-left col-sm-6 col-md-6 col-lg-6'>"+<c:out value='value.title'/>+"</td>";
				  htmlData += "    <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.nickName'/>+"</td>";
				  htmlData += "    <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.modDt'/>+"</td>";
				  htmlData += "    <td class='text-right col-sm-1 col-md-1 col-lg-1'>"+<c:out value='value.readCnt'/>+"</td>";
				  htmlData += "    <td style='display:none;'>"+<c:out value='value.bdSeq'/>+"</td>";
				  htmlData += "</tr>";
				  
			  });
			//if  
		  }
		  else{
				  htmlData += "<tr>";
				  htmlData += "  <td class='text-center col-sm-12 col-md-12 col-lg-12' colspan='99'>";
					htmlData += "   No data found ";
					htmlData += "  </td>";
				  htmlData += "</tr>";
		  }
		    
		  //데이터 출력
		  $("#rvboardTable>tbody").append(htmlData);
		  
		  //paging
		  $("#page-selection").empty();//페이저 삭제
		  renderingPage(pageTotal,page);
		  
		//PClass.callAjax  
	  });	  
	  
  }
  
  
		    //paging
		    function renderingPage(pageTotal, page){
		      console.log("pageTotal:"+pageTotal);
		      console.log("page:"+page);
		      
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
		          console.log("num:"+num);
		          doRetrive(num);
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
       <h2>충전소 리뷰 게시판</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select)--> 
    <form action="#" class="form-inline text-right" >
      <input type="hidden" name="div" id="div" value="${divValue}" >  
      <div class="form-group">
				<select class="form-control input-sm" name="searchDiv" id="searchDiv">
          <c:forEach var="code" items="${BOARD_SEARCH}">
            <option value='<c:out value="${code.detCode }"/>' >
              <c:out value="${code.detName }" />
            </option>
          </c:forEach>
				</select>
				<input type="text" class="form-control input-sm" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요">
        <select class="form-control input-sm" name="pageSize" id="pageSize">
          <c:forEach var="code" items="${PAGE_SIZE}">
            <option value='<c:out value="${code.detCode }"/>'>
              <c:out value="${code.detName }" />
            </option>
          </c:forEach>
        </select>
        <input type="button" class="btn btn-primary btn-sm" value="조회" id="doRetrive">
        <input type="button" class="btn btn-primary btn-sm" value="등록" id="moveToReg">				      
      </div>
    </form> 
    <!-- 검색 ------------------------------------------------------------------->
    
    <!-- 테이블 목록 -->
    <div class="table-responsive">
    <table id="rvboardTable" class="table table-striped table-bordered table-hover">
      <thead class="bg-primary">
        <tr>
          <th class="text-center col-sm-1 col-md-1 col-lg-1">번호</th>
          <th class="text-center col-sm-2 col-md-2 col-lg-2">충전소명</th>
          <th class="text-center col-sm-6 col-md-6 col-lg-6">제목</th>
          <th class="text-center col-sm-1 col-md-1 col-lg-1">작성자</th>
          <th class="text-center col-sm-1 col-md-1 col-lg-1">등록일</th>
          <th class="text-center col-sm-1 col-md-1 col-lg-1">조회수</th>
          <th style='display:none;'>SEQ</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${list.size()>0 }">
             <c:forEach var="vo" items="${list }" >
			        <tr>
			          <td class="text-center col-sm-1 col-md-1 col-lg-1"><c:out value="${vo.num }"></c:out></td>
			          <td class="text-center col-sm-2 col-md-2 col-lg-2"><c:out value="${vo.csnm }"></c:out></td>
			          <td class="text-left col-sm-6 col-md-6 col-lg-6"><c:out value="${vo.title }"></c:out></td>
			          <td class="text-center col-sm-1 col-md-1 col-lg-1"><c:out value="${vo.modId }"></c:out></td>
			          <td class="text-center col-sm-1 col-md-1 col-lg-1"><c:out value="${vo.modDt }"></c:out></td>
			          <td class="text-right col-sm-1 col-md-1 col-lg-1"><c:out value="${vo.readCnt }"></c:out></td>
			          <td style='display:none;'><c:out value="${vo.bdSeq }"></c:out></td>
			        </tr>              
             </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td class="text-center col-sm-12 col-md-12 col-lg-12" colspan="99">
                  No data found
              </td>
            </tr>
          </c:otherwise>
        </c:choose>
      
     
            
      </tbody>
    </table>
    </div>
    <!-- 테이블 목록 -------------------------------------------------------------->

    <!-- 페이징 -->
    <div class="text-center col-sm-12 col-md-12 col-lg-12">
      <div id="page-selection" class="text-center page"></div>    
    </div>
    <!-- 페이징--- -------------------------------------------------------------->    
  </div>   
  <!-- div container ---------------------------------------------------------->
</div>

<footer>
  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>  
</body>
</html>


















