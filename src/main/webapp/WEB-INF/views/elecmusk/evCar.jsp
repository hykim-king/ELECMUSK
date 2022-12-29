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
    doRetrieve(1);
    
    
    
    $("#evCarSave").on("click",function(){
      window.location.href = "${CP}/elecmusk/regevcar.do";
    });
    
    $("#keywordRetrive").on("click",function(){
      doRetrieve(1);
    });
    
    $(function() {
      let didScroll;
      let lastScrollTop = 0;
      let navbarHeight = $("header").outerHeight();
      $(window).scroll(function(event) {
        didScroll = true;
      });

      setInterval(function() {
        if (didScroll) {
          hasScrolled();
          didScroll = false;
        }
      }); // 스크롤이 멈춘 후 동작이 실행되기 까지의 딜레이

      function hasScrolled() {
        if ($(this).width() > 700) {
          let st = $(this).scrollTop(); // 현재 window의 scrollTop 값
          if ($(window).scrollTop() > 50) {
            $(".logo-area").slideUp("fast"); // header 숨기기
            $(".text-logo-area").addClass("visible");
          } else {
            if ($(window).scrollTop() < 200) {
              $(".logo-area").slideDown("fast"); // header 보이기
              $(".text-logo-area").removeClass("visible");
            }
          }
        }
      }
    });
    //document End -------------------------------------------------------------
  });
  
  function doRetrieve(page) {
    let method = "GET";
    let url    = "/elecmusk/doRetrieve.do";
    let async  = true;
    let params = {
        manufactureKeyword: $("#manufactureKeyword").val(),
        appearanceKeyword: $("#appearanceKeyword").val(),
        modelKeyword: $("#modelKeyword").val(),
        batteryTypeKeyword: $("#batteryTypeKeyword").val(),
        pageSize : $("#pageSize").val(),
        pageNo: page
    };
    PClass.callAjax(method,url,async,params,function(data){
        let parsedJson = JSON.parse(data);
            
        let htmlData = "";
        $("#evCar>tbody").empty();
        
        let totalCnt = 0; //총글수
        let pageTotal = 0;//총 페이지수        
        
        if(null != parsedJson && parsedJson.length > 0) {
          
          totalCnt=parsedJson[0].totalCnt;
          pageTotal = Math.ceil( totalCnt/$("#pageSize").val() );
          
          $.each(parsedJson, function(index, value) {
             htmlData += "<tr>";
             htmlData += "<div class='picture'>";
             htmlData += "  <td rowspan='11'><a onClick='evCarSelectOne("+<c:out value='value.carNo'/>+")'><img src='"+<c:out value='value.imgUrl'/>+"' style='width:700px;'/></a></td>";
             htmlData += "</div>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>자동차명</td>";
             htmlData += "  <td>"+<c:out value='value.carName'/>+"</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>가격</td>";
             htmlData += "  <td>"+<c:out value='value.carPrice'/>+"(만원)</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>제조사</td>";
             htmlData += "  <td>"+<c:out value='value.manufacture'/>+"</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>연식</td>";
             htmlData += "  <td>"+<c:out value='value.productYear'/>+"년형</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>차종</td>";
             htmlData += "  <td>"+<c:out value='value.appearance'/>+"</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>모델</td>";
             htmlData += "  <td>"+<c:out value='value.carModel'/>+"</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>배터리 타입</td>";
             htmlData += "  <td>"+<c:out value='value.batteryType'/>+"</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>배터리 전압</td>";
             htmlData += "  <td>"+<c:out value='value.batteryCapa'/>+"kWh</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>최대속도</td>";
             htmlData += "  <td>"+<c:out value='value.maxSpeed'/>+"km/h</td>";
             htmlData += "</tr>";
             htmlData += "<tr>";
             htmlData += "  <td>출력</td>";
             htmlData += "  <td>"+<c:out value='value.outPut'/>+"kW</td>";
             htmlData += "</tr>";
          })
        } else {
               htmlData += "<tr>";
               htmlData += "  <td colsapn='2' rowspan='11'>등록된 차 정보가 없습니다.</td>";
               htmlData += "</tr>";
        }
        $("#evCar>tbody").append(htmlData);
        $("#page-selection").empty();
        renderingPage(pageTotal,page)
    });
    
  }
  
  function renderingPage(pageTotal, page){
      pageTotal=parseInt(pageTotal);
      
      //연결된 EventHandler제거
      $("#page-selection").unbind("page");
      
      $("#page-selection").bootpag({
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
            doRetrieve(num);
        });
    }
  
    function evCarSelectOne(carNo){
      if(${2 <= sessionScope.userInfo.status}) {
        let url = "${CP}/elecmusk/evCarSelectOne.do";
  
        url = url + "?carNo="+carNo;
        location.href = url;
      } 
    }
