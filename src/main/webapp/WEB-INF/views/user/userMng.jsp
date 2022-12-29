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

<!-- 페이징-->
<script src="${CP_RES}/bootstrap/js/jquery.bootpag.js"></script>

<!-- String, Number, Date Util -->
<script src="${CP_RES}/bootstrap/js/eUtil.js"></script>

<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>

<title>회원관리</title>
<style type="text/css">
#contents{
  margin-bottom: 100px;
}

#formButtons{
  margin-bottom: 10px;
}

#mainButton {
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
    doRetrieve(1);
    
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
    
    //수정 버튼 
    $("#doUpdate").on("click",function(){
    	console.log("으갹");
    	
	    if(eUtil.ISEmpty($("#mSeq").val())){
	        alert("고유번호는 필수입니다. 유저 정보를 클릭하여 조회해주세요");
	        $("#mSeq").focus();
	        return;
	      }
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
      if(eUtil.ISEmpty($("#nickname").val())){
          alert("닉네임는 필수입니다. 닉네임을 입력 하세요.");
          $("#nickname").focus();
          return;
      }
      if($("#nicknameCheckYN").val() != "1"){
        alert("닉네임중복 체크  해주세요.");
        $("#nicknameCheck").focus();
        return;
      }
      if(eUtil.ISEmpty($("#password").val())){
         alert("비밀번호는 필수입니다. 비밀번호를 입력 하세요.");
         $("#password").focus();
         return;
       }
      
      let birth = $("#birthYear").val()+$("#birthMonth").val().padStart(2, '0')+$("#birthDay").val().padStart(2, '0');
      
      if(eUtil.ISEmpty($("#birthYear").val()) ||  
         eUtil.ISEmpty($("#birthMonth").val()) || 
         eUtil.ISEmpty($("#birthDay").val())
        ){
          birth = "";
      }
      
      if(confirm("입력하신 정보로 수정하시겠습니까?")==false){
          return;
      }  
      

      
      let params = { 
    		mSeq : $("#mSeq").val(),
	      userId : $("#userId").val(),
	      nickname : $("#nickname").val(),
	      userPw : $("#password").val(),
	      name : $("#name").val(),
	      birth : birth,
	      email : $("#email").val(),
	      backupQuestion : $("#backupQuestion").val(),
	      backupAnswer : $("#backupAnswer").val(),
	      point : $("#point").val(),
	      status : $("#userStatus").val()
      };
      
      console.log(params);
      
      $.ajax({ 
          type: "POST",
          url: "/ehr/elecmusk/doUserUpdate.do",
          asyn: "true",
          dataType: "html",
          data: params,
          success:function(data){ //통신 성공
            console.log(data);
            let parsedJson = JSON.parse(data);
            
            if("1" == parsedJson.msgId){
              let message = "성공적으로 수정 되었습니다.\n";
              alert(message);
              let f = document.createElement('form');
              f.setAttribute('method', 'post');
              f.setAttribute('action', 'userMng.do');
              document.body.appendChild(f);
              f.submit();
            }else{
              alert(parsedJson.msgContents);
            }
          },
          error:function(data){//실패
          },
          complete:function(data){//성공, 실패 관계 없이 출력
          }
       });
    });//수정 버튼 클릭
    
    //초기화 버튼 누르기
    $("#initBtn").on("click",function(){
    	initControll();
    });//initBtn 클릭
    
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
    
    //테이블 데이터 click
    $("#userTable>tbody").on("click","tr",function(e){
    	let tdArray = $(this).children();
    	let mSeq = tdArray.eq(1).text();
    	
    	console.log("mSeq: "+mSeq);
    	
    	$.ajax({ 
    		   type: "GET",
    		   url: "/ehr/elecmusk/doSelectOne.do",
    		   asyn: "true",
    		   dataType: "html",
    		   data:{
    			   mSeq: mSeq
    		   },
    		   success:function(data){ //통신 성공
    		     console.log(data);
    		     
    		     let parsedJson = JSON.parse(data);
    		     console.log("parsedJson: "+parsedJson);
    		     
    		     let birthYear = "";
    		     let birthMonth = "";
    		     let birthDay = "";
    		     
    		     if((parsedJson.birth)!=undefined){
	    		     birthYear = ((String)(parsedJson.birth)).substr(0, 4);
	    		     birthMonth = ((String)(parsedJson.birth)).substr(4, 2);
	    		     if(birthMonth.substr(0,1)==="0"){
	    		    	 birthMonth = birthMonth.substr(1,1);
	    		     }
	    		     birthDay = ((String)(parsedJson.birth)).substr(6, 2);
	    		     if(birthDay.substr(0,1)==="0"){
	    		    	 birthDay = birthDay.substr(1,1);
	             }
    		     }
    		     
    		     console.log("birthYear: "+birthYear);
    		     console.log("birthMonth: "+birthMonth);
    		     console.log("birthDay: "+birthDay);
    		     
    		      let status = "";
    		      console.log("status: "+parsedJson.status);
    		      status = parsedJson.status;
    		     
    		     $("#mSeq").val(mSeq);
    		     $("#userId").val(parsedJson.userId);
    		     $("#nickname").val(parsedJson.nickname);
    		     $("#password").val(parsedJson.userPw);
    		     $("#name").val(parsedJson.name);
    		     $("#birthYear").val(birthYear);
    		     $("#birthMonth").val(birthMonth);
    		     $("#birthDay").val(birthDay);
    		     $("#email").val(parsedJson.email);
    		     $("#backupQuestion").val(parsedJson.backupQuestion);
    		     $("#backupAnswer").val(parsedJson.backupAnswer);
    		     $("#point").val(parsedJson.point);
    		     $("#joinDate").val(parsedJson.joinDate);
    		     $("#userStatus").val(parsedJson.status);
    		     console.log("켁!");
    		   
 		         $("#idCheckYN").val("1");
 		         $("#userId").prop("disabled",true);
 		         $("#nicknameCheckYN").val("1");
 		         $("#nickname").prop("disabled",true);
    		     
    		   },
    		   error:function(data){//실패
    		   },
    		   complete:function(data){//성공, 실패 관계 없이 출력
    		   }

    		});
    	
    });//테이블 데이터 click 끝
    
    //조회버튼 클릭
    $("#doRetrive").on("click",function(){
    	console.log("조회버튼 클릭");
    	doRetrieve(1);
    });//조회버튼 클릭
    
    //전체 선택/해제
    $("#checkAll").on("click",function(){
      console.log("#checkAll");
      //chk
      //전체 체크
      if( $("#checkAll").is(":checked") == true ){
        $("input[name=chk]").prop("checked",true);
      //체크 해제   
      }else{
        $("input[name=chk]").prop("checked",false);
      }
      
    });//전체선택, 해제
    
    //다건삭제 
     $("#multiBan").on("click",function(){
       let mSeqArray = [];
       
       
       $("input:checkbox[name=chk]").each(function(i,element){
         
         //체크된것들은 uIdArray추가
         if($(this).is(":checked")==true){
           console.log($(this).val());
           mSeqArray.push($(this).val());
         }
       });
       
       console.log(mSeqArray);
       
       let message="정지된 사용자는 다시 복구할 수 있으나 \n";
       message += "아이디와 닉네임이 수정됩니다.\n";
       message += "정말로 사용자를 정지시키겠습니까?";
       if(confirm(message)==false){
    	   return;
       }
       
       let mSeqString = "";
       if(mSeqArray.length>0){
    	   mSeqString = mSeqArray.toString();
         console.log("mSeqString:"+mSeqString);
       }else{
         alert("삭제할 자료를 선택 하세요.");
         return;
       }
       
       $.ajax({ 
    	   type: "POST",
    	   url: "/ehr/elecmusk/multiBan.do",
    	   asyn: "true",
    	   dataType: "html",
    	   data:{ mSeqString :  mSeqString},
    	   success:function(data){ //통신 성공
    		   console.log(data);
    		   let parsedJson = JSON.parse(data);
    		   
             if("0" != parsedJson.msgId){
                 alert(parsedJson.msgContents);
                 let f = document.createElement('form');
                 f.setAttribute('method', 'post');
                 f.setAttribute('action', 'userMng.do');
                 document.body.appendChild(f);
                 f.submit();
               }else{
                 alert(parsedJson.msgContents);
               }
             let f = document.createElement('form');
             f.setAttribute('method', 'post');
             f.setAttribute('action', 'userMng.do');
             document.body.appendChild(f);
             f.submit();
    	   },
    	   error:function(data){//실패
    	   
    	   },
    	   complete:function(data){//성공, 실패 관계 없이 출력
    	   
    	   }

    	});
     
     });//다건삭제 
  
  //검색 엔터처리
  $("#searchWord").on("keypress",function(e){
    if(13 == e.which){
      e.preventDefault();
      doRetrieve(1);
    }
    
  });//검색 엔터처리  

  //textinput에 숫자만 입력 처리
  $(".numberOnly").on("keyup",function(e){
    console.log(""+$(this).val());
    
    $(this).val(   $(this).val().replace(/[^0-9]/g,"")   );
  }); //.numberonly
  
  //닉네임 재설정
  $("#nicknameReset").on("click",function(){
    console.log("ㅇ에이이이");
    
    $("#nicknameCheckYN").val("0");
    $("#nickname").val("");
    $("#nickname").prop("disabled",false);
    
  });//닉네임 재설정 끝
  
  //아이디 재설정
  $("#idReset").on("click",function(){
    console.log("ㅇ에이이이");
    
    $("#idCheckYN").val("0");
    $("#userId").val("");
    $("#userId").prop("disabled",false);
    
  });//아이디 재설정 끝
  
  });//document.ready  //document.ready  //document.ready  //document.ready  
  
  //밑에 수정칸 초기화
  function initControll(){
	  const initValue = "";
	  $("#idCheckYN").val("0");
	  $("#nicknameCheckYN").val("0");
	  
    $("#mSeq").val(initValue);
    $("#userId").val(initValue);
    $("#nickname").val(initValue);
    $("#password").val(initValue);
    $("#name").val(initValue);
    $("#birthYear").val(initValue);
    $("#birthMonth").val(initValue);
    $("#birthDay").val(initValue);
    $("#email").val(initValue);
    $("#backupQuestion").val(initValue);
    $("#backupAnswer").val(initValue);
    $("#point").val(initValue);
    $("#joinDate").val(initValue);
    $("#userStatus").val(initValue);
    
    $("#userId").prop("disabled",false);
    $("#nickname").prop("disabled",false);
	  
  }//initControll()
  
  //조회
  function doRetrieve(page){
	  console.log("doRetrieve");
	  
	  let userDiv = document.querySelector('input[name="userDiv"]:checked').value;
	  console.log("userDiv: "+userDiv);
	  
	  let searchDivValue = $("#searchDiv").val();
	  
	  //혹시모르니 처리
	  if("ALL"===searchDivValue){
		  searchDivValue="";
	  }
	  
	  $.ajax({ 
		   type: "GET",
		   url: "/ehr/elecmusk/doUserRetrieve.do",
		   asyn: "true",
		   dataType: "html",
		   data:{
			   searchDiv : searchDivValue,
         searchWord: $("#searchWord").val(),
			   pageSize : $("#pageSize").val(),
			   pageNo : page,
			   userDiv : userDiv
		   },
		   success:function(data){ //통신 성공
		    console.log(data);
		   
		    let parsedJson = JSON.parse(data);
		    
		    let htmlData = "";
		    let totalCnt = 0;
		    let pageTotal = 0;
		    
		    //데이터 지워주고
		    $("#userTable>tbody").empty();
		    
		    if(null!=parsedJson && parsedJson.length>0){
		    	
		    	totalCnt = parsedJson[0].totalCnt;
		    	pageTotal = pageTotal = Math.ceil( totalCnt/$("#pageSize").val() );
          console.log("=totalCnt="+totalCnt);
          console.log("=pageSize="+$("#pageSize").val());
          console.log("=pageTotal="+pageTotal);
          console.log("=page="+page);	
          
          $.each(parsedJson,function(index,value){
        	  let nickname = value.nickname;
        	  if(nickname.length>40){
        		  nickname = nickname.substr(0,40)+"...";
        	  }
        	  let status = "";
        	  console.log(value.status);
        	  switch((String)(value.status)){
        	  case "0":
        		  status = "탈퇴(정지)";
        		  break;
        	  case "1":
        		  status = "일반";
        		  break;
        	  case "2":
        		  status = "관리자";
        		  break;
        	  }
            htmlData +=" <tr>";
            htmlData +=" <td class='text-center col-sm-1 col-md-1 col-lg-1'><input type='checkbox' name='chk' value='"+value.mSeq+"' /></td>";
            htmlData += "<td class='text-center col-sm-1 col-md-1 col-lg-1'>"+value.mSeq+"</td>";
            htmlData += "<td class='text-center col-sm-3 col-md-3 col-lg-3'>"+value.userId+"</td>";
            htmlData += "<td class='text-center col-sm-3 col-md-3 col-lg-3'>"+nickname+"</td>";
            htmlData += "<td class='text-center col-sm-1 col-md-1 col-lg-1'>"+value.name+"</td>";
            htmlData += "<td class='text-center col-sm-1 col-md-1 col-lg-1'>"+value.point+"</td>";
            htmlData += "<td class='text-center col-sm-1 col-md-1 col-lg-1'>"+value.joinDate+"</td>";
            htmlData += "<td class='text-center col-sm-1 col-md-1 col-lg-1'>"+status+"</td>";
            htmlData +=" </tr>";                  
          });
          
        //if 끝.
		    }else{
              htmlData +=" <tr>"; 
              htmlData +="   <td colspan='99' class='text-center  col-sm-12 col-md-12 col-lg-12'>no data found</td>";
              htmlData +=" </tr>";
	      }
		    
		    $("#userTable>tbody").append(htmlData);
        $("#page-selection").empty();
        renderingPage(pageTotal,page);
		   },
		   error:function(data){//실패
		   
		   },
		   complete:function(data){//성공, 실패 관계 없이 출력
		   
		   }

		});//doRetrieve ajax
		}//doRetrieve
		
   //paging
   function renderingPage(pageTotal, page){
     console.log("pageTotal:"+pageTotal);
     console.log("page:"+page);
     
     pageTotal=parseInt(pageTotal);
     
     //연결된 EventHandler제거
     $('#page-selection').unbind('page');
     
     $('#page-selection').bootpag({
         total: pageTotal,
         page: page,
         maxVisible: 10,
         leaps: true,
         firstLastUse: true,
         first: '←',
         last: '→',
         wrapClass: 'pagination',
         activeClass: 'active',
         disabledClass: 'disabled',
         nextClass: 'next',
         prevClass: 'prev',
         lastClass: 'last',
         firstClass: 'first'
     }).on("page", function(event, num){
         console.log("num:"+num);
         doRetrieve(num);
     });      
   }  
	      		
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
			<h2>회원관리</h2>
		</div>

		<!-- 검색 : 검색구분(select) 검색어(input) 페이지 사이즈(select)-->
		<form action="#" class="form-inline text-left">
			<div class="form-group">
				<input type="button" class="btn btn-primary btn-sm" value="선택 정지" id="multiBan">
				<select class="form-control input-sm" name="searchDiv" id="searchDiv">
					<c:choose>
					 <c:when test="${USER_SEARCH.size()>0}">
					   <c:forEach var="code" items="${USER_SEARCH}">
					     <option value='<c:out value="${code.detCode}"/>'><c:out value="${code.detName}"/></option>
					   </c:forEach>
					 </c:when>
					</c:choose>
				</select> <input type="text" class="form-control input-sm" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요"> <select
					class="form-control input-sm" name="pageSize" id="pageSize">
          <c:choose>
            <c:when test="${PAGE_SIZE.size()>0}">
              <c:forEach var="pageSize" items="${PAGE_SIZE}">
                <option value='<c:out value="${pageSize.detCode }"/>'><c:out value="${pageSize.detName }"/></option>
              </c:forEach>
            </c:when>
            <c:otherwise>
            </c:otherwise>
          </c:choose>
				</select> <input type="button" class="btn btn-primary btn-sm" value="조회" id="doRetrive">
				    전체<input type="radio" name="userDiv" checked="checked" value="">
                    일반<input type="radio" name="userDiv" value="10">
                    탈퇴(정지)<input type="radio" name="userDiv" value="20">
			</div>
		</form>
		<!-- 검색부분 ----------------------------------------->
		<table class="table table-striped table-bordered table-hover" id="userTable">
			<thead class="bg-primary">
				<tr>
					<th class="text-center col-sm-1 col-md-1 col-lg-1"> <input type="checkbox" id="checkAll"></th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">고유번호</th>
					<th class="text-center col-sm-3 col-md-3 col-lg-3">아이디</th>
					<th class="text-center col-sm-3 col-md-3 col-lg-3">닉네임</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">이름</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">포인트</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">가입일</th>
					<th class="text-center col-sm-1 col-md-1 col-lg-1">상태</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<!-- 테이블 목록 -------------------------------------------------------------->

		<!-- 페이징 -->
		<div class="text-center col-sm-12 col-md-12 col-lg-12">
			<div id="page-selection" class="text-center page"></div>
		</div>
		<!-- 페이징--- -------------------------------------------------------------->
		
		<!--버튼  -->
    <div class="row text-right" id="formButtons">
        <div class="col-sm-8 col-md-8 col-lg-8">
          <input type="button" class="btn btn-primary btn-sm" value="초기화" id="initBtn" >
          <input type="button" class="btn btn-primary btn-sm" value="수정"  id="doUpdate">
        </div>
    </div>
    <div class="row text-left">
        <div class="col-sm-2 col-md-2 col-lg-2"></div>
        <div class="col-sm-8 col-md-8 col-lg-8">*은 필수. 필수가 아닌 데이터중 비어있는 데이터는 조회시 아무 결과가 나오지 않습니다.</div>
    </div>
    <br>
    <!--버튼 -------------------------------------------------------------------->
		
		<!-- 폼 -->
		<form action="#" class="form-horizontal">
			
			<div class="form-group">
				<label for="mSeq" class="col-sm-2 col-md-2 col-lg-2 control-label">고유번호</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" class="form-control" id="mSeq" name="mSeq" readonly="readonly">
				</div>
			</div>
			
			<input type="hidden" name="idCheckYN" id="idCheckYN">
			<div class="form-group">
				<label for="userId" class="col-sm-2 col-md-2 col-lg-2 control-label">아이디*</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" maxlength="20" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요">
				</div>
				<div class="col-sm-2 col-md-2 col-lg-2 text-right">
					<input type="button" class="btn btn-primary btn-sm" value="아이디 중복 확인" id="idCheck">
				</div>
				<div class="col-sm-2 col-md-2 col-lg-2 text-left">
					<input type="button" class="btn btn-primary btn-sm" value="아이디 초기화" id="idReset">
				</div>
			</div>
			
			<input type="hidden" name="nicknameCheckYN" id="nicknameCheckYN">
			<div class="form-group">
				<label for="nickname" class="col-sm-2 col-md-2 col-lg-2 control-label">닉네임*</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" maxlength="20" class="form-control" id="nickname" name="nickname" placeholder="닉네임을 입력하세요">
				</div>
				<div class="col-sm-2 col-md-2 col-lg-2 text-right">
					<input type="button" class="btn btn-primary btn-sm" value="닉네임 중복 확인" id="nicknameCheck">
				</div>
				<div class="col-sm-2 col-md-2 col-lg-2 text-left">
					<input type="button" class="btn btn-primary btn-sm" value="닉네임 초기화" id="nicknameReset">
				</div>
			</div>

			<div class="form-group">
				<label for="password" class="col-sm-2 col-md-2 col-lg-2 control-label">비밀번호*</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="password" maxlength="50" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요">
				</div>
			</div>

			<div class="form-group">
				<label for="name" class="col-sm-2 col-md-2 col-lg-2 control-label">이름</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" maxlength="20" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
				</div>
			</div>

      <div class="form-group">
        <div class="form-inline">
          <label class="col-sm-2 control-label">생년월일</label>
          <div class="col-sm-10">
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
				<label for="email" class="col-sm-2 col-md-2 col-lg-2 control-label">이메일</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
				</div>
			</div>

      <div class="form-group">
        <label for="backupQuestion" class="col-sm-2 col-md-2 col-lg-2 control-label">본인확인 질문</label>
        <div class="col-sm-6 col-md-6 col-lg-6">
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
        <label for="backupAnswer" class="col-sm-2 control-label">본인확인 질문 답변</label>
        <div class="col-sm-6 col-md-6 col-lg-6">
          <input type="text" class="form-control" id="backupAnswer" placeholder="본인확인 질문 답변">
        </div>
      </div>

			<div class="form-group">
				<label for="point" class="col-sm-2 col-md-2 col-lg-2 control-label">포인트</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" class="form-control numberOnly" id="point" name="point">
				</div>
			</div>

			<div class="form-group">
				<label for="joinDate" class="col-sm-2 col-md-2 col-lg-2 control-label">등록일</label>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<input type="text" class="form-control" id="joinDate" name="joinDate" readonly="readonly" placeholder="등록일을 입력하세요">
				</div>
			</div>

      <div class="form-group">
        <label for="userStatus" class="col-sm-2 col-md-2 col-lg-2 control-label">상태</label>
        <div class="col-sm-6 col-md-6 col-lg-6">
          <select  class="form-control" id = "userStatus">
              <option value="1">일반</option>
              <option value="0">탈퇴(정지)</option>
              <option value="2">관리자</option>
            </select>
        </div>
      </div>

		</form>
		<!--폼   -------------------------------------------------------------------->
	</div>
	<!-- div contents ------------------------------------------->
	<footer>
	  <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
	</footer>
</body>
</html>