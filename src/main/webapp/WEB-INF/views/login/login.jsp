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

<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
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
	  
  });
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