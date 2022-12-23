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
	  doRetriveBlog(1);
	  doRetriveNews(1);
	  
  });//=====================================document.ready끝
   //=================================
	 //조회함수
	 //=================================
  function doRetriveBlog(page) {
      let method = "GET";
      let url    = "/elecmusk/doNaverSearch.do";
      let async  = true;
      let param  = {
          searchDiv : 10,
          searchWord: $("#searchWord").val(),
          pageSize : $("#pageSize").val(),
          pageNo: page
      };
      PClass.callAjax(method,url,async,param,function(data){
            //JSON.parse() 메서드는 JSON 문자열의 구문을 분석하고, 그 결과에서 JavaScript 값이나 객체를 생성합니다.
            let parsedJson = JSON.parse(data);
            let htmlData = "";
            $("#BlogTable>tbody").empty();
            
            if(null != parsedJson && parsedJson.items.length > 0) {
                $.each(parsedJson.items, function(index, value) {
                    htmlData += " <tr>                                                                                             ";
                    htmlData += "   <td class='text-left col-sm-9 col-md-9 col-lg-9'>"+<c:out value='value.title'/>+"</td>       ";
                    htmlData += "   <td class='text-center col-sm-1 col-md-1 col-lg-1'><a href='"+<c:out value='value.link'/>+"' target='blank'><span class='glyphicon glyphicon-play'/></a></td>       ";
                    htmlData += " </tr>                                                                                            ";
                })
            } //json if문 end -----
            
            $("#BlogTable>tbody").append(htmlData);
      });
    }
  function doRetriveNews(page) {
      console.log("doRetrive page: "+page);
      
      let method = "GET";
      let url    = "/elecmusk/doNaverSearch.do";
      let async  = true;
      let param  = {
          searchDiv : 20,
          searchWord: $("#searchWord").val(),
          pageSize : $("#pageSize").val(),
          pageNo: page
      };
      PClass.callAjax(method,url,async,param,function(data){
            //JSON.parse() 메서드는 JSON 문자열의 구문을 분석하고, 그 결과에서 JavaScript 값이나 객체를 생성합니다.
            let parsedJson = JSON.parse(data);
            let htmlData = "";
            $("#NewsTable>tbody").empty();
            
            if(null != parsedJson && parsedJson.items.length > 0) {
                $.each(parsedJson.items, function(index, value) {
                    htmlData += "    <tr>                                                                                                                        ";
                    htmlData += "      <td class='text-left col-sm-9 col-md-9 col-lg-9'>"+<c:out value='value.title'/>+"</td>                                  ";
                    htmlData += "      <td class='text-center col-sm-1 col-md-1 col-lg-1'><a href='"+<c:out value='value.link'/>+"' target='blank'><span class='glyphicon glyphicon-play'/></a></td>                                  ";
                    htmlData += "    </tr>                                                                                                                       ";
                })
            } //json if문 end -----
            
            $("#NewsTable>tbody").append(htmlData);
      });
    }
  //=================================
  //조회함수 끝
  //=================================
	  
  function moveToBlog(){
    if(${null != sessionScope.userInfo.status}){
      let url = "${CP}/elecmusk/blogView.do";
      location.href = url;
    }
  //=============================moveToboard함수 끝  
  }
  
  function moveToNews(){
    if(${null != sessionScope.userInfo.status}){
      let url = "${CP}/elecmusk/naverview.do";
      location.href = url;
    }
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
    <div class="table-freeresponsive" style="width:100%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3); cursor:pointer;" onclick="moveToNews()"><b>뉴스(최신)</b></h4>
    <table class="table" id="NewsTable" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <tbody>
      </tbody>
    </table>
      <input type="hidden" id="pageSize" value="10">
      <input type="hidden" id="searchWord" value="전기차">
    </div>
    <div class="table-flawresponsive" style="width:100%; margin: 5px; padding: 5px;">
    <h4 style="border: 2px solid rgba(200,200,200,0.4); padding:5px; border-radius: 10px; background-color: rgba(222,222,222,0.3); cursor:pointer;" onclick="moveToBlog()"><b>블로그(최신)</b></h4>
    <table class="table" id="BlogTable" style="border-bottom: 1px solid rgba(222,222,222,1)">
      <tbody>
      </tbody>
    </table>
    </div>
    <!-------------------------------------------------- 테이블 목록 -->
  </div>
</body>
</html>