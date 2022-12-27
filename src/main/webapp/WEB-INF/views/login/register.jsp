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
<title>회원가입</title>
<style type="text/css">
#contents{
  margin-bottom: 100px;
}

#mainButton {
  width: 48%;
  margin: auto;
}

#otherbuttons{
  margin-top: 8px;
}

h5{
  text-align: center;
}
</style>
<script >
  $(document).ready(function(){
    console.log("document.ready");
    
    //메인버튼(로그인) 클릭
    $("#mainButton").on("click",function(){
    	console.log("메인버튼 클릭");
    	
    	//데이터 넘기는건 형식에 안 맞는 등 특정 상황에 안넘어가고 입력된 데이터를 유지해야해서
    	//form submit이 아닌 ajax로 넘길 것
    	
    	if(eUtil.ISEmpty($("#userId").val())){
    		alert("아이디는 필수입니다. 아이디를 입력 하세요.");
        $("#userId").focus();
        return;
    	}
    	if($("#idCheckYN").val() != "1"){
        alert("아이디중복 체크  해주세요.");
        $("#idCheck").focus();
        return;
      }
    	if(eUtil.ISEmpty($("#password").val())){
    		alert("비밀번호는 필수입니다. 비밀번호를 입력 하세요.");
        $("#password").focus();
        return;
    	}
    	if(eUtil.ISEmpty($("#passwordCheck").val())){
    		alert("비밀번호 확인은 필수입니다. 비밀번호 확인을 입력 하세요.");
        $("#passwordCheck").focus();
        return;
    	}
    	
    	let birth = $("#birthYear").val()+$("#birthMonth").val().padStart(2, '0')+$("#birthDay").val().padStart(2, '0');
    	
    	if(eUtil.ISEmpty($("#birthYear").val()) ||  
         eUtil.ISEmpty($("#birthMonth").val()) || 
         eUtil.ISEmpty($("#birthDay").val())
        ){
    		  birth = "";
    	}
    	
    	let backupQuestion = $("#backupQuestion").val();
    	let backupAnswer = $("#backupAnswer").val();
    	
    	if(eUtil.ISEmpty(backupQuestion) || eUtil.ISEmpty(backupAnswer)){
    		backupQuestion="";
    		backupAnswer="";
    	}

    	if($("#password").val() != $("#passwordCheck").val()){
    		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다. 확인해주세요");
    		$("#password").focus();
    		return;
    	}
    	
    	if(eUtil.ISEmpty($("#name").val()) ||
    		 eUtil.ISEmpty($("#birthYear").val()) ||	
    		 eUtil.ISEmpty($("#birthMonth").val()) ||	
    		 eUtil.ISEmpty($("#birthDay").val()) ||	
    		 eUtil.ISEmpty($("#email").val()) ||	
    		 eUtil.ISEmpty($("#backupQuestion").val()) ||	
    		 eUtil.ISEmpty($("#backupAnswer").val())	
    	  ){
    		if(confirm("필수정보를 입력하지 않으시면 가입에는 문제가 없으나,\n나중에 아이디 및 비밀번호를 찾을 때 어려울 수 있습니다.\n계속하시겠습니까?")==false){
    			return;
    		}
    	}
    	
    	/* if($("#birth").val().length!=8){
            alert("생년월일은 8자리 숫자로 입력해주세요");
            return;
      } */
    	
    	//생일에 이상한 숫자를 입력하면 오류가 남. Todate로 sql쿼리 바꾸기
    	
    	if(confirm("입력하신 정보로 회원가입 하시겠습니까?")==false){
    		return;
    	}
      
    	let params = { 
    			userId : $("#userId").val(),
    			userPw : $("#password").val(),
    			name : $("#name").val(),
    			birth : birth,
    			email : $("#email").val(),
    			backupQuestion : backupQuestion,
    			backupAnswer : backupAnswer
    	};
    	
    	console.log(params);
    	
    	$.ajax({ 
    		   type: "POST",
    		   url: "/ehr/login/doRegister.do",
    		   asyn: "true",
    		   dataType: "html",
    		   data: params,
    		   success:function(data){ //통신 성공
    		     console.log(data);
    		     let parsedJson = JSON.parse(data);
    		     
    		     if("1" == parsedJson.msgId){
    		    	 let message = "성공적으로 회원가입 되었습니다.\n";
    		    	 message    += "최초 닉네임이 임시 닉네임으로 되어있으니 우측 상단 마이페이지에서 수정하시기바랍니다.";
    		       alert(message);
             }else{
               alert(parsedJson.msgContents);
             }
    		    window.location.href="${CP}/login/login.do";
    		   },
    		   error:function(data){//실패
    		   
    		   },
    		   complete:function(data){//성공, 실패 관계 없이 출력
    		   
    		   }

    		});
    	
    });//메인버튼(가입) 클릭
    
    //아이디 중복확인
    $("#idCheck").on("click",function(){
      console.log("중복확인 클릭");
      
      if(eUtil.ISEmpty( $("#userId").val())){
          alert("아이디를 입력하세요.");
          $("#userId").focus();
          return;
        }
      
      $.ajax({ 
    	   type: "GET",
    	   url: "/ehr/login/idCheck.do",
    	   asyn: "true",
    	   dataType: "html",
    	   data:{ userId : $("#userId").val()},
    	   success:function(data){ //통신 성공
    	   
    		   let parsedJson = JSON.parse(data);
    	   
    		   if("0" == parsedJson.msgId){
    			   alert(parsedJson.msgContents);
    			   $("#idCheckYN").val("1");
    			   $("#userId").prop("disabled",true);
    		   }else{
    			   alert(parsedJson.msgContents);
    	       $("#idCheckYN").val("0");
    		   }
    	   
    	   },
    	   error:function(data){//실패
    	   
    	   },
    	   complete:function(data){//성공, 실패 관계 없이 출력
    	   
    	   }

    	});
      
    });//아이디중복확인버튼 클릭
    
    //아이디 재설정
    $("#idReset").on("click",function(){
    	console.log("ㅇ에이이이");
    	
    	$("#idCheckYN").val("0");
    	$("#userId").prop("disabled",false);
    	
    });//재설정 끝
    
  });//document.ready
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
      <h2>회원가입</h2>
    </div>
      <h5>*는 필수정보 입니다.</h5>
    <form class="form-horizontal">
      <input type="hidden" name="idCheckYN" id="idCheckYN" value="0">
      <div class="form-group">
        <label for="userId" class="col-sm-3 control-label">아이디*</label>
        <div class="col-sm-6">
          <input type="text" class="form-control" id="userId" placeholder="아이디" maxlength="20">
        </div>
        <div class="col-sm-2">
          <input type="button" class="form-control" value="중복확인" id="idCheck">
        </div>
        <div class="col-sm-1">
          <input type="button" class="form-control" value="재설정" id="idReset">
        </div>
      </div>
      <div class="form-group">
        <label for="password" class="col-sm-3 control-label">비밀번호*</label>
        <div class="col-sm-6">
          <input type="password" class="form-control" id="password" placeholder="비밀번호">
        </div>
      </div>
      <div class="form-group">
        <label for="passwordCheck" class="col-sm-3 control-label">비밀번호 확인*</label>
        <div class="col-sm-6">
          <input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인">
        </div>
      </div>
      <div class="form-group">
        <label for="name" class="col-sm-3 control-label">이름</label>
        <div class="col-sm-6">
          <input type="text" class="form-control" id="name" placeholder="이름">
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
			<div class="form-group">
        <label for="email" class="col-sm-3 control-label">이메일</label>
        <div class="col-sm-6">
          <input type="email" class="form-control" id="email" placeholder="이메일">
        </div>
      </div>
      <div class="form-group">
        <label for="backupQuestion" class="col-sm-3 control-label">본인확인 질문</label>
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
          <input type="text" class="form-control" id="backupAnswer" placeholder="본인확인 질문 답변">
        </div>
      </div>
    </form>
    <button type="button" class="btn btn-default btn-lg btn-block" id="mainButton">가입</button>

  </div>
  <!-- div contents ------------------------------------------->
  <footer>
    <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
  </footer>
</body>
</html>