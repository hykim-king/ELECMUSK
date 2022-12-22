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
<!-- bootstrap js -->
<script src="${CP_RES}/bootstrap/js/bootstrap.min.js"></script>
<!-- highchart -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<meta charset="UTF-8">
<title>통계정보</title>
<style type="text/css">
	.highcharts-figure,
	.highcharts-data-table table {
	  min-width: 450px;
	  max-width: 1000px;
	  margin: 1em auto;
	}
	
	#chartArea1{
	  max-height: 500px;
	  display: none;
	}
	#chartArea2{
	  max-height: 500px;
	  display: none;
	}
	#chartArea3{
	  max-height: 500px;
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
	
	#graphArea{
	  text-align: right;
	}
</style>
<script >
  $(document).ready(function(){
	  console.log("document.ready");
	  
	  $("#selectGraph").change(function(){
		     if($(this).val() == 10) {
		         $("#chartArea1").css("display","block");
		         $("#chartArea2").css("display","none");
		         $("#chartArea3").css("display","none");
		       } else if($(this).val() == 20) {
		         $("#chartArea1").css("display","none");
		         $("#chartArea2").css("display","block");
		         $("#chartArea3").css("display","none");
		       } else if($(this).val() == 30) {
		         $("#chartArea1").css("display","none");
		         $("#chartArea2").css("display","none");
		         $("#chartArea3").css("display","block");
		       }
	  });
	    
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
          daejeonNorthChart(seoul,choongbuk,gyeonggi,choongnam,gangwon,daejeon,sejong,incheon);
          daejeonSouthChart(ulsan,jeonbuk,busan,gyeongbuk,jeju,daegu,jeonnam,gyeongnam,gwangju);
          koreaChart(countSum);
        }
      });
  });
  
  function daejeonNorthChart(seoul,choongbuk,gyeonggi,choongnam,gangwon,daejeon,sejong,incheon) {
	  Highcharts.chart('chartArea1', {
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
	          text: '대전 이북 지역별 전기차 통계'
	        },
	        credits: { enabled: false },
	              xAxis : {
	                  categories:["21년6월","21년7월","21년8월","21년9월","21년10월","21년11월","21년12월","22년1월","22년2월","22년3월"]
	        },
	        yAxis: {
	          title: {
	            text: '전기차 통계 정보'
	          },
	          labels: {
	            formatter: function () {
	              return this.value / 1 + '대';
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
	        { name: '충북',
	            data: choongbuk
	        },
	        { name: '충남',
	            data: choongnam
	        },
	        { name: '강원',
	            data: gangwon
	        },
	        { name: '대전',
	            data: daejeon
	        },
	        { name: '세종',
	            data: sejong
	        },
	        { name: '인천',
	            data: incheon
	        }]
	      });
  }
  function daejeonSouthChart(ulsan,jeonbuk,busan,gyeongbuk,jeju,daegu,jeonnam,gyeongnam,gwangju) {
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
	          text: '대전 이남 지역별 전기차 통계'
	        },
	        credits: { enabled: false },
	              xAxis : {
	                  categories:["21년6월","21년7월","21년8월","21년9월","21년10월","21년11월","21년12월","22년1월","22년2월","22년3월"]
	        },
	        yAxis: {
	          title: {
	            text: '전기차 통계 정보'
	          },
	          labels: {
	            formatter: function () {
	              return this.value / 1 + '대';
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
	        { name: '울산',
	            data: ulsan
	        },
	        { name: '전북',
	            data: jeonbuk
	        },
	        { name: '부산',
	            data: busan
	        },
	        { name: '경북',
	            data: gyeongbuk
	        },
	        { name: '제주',
	            data: jeju
	        },
	        { name: '대구',
	            data: daegu
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
	    Highcharts.chart('chartArea3', {
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
	          credits: { enabled: false },
	                xAxis : {
	                    categories:["21년6월","21년7월","21년8월","21년9월","21년10월","21년11월","21년12월","22년1월","22년2월","22년3월"]
	          },
	          yAxis: {
	            title: {
	              text: '전국 전기차 통계 정보'
	            },
	            labels: {
	              formatter: function () {
	                return this.value / 1 + '대';
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
<div>
<div id="graphArea">
  <select id="selectGraph" name="selectGraph" onchange="selectGraphVal()" style="margin:30px;">
    <option value="10">대전 이북 통계</option>
    <option value="20">대전 이남 통계</option>
    <option value="30" selected="selected">전국 통계</option>
  </select>  
  <figure class="highcharts-figure">
  <div id="chartArea1"></div>
</figure>

  <figure class="highcharts-figure">
  <div id="chartArea2"></div>
</figure>

  <figure class="highcharts-figure">
  <div id="chartArea3"></div>
</figure>

</div>

</body>
</html>