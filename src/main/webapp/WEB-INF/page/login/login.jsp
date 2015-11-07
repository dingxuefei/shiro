<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<html>
<head>
	<title>登录</title>
	<link type="text/css" href="${ctx}/static/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link type="text/css" href="${ctx}/static/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<link type="text/css" href="${ctx}/static/css/style.css" rel="stylesheet" />
	<link type="text/css" href="${ctx}/static/css/themes.css" rel="stylesheet" />
</head>

<body class="login">
<br/>
<br/>
<br/>
<br/>
	<div class="wrapper">
		<h2 align="center" style="font-family:Verdana, Geneva, sans-serif; font-size:28px; color:#FFF;">管理员登录</h2>
		<div class="login-body">
			<h2>LOGIN</h2>
                        
			<form method="post" style="margin: 0px;">
				<div class="control-group">
					<div class="email controls">
						<input name="username" placeholder="用户名" class="input-block-level" required type="text" value="<shiro:principal />">
					</div>
				</div>
				<div class="control-group">
					<div class="pw controls">
						<input placeholder="密码" class="input-block-level" required type="password" name="password">
					</div>
				</div>
				<div class="control-group">
					<input style="margin-top:-3px;" type="checkbox" name="rememberMe" id="rememberMe" value="true"><label for="rememberMe" style="display: inline-block;margin-left: 5px;">下次自动登录</label>
				</div>
				<div class="submit" style="margin-top: 0px;">
					<input value="登录" class="btn btn-primary" type="submit" />
				</div>
			</form>
			<div class="forget">
			&nbsp;
				<c:if test="${!empty error}">
					<a href="javascript:void(0);" style="color: #E54B5D;padding: 0px;"><span>${error}</span></a>
				</c:if>
			</div>
		</div>
	</div>


</body>
</html>