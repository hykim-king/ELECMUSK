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

<!-- String, Number, Date Util -->
<script src="${CP_RES}/bootstrap/js/eUtil.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<title>아이디/비밀번호 찾기</title>
<style type="text/css">

#contents{
  margin-bottom: 100px;
}

.btn {
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
<script>
	$(document).ready(function() {
		console.log("document.ready");

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
		
		//findIdByEmail클릭
		$("#findIdByEmail").on("click", function() {
			console.log("에잉???");
		
			if(eUtil.ISEmpty($("#email").val())){
        alert("이메일을 입력 하세요.");
        $("#email").focus();
        return;
      }
			
			$.ajax({
				type : "GET",
				url : "/ehr/login/findIdByEmail.do",
				asyn : "true",
				dataType : "html",
				data : {
					email : $("#email").val()
				},
				success : function(data) { //통신 성공
					console.log(data);
					  
				  let parsedJson = JSON.parse(data);
					console.log(parsedJson.length);
					if(parsedJson.length==0){
						alert($("#email").val()+"의 이메일로 등록된 아이디는 없습니다.");
					}else if(parsedJson.length > 0){
						let message = "";
						message +=$("#email").val()+"의 이메일로 등록된 아이디는 "+parsedJson.length+"개이고 \n";
						$.each(parsedJson,function(index,value){
							message += (index+1)+". ";
							message += value.userId;
							message += "\n";
						});
						message +="가 있습니다.";
						alert(message);
					}
				},
				error : function(data) {//실패

				},
				complete : function(data) {//성공, 실패 관계 없이 출력

				}

			});

		});
		//findIdByEmail클릭

		//findIdByNameBirth클릭
    $("#findIdByNameBirth").on("click", function() {
      console.log("오옷");

      let birth = $("#birthYear").val()+$("#birthMonth").val().padStart(2, '0')+$("#birthDay").val().padStart(2, '0');
      
      if(eUtil.ISEmpty($("#birthYear").val()) ||  
         eUtil.ISEmpty($("#birthMonth").val()) || 
         eUtil.ISEmpty($("#birthDay").val())
        ){
          birth = "";
      }
      
      if(eUtil.ISEmpty($("#name").val())){
          alert("이름을 입력해주세요.");
          $("#name").focus();
          return;
      }
      
      if(eUtil.ISEmpty(birth)){
          alert("생년월일을 전부 입력해주세요.");
          return;
      }
      
      $.ajax({
        type : "GET",
        url : "/ehr/login/findIdByNameBirth.do",
        asyn : "true",
        dataType : "html",
        data : {
        	  name: $("#name").val(),
        	  birth: birth
        },
        success : function(data) { //통신 성공
          console.log(data);
            
          let parsedJson = JSON.parse(data);
          console.log(parsedJson.length);
          
          let birthMessage = $("#birthYear").val() +"년 ";
          birthMessage += $("#birthMonth").val() +"월 ";
          birthMessage += $("#birthDay").val() +"일의 \n";
          
          if(parsedJson.length==0){
            alert(birthMessage+$("#name").val()+"의 이름으로 등록된 아이디는 없습니다.");
          }else if(parsedJson.length > 0){
            let message = birthMessage;
            message +=$("#name").val()+"의 이름으로 등록된 아이디는 "+parsedJson.length+"개이고 \n";
            $.each(parsedJson,function(index,value){
              message += (index+1)+". ";
              message += value.userId;
              message += "\n";
            });
            message +="가 있습니다.";
            alert(message);
          }
        },
        error : function(data) {//실패

        },
        complete : function(data) {//성공, 실패 관계 없이 출력

        }

      });

    });
    //findIdByNameBirth클릭

		//findPwByBackup클릭
    $("#findPwByBackup").on("click", function() {
      console.log("아잉");
      
      if(eUtil.ISEmpty($("#userId").val())){
          alert("아이디을 입력해주세요.");
          $("#userId").focus();
          return;
      }
      if(eUtil.ISEmpty($("#backupQuestion").val())){
          alert("본인확인 질문을 선택해주세요.");
          $("#backupQuestion").focus();
          return;
      }
      if(eUtil.ISEmpty($("#backupAnswer").val())){
          alert("본인확인 질문 답변을 입력해주세요.");
          $("#backupAnswer").focus();
          return;
      }
      
      $.ajax({
        type : "GET",
        url : "/ehr/login/findPwByBackup.do",
        asyn : "true",
        dataType : "html",
        data : {
        	  userId: $("#userId").val(),
        	  backupQuestion : $("#backupQuestion").val(),
        	  backupAnswer : $("#backupAnswer").val()
        },
        success : function(data) { //통신 성공
          console.log(data);
          
          let parsedJson = JSON.parse(data);
          
          if(data=="null"){
        	  
        	  message = "입력하신 정보와 일치하는 아이디/본인확인 질문 답변이 없습니다.\n";
        	  message+= "아이디와 본인확인 질문 답변을 확인해주세요.\n";
        	  message+= "아이디가 기억나지 않으시면 위 아이디 찾기를 이용해주세요.";
        	  alert(message);
        	  
          }else{
        	  let password = parsedJson.userPw;
        	  alert("입력하신 아이디의 비밀번호는 "+password+"입니다.");
          }
        },
        error : function(data) {//실패
        },
        complete : function(data) {//성공, 실패 관계 없이 출력
        }

      });

    });
    //findPwByBackup클릭
		
	});
</script>

</head>
<body>
  <!------------------------------------------------- 헤더 -->
  <header>
    <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <!------------------------------------------------- 헤더끝 -->
  <!-- div contents -->
  <div id="contents">
    <div class="page-header text-center">
      <h2>아이디/비밀번호 찾기</h2>
    </div>
		<div>
			<h4 class="text-center">이메일로 아이디 찾기</h4>
			<form class="form-horizontal" action="#">
				<div class="form-group">
					<label for="email" class="col-sm-3 control-label">이메일</label>
					<div class="col-sm-6">
						<input type="email" class="form-control" id="email" placeholder="이메일">
					</div>
				</div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block" id="findIdByEmail">찾기</button>
		</div>
		<div>
			<h4 class="text-center">생년월일로 아이디 찾기</h4>
			<form class="form-horizontal" action="#">
				<div class="form-group">
					<label for="name" class="col-sm-3 control-label">이름</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="name"	placeholder="홍길동">
					</div>
				</div>
				<div class="form-group">
        <div class="form-inline">
          <label class="col-sm-3 control-label">생년월일</label>
          <div class="col-sm-6">
            <select class="form-control" id="birthYear">
              <option value="">선택안함</option>
              <c:forEach begin="1930" end="2022" var="year">
                <option>${year }</option>
              </c:forEach>
            </select>년
            <select class="form-control" id="birthMonth">
              <option value="">선택안함</option>
              <c:forEach begin="1" end="12" var="month">
                <option>${month }</option>
              </c:forEach>
            </select>월
            <select class="form-control" id="birthDay">
              <option value="">선택안함</option>
              <c:forEach begin="1" end="31" var="day">
                <option>${day }</option>
              </c:forEach>
            </select>일 
          </div>
        </div>
      </div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block" id="findIdByNameBirth">찾기</button>
		</div>
		<div>
			<h4 class="text-center">본인확인 질문으로 비밀번호 찾기</h4>
			<form class="form-horizontal">
				<div class="form-group">
					<label for="userId" class="col-sm-3 control-label">아이디</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="userId" placeholder="아이디">
					</div>
				</div>
				<div class="form-group">
					<label for="backupAnswer" class="col-sm-3 control-label">본인확인 질문 답변</label>
					<div class="col-sm-6">
						<select  class="form-control" id = "backupQuestion">
	            <option value="">선택안함</option>
	            <c:choose>
	              <c:when test="${USER_BACKUPQUESTION.size()>0}">
	                <c:forEach var="code" items="${USER_BACKUPQUESTION}">
	                  <option value='<c:out value="${code.detName}"/>'><c:out value="${code.detName}" /></option>
	                </c:forEach>
	              </c:when>
	            </c:choose>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="backupAnswer" class="col-sm-3 control-label">본인확인 질문 답변</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="backupAnswer" placeholder="답변">
					</div>
				</div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block" id="findPwByBackup">찾기</button>
		</div>

  </div>
  <!-- div contents ------------------------------------------->
  <footer>
    <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
  </footer>
</body>
</html>