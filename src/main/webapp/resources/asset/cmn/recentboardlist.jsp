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

<!-- jQuery -->
<script src="${CP_RES}/bootstrap/js/jquery-1.12.4.js"></script>
<!-- paging -->
<script src="${CP_RES}/bootstrap/js/jquery.bootpag.js"></script>
<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>제목</title>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  doRetrieve1(1);
	  doRetrieve2(1);
	  doRetrieve3(1);
	  
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
  function doRetrieve1(page){
	  let category = 1;
    let method = "GET";
    let url    = "/board/doRetrieve.do";
    let async  = true;
    let params = {
    		category  : category,
        searchDiv : $('#searchDiv').val(),
        searchWord: $('#searchWord').val(),
        pageSize  : 5,
        pageNo    : page
    };
    
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      
      $("#freeTable>tbody").empty();
      
      let totalCnt = 0;//총글수
      let pagetotal = 0;//총페이지수
      
      if(null != parsedJson && parsedJson.length > 0){
        
        totalCnt = parsedJson[0].totalCnt;
        pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
        console.log("-----------------");
        console.log("--totalCnt--"+totalCnt);
        console.log("---pagetotal---"+pagetotal);
        console.log("---page---"+page);
        console.log("-----------------");
        
        $.each(parsedJson,function(index,value){
          //htmlData += "  <td class='text-left col-sm-6 col-dm-6 col-lg-6'><a href='#' onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "<tr>";
          htmlData += "  <td class='text-center col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.num'></c:out>+"</td>";
          htmlData += "  <td class='text-left col-sm-10 col-dm-10 col-lg-10'><a onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "  <td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>";
          htmlData += "</tr>";
          //<td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>
        });
      }//if
      else{
        htmlData += "<tr>";
        htmlData += " <td class='text-center col-sm-12 col-dm-12 col-lg-12' colspan='99'>";
        htmlData += "   No data found";
        htmlData += " </td>";
        htmlData += "</tr>";
        
        
      }//else
      
      //데이터출력
      $("#freeTable>tbody").append(htmlData);
      
    });//===============PClass.callAjax끝
  }
  function doRetrieve2(page){
	  let category = 2;
    let method = "GET";
    let url    = "/board/doRetrieve.do";
    let async  = true;
    let params = {
    		category  : category,
        searchDiv : $('#searchDiv').val(),
        searchWord: $('#searchWord').val(),
        pageSize  : 5,
        pageNo    : page
    };
    
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      
      $("#flawTable>tbody").empty();
      
      let totalCnt = 0;//총글수
      let pagetotal = 0;//총페이지수
      
      if(null != parsedJson && parsedJson.length > 0){
        
        totalCnt = parsedJson[0].totalCnt;
        pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
        console.log("-----------------");
        console.log("--totalCnt--"+totalCnt);
        console.log("---pagetotal---"+pagetotal);
        console.log("---page---"+page);
        console.log("-----------------");
        
        $.each(parsedJson,function(index,value){
          //htmlData += "  <td class='text-left col-sm-6 col-dm-6 col-lg-6'><a href='#' onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "<tr>";
          htmlData += "  <td class='text-center col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.num'></c:out>+"</td>";
          htmlData += "  <td class='text-left col-sm-10 col-dm-10 col-lg-10'><a onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "  <td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>";
          htmlData += "</tr>";
          //<td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>
        });
      }//if
      else{
        htmlData += "<tr>";
        htmlData += " <td class='text-center col-sm-12 col-dm-12 col-lg-12' colspan='99'>";
        htmlData += "   No data found";
        htmlData += " </td>";
        htmlData += "</tr>";
        
        
      }//else
      
      //데이터출력
      $("#flawTable>tbody").append(htmlData);
      
    });//===============PClass.callAjax끝
  }
  function doRetrieve3(page){
	  let category = 5;
    let method = "GET";
    let url    = "/board/doRetrieve.do";
    let async  = true;
    let params = {
    		category  : category,
        searchDiv : $('#searchDiv').val(),
        searchWord: $('#searchWord').val(),
        pageSize  : 5,
        pageNo    : page
    };
    
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      
      let parsedJson = JSON.parse(data);
      
      let htmlData = "";
      
      $("#noticeTable>tbody").empty();
      
      let totalCnt = 0;//총글수
      let pagetotal = 0;//총페이지수
      
      if(null != parsedJson && parsedJson.length > 0){
        
        totalCnt = parsedJson[0].totalCnt;
        pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
        console.log("-----------------");
        console.log("--totalCnt--"+totalCnt);
        console.log("---pagetotal---"+pagetotal);
        console.log("---page---"+page);
        console.log("-----------------");
        
        $.each(parsedJson,function(index,value){
          //htmlData += "  <td class='text-left col-sm-6 col-dm-6 col-lg-6'><a href='#' onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "<tr>";
          htmlData += "  <td class='text-center col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.num'></c:out>+"</td>";
          htmlData += "  <td class='text-left col-sm-10 col-dm-10 col-lg-10'><a onClick='doSelectOne("+<c:out value='value.bdSeq '/>+")'>"+<c:out value='value.title'></c:out>+"</a></td>";
          htmlData += "  <td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>";
          htmlData += "</tr>";
          //<td style='display: none;'>"+<c:out value='value.bdSeq '/>+"</td>
        });
      }//if
      else{
        htmlData += "<tr>";
        htmlData += " <td class='text-center col-sm-12 col-dm-12 col-lg-12' colspan='99'>";
        htmlData += "   No data found";
        htmlData += " </td>";
        htmlData += "</tr>";
        
      }//else
      
      //데이터출력
      $("#noticeTable>tbody").append(htmlData);
      
    });//===============PClass.callAjax끝
  }
  //=================================
  //조회함수 끝
  //=================================
	  
  
  //=============================doSelectOne함수
  function doSelectOne(boardSeq){
		  let url = "${CP}/board/doSelectOne.do";
	
	    url = url + "?bdSeq="+boardSeq;
	    console.log("url : "+url);
	    location.href = url;
  //=============================doSelectOne함수 끝  
  }
  
  //=============================moveToboard함수
  function moveToboard(category){
		  let url = "${CP}/board/boardView.do";
	
	    url = url + "?category="+category;
	    console.log("url : "+url);
	    location.href = url;
  //=============================moveToboard함수 끝  
  }
</script>
<style>
  a {
    text-decoration: none;
    color: #000;
    cursor:pointer;
  }
</style>
</head>
<body>
  <div class="recentboardArea" style="display: flex; ">
    <div class="table-freeresponsive" style="width:33%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3); cursor:pointer;" onclick="moveToboard(1)"><b>자유 게시판(최신)</b></h4>
    <table class="table" id="freeTable" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <tbody>
      </tbody>
    </table>
    </div>
    
    <div class="table-flawresponsive" style="width:33%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3); cursor:pointer;" onclick="moveToboard(2)"><b>결함 게시판(최신)</b></h4>
    <table class="table" id="flawTable" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <tbody>
      </tbody>
    </table>
    </div>
    
    <div class="table-noticeresponsive" style="width:33%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3); cursor:pointer;" onclick="moveToboard(5)"><b>공지 사항(최신)</b></h4>
    <table class="table" id="noticeTable" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <tbody>
      </tbody>
    </table>
    </div>
    <!-------------------------------------------------- 테이블 목록 -->
  </div>
</body>
</html>