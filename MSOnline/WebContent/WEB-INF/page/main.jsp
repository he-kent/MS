<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/dist/css/bootstrap.min.css"  />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/treeview/bootstrap-treeview.min.css"/>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jqueryui/themes/base/jquery-ui.min.css"/>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/base.css"/>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/treeview/bootstrap-treeview.min.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/dist/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/jqueryui/jquery-ui.min.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/echartjs/echarts.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resource/echartjs/vintage.js"></script>
 <c:set var="contextPath" value="${pageContext.request.contextPath}" scope="application"></c:set>
    <script>  
        <%--JS gloable varilible--%>  
        var contextPath = "${contextPath}";  
        var ajax = $.ajax;
        var e = event || window.event;
	     // 对Date的扩展，将 Date 转化为指定格式的String
	     // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
	     // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
	     // 例子： 
	     // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
	     // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
	     Date.prototype.Format = function (fmt) { //author: meizz 
	         var o = {
	             "M+": this.getMonth() + 1, //月份 
	             "d+": this.getDate(), //日 
	             "h+": this.getHours(), //小时 
	             "m+": this.getMinutes(), //分 
	             "s+": this.getSeconds(), //秒 
	             "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	             "S": this.getMilliseconds() //毫秒 
	         };
	         if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	         for (var k in o)
	         if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	         return fmt;
	     };
    </script> 
</head>
<body>
    <nav class="navbar navbar-default ">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" id="toFirstPage" href="#"onclick="menuOpt.toLoadPage('home/homePage.do')"><img src="${pageContext.request.contextPath}/resource/img/pnglogo.png"  class="logo"/>民生理疗管理系统</a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="${pageContext.request.contextPath}/user/safeExit.do"><b>欢迎，${sessionScope.user.username}</b></a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
	          <c:if test="${!empty sessionScope.user.avatar}">
	               <img class="img-rounded" src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" alt="用户头像" title="用户头像"/>
	          </c:if>
	          <c:if test="${empty sessionScope.user.avatar}">
	               <span class="glyphicon glyphicon-user"></span>
	          </c:if>
	            <span class="caret"></span>
	          </a>
	          <ul class="dropdown-menu">
	            <li><a href="#">用户资料</a></li>
	            <li><a href="#">修改密码</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="${pageContext.request.contextPath}/user/safeExit.do" target="_top">安全退出</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	<div class="container-fluid">
	    <div class="row">
	        <div class="col-md-2  col-ms-1">
		         <div class="left-menu-list-box" >
		            <!--  <p ><span class="glyphicon glyphicon-th-list"></span>菜单列表</p> -->
		               <c:forEach  items="${sessionScope.menus}" var="menu">
		                       <h3 onclick="menuOpt.menuOnclick(this);" class="h3"> ${menu.menuName}</h3>
			                    <c:if test="${!empty menu.childrenMenu}">
			                         <ul class="menu-list menuclose">
				                        <c:forEach items="${menu.childrenMenu}" var="childMenu">
							                  <li><a href="#" onclick="menuOpt.toLoadPage('${childMenu.menuUrl}')">${childMenu.menuName}</a></li>
				                        </c:forEach>
			                          </ul>
			                    </c:if>
		               </c:forEach>
		         </div>
	        </div>
	        <div class="col-md-10 col-ms-11">
	         <div class="main-content" id="mainContent"> </div>
	        </div>
	    </div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/main.js"></script>
</body>
</html>