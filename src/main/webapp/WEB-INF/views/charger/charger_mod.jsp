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
<title>데이터 수정</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
      //관리자메뉴 이동
      $("#moveToManagerPage").on("click",function(){
        
        console.log('moveToManagerPage');
        
        window.location.href = "${CP}/charger/moveToManagerPage.do";
        
      //moveToManagerPage
      });
	  
	  //삭제
	  $("#doDelete").on("click", function(){
		  if(confirm("삭제 하시겠습니까?")==false)return;
      let method  = "GET";
      let url     = "/charger/doDelete.do";
      let async   = true;
      let params  ={
    		  charger_seq : $("#charger_seq").val()
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

	      if(eUtil.ISEmpty( $("#connector").val() ) == true){
	        alert("충전기명을 입력 하세요.");
          $("#connector").focus();
	        return;
	      }     
	      
	      if(eUtil.ISEmpty( $("#image").val() ) == true){
          alert("이미지를 추가 하세요.");
          $("#image").focus();
          return;
	      }      
	      
	      if(eUtil.ISEmpty( $("#ev_current").val() ) == true){
          alert("충전전류를 입력 하세요.");
          $("#ev_current").focus();
          return;
	      }
	     
	      if(eUtil.ISEmpty( $("#ev_voltage").val() ) == true){
          alert("충전전압을 입력 하세요.");
          $("#ev_voltage").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#ev_power").val() ) == true){
          alert("충전전력을 입력 하세요.");
          $("#ev_power").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#ev_level").val() ) == true){
          alert("충전레벨을 입력 하세요.");
          $("#ev_level").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#ev_support").val() ) == true){
          alert("지원차량을 입력 하세요.");
          $("#ev_support").focus();
          return;
	      }      
	      
	      if(confirm("수정 하시겠습니까?")==false)return;
	      
	      let method = "POST";
	      let url    = "/charger/doUpdate.do";
	      let async  = true;
	      let params = {
	    		 charger_seq : $("#charger_seq").val(),
	    		 connector : $("#connector").val(),
	    		 image : $("#image").val(),
	    		 ev_current : $("#ev_current").val(),
	    		 ev_voltage : $("#ev_voltage").val(),
	    		 ev_power : $("#ev_power").val(),
	    		 ev_level : $("#ev_level").val(),
	    		 ev_support : $("#ev_support").val()
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
      window.location.href="${CP}/charger/moveToManagerPage.do";
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
       <h2>충전기 데이터 수정</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-warning btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-danger btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="moveToManagerPage">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    <!-- 폼 -->
    <form action="#" class="form-horizontal">   
    <input type="hidden" class="form-control" id="charger_seq" name="charger_seq" value="${vo.charger_seq }">
    <input type="hidden" id="image" name="image" value="${vo.image}">
      <div class="form-group">
        <label for="connector" >충전기명</label>
        <input type="text" class="form-control" id="connector" name="connector" 
        value="<c:out value='${vo.connector }' />"
        placeholder="충전기명을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="image" >이미지</label>
        <input type="text" class="form-control" id="image" name="image" 
         value="<c:out value='${vo.image}' />" 
         placeholder="이미지를 추가하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="ev_current" >충전전류</label>
        <input type="text" class="form-control" id="ev_current" name="ev_current" 
         value="<c:out value='${vo.ev_current}' />" 
         placeholder="충전전류를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="ev_voltage" >충전전압</label>
        <input type="text" class="form-control" id="ev_voltage" name="ev_voltage" 
         value="<c:out value='${vo.ev_voltage}' />" 
         placeholder="충전전압을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="ev_power" >충전전력</label>
        <input type="text" class="form-control" id="ev_power" name="ev_power" 
         value="<c:out value='${vo.ev_power}' />" 
         placeholder="충전전력을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="ev_level" >충전레벨</label>
        <input type="text" class="form-control" id="ev_level" name="ev_level" 
         value="<c:out value='${vo.ev_level}' />" 
         placeholder="충전레벨을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="ev_support" >지원차량</label>
        <input type="text" class="form-control" id="ev_support" name="ev_support" 
         value="<c:out value='${vo.ev_support}' />" 
         placeholder="지원차량을 입력하세요" maxlength="100">
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