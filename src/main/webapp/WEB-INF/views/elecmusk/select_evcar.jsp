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
		
		$("#evCarDelete").on("click",function(){
			if(confirm("삭제 하시겠습니까?") == false) return;
		  let method  = "GET";
		  let url     = "/elecmusk/evCarDelete.do";
		  let async   = true;
		  let params  ={
		      carNo    : $("#carNo").val()
		  };
		  PClass.callAjax(method,url,async,params,function(data){
			  let parsedJson = JSON.parse(data);
		    if("1" == parsedJson.msgId){
		      alert(parsedJson.msgContents);
		      moveToList();
		    }else{
		      alert(parsedJson.msgContents);
		    }
		  });
		});// delete end -----------------------------------------------------------
		
		$("#evCarList").on("click",function(){
			moveToList();
		});
		
		$("#evCarUpdate").on("click",function(){
			checkText();
		  if(confirm("수정하시겠습니까?") == false) return;
	    let method  = "POST";
	    let url     = "/elecmusk/evCarUpdate.do";
	    let async   = true;
	    let params  ={
	    		carNo     : $("#carNo").val(),
	    		imgUrl    : $("#imgUrl").val(),
	    		carName   : $("#carName").val(),
	    		carPrice   : $("#carPrice").val(),
	    		manufacture   : $("#manufacture").val(),
	    		productYear   : $("#productYear").val(),
	    		appearance   : $("#appearance").val(),
	    		carModel   : $("#carModel").val(),
	    		maxDistance   : $("#maxDistance").val(),
	    		batteryType   : $("#batteryType").val(),
	    		batteryCapa   : $("#batteryCapa").val(),
	    		maxSpeed   : $("#maxSpeed").val(),
	    		outPut   : $("#outPut").val()
	    };
	    PClass.callAjax(method,url,async,params,function(data){
	      let parsedJson = JSON.parse(data);
	      if("1" == parsedJson.msgId){
	        alert(parsedJson.msgContents);
	        moveToList();
	      }else{
	        alert(parsedJson.msgContents);
	      }	        	
	    });
		});// update end -----------------------------------------------------------
		
   $("#doSaveFile").on("click",function(){
       let fileInput = $("#file01")[0];
       
       if(fileInput.files.length === 0){
         alert("파일을 선택해 주셔요.");
         return;
       }
       
       //javascript : <form></form>
       let formData = new FormData();
       
       for(let i=0;i<fileInput.files.length;i++){
         formData.append("image"+i,fileInput.files[i]);
       }
       
       //image란 이름으로, 파일객체 지정
       
       
       //contentType : default값은 "application/x-www-form-urlencoded; charset=UTF-8"
       //-->multipart/form-data로 전송되도록 false설정
       //processData : true -> query string으로 데이터 전달! ex)http://localhost:8089?title = 1234
       
       $.ajax({ 
          type: "POST",
          url: "${CP}/file/ajaxUpload.do",
          processData: false, //
          contentType: false,
          asyn: "true",
          //dataType: "html",
          data: formData,
          success:function(data){ //통신 성공
            let htmlData = "";
            let imgPath = "";
            
            
            if(null != data && data.length > 0) {
                  $.each(data, function(index, value) {
                  ///ehr/resources/asset/imgs/evcar_imgs/G70.png
                  imgPath = "/ehr"+value.imageViewPath+"/"+value.saveFileName;
                  htmlData += "    <img src='"+imgPath+"' style='width:100%;' '>";
                  });
            }
            $("#imgUrl").val(imgPath);

          },
          error:function(data){//실패
          
          },
          complete:function(data){//성공, 실패 관계 없이 출력
          
          }

       });
       
       
     });//-----------------------------doSaveFile 끝		
		
	});//document End ------------------------------------------------------------
	
	function moveToList(){
		window.location.href="${CP}/elecmusk/evcar.do";
	};
	
	function checkText(){
	  if(eUtil.ISEmpty( $("#carName").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#carPrice").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#manufacture").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#productYear").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#appearance").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#carModel").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#maxDistance").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#batteryType").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#batteryCapa").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#maxSpeed").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  if(eUtil.ISEmpty( $("#outPut").val()) == true){
	      alert("구분을 입력하세요.");
	      return;
	  }
	  
	};
</script>
</head>
<body>
  <header>
  <jsp:include page ="${CO}/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>  
 <div id="contents">
  <!-- div container -->   
  <div class="container">
    <!-- 제목 -->
    <div class="page-header">
       <h2>전기차 정보 관리</h2>
    </div>
    <!-- 제목 ------------------------------------------------------------------->
    <!--버튼  -->
    <form action="${CP}/file/upload.do" method="post" enctype="multipart/form-data" class="form-horizontal">   
    <div class="row text-right">
      <input type="button" class="btn btn-primary btn-sm" value="수정" id="evCarUpdate">
      <input type="button" class="btn btn-primary btn-sm" value="삭제" id="evCarDelete">
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="evCarList">
    </div>
    <div class="form-group">
      <label for="file01" >이미지</label>
      <input type="file" class="form-control" id="file01" name="file01" placeholder="파일을 입력해주세요" maxlength="100">
      <input type="button" class="btn btn-primary btn-sm" value="사진등록" id="doSaveFile">
    </div>   
    </form> 
    <!--버튼 -------------------------------------------------------------------->
    
    <!-- 폼 -->
    <form action="#" class="form-horizontal"> 
    <input type="hidden" id="carNo" name="carNo" value="${vo.carNo}">  
    <input type="hidden" id="imgUrl" name="imgUrl" value="${vo.imgUrl}">  
    <table style="width: 100%;">
      <tr>
        <td style="width:50%;" id="imgArea"><img src="<c:out value="${vo.imgUrl}"/>" style="width:100%;"></td>
        <td>
		      <div class="form-group">
		        <label for="title" >제목</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.carName}"/>" id="carName" name="carName" placeholder="차 이름을 입력해주세요" maxlength="100">
		      </div>
		      <div class="form-group">
		        <label for="modId" >가격</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.carPrice}"/>"  id=carPrice name="carPrice" placeholder="가격을 입력해주세요" maxlength="100">
		      </div>
		      <div class="form-group">
		        <label for="readCnt" >제조사</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.manufacture}"/>" id="manufacture" name="manufacture" placeholder="제조사를 입력해주세요" maxlength="100">
		      </div>
		      <div class="form-group">
		        <label for="modDt" >연식</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.productYear}"/>"  id="productYear" name="productYear" placeholder="연식을 입력해주세요" maxlength="100">
		      </div>
		      <div class="form-group">
		        <label for="regId" >차종</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.appearance}"/>" id="appearance" name="appearance" placeholder="차종을 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >모델</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.carModel}"/>" id="carModel" name="carModel" placeholder="모델을 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >최대 주행거리</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.maxDistance}"/>" id="maxDistance" name="maxDistance" placeholder="최대 주행거리를 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >배터리 종류</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.batteryType}"/>" id="batteryType" name="batteryType" placeholder="배터리 종류를 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >배터리 전압</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.batteryCapa}"/>" id="batteryCapa" name="batteryCapa" placeholder="배터리 전압을 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >최대속력</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.maxSpeed}"/>" id="maxSpeed" name="maxSpeed" placeholder="최대 속도를 입력해주세요" maxlength="100">
		      </div>      
		      <div class="form-group">
		        <label for="regId" >출력</label>
		        <input type="text" class="form-control" value="<c:out value="${vo.outPut}"/>" id="outPut" name="outPut" placeholder="출력을 입력해주세요" maxlength="100">
		      </div>          
        </td>
      </tr>
    </table>    
    </form>
    <!--폼   -------------------------------------------------------------------->
  </div>   
  <!-- div container ---------------------------------------------------------->  
</div>
<footer>
<jsp:include page ="/resources/asset/cmn/main_footer.jsp" flush="false"/>
</footer>
</body>
	</html>
