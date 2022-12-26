<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 15        최초작성 
    
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/css/bootstrap.min.css">

<!-- jQuery -->
<script src="${CP_RES}/js/jquery-1.12.4.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>관리자_보조금</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	    //관리자메뉴 이동
      $("#moveToManagerPage").on("click",function(){
        
        console.log('moveToManagerPage');
        
        moveToManagerPage();
        
      //moveToManagerPage
      });
	  
	  //삭제
	  $("#doDelete").on("click", function(){
		  if(confirm("삭제 하시겠습니까?")==false)return;
      let method  = "GET";
      let url     = "/subsidy/doDelete.do";
      let async   = true;
      let params  ={
    		  subsidy_seq : $("#subsidy_seq").val()
      };
      PClass.callAjax(method,url,async,params,function(data){
        let parsedJson = JSON.parse(data);
        if("1" == parsedJson.msgId){
          alert(parsedJson.msgContents);
          moveToManagerPage();
        }else{
          alert(parsedJson.msgContents);
        }
      });//PClass
      
	  });//doDelete
	  
	    //수정
	    $("#doUpdate").on("click",function(){

	      if(eUtil.ISEmpty( $("#name").val() ) == true){
	        alert("자동차명을 입력 하세요.");
          $("#name").focus();
	        return;
	      }     
	      
	      if(eUtil.ISEmpty( $("#model").val() ) == true){
          alert("차종을 입력 하세요.");
          $("#model").focus();
          return;
	      }      
	      
	      if(eUtil.ISEmpty( $("#subsidy").val() ) == true){
          alert("보조금을 입력 하세요.");
          $("#subsidy").focus();
          return;
	      }
	     
	      if(eUtil.ISEmpty( $("#manufacturer").val() ) == true){
          alert("제조사를 입력 하세요.");
          $("#manufacturer").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#madeby").val() ) == true){
          alert("생산지를 입력 하세요.");
          $("#madeby").focus();
          return;
	      }      
	      
	      if(confirm("수정 하시겠습니까?")==false)return;
	      
	      let method = "POST";
	      let url    = "/subsidy/doUpdate.do";
	      let async  = true;
	      let params = {
	    		 subsidy_seq : $("#subsidy_seq").val(),
           name : $("#name").val(),
           model : $("#model").val(),
           subsidy : $("#subsidy").val(),
           manufacturer : $("#manufacturer").val(),
           madeby : $("#madeby").val()
	      };
	      
	      PClass.callAjax(method,url,async,params,function(data){
	        console.log(data);
	        let parsedJson = JSON.parse(data);
	        
	        if("1"==parsedJson.msgId){
	          alert(parsedJson.msgContents);
	          moveToManagerPage();
	        }else{
	          alert(parsedJson.msgContents);
	        }
	        
	      });
	      
	    });
	
	    
  });
  
  
  function moveToManagerPage(){
      window.location.href="${CP}/subsidy/moveToManagerPage.do";
   };
</script>

</head>
<body>
<header>
<jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
</header>

  <div id="contents">
  
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h1 style="color: orange;">관리자메뉴</h1><br>
       <h2>보조금 데이터 수정</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <input type="hidden" class="form-control" id="subsidy_seq" name="subsidy_seq" value="${vo.subsidy_seq }">
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-warning btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-danger btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="moveToManagerPage">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    <!-- 폼 -->
    <form action="#" class="form-horizontal">   

      <div class="form-group">
        <label for="name" >자동차명</label>
        <input type="text" class="form-control" id="name" name="name" 
        value="<c:out value='${vo.name }' />"
        placeholder="자동차명을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="model" >차종</label>
        <input type="text" class="form-control" id="model" name="model" 
         value="<c:out value='${vo.model}' />" 
         placeholder="(소형,중형,대형)을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="subsidy" >보조금</label>
        <input type="text" class="form-control" id="subsidy" name="subsidy" 
         value="<c:out value='${vo.subsidy}' />" 
         placeholder="보조금을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="manufacturer" >제조사</label>
        <input type="text" class="form-control" id="manufacturer" name="manufacturer" 
         value="<c:out value='${vo.manufacturer}' />" 
         placeholder="제조사를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="madeby" >생산지</label>
        <input type="text" class="form-control" id="madeby" name="madeby" 
         value="<c:out value='${vo.madeby}' />" 
         placeholder="생산지를 입력하세요" maxlength="100">
      </div>
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>
  
  </div>
  
<footer>
  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>
</body>
</html>