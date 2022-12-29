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
<%  
    String categoryValue = request.getParameter("category");
    String title = "";
    if("1".equals(categoryValue)){
      title = "자유게시판";
    }else if("2".equals(categoryValue)){
      title = "결함 게시판";
    }else if("3".equals(categoryValue)){
    	title = "뉴스";
    }else if("5".equals(categoryValue)){
    	title = "공지사항";
    }
    
    request.setAttribute("title", title);
    request.setAttribute("categoryValue", categoryValue);
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
<title>제목</title>
<script >
  $(document).ready(function(){
	  doRetrieve(1);
	  
	  
	  
	  
    //===========================검색어 enter event
    $("#searchWord").on("keydown",function(e){
      
      if(13 == e.which){
        e.preventDefault();
        doRetrieve(1);
      }
    });//========================검색어 enter event 끝
	  
	//========================================한건조회(상세조회) 테이블 클릭

	//========================================한건조회(상세조회) 테이블 클릭 끝  
	  $("#doRetrieve").on("click",function(){
		  doRetrieve(1);
	  });
	  
	  //========================================등록화면 이동
	  $("#moveToReg").on("click",function(){
		  console.log("doSave");
		  
		  let categoryValue = ${categoryValue};
		  
		  window.location.href = "${CP}/board/moveToReg.do?category="+categoryValue;
		  
	  });//========================================등록화면 이동끝
	  
	  
  });//=====================================document.ready끝
  
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
	 
   //=================================
	 //조회함수
	 //=================================
  function doRetrieve(page){
    console.log("doRetrive().page: "+page);
    
    let categoryValue = ${categoryValue};
    
    console.log("악"+categoryValue);
    
    let method = "GET";
    let url    = "/board/doRetrieve.do";
    let async  = true;
    let params = {
    		category  : categoryValue,
        searchDiv : $('#searchDiv').val(),
        searchWord: $('#searchWord').val(),
        pageSize  : $('#pageSize').val(),
        pageNo    : page
    };
    
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      
      $("#boardTable>tbody").empty();
      
      let totalCnt = 0;//총글수
      let pagetotal = 0;//총페이지수
      
      if(null != parsedJson && parsedJson.length > 0){
        
        totalCnt = parsedJson[0].totalCnt;
        pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
        console.log("-----------------");
        console.log("--totalCnt--"+totalCnt);
        console.log("---pagetotal---"+pagetotal);
        console.log("---page---"+page);
        console.log("-----------------");
        
        $.each(parsedJson,function(index,value){
          //htmlData += "  <td class='text-left col-sm-6 col-dm-6 col-lg-6'><a href='#' onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "<tr>";
          htmlData += "  <td class='text-center col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.num'></c:out>+"</td>";
          htmlData += "  <td class='text-left col-sm-6 col-dm-6 col-lg-6'><a href='#' onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "  <td class='text-center col-sm-2 col-dm-2 col-lg-2'>"+<c:out value='value.nickName'></c:out>+"</td>";
          htmlData += "  <td class='text-center col-sm-2 col-dm-2 col-lg-2'>"+<c:out value='value.modDt'></c:out>+"</td>";
          htmlData += "  <td class='text-right col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.readCnt'></c:out>+"</td>";
          htmlData += "  <td class='text-right col-sm-1 col-dm-1 col-lg-1' style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>";
          htmlData += "  <td class='text-right col-sm-1 col-dm-1 col-lg-1' style='display: none;'>"+<c:out value='value.category '/>+"</td>";
          htmlData += "</tr>";
          //<td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>
        });
      }//if
      else{
        htmlData += "<tr>";
        htmlData += " <td class='text-center col-sm-12 col-dm-12 col-lg-12' colspan='99'>";
        htmlData += "   No data found";
        htmlData += " </td>";
        htmlData += "</tr>";
        
        
      }//else
      
      //데이터출력
      $("#boardTable>tbody").append(htmlData);
      
      //paging
      $("#page-selection").empty();//페이지 삭제
      renderingPage(pageTotal,page);
      
    });//===============PClass.callAjax끝
  }
  //=================================
  //조회함수 끝
  //=================================
	  
	  
  //=====================================================page
  function renderingPage(pageTotal,page){
    console.log("pageTotal"+pageTotal);
    console.log("page"+page);
    
    pageTotal = parseInt(pageTotal);
    
    //연결된 이벤트 제거
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
        console.log("num"+num);
        doRetrieve(num);
    }); 
  }//=======================================================page 끝
  
  
  //=============================doSelectOne함수
  function doSelectOne(boardSeq){
	   let url = "${CP}/board/doSelectOne.do";

    url = url + "?bdSeq="+boardSeq;
    console.log("url : "+url);
    location.href = url;
  //=============================doSelectOne함수 끝  

  }
</script>

</head>
<body>
  <!------------------------------------------------- 헤더 -->
  <header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <!------------------------------------------------- 헤더끝 -->
  <div id="contents">
  
  <!-------------------------------------- div container -->
  <div class="container">
    <!----------------------------------- 제목 -->
    <div class="page-header">
      <h2>${title}</h2>
    </div>
    <!------------------------------------ 제목 -->
    <!---------------------------------------- 검색 : 검색 구분(select) 검색어(input) 페이지 사이즈(select) -->
    <form action="#" class="form-inline text-right">
      <div class="form-group">
        <select class="form-control input-sm" name="searchDiv" id="searchDiv">
          <option value="50">전체</option>
          <option value="10">작성자</option>
          <option value="20">제목</option>
          <option value="30">내용</option>
        </select>
        <input type="text" class="form-control input-sm" 
        name="searchWord" id="searchWord"
        placeholder="검색어를 입력하세요.">
        <select class="form-control input-sm" name="pageSize" id="pageSize">
          <option value="10">10</option>
          <option value="20">20</option>
          <option value="30">30</option>
          <option value="50">50</option>
          <option value="100">100</option>
        </select>
        <!------------------------------------- 버튼 -->
          <input type="button" class="btn btn-primary btn-sm" value="조회" id="doRetrieve">
          <input type="button" class="btn btn-primary btn-sm" value="등록" id="moveToReg">
        <!------------------------------------- 버튼 -->
      </div>
    </form>
    <!---------------------------------------- 검색 -->
    
    <!-------------------------------------------------- 테이블 목록 -->
    <div class="table-responsive">
    <table class="table table-bordered table-hover" id="boardTable">
      <thead class="bg-primary">
        <tr>
          <th class="text-center col-sm-1 col-dm-1 col-lg-1">번호</th>
          <th class="text-center col-sm-6 col-dm-6 col-lg-6">제목</th>
          <th class="text-center col-sm-2 col-dm-2 col-lg-2">작성자</th>
          <th class="text-center col-sm-2 col-dm-2 col-lg-2">등록일</th>
          <th class="text-center col-sm-1 col-dm-1 col-lg-1">조회수</th>
        </tr>
      </thead>
      <tbody>

      </tbody>
    </table>
    </div>
    <!-------------------------------------------------- 테이블 목록 -->
    
    <!-------------------------------------------------- 페이징 -->
    <div class="text-center col-sm-12 col-dm-12 col-lg-12">
      <div id="page-selection" class="text-center page"></div>
    </div>
    <!-------------------------------------------------- 페이징 -->
    
    

  
  </div>
  <!--------------------------------------- div container --->
  </div>

<jsp:include page ="/resources/asset/cmn/main_footer.jsp" flush="false"/>
</body>
</html>