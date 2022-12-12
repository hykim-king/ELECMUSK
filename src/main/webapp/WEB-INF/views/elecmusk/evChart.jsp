<%--
/**
  Class Name:
  Description:
  
  Modification information
  
    수정일     수정자      수정내용
  -----   -----  -------------------------------------------
    2022. 12. 1        최초작성 
    
    author eclass 개발팀 :ITSC
    since 2022.11.24
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@page import="java.util.List"%>
<%@page import="com.pcwk.ehr.chart.dao.evChartDao"%>
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
<!-- callAjax -->
<script src="${CP_RES}/bootstrap/js/callAjax.js"></script>
<!-- String, Number, Date Util  -->
<script src="${CP_RES}/bootstrap/js/eUtil.js"></script>
<!-- paging -->
<script src="${CP_RES}/bootstrap/js/jquery.bootpag.js"></script>
<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<!-- highchart -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<meta charset="UTF-8">
<title>통계정보</title>
<style type="text/css">
.highcharts-figure,
.highcharts-data-table table {
  min-width: 320px;
  max-width: 800px;
  margin: 1em auto;
}

#chartArea {
  height: 450px;
}

.highcharts-data-table table {
  font-family: Verdana, sans-serif;
  border-collapse: collapse;
  border: 1px solid #ebebeb;
  margin: 10px auto;
  text-align: center;
  width: 100%;
  max-width: 500px;
}

.highcharts-data-table caption {
  padding: 1em 0;
  font-size: 1.2em;
  color: #555;
}

.highcharts-data-table th {
  font-weight: 600;
  padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
  padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
  background: #f8f8f8;
}

.highcharts-data-table tr:hover {
  background: #f1f7ff;
}

</style>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	    
      let method = "GET";
      let url    = "/elecmusk/chartRetrieve.do";
      let async  = false;
      let params = {};
      PClass.callAjax(method,url,async,params,function(data){
        let parsedJson = JSON.parse(data);
        let seoul = [];
        let ulsan = [];
        let choongbuk = [];
        let jeonbuk = [];
        let gyeonggi = [];
        let choongnam = [];
        let busan = [];
        let gangwon = [];
        let gyeongbuk = [];
        let daejeon = [];
        let sejong = [];
        let jeju = [];
        let daegu = [];
        let incheon = [];
        let jeonnam = [];
        let gyeongnam = [];
        let gwangju = [];
        let countSum = [];
        if(null != parsedJson && parsedJson.length > 0) {
          $.each(parsedJson, function(index, value){
            seoul.push([value.seoul]);
            ulsan.push([value.ulsan]);
            choongbuk.push([value.choongbuk]);
            jeonbuk.push([value.jeonbuk]);
            gyeonggi.push([value.gyeonggi]);
            choongnam.push([value.choongnam]);
            busan.push([value.busan]);
            gangwon.push([value.gangwon]);
            gyeongbuk.push([value.gyeongbuk]);
            daejeon.push([value.daejeon]);
            sejong.push([value.sejong]);
            jeju.push([value.jeju]);
            daegu.push([value.daegu]);
            incheon.push([value.incheon]);
            jeonnam.push([value.jeonnam]);
            gyeongnam.push([value.gyeongnam]);
            gwangju.push([value.gwangju]);
            countSum.push([value.countSum]);
          })//.each
          chart(seoul,ulsan,choongbuk,jeonbuk,gyeonggi,choongnam,busan,gangwon,gyeongbuk,daejeon,sejong,jeju,daegu,incheon,jeonnam,gyeongnam,gwangju);
          koreaChart(countSum)
        }
      });

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
  });
  
  function chart(seoul,ulsan,choongbuk,jeonbuk,gyeonggi,choongnam,busan,gangwon,gyeongbuk,daejeon,sejong,jeju,daegu,incheon,jeonnam,gyeongnam,gwangju,countSum) {
	  Highcharts.chart('chartArea', {
	        chart: {
	          type: 'area'
	        },
	        accessibility: {
	          description: ''
	        },
	        title: {
	          text: '월 별 전기차 통계 현황'
	        },
	        subtitle: {
	          text: '지역별 전기차 통계'
	        },
	              xAxis : {
	                  categories:["21년6월","21년7월","21년8월","21년9월","21년10월","21년11월","21년12월","22년1월","22년2월","22년3월"]
	        },
	        yAxis: {
	          title: {
	            text: '전기차 통계 정보'
	          },
	          labels: {
	            formatter: function () {
	              return this.value / 0.025 + '대';
	            }
	          }
	        },
	        tooltip: {
	          pointFormat: '{series.name} 전기차 통계 <b>{point.y:,.0f}</b><br/>{point.x}'
	        },
	        plotOptions: {
	          area: {
	            pointStart: 0,
	            marker: {
	              enabled: false,
	              symbol: 'circle',
	              radius: 2,
	              states: {
	                hover: {
	                  enabled: true
	                }
	              }
	            }
	          }
	        },
	        series: [{
	          name: '서울',
	          data: seoul
	        }, 
	        { name: '경기',
	          data: gyeonggi
	        },
	        { name: '울산',
	            data: ulsan
	        },
	        { name: '충북',
	            data: choongbuk
	        },
	        { name: '전북',
	            data: jeonbuk
	        },
	        { name: '충남',
	            data: choongnam
	        },
	        { name: '부산',
	            data: busan
	        },
	        { name: '강원',
	            data: gangwon
	        },
	        { name: '경북',
	            data: gyeongbuk
	        },
	        { name: '대전',
	            data: daejeon
	        },
	        { name: '세종',
	            data: sejong
	        },
	        { name: '제주',
	            data: jeju
	        },
	        { name: '대구',
	            data: daegu
	        },
	        { name: '인천',
	            data: incheon
	        },
	        { name: '전남',
	            data: jeonnam
	        },
	        { name: '경남',
	            data: gyeongnam
	        },
	        { name: '광주',
	            data: gwangju
	        }]
	      });
  }
  function koreaChart(countSum) {
	    Highcharts.chart('chartArea2', {
	          chart: {
	            type: 'area'
	          },
	          accessibility: {
	            description: ''
	          },
	          title: {
	            text: '월 별 전기차 통계 현황'
	          },
	          subtitle: {
	            text: '전국 전기차 통계'
	          },
	                xAxis : {
	                    categories:["21년6월","21년7월","21년8월","21년9월","21년10월","21년11월","21년12월","22년1월","22년2월","22년3월"]
	          },
	          yAxis: {
	            title: {
	              text: '전국 전기차 통계 정보'
	            },
	            labels: {
	              formatter: function () {
	                return this.value / 0.025 + '대';
	              }
	            }
	          },
	          tooltip: {
	            pointFormat: '{series.name} 전기차 통계 <b>{point.y:,.0f}</b><br/>{point.x}'
	          },
	          plotOptions: {
	            area: {
	              pointStart: 0,
	              marker: {
	                enabled: false,
	                symbol: 'circle',
	                radius: 2,
	                states: {
	                  hover: {
	                    enabled: true
	                  }
	                }
	              }
	            }
	          },
	          series: [             
	          {name: '전국',
	              data: countSum
	          }]
	        });
	  }
</script>

</head>
<body>
<header>
<jsp:include page ="/resources/asset/cmn/main_header.jsp" flush="false"/>
</header>
<div id="contents">
  <figure class="highcharts-figure">
  <div id="chartArea"></div>
  <p class="highcharts-description">
    2021년 06월 ~ 2022년 03월.
  </p>
</figure>
  <figure class="highcharts-figure">
  <div id="chartArea2"></div>
  <p class="highcharts-description">
    2021년 06월 ~ 2022년 03월.
  </p>
</figure>
</div>

<footer>
<jsp:include page="/resources/asset/cmn/main_footer.jsp" flush="false" />
</footer>
</body>
</html>