</script>
</head>
<body>
  <header>
    <jsp:include page="/resources/asset/cmn/main_header.jsp" flush="false" />
  </header>
  <div id="contents">
  <input type="hidden" id="pageSize" name="pageSize" value="6">
    <div class="select-area">
    <table class="selectTable">
      <thead>
        <th>&nbsp;</th>
        <th>제조사</th>
        <th>외형</th>
        <th>차종</th>
        <th>배터리종류</th>
      </thead>
      <tbody>
        <tr>
          <td>
            <label>키워드</label>
          </td>
          <td>
            <select id="manufactureKeyword" name="manufactureKeyword">
            <option value="">전체</option>
		          <c:choose>
		           <c:when test="${MANUFACTURE_KEYWORD.size()>0}">
		             <c:forEach var="code" items="${MANUFACTURE_KEYWORD}">
		               <option value='<c:out value="${code.detCode}"/>'><c:out value="${code.detName}"/></option>
		             </c:forEach>
		           </c:when>
		          </c:choose>            
            </select>
          </td>
          <td>
            <select id="appearanceKeyword" name="appearanceKeyword">
            <option value="">전체</option>
              <c:choose>
               <c:when test="${APPEARANCE_KEYWORD.size()>0}">
                 <c:forEach var="code" items="${APPEARANCE_KEYWORD}">
                   <option value='<c:out value="${code.detCode}"/>'><c:out value="${code.detName}"/></option>
                 </c:forEach>
               </c:when>
              </c:choose>
            </select>
          </td>
          <td>
            <select id="modelKeyword" name="modelKeyword">
            <option value="">전체</option>
              <c:choose>
               <c:when test="${MODEL_KEYWORD.size()>0}">
                 <c:forEach var="code" items="${MODEL_KEYWORD}">
                   <option value='<c:out value="${code.detCode}"/>'><c:out value="${code.detName}"/></option>
                 </c:forEach>
               </c:when>
              </c:choose>
            </select>
          </td>
          <td>
            <select id="batteryTypeKeyword" name="batteryTypeKeyword">
            <option value="">전체</option>
              <c:choose>
               <c:when test="${BATTERYTYPE_KEYWORD.size()>0}">
                 <c:forEach var="code" items="${BATTERYTYPE_KEYWORD}">
                   <option value='<c:out value="${code.detCode}"/>'><c:out value="${code.detName}"/></option>
                 </c:forEach>
               </c:when>
              </c:choose>
            </select>
          </td>
          <td>
            <input type="button" class="btn btn-primary btn-sm" value="조회" id="keywordRetrive">
            <c:choose>
              <c:when test="${2 <= sessionScope.userInfo.status && not empty sessionScope.userInfo}">
                <input type="button" class="btn btn-primary btn-sm" value="등록" id="evCarSave">
              </c:when>
              <c:otherwise>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </tbody>
    </table>
    </div>
    
    <table class="evcar-table" id="evCar">
      <tbody>
      </tbody>
    </table>
    
    <div class="page-header" style="margin:30px">
    <div class="text-center col-sm-12 col-md-12 col-lg-12">
      <div id="page-selection" class="text-center page"></div>    
    </div>
    </div>
     
  </div>
  <footer>
    <jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
  </footer>
</body>
  </html>
