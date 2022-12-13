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

<!-- 페이징 추가할 때 추가 -->

<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>제목</title>
<style type="text/css">
#container{
  margin-bottom: 100px;
}

#mainButton {
  width: 48%;
  margin: auto;
}

#otherbuttons{
  margin-top: 8px;
}

h4{
  margin-top: 40px;
  margin-bottom: 20px;
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
	<div class="container" id="container">
		<div class="page-header text-center">
			<h2>회원관리</h2>
		</div>

		<!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select)-->
		<form action="#" class="form-inline text-right">
			<div class="form-group">
				<select class="form-control input-sm" name="searchDiv"
					id="searchDiv">
					<option value="">전체</option>
					<option value="10">아이디</option>
					<option value="20">이름</option>
					<option value="30">이메일</option>
				</select> <input type="text" class="form-control input-sm" name="searchWord"
					id="searchWord" placeholder="검색어를 입력하세요"> <select
					class="form-control input-sm" name="pageSize" id="pageSize">
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="50">50</option>
					<option value="100">100</option>
				</select> <input type="button" class="btn btn-primary btn-sm" value="조회"
					id="doRetrive"> <input type="button"
					class="btn btn-primary btn-sm" value="삭제" id="upDeleteAll">
			</div>
			<!-- 검색부분 ----------------------------------------->


		</form>
		<table class="table table-striped table-bordered table-hover"
			id="userTable">
			<thead class="bg-primary">
				<tr>
					<th class="text-center col-sm-1 col-md-1 col-lg-1"><input
						type="checkbox" id="checkAll"></th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">고유번호</th>
					<th class="text-center col-sm-2 col-md-2 col-lg-2">아이디</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">닉네임</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">이름</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">생년월일</th>
					<th class="text-center col-sm-2 col-md-2 col-lg-2">이메일</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">포인트</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">가입일</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">상태</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<!-- 테이블 목록 -------------------------------------------------------------->

		<!-- 페이징 -->
		<div class="text-center col-sm-12 col-md-12 col-lg-12">
			<div id="page-selection" class="text-center page"></div>
		</div>
		<!-- 페이징--- -------------------------------------------------------------->

	</div>
	<!-- div container ------------------------------------------->

</body>
</html>