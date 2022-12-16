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
	  
	  //삭제
	  $("#doDelete").on("click", function(){
		  if(confirm("삭제 하시겠습니까?")==false)return;
      let method  = "GET";
      let url     = "/chargingfee/doDelete.do";
      let async   = true;
      let params  ={
    		  provider_seq : $("#provider_seq").val()
      };
      PClass.callAjax(method,url,async,params,function(data){
        let parsedJson = JSON.parse(data);
        if("1" == parsedJson.msgId){
          alert(parsedJson.msgContents);
          moveToList();
        }else{
          alert(parsedJson.msgContents);
        }
      });//PClass
      
	  });//doDelete
	  
	    //수정
	    $("#doUpdate").on("click",function(){

	      if(eUtil.ISEmpty( $("#enterprenuer").val() ) == true){
	        alert("사업자명을 입력 하세요.");
          $("#enterprenuer").focus();
	        return;
	      }     
	      
	      if(eUtil.ISEmpty( $("#rapid_below100").val() ) == true){
          alert("급속요금을 입력 하세요.");
          $("#rapid_below100").focus();
          return;
	      }      
	      
	      if(eUtil.ISEmpty( $("#rapid_above100").val() ) == true){
          alert("급속요금을 입력 하세요.");
          $("#rapid_above100").focus();
          return;
	      }
	     
	      if(eUtil.ISEmpty( $("#slow_fee").val() ) == true){
          alert("완속요금을 입력 하세요.");
          $("#slow_fee").focus();
          return;
	      }      
	   

	      
	      if(confirm("수정 하시겠습니까?")==false)return;
	      
	      let method = "POST";
	      let url    = "/chargingfee/doUpdate.do";
	      let async  = true;
	      let params = {
	    		 provider_seq : $("#provider_seq").val(),
	    		 enterprenuer : $("#enterprenuer").val(),
	    		 rapid_below100 : $("#rapid_below100").val(),
	    		 rapid_above100 : $("#rapid_above100").val(),
	    		 slow_fee : $("#slow_fee").val()
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
	    
  });
  
  
  function moveToList(){
    window.location.href= "${CP}/chargingfee/view.do";
  }
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
       <h2>데이터 수정</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <input type="hidden" class="form-control" id="provider_seq" name="provider_seq" value="${vo.provider_seq }">
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-warning btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-danger btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="moveToList">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    <!-- 폼 -->
    <form action="#" class="form-horizontal">   

      <div class="form-group">
        <label for="enterprenuer" >사업자명</label>
        <input type="text" class="form-control" id="enterprenuer" name="enterprenuer" 
        value="<c:out value='${vo.enterprenuer }' />"
        placeholder="사업자명을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="rapid_below100" >급속100kW미만요금</label>
        <input type="text" class="form-control" id="rapid_below100" name="rapid_below100" 
         value="<c:out value='${vo.rapid_below100}' />" 
         placeholder="급속요금을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="rapid_above100" >급속100kW이상요금</label>
        <input type="text" class="form-control" id="rapid_above100" name="rapid_above100" 
         value="<c:out value='${vo.rapid_above100}' />" 
         placeholder="급속요금을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="slow_fee" >완속충전요금</label>
        <input type="text" class="form-control" id="slow_fee" name="slow_fee" 
         value="<c:out value='${vo.slow_fee}' />" 
         placeholder="완속요금을 입력하세요" maxlength="100">
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