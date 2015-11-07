<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<html>
<head>
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
			
			<shiro:hasPermission name="sys:role:create">
			    <ul class="nav nav-pills">
			        <li class='active'><a href="${ctx}/role/create">角色新增</a></li>
			    </ul>
			</shiro:hasPermission>
			<table id="table" class="table table-bordered table-hover table-condensed">
			    <thead style="background-color:silver; font-family: arial;">
			        <tr>
			            <th>角色名称</th>
			            <th>角色描述</th>
			            <th>拥有的资源</th>
			            <th>操作</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${roleList}" var="role">
			            <tr>
			                <td>${role.role}</td>
			                <td>${role.description}</td>
			                <td>${shiro_fn:resourceNames(role.resourceIds)}</td>
			                <td data-url = "${ctx}/role/${role.id}/delete">
			                    <shiro:hasPermission name="sys:role:update">
			                        <a href="${ctx}/role/${role.id}/update">修改</a>
			                    </shiro:hasPermission>
			
			                    <shiro:hasPermission name="sys:role:delete">
			                        <a class="btn-delete" href="javascript:void(0);">删除</a>
			                    </shiro:hasPermission>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
			</table>
			<app:page url="${ctx}/role?" page="${page}" />
		</div>
	</div>
</div>
</body>
</html>