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
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">

<!-- jQuery -->
<script src="${CP_RES}/bootstrap/js/jquery-1.12.4.js"></script>

<!-- String, Number, Date Util -->
<script src="${CP_RES}/bootstrap/js/eUtil.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<title>제목</title>
<style type="text/css">
#mainButton {
	width: 48%;
	margin: auto;
}

#otherbuttons{
  margin-top: 8px;
}
</style>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	  $("#mainButton").on("click",function(){
		  console.log("엑");
		  
		  if(confirm("로그인 하시겠습니까?")==false){
			  return;
		  }
		  
		  $.ajax({ 
			   type: "POST",
			   url: "/ehr/elecmusk/doLogin.do",
			   asyn: "true",
			   dataType: "html",
			   data:{
				   userId : $("#userId").val(),
				   userPw : $("#password").val()
			   },
			   success:function(data){ //통신 성공
				   console.log(data);
			   
				   let parsedJson = JSON.parse(data);
				   
				   //아이디 확인 결과
				   //성공:10 / 아이디 존재X:20 / 아이디 안넘어감: 30
				   //비밀번호 틀림:40 / 비밀번호 안넘어감: 50
				   
				   if("20"==parsedJson.msgId){
					   alert(parsedJson.msgContents);
					   $("#userId").focus();
					   return;
					 }
				   if("30"==parsedJson.msgId){
					   alert(parsedJson.msgContents);
					   $("#userId").focus();
					   return;
					 }
				   if("40"==parsedJson.msgId){
					   alert(parsedJson.msgContents);
					   $("#password").focus();
					   return;
					 }
				   if("50"==parsedJson.msgId){
					   alert(parsedJson.msgContents);
					   $("#password").focus();
					   return;
					 }
				   
				   //성공했을 때 어떻게 할 지. 메인화면으로 보내버릴까요??
				   if("10"==parsedJson.msgId){
					   alert(parsedJson.msgContents);
					   
					   window.location.href="${CP}/elecmusk/view.do";
					 }
				   
			   },
			   error:function(data){//실패
			   
			   },
			   complete:function(data){//성공, 실패 관계 없이 출력
			   
			   }

			});
		  
		  
	  });//메인버튼(로그인 버튼) 클릭
	  
	  
	  
	  
	  
  });//document.ready
</script>

</head>
<body>

	<!-- div container -->
	<div class="container">
		<div class="page-header text-center">
			<h2>로그인</h2>
		</div>
		<form class="form-horizontal">
			<div class="form-group">
				<label for="userId" class="col-sm-3 control-label">아이디</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="userId" placeholder="아이디">
				</div>
			</div>
			<div class="form-group">
				<label for="password" class="col-sm-3 control-label">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="password" placeholder="비밀번호">
				</div>
			</div>
		</form>
    <button type="button" class="btn btn-default btn-lg btn-block" id="mainButton">로그인</button>
    <div class="col-sm-offset-3 col-sm-6" id="otherbuttons">
      <input type="button" class="btn btn-default" value="회원가입"></button>
      <input type="button" class="btn btn-default" value="아이디/비밀번호 찾기"></button>
    </div>

	</div>
	<!-- div container ------------------------------------------->

</body>
</html>