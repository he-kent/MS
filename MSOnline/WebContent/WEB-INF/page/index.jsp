<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="author" content="He"/>
  <meta name="description" content="login page"/>
  <meta name="keywords" content="妙手在线,理疗,脊柱矫正"/>
  <!-- http-equiv 属性改写http 请求。http-equiv 可以模拟或替换三种请求头   值用  content指定  -->
  <!-- <meta http-equiv="refresh" content="5"/> -->
  <meta http-equiv="content-type" content="text/html charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <!-- 指定默认样式，content  可以是一个对应的 style 元素 或 link 元素 -->
  <meta http-equiv="default-style" content=""/>
  <title>登陆</title>
  <!-- <base href="http://localhost:8080/MSOline/"/> 设置链接基准URL-->
  <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/dist/css/bootstrap.min.css"  />
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/base.css"/>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/login.css"/>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="warp">
           <div class="container logincontainer" >
                <div class="panel panel-primary">
				  <div class="panel-heading">登陆</div>
				  <div class="panel-body">
				     <div class="text-center"> <span class="text-danger">${msg}</span></div>
				    <form class="form-horizontal" role="form" method="post" action="${pageContext.request.contextPath}/user/login.do">
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">用户名:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">密码:</label>
					    <div class="col-sm-8">
					      <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					      <div class="checkbox">
					        <label>
					          <input type="checkbox" id="pwd-memory">记住密码
					        </label>
					      </div>
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10">
					      <button type="submit" class="btn btn-primary" >登录</button>
					    </div>
					  </div>
					</form>
				  </div>
		        </div>
           </div>
     </div>
</body>
</html>
