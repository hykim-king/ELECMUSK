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
<title>댓글창</title>
<style >
.commentbox{

width: 100%;
    height: 6.25em;
    resize: none;
}


</style>
<script >

  $(document).ready(function() {
    console.log("document.ready");
    
    doRetrieve(1);
    
    //글자수 200자 제한
    $('.commentbox').keyup(function() {
      var content = $(this).val();

      //글자수 실시간 카운팅
      $('#counter').html("(" + content.length + "/최대 200자)");

      if (content.length > 200) {
        alert("최대 200자까지 입력 가능합니다.");
        $(this).val(content.substring(0, 200));
        $('#counter').html("(200/최대 200자)");
      }

    });//글자수 200자 제한

  });//document.ready
  
  function doRetrieve(page){
    console.log("악");
    
    console.log("1: "+$("#bdSeq").val());
    
    $.ajax({ 
         type: "GET",
         url: "/ehr/boardComment/doRetrieve.do",
         asyn: "true",
         dataType: "html",
         data:{
           //bdSeq : $("#bdSeq").val(),
           bdSeq : 401,
           pageSize : 50,
           pageNo : page
         },
         success:function(data){ //통신 성공
           console.log(data);
         
           let parsedJson = JSON.parse(data);
           
           console.log(parsedJson);
         
           let htmlData =""; //String str = "";
           
           $("#commentTable>tbody").empty();
           
           let totalCnt = 0;
           let pageTotal = 0;
           
           //파싱된 데이터 정리
           if(null != parsedJson && parsedJson.length > 0){
             
             totalCnt = parsedJson[0].totalCnt;
             pageTotal = Math.ceil( totalCnt/$("#pageSize").val());
             
             $.each(parsedJson,function(index,value){
               htmlData += "<tr>";
               htmlData += "  <td class='text-left col-sm-2 col-dm-2 col-lg-2'>"+<c:out value='value.memberNickname'></c:out>+"</td>";
               htmlData += "  <td class='text-left col-sm-8 col-dm-8 col-lg-8'>"+<c:out value='value.contents'></c:out>+"</td>";
               htmlData += "  <td class='text-left col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.regDt'></c:out>+"</td>";
               htmlData += "</tr>";
               
             });
             
           }else{//파싱된 데이터 정리(if문 끝)
             
           
           }//파싱된 데이터 정리(else문 끝)
           
           $("#commentTable>tbody").append(htmlData);
         },
         error:function(data){//실패
         
         },
         complete:function(data){//성공, 실패 관계 없이 출력
         
         }

   });
  }
  
</script>

</head>

<body>

<!-- 댓글 뿌리기 -->
<table class="table" id="commentTable">
  <tbody></tbody>
</table>
<!-- 댓글 뿌리기 ------------------------------------------------>

<!-- 댓글 입력 -->
  <form name="commentInsertForm" method="post" enctype="multipart/form-data">
  <div class="comtitle"><h3>댓글</h3></div>
   
  <div class="cominput" >
  <textarea class="commentbox"rows="15"  name="Com_Content" placeholder="댓글을 입력해주세요" ></textarea>
  <div class="com2">
  <div class="com_btn">
  <button type="button" class="button3">취소</button>
  <button type="button" name="commentInsertBtn" class="button1">등록</button>
  
  </div>
  <span style="color:#aaa;" id="counter">(0/최대200자)</span>
  </div>
  </div>
  </form>
<!-- 댓글 입력 --------------------------------------------------->
</body>
</html>