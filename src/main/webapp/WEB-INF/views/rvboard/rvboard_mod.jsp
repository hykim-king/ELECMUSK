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
     //공지사항(10)/자유게시판 구분(20)
     String divValue = request.getParameter("div");
     String title = "";
     if("20".equals(divValue)){
       title = "자유게시판 상세";
     }else{
       title = "공지사항 상세";
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
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/css/bootstrap.min.css">

<!-- jQuery -->
<script src="${CP_RES}/js/jquery-1.12.4.js"></script>
<!-- callAjax -->
<script src="${CP_RES}/js/callAjax.js"></script>
<!-- String, Number, Date Util -->
<script src="${CP_RES}/js/eUtil.js"></script>

<!-- paging -->
<script src="${CP_RES}/js/jquery.bootpag.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/js/bootstrap.min.js"></script>

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
      if(eUtil.ISEmpty($("#div").val()) == true){
          alert("구분을 입력 하세요.");
          return;
      }
		  
      if(eUtil.ISEmpty($("#seq").val()) == true){
          alert("SEQ를 입력 하세요.");
          return;
      }
      
      if(confirm("삭제 하시겠습니까?")==false)return;
      
      let method = "GET";
      let url = "/board/doDelete.do";
      let async = true;
      let params = {
    		  div: $("#div").val(),
    		  seq: $("#seq").val()
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
	    window.location.href= "${CP}/board/boardView.do?div="+$("#div").val();
	  }
  
  
  
</script>

</head>
<body>
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
      <input type="hidden" name="div" id="div" value="${vo.getDiv()}">
      <input type="hidden" name="seq" id="seq" value="${vo.seq}">
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
        <label for="contents" >내용</label>
        <textarea class="form-control" rows="10" id="contents" name="contents"><c:out value="${vo.contents}"/></textarea>
      </div>      	    
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>   
  <!-- div container ---------------------------------------------------------->
     
     
     
</body>
</html>





















