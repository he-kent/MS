<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/homepage.css"/>
<title>首页</title>
</head>
<body>
<div class="page-header">
  <h1> <small></small></h1>
</div>
<div class="homebox">
   <div >
       <div id="CostOfWeekBar" class="homeChatrs"></div>
   </div>
   <div >
       <div id="CostPcOfWeekBar"class="homeChatrs"></div>
   </div>
</div>
<div class="homebox">
   <div >
       <div id="CardMoneyOfWeekBar" class="homeChatrs"></div>
   </div>
   <div >
       <div id="CardCountOfWeekBar"class="homeChatrs"></div>
   </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/homepage/homepage.js"></script>
</body>
</html>