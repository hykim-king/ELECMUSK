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
<title>관리자_충전소</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
    //관리자메뉴 이동
    $("#moveToManagerPage").on("click",function(){
      
      console.log('moveToManagerPage');
      
      window.location.href = "${CP}/station/moveToManagerPage.do";
      
    //moveToManagerPage
    });
	  
	  //삭제
	  $("#doDelete").on("click", function(){
		  if(confirm("삭제 하시겠습니까?")==false)return;
      let method  = "GET";
      let url     = "/station/doDelete.do";
      let async   = true;
      let params  ={
    		  station_seq : $("#station_seq").val()
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

	      if(eUtil.ISEmpty( $("#addr").val() ) == true){
	        alert("주소를 입력 하세요.");
          $("#addr").focus();
	        return;
	      }     
	      
	      if(eUtil.ISEmpty( $("#csnm").val() ) == true){
          alert("충전소명을 입력 하세요.");
          $("#csnm").focus();
          return;
	      }      
	      
	      if(eUtil.ISEmpty( $("#csid").val() ) == true){
          alert("충전소ID를 입력 하세요.");
          $("#csid").focus();
          return;
	      }
	     
	      if(eUtil.ISEmpty( $("#chargetp").val() ) == true){
          alert("충전기타입을 입력 하세요.");
          $("#chargetp").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#cpid").val() ) == true){
          alert("충전기ID를 입력 하세요.");
          $("#cpid").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#cpnm").val() ) == true){
          alert("충전기명칭 입력 하세요.");
          $("#cpnm").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#cpstat").val() ) == true){
          alert("충전기상태를 입력 하세요.");
          $("#cpstat").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#cptp").val() ) == true){
          alert("충전방식을 입력 하세요.");
          $("#cptp").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#lat").val() ) == true){
          alert("위도를 입력 하세요.");
          $("#lat").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#longi").val() ) == true){
          alert("경도를 입력 하세요.");
          $("#longi").focus();
          return;
	      }      
	   
	      if(eUtil.ISEmpty( $("#statupdatetime").val() ) == true){
          alert("갱신시간을 입력 하세요.");
          $("#statupdatetime").focus();
          return;
	      }      
	      
	      if(confirm("수정 하시겠습니까?")==false)return;
	      
	      let method = "POST";
	      let url    = "/station/doUpdate.do";
	      let async  = true;
	      let params = {
	    		 station_seq : $("#station_seq").val(),
           addr : $("#addr").val(),
           csnm : $("#csnm").val(),
           csid : $("#csid").val(),
           chargetp : $("#chargetp").val(),
           cpid : $("#cpid").val(),
           cpnm : $("#cpnm").val(),
           cpstat : $("#cpstat").val(),
           cptp : $("#cptp").val(),
           lat : $("#lat").val(),
           longi : $("#longi").val(),
           statupdatetime : $("#statupdatetime").val()
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
	    window.location.href="${CP}/station/moveToManagerPage.do";
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
       <h2>충전소 데이터 수정</h2>
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
    <input type="hidden" class="form-control" id="station_seq" name="station_seq" value="${vo.station_seq }">
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-warning btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-danger btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id=moveToManagerPage>
    </div>
    <!--버튼 -------------------------------------------------------------------->
    <!-- 폼 -->
    <form action="#" class="form-horizontal">   

      <div class="form-group">
        <label for="addr" >주소</label>
        <input type="text" class="form-control" id="addr" name="addr" 
        value="<c:out value='${vo.addr }' />"
        placeholder="주소를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="csnm" >충전소명</label>
        <input type="text" class="form-control" id="csnm" name="csnm" 
         value="<c:out value='${vo.csnm}' />" 
         placeholder="충전소명을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="csid" >충전소ID</label>
        <input type="text" class="form-control" id="csid" name="csid" 
         value="<c:out value='${vo.csid}' />" 
         placeholder="충전소ID를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="chargetp" >충전기타입</label>
        <input type="text" class="form-control" id="chargetp" name="chargetp" 
         value="<c:out value='${vo.chargetp}' />" 
         placeholder="충전기타입을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="cpid" >충전기ID</label>
        <input type="text" class="form-control" id="cpid" name="cpid" 
         value="<c:out value='${vo.cpid}' />" 
         placeholder="충전기ID를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="cpnm" >충전기명칭</label>
        <input type="text" class="form-control" id="cpnm" name="cpnm" 
         value="<c:out value='${vo.cpnm}' />" 
         placeholder="충전기명칭을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="cpstat" >충전기상태</label>
        <input type="text" class="form-control" id="cpstat" name="cpstat" 
         value="<c:out value='${vo.cpstat}' />" 
         placeholder="충전기상태를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="cptp" >충전방식</label>
        <input type="text" class="form-control" id="cptp" name="cptp" 
         value="<c:out value='${vo.cptp}' />" 
         placeholder="충전방식을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="lat" >위도</label>
        <input type="text" class="form-control" id="lat" name="lat" 
         value="<c:out value='${vo.lat}' />" 
         placeholder="위도를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="longi" >경도</label>
        <input type="text" class="form-control" id="longi" name="longi" 
         value="<c:out value='${vo.longi}' />" 
         placeholder="경도를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="statupdatetime" >갱신시간</label>
        <input type="text" class="form-control" id="statupdatetime" name="statupdatetime" 
         value="<c:out value='${vo.statupdatetime}' />" 
         placeholder="갱신시간을 입력하세요" maxlength="100">
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