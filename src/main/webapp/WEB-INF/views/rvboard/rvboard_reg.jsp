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
     String divValue = request.getParameter("div");
     String title = "";
     if("20".equals(divValue)){
       title = "자유게시판 등록";
     }else{
       title = "공지사항 등록";
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
	  
    
      
	  $("#contents").on("keyup",function(e){
		  
		  //현재 문자열 길이
		  let currnetLength    = $("#contents").val().length;
		  //최대 문자열
		  let contentMaxLength = 2000;

      if(currnetLength > contentMaxLength){
        alert("최대 "+contentMaxLength+"까지 입력 가능합니다.");
        $("#contents").focus();
        
        
        //글자 자르기
        let str = $("#contents").val();
        str  = str.substring(0, contentMaxLength);
	      $("#contents").val(str);
	      
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
	      
      if(eUtil.ISEmpty($("#contents").val()) == true){
          alert("내용을 입력 하세요.");
          $("#contents").focus();
          return;
      }	      
	      
      if(confirm("등록 하시겠습니까?")==false)return;
		  
      let method = "POST";
      let url    = "/board/doSave.do";
      let async  = true;
      let params = {
    		  div : $("#div").val(),
    		  title : $("#title").val(),
    		  regId : $("#regId").val(),
    		  contents : $("#contents").val()
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
      <input type="button" class="btn btn-primary btn-sm" value="등록" id="doSave">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="boardView">
    </div>
    <!--버튼 -------------------------------------------------------------------->

    <!-- 폼 -->
    <form action="#" class="form-horizontal" >   

      <div class="form-group">
      <label for="title" >게시구분</label>
      <select class="form-control input-sm" name="div" id="div" disabled="disabled">
        <c:forEach  var="code" items="${BOARD_DIV}">
            <option value='<c:out value="${code.detCode }"/>' 
              <c:if test="${code.detCode == vo.getDiv() }">selected</c:if>
            >
              <c:out value="${code.detName }" />
            </option>        
        </c:forEach>
      </select>
      </div>
	    <div class="form-group">
		    <label for="title" >제목</label>
		    <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" maxlength="100">
	    </div>
      <div class="form-group">
        <label for="regId" >등록자</label>
        <input type="text" class="form-control" id="regId" name="regId" placeholder="등록자를 입력하세요" maxlength="100"
          value="${sessionScope.userInfo.uId }" readonly="readonly"
        >
      </div>
      <div class="form-group">
        <label for="contents" >내용</label>
        <span id="count">0</span>/10
        <textarea class="form-control" rows="10" id="contents" name="contents" ></textarea>
        
      </div>      	    
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>   
  <!-- div container ---------------------------------------------------------->
     
     
     
</body>
</html>





















