<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 9        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%  
    String categoryValue = request.getParameter("category");
    String title = "";
    if("1".equals(categoryValue)){
      title = "자유게시판";
    }else if("2".equals(categoryValue)){
      title = "결함 게시판";
    }else if("3".equals(categoryValue)){
      title = "뉴스";
    }else if("5".equals(categoryValue)){
      title = "공지사항";
    }
    
    request.setAttribute("title", title);
    request.setAttribute("categoryValue", categoryValue);
%>

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
<title>제목</title>
<style >
.commentbox{

width: 100%;
    height: 6.25em;
    resize: none;
}

</style>
<script >


$(document).ready(function(){
    console.log("document.ready");//document
    
    doRetrieve(1);
    
    
$("#commentTable").on("click", ".doCommentDelete", function() {
        console.log($(this).val());
        
        if(confirm("삭제하시겠습니까?")== false)return;
        
        let method ="GET";
        let url ="/boardComment/doDelete.do";
        let async =true;
        let params ={
                    
        		cmSeq : $(this).val()
           
        };
        PClass.callAjax(method,url,async,params,function(data){
            console.log(data);
            
            let parsedJson = JSON.parse(data);
            doRetrieve(1);
            
            if("1" == parsedJson.msgId){
              alert(parsedJson.msgContents);
            }else{
              alert(parsedJson.msgContents);
            }
        });
         
       });
       
    $("#commentTable").on("click", ".doCommentUpdate", function() {
        
      
        if(eUtil.ISEmpty($("#Com_Content").val())==true){
            alert("수정하실 내용을 입력하세요");
             $("#Com_Content").focus();
              return;
        } 
        if(confirm("수정하시겠습니까?")== false)return;
        
        let method ="POST";
        let url ="/boardComment/doUpdate.do";
        let async =true;
        let params ={
            
            contents : $("#Com_Content").val(),
            cmSeq : $(this).val()
        };
        PClass.callAjax(method,url,async,params,function(data){
            console.log(data);
            
            let parsedJson = JSON.parse(data);
            doRetrieve(1);
            
         
        });
         
       });

 
    $("#doCommentSave").on("click",function(){
    	
    	console.log("doSave");
        if(eUtil.ISEmpty($("#Com_Content").val())==true){
         alert("내용을 입력하세요");
          $("#Com_Content").focus();
           return;
        } 
        if(confirm("등록하시겠습니까?")== false)return;
      
        let method ="POST";
        let url ="/boardComment/doSave.do";
        let async =true;
        let params ={
            bdSeq : $("#bdSeq").val(),
            memberSeq : ${sessionScope.userInfo.mSeq},
            contents : $("#Com_Content").val()
        };
        PClass.callAjax(method,url,async,params,function(data){
            console.log(data);
            
            let parsedJson = JSON.parse(data);
            doRetrieve(1);
            
            if("1" == parsedJson.msgId){
              alert(parsedJson.msgContents);
            }else{
              alert(parsedJson.msgContents);
            }
        });
         
       });
    
      
      
   /////////////////////////////////////글자수 200자 제한
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

    ////////////////////댓글 뿌리는 함수/////////////////////////////
    function doRetrieve(page){
      
      console.log("1: "+$("#bdSeq").val());
      
      $.ajax({ 
           type: "GET",
           url: "/ehr/boardComment/doRetrieve.do",
           asyn: "true",
           dataType: "html",
           data:{
             bdSeq : $("#bdSeq").val(),
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
    
 //         	   alert(value.memberSeq);
//            	   alert(${sessionScope.userInfo.mSeq});
            	   htmlData += "<tr>";
                 htmlData += "  <td class='text-left col-sm-1 col-dm-1 col-lg-1'  style='display:none;'>"+<c:out value='value.cmSeq'></c:out>+"</td>";
                 htmlData += "  <td class='text-left col-sm-1 col-dm-1 col-lg-1'  style='display:none;'>"+<c:out value='value.memberSeq'></c:out>+"</td>";
                 htmlData += "  <td class='text-left col-sm-2 col-dm-2 col-lg-2'>"+<c:out value='value.memberNickname'></c:out>+"</td>";
                 htmlData += "  <td class='text-left col-sm-8 col-dm-8 col-lg-8'>"+<c:out value='value.contents'></c:out>+"</td>";
                 htmlData += "  <td class='text-left col-sm-1 col-dm-1 col-lg-1'>"+<c:out value='value.regDt'></c:out>+"</td>";
                 
                                                        //동적으로 버튼만들어줄때 id쓰면안댐!!!!!!
                 if(value.memberSeq == ${sessionScope.userInfo.mSeq}){ 
                	 htmlData += "<td><button class='btn btn-primary btn-sm doCommentUpdate' value='"+<c:out value='value.cmSeq'></c:out>+"'>수정</td>";
                	 htmlData += "<td><button class='btn btn-primary btn-sm doCommentDelete' value='"+<c:out value='value.cmSeq'></c:out>+"'>삭제</td>";
                 }
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

    if(${vo.category} == '1') {
      let title = $("#votitle").val().slice(5);
      console.log("title: "+title);
      $("#title").val(title);
      doUpdate();
    } else {
      let title = $("#votitle").val();
      $("#title").val(title);
      doUpdateOtherCategory();
    }
    
    console.log("document.ready");
    ifidsame();
    
    
    $("#adminDelete").on("click",function(){
      console.log("document.ready");
      
      if(confirm("삭제 하시겠습니까?") == false)return;
      let method = "GET";
      let url    = "/board/doDelete.do";
      let async  = true;
      let params ={
          category: $("#category").val(),
          bdSeq: $("#bdSeq").val()
      };
      PClass.callAjax(method,url,async,params,function(data){
      console.log(data);
      let parsedJson = JSON.parse(data);
      if("1" == parsedJson.msgId){
        alert(parsedJson.msgContents);
        moveToList();
      }else{
        alert(parsedJson.msgContents);
      }
        
      });//=========================================PClass.callAjax끝
    });//==============================================삭제 끝
    
    

    
    //================================글자수 재한 보여주기(0/2000)
    $("#contentstextarea").on("keyup",function(e){
      //현재문자열 길이
      let currnetLength   = $("#contentstextarea").val().length;
      //최대 문자열 길이
      let contentMaxLength   = 2000;
      
      console.log("currnetLength: "+currnetLength);
      
      if(contentMaxLength<currnetLength){
        alert("입력가능한 문자수를 초과하였습니다.");
        $("#contentstextarea").focus();
        
        let str = $("#contents").val();
        str = str.substring(0,contentMaxLength);
        $("#contentstextarea").val(str);
        return false;
        
      }else{
        $("#count").text(currnetLength);
      }
    });
    //================================글자수 재한 보여주기(0/2000)끝
    
    
    $("#boardView").on("click",function(){
      
      
      moveToList();
    });
    
  });//document 끝
  
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
   
   
  //===================================목록으로 함수이동
  function moveToList(){
    window.location.href="${CP}/board/boardView.do?category="+$("#category").val();
  };
//===================================목록으로 이동 끝
   
  function ifidsame(){

  $("#doDelete").on("click",function(){
      console.log("document.ready");
      if($("#regId").val()==("${sessionScope.userInfo.userId}")) {
      
        if(confirm("삭제 하시겠습니까?") == false)return;
        let method = "GET";
        let url    = "/board/doDelete.do";
        let async  = true;
        let params ={
            category: $("#category").val(),
            bdSeq: $("#bdSeq").val()
        };
        PClass.callAjax(method,url,async,params,function(data){
        console.log(data);
        let parsedJson = JSON.parse(data);
        if("1" == parsedJson.msgId){
          alert(parsedJson.msgContents);
          moveToList();
        }else{
          alert(parsedJson.msgContents);
        }
          
        });//=========================================PClass.callAjax끝
      }else{
        alert("본인 게시글이 아닙니다.");
      }
    });//==============================================삭제 끝
  
};
//==========================================doUpdate시작
function doUpdate() {
     $("#doUpdate").on("click",function(){
         if($("#regId").val()==("${sessionScope.userInfo.userId}")) {
          console.log("doUpdate");
            //div
            if(eUtil.ISEmpty( $("#category").val()) == true){
              alert("구분을 입력하세요.");
              return;
            }
            //제목
            if(eUtil.ISEmpty( $("#title").val()) == true){
              alert("제목을 입력하세요.");
              $("#title").focus();
              return;
            }
            //수정자
            if(eUtil.ISEmpty( $("#modId").val()) == true){
              alert("수정자를 입력하세요.");
              $("#modId").focus();
              return;
            }
            //내용
            if(eUtil.ISEmpty( $("#contentstextarea").val()) == true){
              alert("내용을 입력하세요.");
              $("#contentstextarea").focus();
              return;
            }
            
            if(confirm("수정하시겠습니까?") == false)return;
            
            let method  = "POST";
            let url     = "/board/doUpdate.do";
            let async   = true;
            let params  ={
                category   : $("#category").val(),
                bdSeq      : $("#bdSeq").val(),
                title      : "["+$("#tag").val()+"] "+$("#title").val(),
                modId      : $("#modId").val(),
                contents   : $("#contentstextarea").val()
            };
            PClass.callAjax(method,url,async,params,function(data){
              console.log(data);
              let parsedJson = JSON.parse(data);
              if("1" == parsedJson.msgId){
                alert(parsedJson.msgContents);
                moveToList();
              }else{
                alert(parsedJson.msgContents);
              }
            });
            
         }else{
           alert("본인 계시물이 아닙니다.")
         }
        });
};
//==========================================doUpdate끝

//==========================================doUpdate 다른 카테고리 시작
function doUpdateOtherCategory() {
     $("#doUpdate").on("click",function(){
         if($("#regId").val()==("${sessionScope.userInfo.userId}")) {
          console.log("doUpdate");
            //div
            if(eUtil.ISEmpty( $("#category").val()) == true){
              alert("구분을 입력하세요.");
              return;
            }
            //제목
            if(eUtil.ISEmpty( $("#title").val()) == true){
              alert("제목을 입력하세요.");
              $("#title").focus();
              return;
            }
            //수정자
            if(eUtil.ISEmpty( $("#modId").val()) == true){
              alert("수정자를 입력하세요.");
              $("#modId").focus();
              return;
            }
            //내용
            if(eUtil.ISEmpty( $("#contentstextarea").val()) == true){
              alert("내용을 입력하세요.");
              $("#contentstextarea").focus();
              return;
            }
            
            if(confirm("수정하시겠습니까?") == false)return;
            
            let method  = "POST";
            let url     = "/board/doUpdate.do";
            let async   = true;
            let params  ={
                category   : $("#category").val(),
                bdSeq      : $("#bdSeq").val(),
                title      : $("#title").val(),
                modId      : $("#modId").val(),
                contents   : $("#contentstextarea").val()
            };
            PClass.callAjax(method,url,async,params,function(data){
              console.log(data);
              let parsedJson = JSON.parse(data);
              if("1" == parsedJson.msgId){
                alert(parsedJson.msgContents);
                moveToList();
              }else{
                alert(parsedJson.msgContents);
              }
            });
            
         }else{
           alert("본인 계시물이 아닙니다.")
         }
        });
};
//==========================================doUpdate끝
   
   
</script>

</head>
<body>
  <!------------------------------------------------- 헤더 -->
  <header>
  <jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
  </header>
  <!------------------------------------------------- 헤더끝 -->
  <div id="contents">
  <!-------------------------------------- div container -->
  <div class="container">
    <!----------------------------------- 제목 -->
    <div class="page-header">
      <h2>게시등록</h2>
    </div>
    <!------------------------------------ 제목 -->
    <input type="hidden" class="form-control" id="category" name="category" value="${vo.category }">
    <input type="hidden" class="form-control" id="bdSeq" name="bdSeq" value="${vo.bdSeq }">
    <input type="hidden" class="form-control" id="regId" name="regId" value="${vo.regId }">
    <input type="hidden" class="form-control" id="votitle" name="votitle" value="${vo.title }">
    <input type="hidden" class="form-control" id="regDt" name="regDt" value="${vo.regDt }">
    
    <!------------------------------------- 버튼 -->
    <div class="row text-right">
      <c:choose>
        <c:when test="${2 <= sessionScope.userInfo.status && not empty sessionScope.userInfo}">
         <input type="button" class="btn btn-primary btn-sm" value="관리자 삭제" id="adminDelete">
        </c:when>
      </c:choose>
      <c:choose>
        <c:when test="${sessionScope.userInfo.userId == vo.regId}">
          <input type="button" class="btn btn-primary btn-sm" value="수정" id="doUpdate">
          <input type="button" class="btn btn-primary btn-sm" value="삭제" id="doDelete">
        </c:when>
      </c:choose>
      <input type="button" class="btn btn-primary btn-sm" value="목록" id="boardView">
    </div>
    <!------------------------------------- 버튼 -->
    
    <!--------------------------------------------------------- 폼 -->
    <form action="#" class="form-horizontal">
     <c:choose>
      <c:when test="${sessionScope.userInfo.userId == vo.regId}">
      <div class="form-group">
       <c:choose>
        <c:when test="${vo.category == '1'}">
          <label for="title">태그</label>
            <select class="form-control input-sm" name="tag" id="tag">
              <option value="자유">자유</option>
              <option value="유머">유머</option>
              <option value="거래">거래</option>
              <option value="건의">건의</option>
            </select>
          </c:when>
        </c:choose>
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" placeholder="제목 입력하세요" maxlength="100" >
          </div>
          <div class="form-group">
            <label for="regId">등록자</label>
            <input type="text" class="form-control" id="nickName" name="nickName" placeholder="등록자 입력하세요" maxlength="100" readonly="readonly" value="${vo.nickName }">
          </div>
          <div class="form-group">
            <label for="contentstextarea">내용</label>
            <textarea class="form-control" rows="10" id="contentstextarea" name="contentstextarea" style="resize: none;">${vo.contents }</textarea>
            <div class="text-right col-sm-12 col-dm-12 col-lg-12"><span id="count">0</span>/2000</div>
          </div>
          </c:when>
          <c:otherwise>
       <div class="form-group">
              <label for="title">제목</label>
              <input type="text" class="form-control" id="title" name="title" placeholder="제목 입력하세요" readonly="readonly" maxlength="100" >
            </div>
            <div class="form-group">
              <label for="regId" style="display: block;">등록자</label>
              <div style="border: 1px solid rgba(220,220,220,1); padding: 10px; border-radius: 5px;">
               ${vo.nickName}
              </div>
            </div>
            <div class="form-group">
              <label for="contentstextarea" style="display: block;">내용</label>
              <div style="border: 1px solid rgba(220,220,220,1); padding: 10px; height: 100%; word-break: break-all; border-radius: 5px; min-height: 300px;">
               ${vo.contents }
              </div>
            </div>
          </c:otherwise>
        </c:choose>
    </form>
    <!--------------------------------------------------------- 폼 -->
  
  <!--------댓글 ----------->
<!-- 댓글 뿌리기 -->
<table class="table" id="commentTable">
  <tbody></tbody>
</table>

<!-- 댓글 입력 -->
  <form name="commentInsertForm">
  <div class="comtitle"><h3>댓글창</h3></div>
  <div class="cominput" >
  <label for ="Com_Content">내용</label>
  <textarea class="commentbox"rows="15"  name="Com_Content" id="Com_Content" placeholder="댓글을 입력해주세요" ></textarea>
  <div class="com2">
  <div class="com_btn">
  
  <button type="button" class="button3">취소</button>
  <button type="button" name="commentInsertBtn" class="button1" id='doCommentSave'>등록</button>
  </div>
  </div>  
  </div>
  <span style="color:#aaa;" id="counter">(0/최대200자)</span>
  
  
  </form>
<!-- 댓글 입력 --------------------------------------------------->


  </div>
  <!--------------------------------------- div container --->
  </div>
  <jsp:include page ="/resources/asset/cmn/main_footer.jsp" flush="false"/>
</body>
</html>