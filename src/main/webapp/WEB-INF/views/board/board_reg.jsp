<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 9        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  
    //공지사항(10) / 자유게시판 구분(20)
    String categoryValue = request.getParameter("category");
    String title = "";
    if("1".equals(categoryValue)){
      title = "자유게시판";
    }else if("2".equals(categoryValue)){
      title = "결함 게시판";
    }else if("3".equals(categoryValue)){
      title = "뉴스";
    }else if("5".equals(categoryValue)){
      title = "공지사항";
    }
    
    request.setAttribute("title", title);
    request.setAttribute("categoryValue", categoryValue);
%>    
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
<title>제목</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	  if(${categoryValue} == '1') {
		  doSave();
	  } else {
		  doSaveOtherCategory();
	  }
	  
	    //================================글자수 재한 보여주기(0/2000)
	    $("#contentstextarea").on("keyup",function(e){
	      //현재문자열 길이
	      let currnetLength   = $("#contentstextarea").val().length;
	      //최대 문자열 길이
	      let contentMaxLength   = 2000;
	      
	      console.log("currnetLength: "+currnetLength);
	      
	      if(contentMaxLength<currnetLength){
	        alert("입력가능한 문자수를 초과하였습니다.");
	        $("#contentstextarea").focus();
	        
	        let str = $("#contents").val();
	        str = str.substring(0,contentMaxLength);
	        $("#contentstextarea").val(str);
	        return false;
	        
	      }else{
	        $("#count").text(currnetLength);
	      }
	    });
	    //================================글자수 재한 보여주기(0/2000)끝
	  
	  $("#boardView").on("click",function(){
		  moveToList();
	  });
	  
  });//document 끝
  
  //==================================================================
  //=헤더부분 스크립트 이부분 꼭 넣으세요
  //==================================================================
  
   $(function() {
       let didScroll;
       let lastScrollTop = 0;
       let navbarHeight = $("header").outerHeight();
        $(window).scroll(function(event){
            didScroll = true;
        });
        setInterval(function() {
            if (didScroll) {
                hasScrolled();
                didScroll = false;
            }
        }); // 스크롤이 멈춘 후 동작이 실행되기 까지의 딜레이
        function hasScrolled() {
          if($(this).width() > 700) {       
          let st = $(this).scrollTop(); // 현재 window의 scrollTop 값
              if ($(window).scrollTop() > 50){
                  $(".logo-area").slideUp("fast"); // header 숨기기
                  $(".text-logo-area").addClass("visible");
              } else {
                  if($(window).scrollTop() < 200) {
                      $(".logo-area").slideDown("fast"); // header 보이기
                      $(".text-logo-area").removeClass("visible");
              }
           }
        }
     }
     });
 //==================================================================
 //=헤더부분 스크립트 이부분 꼭 넣으세요
 //==================================================================
	 
 //doSave -----------------------------------------------------------
	function doSave() {
	    $("#doSave").on("click",function(){
	        console.log("doSave");
	          if(eUtil.ISEmpty($("#title").val())==true){
	            alert("제목을 입력 하세요.");
	            $("#title").focus();
	            return;
	          }
	          
	          if(eUtil.ISEmpty($("#regId").val())==true){
	            alert("등록자를 입력 하세요.");
	            $("#regId").focus();
	            return;
	          }
	          if(eUtil.ISEmpty($("#contentstextarea").val())==true){
	            alert("내용을 입력 하세요.");
	            $("#contentstextarea").focus();
	            return;
	          } 
	          if(confirm("등록 하시겠습니까?") == false)return;
	          
	          let categoryValue = ${categoryValue};
	          let mSeq = ${sessionScope.userInfo.mSeq};
	          
	          let method    = "POST";
	          let url       = "/board/doSave.do";
	          let async     = true;
	          let params    = {
	              category : categoryValue,
	              title : "["+$("#tag").val()+"] "+$("#title").val(),
	              nickName : $("#nickName").val(),
	              contents : $("#contentstextarea").val(),
	              regId :$("#regId").val(),
	              mSeq : mSeq
	          }
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
	          
	      }); 
 } 
	//=====================================doSave 끝  
	//=====================================doSave 다른카테고리
	function doSaveOtherCategory() {
	    $("#doSave").on("click",function(){
	        console.log("doSave");
	          if(eUtil.ISEmpty($("#title").val())==true){
	            alert("제목을 입력 하세요.");
	            $("#title").focus();
	            return;
	          }
	          
	          if(eUtil.ISEmpty($("#regId").val())==true){
	            alert("등록자를 입력 하세요.");
	            $("#regId").focus();
	            return;
	          }
	          if(eUtil.ISEmpty($("#contentstextarea").val())==true){
	            alert("내용을 입력 하세요.");
	            $("#contentstextarea").focus();
	            return;
	          } 
	          if(confirm("등록 하시겠습니까?") == false)return;
	          
	          let categoryValue = ${categoryValue};
	          let mSeq = ${sessionScope.userInfo.mSeq};
	          
	          let method    = "POST";
	          let url       = "/board/doSave.do";
	          let async     = true;
	          let params    = {
	              category : categoryValue,
	              title : $("#title").val(),
	              nickName : $("#nickName").val(),
	              contents : $("#contentstextarea").val(),
	              regId :$("#regId").val(),
	              mSeq : mSeq
	          }
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
	          
	      });
 } 
	//=====================================doSave 다른카테고리
  function moveToList(){

    let categoryValue = ${categoryValue};
	  window.location.href="${CP}/board/boardView.do?category="+categoryValue;
  }
	 
</script>

</head>
<body>
  <!------------------------------------------------- 헤더 -->
  <header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <!------------------------------------------------- 헤더끝 -->
  <div id="contents">
  <!-------------------------------------- div container -->
  <div class="container">
    <!----------------------------------- 제목 -->
    <div class="page-header">
      <h2>게시등록</h2>
    </div>
    <!------------------------------------ 제목 -->
    
    <!------------------------------------- 버튼 -->
    <div class="row text-right">

       <input type="hidden" class="form-control" id="nickName" name="nickName" placeholder="등록자 입력하세요" value="${sessionScope.userInfo.nickname}" readonly="readonly" maxlength="100">
       <input type="hidden" id="regId" name="regId" value="${sessionScope.userInfo.userId}">
       <input type="button" class="btn btn-primary btn-sm" value="등록" id="doSave">
       <input type="button" class="btn btn-primary btn-sm" value="목록" id="boardView">
    </div>
    <!------------------------------------- 버튼 -->
    
    <!--------------------------------------------------------- 폼 -->
    <form action="#" class="form-horizontal">
      <div class="form-group">
      <c:choose>
        <c:when test="${categoryValue == '1'}">
          <label for="title">태그</label>
		        <select class="form-control input-sm" name="tag" id="tag">
		          <option value="자유">자유</option>
		          <option value="유머">유머</option>
		          <option value="거래">거래</option>
		          <option value="건의">건의</option>
		        </select>
	        </c:when>
        </c:choose>
        <label for="title">제목</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="제목 입력하세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="contentstextarea">내용</label>
        <textarea class="form-control" style="resize:none;" rows="10" id="contentstextarea" name="contentstextarea" ></textarea>
        <div class="text-right col-sm-12 col-dm-12 col-lg-12"><span id="count">0</span>/2000</div>
      </div>
    </form>
    <!--------------------------------------------------------- 폼 -->
  
  
  
  
  
  </div>
  <!--------------------------------------- div container --->
  </div>
  <jsp:include page ="/resources/asset/cmn/main_footer.jsp" flush="false"/>
</body>
</html>