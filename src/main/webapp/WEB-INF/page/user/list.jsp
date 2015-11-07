<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<html lang="zh-CN">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
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
			<c:if test="${not empty msg}">
			    <div class="alert alert-success fade in">
				    <button type="button" class="close" data-dismiss="alert">&times;</button>
				    <span class="icon-ok-sign icon-large"></span>
				    ${msg}
			    </div>
			</c:if>
			
			<shiro:hasPermission name="sys:user:create">
			    <ul class="nav nav-pills">
			        <li class='active'><a href="${ctx}/user/create">用户新增</a></li>
			    </ul>
			</shiro:hasPermission>
			
			<table id="table" class="table table-bordered table-hover table-condensed">
			    <thead style="background-color:silver; font-family: arial;">
			        <tr>
			            <th>用户名</th>
			            <th>角色列表</th>
			            <th>操作</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${userList}" var="user">
			            <tr>
			                <td>${user.username}</td>
			                <td>${shiro_fn:roleNames(user.roleIds)}</td>
			                <td data-url = "${ctx}/user/${user.id}/delete">
			                    <shiro:hasPermission name="sys:user:update">
			                        <a href="${ctx}/user/${user.id}/update">修改</a>
			                    </shiro:hasPermission>
			
			                    <shiro:hasPermission name="sys:user:update">
			                        <a href="${ctx}/user/${user.id}/changePassword">改密</a>
			                    </shiro:hasPermission>
			                    
			                    <shiro:hasPermission name="sys:user:delete">
			                        <a class="btn-delete" href="javascript:void(0);">删除</a>
			                    </shiro:hasPermission>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
			</table>
			<app:page url="${ctx}/user?" page="${page}" />
		</div>
	</div>
</div>
</body>
</html>