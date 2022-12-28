<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 15        최초작성 
    
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" type="image/x-icon" href="${CP}/favicon.ico">   
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="${CP_RES}/css/bootstrap.min.css">

<!-- jQuery -->
<script src="${CP_RES}/js/jquery-1.12.4.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>관리자_충전요금</title>
<script >
  $(document).ready(function(){
    console.log("document.ready");
    
    function readImage(input) {
        // 인풋 태그에 파일이 있는 경우
        if(input.files && input.files[0]) {
            // 이미지 파일인지 검사 (생략)
            // FileReader 인스턴스 생성
            const reader = new FileReader();
            // 이미지가 로드가 된 경우
            reader.onload = e => {
                const previewImage = document.getElementById("preview-image");
                previewImage.src = e.target.result;
            }
            // reader가 이미지 읽도록 하기
            reader.readAsDataURL(input.files[0]);
        }
    }
    // input file에 change 이벤트 부여
    const inputImage = document.getElementById("file01");
    inputImage.addEventListener("change", e => {
        readImage(e.target);
    });   
    
      //관리자메뉴 이동
      $("#moveToManagerPage").on("click",function(){
        
        console.log('moveToManagerPage');
        
        window.location.href = "${CP}/chargingfee/moveToManagerPage.do";
        
      //moveToManagerPage
      });
    
    //삭제
    $("#doDelete").on("click", function(){
      if(confirm("삭제 하시겠습니까?")==false)return;
      let method  = "GET";
      let url     = "/chargingfee/doDelete.do";
      let async   = true;
      let params  ={
          provider_seq : $("#provider_seq").val()
      };
      PClass.callAjax(method,url,async,params,function(data){
        let parsedJson = JSON.parse(data);
        if("1" == parsedJson.msgId){
          alert(parsedJson.msgContents);
          moveToManagerPage();
        }else{
          alert(parsedJson.msgContents);
        }
      });//PClass
      
    });//doDelete
    
      //수정
      $("#doUpdate").on("click",function(){

        if(eUtil.ISEmpty( $("#enterprenuer").val() ) == true){
          alert("사업자명을 입력 하세요.");
          $("#enterprenuer").focus();
          return;
        }     
        
        if(eUtil.ISEmpty( $("#rapid_below100").val() ) == true){
          alert("급속요금을 입력 하세요.");
          $("#rapid_below100").focus();
          return;
        }      
        
        if(eUtil.ISEmpty( $("#rapid_above100").val() ) == true){
          alert("급속요금을 입력 하세요.");
          $("#rapid_above100").focus();
          return;
        }
       
        if(eUtil.ISEmpty( $("#slow_fee").val() ) == true){
          alert("완속요금을 입력 하세요.");
          $("#slow_fee").focus();
          return;
        }      
     

        
        if(confirm("수정 하시겠습니까?")==false)return;
        
        let method = "POST";
        let url    = "/chargingfee/doUpdate.do";
        let async  = true;
        let params = {
           provider_seq : $("#provider_seq").val(),
           image : $("#image").val(),
           enterprenuer : $("#enterprenuer").val(),
           rapid_below100 : $("#rapid_below100").val(),
           rapid_above100 : $("#rapid_above100").val(),
           slow_fee : $("#slow_fee").val()
        };
        
        PClass.callAjax(method,url,async,params,function(data){
          console.log(data);
          let parsedJson = JSON.parse(data);
          
          if("1"==parsedJson.msgId){
            alert(parsedJson.msgContents);
            moveToManagerPage();
          }else{
            alert(parsedJson.msgContents);
          }
          
        });
        
      });
  
      $("#doSaveFile").on("click",function(){
          console.log("doSaveFile");
          $("#preview-image").css("display","block");
          
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
               let imgPath = "";
               
               if(null != data && data.length > 0) {
                     $.each(data, function(index, value) {
                     ///ehr/resources/asset/imgs/evcar_imgs/G70.png
                     imgPath = "/ehr"+value.imageViewPath+"/"+value.saveFileName;
                     });
               }
               $("#image").val(imgPath);

             },
             error:function(data){//실패
             
             },
             complete:function(data){//성공, 실패 관계 없이 출력
             
             }

          });
          
          
        });//-----------------------------doSaveFile 끝  
      
  });
  
  
  function moveToManagerPage(){
    window.location.href="${CP}/chargingfee/moveToManagerPage.do";
  };
