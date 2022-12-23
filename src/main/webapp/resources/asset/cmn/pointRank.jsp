<%--
/**
  Class Name: board_list.jsp
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 5        최초작성 
    
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
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${CP_RES}/main_home.css">
<!-- jQuery -->
<script src="${CP_RES}/bootstrap/js/jquery-1.12.4.js"></script>
<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>제목</title>
<script >
  $(document).ready(function(){
	  pointRank();
	  
  });//=====================================document.ready끝
  
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
	 
   //=================================
	 //조회함수
	 //=================================
  function pointRank(){
    let method = "GET";
    let url    = "/elecmusk/pointRank.do";
    let async  = true;
    let params = {};
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      let pointRankis;
      if(null != parsedJson && parsedJson.length > 0){
    	  $.each(parsedJson,function(index,value){
    		  htmlData += "<tr>                                                                                        ";
    		  htmlData += "<td class='text-center col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.num'/>+"</td>      ";
    		  htmlData += "<td class='text-center col-sm-3 col-dm-3 col-lg-3'>"+<c:out value='value.nickname'/>+"</td> ";
    		  htmlData += "<td class='text-center col-sm-3 col-dm-3 col-lg-3'>"+<c:out value='value.point'/>+" 포인트</td>    ";
    		  htmlData += "</tr>                                                                                       ";
    	  });
      }
      $("#pointRankArea").append(htmlData);    
    });//===============PClass.callAjax끝
  }
</script>
<style>
  a {
    text-decoration: none;
    color: #000;
  }
  a:hover{
    text-decoration: underline;
  }
</style>
</head>
<body>
  <div class="pointRankArea" style="display: flex; ">
    
    <div class="table-freeresponsive" style="width:100%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3)"><b>포인트 랭킹</b></h4>
    <table class="table" id="pointRankArea" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <thead>
        <th class="text-center col-sm-1 col-dm-1 col-lg-1">순위</th>
        <th class="text-center col-sm-3 col-dm-3 col-lg-3">이름</th>
        <th class="text-center col-sm-3 col-dm-3 col-lg-3">포인트</th>
      </thead>
      <tbody>
      </tbody>
    </table>
    </div>
    <!-------------------------------------------------- 테이블 목록 -->
  
  </div>
  <!--------------------------------------- div container --->
</body>
</html>