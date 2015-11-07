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
			<ul class="nav nav-pills" style="margin-bottom: 10px;">
			    <li class='active' style="margin-left: 10px;color: #0099ff;">当前在线人数：${sessionCount}人</li>
			    <a href="" style="float: right;padding-right: 10px;">刷新</a>
			</ul>
			<table id="table" class="table table-bordered table-hover table-condensed">
			    <thead style="background-color:silver; font-family: arial;">
			        <tr>
			            <th style="width: 400px;">会话ID</th>
			            <th>用户名</th>
			            <th>主机地址</th>
			            <th>登录时间</th>
			            <th>最后访问时间</th>
			            <th>超时时间(s)</th>
			            <th>已强制退出</th>
			            <th>操作</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${sessions}" var="session">
			            <tr>
			                <td>${session.id}</td>
			                <td>${shiro_fn:principal(session)}</td>
			                <td>${session.host}</td>
			                <td><fmt:formatDate value="${session.startTimestamp}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                <td><fmt:formatDate value="${session.lastAccessTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                <td><fmt:formatNumber value="${session.timeout/1000}" pattern="0" /></td>
			                <td>${shiro_fn:isForceLogout(session) ? '是' : '否'}</td>
			                <td data-url = "${ctx}/sessions/${session.id}/forceLogout">
			                	<shiro:hasPermission name="sys:session:forceLogout">
				                    <c:if test="${not shiro_fn:isForceLogout(session)}">
				                        <a class="btn-delete" href="javascript:void(0);">强制退出</a>
				                    </c:if>
			                    </shiro:hasPermission>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
	//setInterval("window.location.reload();", 2000)
</script>
</body>
</html>