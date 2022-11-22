<%@ page language="java" contentType="text/html; charset=UTF-8"
          isErrorPage="true"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initail-scale=1.0">
<meta name="description" content="pcwk html" />
<!-- 키워드 -->
<meta name="keyword" content="html5, css3, javascript6, jQuery">
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="/PC_HTML/favicon.ico">
<!-- jquery ui -->
<link rel="stylesheet" href="/PC_HTML/assets/css/jquery-ui.css">
<style>
  table{
   width: 600px;
   border-collapse: collapse;
  }
  
  th,td{
    border: 1px solid #ccc;
    text-align: center;
  }
</style>
<title>제목</title>
<script src="/PC_HTML/assets/js/jquery-3.6.1.min.js"></script>
<script src="/PC_HTML/assets/js/jquery-ui.js"></script>
<!-- javascript -->
<script type="text/javascript">
  $(document).ready(function(){
    
  });
</script>
</head>
<body>
  <h2>처리중 예외 발생</h2>
  <hr>
  <table>
    <tr>
      <th>예외내용</th>
    </tr>
    
    <tr>
      <td><%= exception.toString() %></td>
    </tr>
  </table>
</body>
</html>