<%--
/**
  Class Name:fileUpload.jsp
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 11. 28        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@page import="java.util.Formatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" href="${CP_RES}/css/bootstrap.min.css">

<!-- jQuery -->
<script src="${CP_RES}/js/jquery-1.12.4.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>파일 업,다운로드</title>
<script >
$(document).ready(function(){
    console.log("document.ready");
    
    $(".downloadTable>tbody").on("click","tr",function(e){
    	console.log("click tbody");
    	let tdArrays = $(this).children();
    	let orgFileNm = tdArrays.eq(0).text();
    	let saveFileName = tdArrays.eq(1).text();
    	let savePath = tdArrays.eq(2).text();
    	console.log("orgFileNm: "+orgFileNm);
    	console.log("saveFileName: "+saveFileName);
    	console.log("savePath: "+savePath);
    	
    	$("#orgFileName").val(orgFileNm);
    	$("#saveFileName").val(saveFileName);
    	$("#savePath").val(savePath);
    	
    	document.filedownloadFrm.submit();
    });
    
    $("#doSaveFile").on("click",function(){
        console.log("doSaveFile");
        
        let fileInput = $("#file01")[0];
        console.log("fileInput: "+fileInput);
        
        if(fileInput.files.length === 0){
          alert("파일을 선택해 주셔요.");
          return;
        }
        
        console.log("fileInput.files.length: "+fileInput.files.length);
        
        //javascript : <form></form>
        let formData = new FormData();
        
        for(let i=0;i<fileInput.files.length;i++){
          formData.append("image"+i,fileInput.files[i]);
        }
        
        //image란 이름으로, 파일객체 지정
        
        
        //contentType : default값은 "application/x-www-form-urlencoded; charset=UTF-8"
        //-->multipart/form-data로 전송되도록 false설정
        //processData : true -> query string으로 데이터 전달! ex)http://localhost:8089?title = 1234
        
        console.log("data:formData: "+formData);
        
        $.ajax({ 
           type: "POST",
           url: "${CP}/file/ajaxUpload.do",
           processData: false, //
           contentType: false,
           asyn: "true",
           //dataType: "html",
           data: formData,
           success:function(data){ //통신 성공
             console.log(data);
           
             let htmlData = "";

             if(null != data && data.length > 0) {
                   $.each(data, function(index, value) {
                   let imgPath = "${CP}/"+value.imageViewPath+"/"+value.saveFileName;
                   console.log("imgPath: "+imgPath);
                   htmlData += "<tr>";
                   htmlData += "    <td class='text-center col-sm-1 col-md-1 col-lg-1'>"+value.orgFileName+"</td>";    
                   htmlData += "    <td class='text-left col-sm-6 col-md-6 col-lg-8'>"+value.saveFileName+"</td>";
                   htmlData += "    <td class='text-center col-sm-2 col-md-2 col-lg-1'>"+value.savePath+"</td>";
                   htmlData += "    <td class='text-center col-sm-2 col-md-2 col-lg-1'>"+value.ext+"</td>";
                   htmlData += "    <td class='text-right col-sm-1 col-md-1 col-lg-1'>"+value.fileSize+"</td>";
                   htmlData += "    <td class='text-right col-sm-1 col-md-1 col-lg-1'><img src='"+imgPath+"'></td>";
                   htmlData += "</tr>";                
                   });
             }
             $("#fileTable>tbody").append(htmlData);  

           },
           error:function(data){//실패
           
           },
           complete:function(data){//성공, 실패 관계 없이 출력
           
           }

        });
        
        
      });//-----------------------------doSaveFile 끝
    
 });//document
</script>

</head>
<body>
  <!-- div container -->   
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h2>게시등록</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-primary btn-sm" value="등록" id="doSaveFile">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    
    <!-- 폼 -->
    <!-- 파일 보낼때 필수. -->
    <form action="${CP}/file/upload.do" method="post" enctype="multipart/form-data" class="form-horizontal">   
	    <div class="form-group">
		    <label for="file01" >일반파일</label>
		    <input type="file" multiple="multiple" class="form-control" id="file01" name="file01" placeholder="파일을 입력해주세요" maxlength="100">
	    </div>
      <div class="form-group">
        <label for="file02" >이미지</label>
        <input type="file" class="form-control" id="file02" name="file02" placeholder="파일을 입력해주세요" maxlength="100">
      </div>
      <div class="form-group">
        <label for="regId" ></label>
        <input type="submit" class="form-control" value="전송">
      </div>
    </form>
    <!--폼   -------------------------------------------------------------------->
     
    <!-------------------------------------------------- 테이블 목록 -->
    <div class="table-responsive">
    <table id="fileTable" class="downloadTable table table-striped table-bordered table-hover">
      <thead class="bg-primary">
        <tr>
          <th class="text-center col-sm-1 col-dm-1 col-lg-1">원본 파일명</th>
          <th class="text-center col-sm-6 col-dm-6 col-lg-6">저장 파일명</th>
          <th class="text-center col-sm-2 col-dm-2 col-lg-2">저장경로</th>
          <th class="text-center col-sm-2 col-dm-2 col-lg-2">사이즈</th>
          <th class="text-center col-sm-1 col-dm-1 col-lg-1">확장자</th>
        </tr>
      </thead>
      <tbody>
	      <c:choose>
	        <c:when test="${list.size()>0}">
	          <c:forEach var="vo" items="${list}">
			        <tr>
			          <td class="text-center col-sm-1 col-dm-1 col-lg-1">${vo.orgFileName}</td>
			          <td class="text-left col-sm-6 col-dm-6 col-lg-6">${vo.saveFileName}</td>
			          <td class="text-center col-sm-2 col-dm-2 col-lg-2">${vo.savePath}</td>
			          <td class="text-center col-sm-2 col-dm-2 col-lg-2"><fmt:formatNumber value='${vo.fileSize}'/></td>
			          <td class="text-right col-sm-1 col-dm-1 col-lg-1">${vo.ext}</td>
			        </tr>
	          </c:forEach>
	        </c:when>
	        <c:otherwise>
	         
	        </c:otherwise>
	      </c:choose>
      </tbody>
    </table>
    <form action="${CP}/file/download.do" name="filedownloadFrm" method="post">
      <input type="text" name="orgFileName" id="orgFileName">
      <input type="text" name="saveFileName" id="saveFileName">
      <input type="text" name="savePath" id="savePath">
    </form>
    
    </div>
    <!-------------------------------------------------- 테이블 목록 --> 
    </div>
    <!-- div container ---------------------------------------------------------->
     
     
</body>
</html>





















