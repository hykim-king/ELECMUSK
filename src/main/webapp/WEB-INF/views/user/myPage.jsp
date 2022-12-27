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
<title>마이 페이지</title>
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
<script >
  $(document).ready(function(){
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
    
	//회원관리 버튼
	$("#moveToUserMng").on("click",function(){
		let userStatus = ${sessionScope.userInfo.status};
		console.log(userStatus);
		if(userStatus!=2){
			alert("관리자만 사용할 수 있습니다.");
			return; 
		}
    let f = document.createElement('form');
    f.setAttribute('method', 'post');
    f.setAttribute('action', 'userMng.do');
    document.body.appendChild(f);
    f.submit();
		
	});//회원관리 버튼
	   
  //새로고침 버튼 - 뺐음 필요할 수도 있으니 남김
  $("#renew").on("click",function(){
	  console.log("엥");
	  renewSession();
	  console.log("${session.userInfo.nickname}");
  });//새로고침 버튼 
    
  //메인버튼(닉네임 바꾸기) 클릭
    $("#updateNickname").on("click",function(){
      console.log("닉네임 바꾸기 버튼 클릭");
      
      if($("#nicknameCheckYN").val() == "0"){
        alert("닉네임 중복 체크를  해주세요.");
        $("#idCheck").focus();
        return;
      }
      //이거사실필요없음ㅋㅋ
      if(eUtil.ISEmpty($("#nickname").val())){
        alert("바꿀 닉네임을 입력 하세요.");
        $("#nickname").focus();
        return;
      } 
      if(confirm("닉네임이 "+$("#nickname").val()+"로 바뀌게됩니다.\n진행하시겠습니까?")==false){
        return;
      }
      
      let params = { 
    		  mSeq : ${sessionScope.userInfo.mSeq}, 
          nickname : $("#nickname").val()
      };  
          
      console.log(params);
      
      $.ajax({ 
           type: "POST",
           url: "/ehr/elecmusk/updateNickname.do",
           asyn: "true",
           dataType: "html",
           data: params,
           success:function(data){ //통신 성공
            console.log(data);
              
            let parsedJson = JSON.parse(data);
            
            if("1" == parsedJson.msgId){
            	alert(parsedJson.msgContents);
            	//변경이 있고나면 세션을 다시만들어야함.
            	//했음!! 세션도 다시만들고 새로고침도 함.
            	renewSession();
            }else{
            	alert(parsedJson.msgContents);
            }
            
           },
           error:function(data){//실패
           
           },
           complete:function(data){//성공, 실패 관계 없이 출력
           
           }

        });
      
    });//메인버튼(닉네임 바꾸기) 클릭
    
  //닉네임 중복확인
    $("#nicknameCheck").on("click",function(){
      console.log("중복확인 클릭");
      
      if(eUtil.ISEmpty( $("#nickname").val())){
          alert("바꿀 닉네임을 입력하세요.");
          $("#nickname").focus();
          return;
        }
      
      $.ajax({ 
         type: "GET",
         url: "/ehr/login/nicknameCheck.do",
         asyn: "true",
         dataType: "html",
         data:{ nickname : $("#nickname").val()},
         success:function(data){ //통신 성공
         
           let parsedJson = JSON.parse(data);
         
           if("0" == parsedJson.msgId){
             alert(parsedJson.msgContents);
             $("#nicknameCheckYN").val("1");
             $("#nickname").prop("disabled",true);
           }else{
             alert(parsedJson.msgContents);
             $("#nicknameCheckYN").val("0");
           }
         
         },
         error:function(data){//실패
         
         },
         complete:function(data){//성공, 실패 관계 없이 출력
          
         }

      });
      
    });//닉네임 중복확인버튼 클릭
    
    //닉네임 재설정
    $("#nicknameReset").on("click",function(){
      console.log("ㅇ에이이이");
      
      $("#nicknameCheckYN").val("0");
      $("#nickname").prop("disabled",false);
      
    });//닉네임 재설정 끝
    
    //현재 비밀번호 확인
    $("#prePasswordCheck").on("click",function(){
      console.log("중복확인 클릭");
      
      if(eUtil.ISEmpty( $("#prePassword").val())){
          alert("현재 비밀번호를 입력하세요.");
          $("#prePassword").focus();
          return;
        }
      
      let userId = "${sessionScope.userInfo.userId}";
      
      $.ajax({ 
         type: "GET",
         url: "/ehr/login/passwordCheck.do",
         asyn: "true",
         dataType: "html",
         data:{ 
        	 userId : userId,
        	 userPw : $("#prePassword").val()
         },
         success:function(data){ //통신 성공
         
           let parsedJson = JSON.parse(data);
         
           if("1" == parsedJson.msgId){
             alert(parsedJson.msgContents);
             $("#passwordCheckYN").val("1");
             $("#prePassword").prop("disabled",true);
           }else{
             alert(parsedJson.msgContents);
             $("#passwordCheckYN").val("0");
           }
          
         },
         error:function(data){//실패
         
         }, 
         complete:function(data){//성공, 실패 관계 없이 출력
         
         }

      });
      
    });//현재 비밀번호 확인버튼 클릭 
    
    //버튼(비밀번호 바꾸기) 클릭
    $("#updatePassword").on("click",function(){
    	console.log("에잉!!");
    	
    	if($("#passwordCheckYN").val()=="0"){
    		$("#prePassword").focus();
    		alert("현재 비밀번호 확인을 해주세요"); 
    		return;
    	}
    	if(eUtil.ISEmpty($("#changedPassword").val())){
    		alert("바꿀 비밀번호를 입력해주세요");
    		$("#changedPassword").focus();
    		return;
    	}
    	if(eUtil.ISEmpty($("#passwordCheck").val())){
    		alert("비밀번호 확인을 입력해주세요");
    		$("#passwordCheck").focus();
    		return; 
    	}
    	if($("#passwordCheck").val()!=$("#changedPassword").val()){
    		alert("변경할 비밀번호와 비밀번호 확인이 일치하지 않습니다.\n확인해서 다시 한 번 입력해주세요.");
    		return;
    	}
    	
    	if(confirm("비밀번호가 변경됩니다.\n진행하시겠습니까?")==false){
    		return;
    	}
    	 
      let params = {
          mSeq : ${sessionScope.userInfo.mSeq}, 
          userPw : $("#changedPassword").val()
      };      	
    	
    	$.ajax({ 
    		   type: "POST",
    		   url: "/ehr/elecmusk/updatePassword.do",
    		   asyn: "true",
    		   dataType: "html",
    		   data: params,
    		   success:function(data){ //통신 성공
    			   console.log(data);
    	              
             let parsedJson = JSON.parse(data);
            
             if("1" == parsedJson.msgId){
               alert(parsedJson.msgContents);
               renewSession();
             }else{
               alert(parsedJson.msgContents);
             }
    		   }, 
    		   error:function(data){//실패
    		   
    		   },
    		   complete:function(data){//성공, 실패 관계 없이 출력
    		   
    		   }

    		});
    	
    });//버튼(비밀번호 바꾸기) 종료
    
    //버튼(이메일바꾸기) 클릭
    $("#updateEmail").on("click",function(){
    	console.log("에잉!!");
    	
    	if(eUtil.ISEmpty($("#email").val())){
    		alert("변경할 이메일을 입력해주세요");
    		$("#email").focus();
    		return; 
    	}
    	
    	if(confirm("이메일이 변경됩니다.\n진행하시겠습니까?")==false){
    		return;
    	}
    	 
      let params = {
          mSeq : ${sessionScope.userInfo.mSeq}, 
          email : $("#email").val() 
      };      	
    	 
    	$.ajax({ 
    		   type: "POST",
    		   url: "/ehr/elecmusk/updateEmail.do",
    		   asyn: "true",
    		   dataType: "html",
    		   data: params,
    		   success:function(data){ //통신 성공
    			   console.log(data);
    	              
             let parsedJson = JSON.parse(data);
            
             if("1" == parsedJson.msgId){
               alert(parsedJson.msgContents);
               renewSession();
             }else{
               alert(parsedJson.msgContents);
             }
    		   }, 
    		   error:function(data){//실패
    		   
    		   },
    		   complete:function(data){//성공, 실패 관계 없이 출력
    		   
    		   }

    		});
    	
    });//버튼(이메일 바꾸기) 종료
    
    //버튼(회원탈퇴) 클릭
    $("#withdraw").on("click",function(){
      console.log("띠용??");
      
      if(confirm("유예기간 없이 사용자 정보가 삭제됩니다.\n진행하시겠습니까?")==false){
          return;
      }
 
      let params = {
    		  mSeq : ${sessionScope.userInfo.mSeq} 
      }  
       
      $.ajax({ 
          type: "POST",
          url: "/ehr/elecmusk/deleteUser.do",
          asyn: "true",
          dataType: "html",
          data: params,
          success:function(data){ //통신 성공
            console.log(data);
                   
            let parsedJson = JSON.parse(data);
           
            if("1" == parsedJson.msgId){
              alert(parsedJson.msgContents);
              window.location.href="${CP}/login/doLogout.do";
            }else{
              alert(parsedJson.msgContents);
            }
          }, 
          error:function(data){//실패
          
          },
          complete:function(data){//성공, 실패 관계 없이 출력
          
          }

       });
      
      
    });//버튼(회원탈퇴) 클릭 종료
    
  });//document.ready
  
  //세션 다시만들기 함수
  function renewSession(){
	  $.ajax({ 
		   type: "GET",
		   url: "/ehr/login/renewSession.do",
		   asyn: "true",
		   dataType: "html",
		   data:{
			   mSeq : ${sessionScope.userInfo.mSeq}
		   },    
		   success:function(data){ //통신 성공
			   //alert(data);
			   window.location.href="${CP}/elecmusk/view.do";
		   }, 
		   error:function(data){//실패
		   
		   },
		   complete:function(data){//성공, 실패 관계 없이 출력
		   
		   }

		});
  }//세션 다시만들기 함수 끝
  
  //세션 확인 로그인으로 튕겨버리는 함수
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
			<h2>마이 페이지</h2>
		</div>
		<div class="text-center">
			<c:choose>
				<c:when	test="${2 <= sessionScope.userInfo.status && not empty sessionScope.userInfo}">
					<div>
						<h4 class="text-center">회원 관리</h4>
						<button type="button" class="btn btn-default btn-lg btn-block" id="moveToUserMng">회원 관리</button>
					</div>
				</c:when>
			</c:choose>
			<h4 class="text-center">닉네임 수정</h4>
			<form class="form-horizontal">
				<div class="form-group">
					<input type="hidden" name="nicknameCheckYN" id="nicknameCheckYN"
						value="0"> <label for="nickname"
						class="col-sm-3 control-label">현재 닉네임</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="preNickname"
							value="${sessionScope.userInfo.nickname }" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="nickname" class="col-sm-3 control-label">바꿀 닉네임</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="nickname"
							placeholder="닉네임" maxlength="20">
					</div>
					<div class="col-sm-2">
						<input type="button" class="form-control" value="중복확인"
							id="nicknameCheck">
					</div>
					<div class="col-sm-1">
						<input type="button" class="form-control" value="재설정"
							id="nicknameReset">
					</div>
				</div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block"
				id="updateNickname">바꾸기</button>
		</div>
		<div>
			<h4 class="text-center">비밀번호 수정</h4>
			<form class="form-horizontal">
			  <input type="hidden" name="passwordCheckYN" id="passwordCheckYN" value="0">
				<div class="form-group" >
					<label for="prePassword" class="col-sm-3 control-label">현재 비밀번호 확인</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="prePassword" placeholder="현재 비밀번호">
					</div>
					<div class="col-sm-2">
            <input type="button" class="form-control" value="확인" id="prePasswordCheck">
          </div> 
				</div>
				<div class="form-group">
					<label for="changedPassword" class="col-sm-3 control-label">변경할 비밀번호</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="changedPassword" placeholder="변경할 비밀번호">
					</div>
				</div>
				<div class="form-group">
					<label for="passwordCheck" class="col-sm-3 control-label">비밀번호 확인</label>
					<div class="col-sm-6">
						<input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인">
					</div>
				</div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block" id="updatePassword">바꾸기</button>
		</div>
		<div>
			<h4 class="text-center">이메일 수정</h4>
			<form class="form-horizontal">
				<div class="form-group">
					<label for="preEmail" class="col-sm-3 control-label">현재 이메일</label>
					<div class="col-sm-6">
						<input type="email" class="form-control" id="preEmail" value="${sessionScope.userInfo.email }" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-3 control-label">이메일</label>
					<div class="col-sm-6">
						<input type="email" class="form-control" id="email"	placeholder="이메일">
					</div>
				</div>
			</form>
			<button type="button" class="btn btn-default btn-lg btn-block" id="updateEmail">바꾸기</button>
		</div>
		<div>
			<h4 class="text-center">회원 탈퇴</h4>
			<button type="button" class="btn btn-default btn-lg btn-block" id="withdraw">탈퇴</button>
		</div>

  </div>
  <!-- div contents ------------------------------------------->
  <footer>
    <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
  </footer>
  
</body>
</html>