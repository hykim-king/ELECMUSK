<%--
/**
  Class Name: board_reg.jsp
  Description: 공지/자유 게시판 등록
  
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
     String categoryValue = request.getParameter("category");
     String title = "";
     if("9".equals(categoryValue)){
         title = "충전소 리뷰게시판";
     }else{
         title = "";
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
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
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
	  
    
      
	  $("#contentsarea").on("keyup",function(e){
		  
		  //현재 문자열 길이
		  let currnetLength    = $("#contentsarea").val().length;
		  //최대 문자열
		  let contentMaxLength = 2000;

      if(currnetLength > contentMaxLength){
        alert("최대 "+contentMaxLength+"까지 입력 가능합니다.");
        $("#contentsarea").focus();
        
        
        //글자 자르기
        let str = $("#contentsarea").val();
        str  = str.substring(0, contentMaxLength);
	      $("#contentsarea").val(str);
	      
      }else{
    	  $("#count").text(currnetLength);
      }
	  
		//  
	  });   
	  
	  //등록
	  $("#doSave").on("click",function(){
		  console.log("doSave");
		  
		  if(eUtil.ISEmpty($("#title").val()) == true){
			  alert("제목을 입력 하세요.");
			  $("#title").focus();
			  return;
		  }
		  
		  
	    if(eUtil.ISEmpty($("#regId").val()) == true){
          alert("등록자를 입력 하세요.");
          $("#regId").focus();
          return;
	    }
	      
      if(eUtil.ISEmpty($("#contentsarea").val()) == true){
          alert("내용을 입력 하세요.");
          $("#contentsarea").focus();
          return;
      }	      
	      
      if(confirm("등록 하시겠습니까?")==false)return;
      let categoryValue = ${categoryValue};
      let method = "POST";
      let url    = "/review/doSave.do";
      let async  = true;
      let params = {
    		  category : categoryValue,
    		  title : $("#title").val(),
    		  regId : $("#regId").val(),
    		  contents : $("#contentsarea").val()
      };
      
      PClass.callAjax(method,url,async,params,function(data){
    	  console.log(data);
    	//JSON.parse() 메서드는 JSON 문자열의 구문을 분석하고, 
    	//그 결과에서 JavaScript 값이나 객체를 생성합니다.
    	  let parsedJson = JSON.parse(data);
    	
    	  if("1" == parsedJson.msgId){
    		  alert(parsedJson.msgContents);
    		  moveToList();
    	  }else{
    		  alert(parsedJson.msgContents);
    	  }
    	
      });
      
      
	  });
	  
	  //목록으로 이동
	  $("#boardView").on("click",function(){
		  console.log("boardView");
		  moveToList();
		//boardView  
	  });
	  
	//document  
  });
  
  function moveToList(){
	  let categoryValue = ${categoryValue};
	  window.location.href= "${CP}/review/rvboardView.do?category="+categoryValue;
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
  <!------------------------------------------------- 헤더 -->
  <header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <!------------------------------------------------- 헤더끝 -->
  <div id="contents">
  <!-- div container -->   
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h2>${title}</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
   
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-primary btn-sm" value="등록" id="doSave">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="boardView">
    </div>
    <!--버튼 -------------------------------------------------------------------->

    <!-- 폼 -->
    <form action="#" class="form-horizontal" >   


	    <div class="form-group">
		    <label for="title" >제목</label>
		    <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" maxlength="100">
	    </div>
      <div class="form-group">
        <label for="regId" >등록자</label>
        <input type="text" class="form-control" id="regId" name="regId" placeholder="등록자를 입력하세요" maxlength="100"
          
        >
      </div>
      <div class="form-group">
        <label for="contentsarea" >내용</label>
        <span id="count">0</span>/10
        <textarea class="form-control" rows="10" id="contentsarea" name="contentsarea" ></textarea>
        
      </div>      	    
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>   
  <!-- div container ---------------------------------------------------------->
     
     
  </div>  
</body>
</html>





