</script>

</head>
<body>
<header>
<jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
</header>

  <div id="contents">
  
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h1 style="color: orange;">관리자메뉴</h1><br>
       <h2>충전요금 데이터 수정</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!--버튼  -->
    <div class="row text-right">
      <input type="button" class="btn btn-warning btn-sm" value="수정" id="doUpdate">
      <input type="button" class="btn btn-danger btn-sm" value="삭제" id="doDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="moveToManagerPage">
    </div>
    <!--버튼 -------------------------------------------------------------------->
    <!-- 폼 -->
    <form action="#" class="form-horizontal">   
    <input type="hidden" class="form-control" id="provider_seq" name="provider_seq" value="${vo.provider_seq }">
    <input type="hidden" id="image" name="image" value="${vo.image}">
      <!-- 이미지 미리보기 -->
      <div class="form-group">
      <label for="preview-image" class="col-sm-2 col-md-2 col-lg-2 control-label" >미리보기</label>
        <div class="col-sm-2 col-md-2 col-lg-2">
          <img style="width:100%; display:display;" id="preview-image" src="<c:out value="${vo.image}"/>">
        </div>
      </div>
      <!-- 이미지 등록하기 -->
      <div class="form-group">
        <label for="file01" class="col-sm-2 col-md-2 col-lg-2 control-label" >이미지</label>
        <div class="col-sm-10 col-md-10 col-lg-10">
          <input type="file" class="form-control" id="file01" name="file01" placeholder="파일을 입력해주세요" maxlength="100">
          <input type="button" class="btn btn-primary btn-sm" value="사진등록" id="doSaveFile">
        </div>
      </div>
      <div class="form-group">
        <label for="enterprenuer" class="col-sm-2 col-md-2 col-lg-2 control-label" >사업자명</label>
        <div class="col-sm-10 col-md-10 col-lg-10">
        <input type="text" class="form-control" id="enterprenuer" name="enterprenuer" 
        value="<c:out value='${vo.enterprenuer }' />"
        placeholder="사업자명을 입력하세요" maxlength="100">
        </div>
      </div>
      <div class="form-group">
        <label for="rapid_below100" class="col-sm-2 col-md-2 col-lg-2 control-label" >급속100kW미만요금</label>
        <div class="col-sm-10 col-md-10 col-lg-10">
        <input type="text" class="form-control" id="rapid_below100" name="rapid_below100" 
         value="<c:out value='${vo.rapid_below100}' />" 
         placeholder="급속요금을 입력하세요" maxlength="100">
         </div>
      </div>
      <div class="form-group">
        <label for="rapid_above100" class="col-sm-2 col-md-2 col-lg-2 control-label" >급속100kW이상요금</label>
        <div class="col-sm-10 col-md-10 col-lg-10">
        <input type="text" class="form-control" id="rapid_above100" name="rapid_above100" 
         value="<c:out value='${vo.rapid_above100}' />" 
         placeholder="급속요금을 입력하세요" maxlength="100">
         </div>
      </div>
      <div class="form-group">
        <label for="slow_fee" class="col-sm-2 col-md-2 col-lg-2 control-label" >완속충전요금</label>
        <div class="col-sm-10 col-md-10 col-lg-10">
        <input type="text" class="form-control" id="slow_fee" name="slow_fee" 
         value="<c:out value='${vo.slow_fee}' />" 
         placeholder="완속요금을 입력하세요" maxlength="100">
         </div>
      </div>

    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>
  
  </div>
  
<footer>
  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>
</body>
</html>