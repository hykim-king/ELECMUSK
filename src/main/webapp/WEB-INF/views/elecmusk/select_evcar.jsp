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
<link rel="stylesheet" href="${CP_RES}/evCar.css">
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
<title>evCarData</title>
<script>
	$(document).ready(function() {
		console.log("carNo: "+ $("#carNo").val());
		
		
		//document End -------------------------------------------------------------
	});
</script>
</head>
<body>
  <!-- div container -->   
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h2>전기차 정보 관리</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-primary btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-primary btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="boardView">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    
    <!-- 폼 -->
    <form action="#" class="form-horizontal"> 
    <input type="text" id="carNo" name="carNo" value="${vo.getcarNo()}">  
      <div class="form-group">
        <label for="title" >제목</label>
        <input type="text" class="form-control" value="<c:out value="${vo.title}"/>" id="title" name="title" placeholder="제목을 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="modId" >수정자</label>
        <input type="text" class="form-control" value="<c:out value="${vo.modId}"/>"  id=modId name="modId" placeholder="수정자를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="readCnt" >조회수</label>
        <input type="text" class="form-control" value="<c:out value="${vo.readCnt}"/>" id="readCnt" name="readCnt" placeholder="수정자를 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="modDt" >등록일</label>
        <input type="text" class="form-control" value="<c:out value="${vo.regDt}"/>" readonly="readonly"  id="modDt" name="modDt" maxlength="100">
      </div>
      <div class="form-group">
        <label for="regId" >등록자</label>
        <input type="text" class="form-control" value="<c:out value="${vo.regId}"/>" readonly="readonly" id="regId" name="regId" maxlength="100">
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
