<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/include/tagtld.jspf"%>
<%@ include file="../jspf/import-css.jspf"%>
<%@ include file="../jspf/import-js.jspf"%>
<html lang="zh-CN">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加/编辑用户</title>
    <style>
	<!--
	    a:HOVER {
			color:#ffa829;
			text-decoration:underline;
		}
	-->
	</style>
</head>
<body>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<form:form method="post" commandName="user" cssClass="form-horizontal" cssStyle="margin-top: 20px;">
					<form:hidden path="id" />
					<form:hidden path="salt" />
					<form:hidden path="locked" />

					<c:if test="${op ne '新增'}">
						<form:hidden path="password" />
					</c:if>

					<div class="control-group">
						<form:label path="username" cssClass="control-label">用户名：</form:label>
						<div class="controls">
							<form:input path="username" />
						</div>
					</div>


					<c:if test="${op eq '新增'}">
						<div class="control-group">
							<form:label path="password" cssClass="control-label">密码：</form:label>
							<div class="controls">
								<form:password path="password" />
							</div>
						</div>
					</c:if>

					<div class="control-group">
						<form:label path="roleIds" cssClass="control-label">角色列表：</form:label>
						<div class="controls">
							<form:select path="roleIds" items="${roleList}"
								itemLabel="description" itemValue="id" multiple="true" />
							(按住shift键多选)
						</div>
					</div>

					<div class="control-group">
						<div class="controls">
							<button type="submit" class="btn btn-info btn-small">
								<i class="${icon_class}"></i>&nbsp;${op}</button>
							<a href="<app:BackURL/>" class="btn btn-small"><i class="icon-reply"></i>&nbsp;返回</a>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>