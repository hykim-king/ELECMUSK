<%--
/**
  Class Name: board_mod.jsp
  Description: 공지/자유 게시판 수정,삭제
  
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
	  
	  //수정
	  $("#doUpdate").on("click",function(){
		  
		  //구분
		  if(eUtil.ISEmpty( $("#div").val() ) == true){
			  alert("구분을 입력 하세요.");
			  return;
		  }

      //SEQ
      if(eUtil.ISEmpty( $("#seq").val() ) == true){
        alert("SEQ를 입력 하세요.");
        return;
      }		  
      
      //충전소명
      if(eUtil.ISEmpty( $("#csnm").val() ) == true){
          alert("충전소명을 입력 하세요.");
          $("#csnm").focus();
          return;
      }      
      //제목
      if(eUtil.ISEmpty( $("#title").val() ) == true){
          alert("제목을 입력 하세요.");
          $("#title").focus();
          return;
      }      
      
      //수정자
      if(eUtil.ISEmpty( $("#modId").val() ) == true){
          alert("수정자를 입력 하세요.");
          $("#modId").focus();
          return;
      }
     
      //내용
      if(eUtil.ISEmpty( $("#contents").val() ) == true){
          alert("내용을 입력 하세요.");
          $("#contents").focus();
          return;
      }      
		  
      if(confirm("수정 하시겠습니까?")==false)return;
      
      let method = "POST";
      let url    = "/board/doUpdate.do";
      let async  = true;
      let params = {
    		  div: $("#div").val(),
    		  seq: $("#seq").val(),
    		  csnm: $("#csnm").val(),
    		  title: $("#title").val(),
    		  modId: $("#modId").val(),
    		  contents:$("#contents").val()
      };
      
      PClass.callAjax(method,url,async,params,function(data){
    	  console.log(data);
    	  let parsedJson = JSON.parse(data);
    	  
    	  if("1"==parsedJson.msgId){
    		  alert(parsedJson.msgContents);
    		  moveToList();
    	  }else{
    		  alert(parsedJson.msgContents);
    	  }
    	  
      });
      
	  });
	  
	  //목록으로 이동
	  $("#moveToList").on("click",function(){
		  console.log("moveToList");
		  moveToList();
	  });
	  
	  $("#doDelete").on("click",function(){
		  console.log("doDelete");
		  
		  //div,seq 전달
      if(eUtil.ISEmpty($("#category").val()) == true){
          alert("구분을 입력 하세요.");
          return;
      }
		  
      if(eUtil.ISEmpty($("#bdSeq").val()) == true){
          alert("SEQ를 입력 하세요.");
          return;
      }
      
      if(confirm("삭제 하시겠습니까?")==false)return;
      
      let method = "GET";
      let url = "/review/doDelete.do";
      let async = true;
      let params = {
    		  category: $("#category").val(),
    		  bdSeq: $("#bdSeq").val()
      };
      
      PClass.callAjax(method,url,async,params,function(data){
    	  console.log(data);
    	  let parsedJson = JSON.parse(data);
        if("1" == parsedJson.msgId){
            alert(parsedJson.msgContents);
            moveToList();
        }else{
            alert(parsedJson.msgContents);
        }
          
      });
		  
		//doDelete  
	  });
	  
	//document  
  });
  
  function moveToList(){
	    window.location.href= "${CP}/review/rvboardView.do?category="+${vo.category };
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
      <input type="button" class="btn btn-primary btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-primary btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="moveToList">
    </div>
    <!--버튼 -------------------------------------------------------------------->

    <!-- 폼 -->
    <form action="#" class="form-horizontal">   
<input type="hidden" class="form-control" id="category" name="category" value="${vo.category }">
    <input type="hidden" class="form-control" id="bdSeq" name="bdSeq" value="${vo.bdSeq }">
	    <div class="form-group">
		    <label for="csnm" >충전소명</label>
		    <input type="text" class="form-control" id="csnm" name="csnm"
		     value="<c:out value='${vo.csnm }' />"
		     placeholder="충전소명을 입력하세요" maxlength="100">
	    </div>
	    <div class="form-group">
		    <label for="title" >제목</label>
		    <input type="text" class="form-control" id="title" name="title"
		     value="<c:out value='${vo.title }' />"
		     placeholder="제목을 입력하세요" maxlength="100">
	    </div>
      <div class="form-group">
        <label for="regId" >수정자</label>
        <input type="text" class="form-control" id="modId" name="modId" 
        value="<c:out value='${vo.modId }' />"
        placeholder="등록자를 입력하세요" maxlength="100">
      </div>
      
      <!-- 조회수 -->
      <div class="form-group">
        <label for="regDt" >조회수</label>
        <input type="text" class="form-control" id="readCnt" name="readCnt" 
         value="<c:out value='${vo.readCnt}' />" 
         readonly="readonly"
         placeholder="조회수" maxlength="100">
      </div>
            
      
      <!-- 등록일 -->
      <div class="form-group">
        <label for="regDt" >등록일</label>
        <input type="text" class="form-control" id="regDt" name="regDt" 
         value="<c:out value='${vo.regDt }' />" 
         readonly="readonly"
         placeholder="등록일" maxlength="100">
      </div>
      <!-- 등록자 -->
      <div class="form-group">
        <label for="regId" >등록자</label>
        <input type="text" class="form-control" id="regId" name="regId" 
         value="<c:out value='${vo.regId }' />"
         readonly="readonly"
        placeholder="등록자" maxlength="100">
      </div>
            
      <div class="form-group">
        <label for="contentstextarea" >내용</label>
        <textarea class="form-control" rows="10" id="contentstextarea" name="contentstextarea"><c:out value="${vo.contents}"/></textarea>
      </div>      	    
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>   
  <!-- div container ---------------------------------------------------------->
     
     
     </div>
</body>
</html>





















