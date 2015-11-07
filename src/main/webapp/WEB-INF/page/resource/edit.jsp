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
		    <form:form method="post" commandName="resource" cssClass="form-horizontal" cssStyle="margin-top: 20px;">
		        <form:hidden path="id"/>
		        <form:hidden path="available"/>
		        <form:hidden path="parentId"/>
		        <form:hidden path="parentIds"/>
		
		        <c:if test="${not empty parent}">
		            <div class="control-group">
					    <label class="control-label">父节点名称：</label>
					    <div class="controls">
					        <label style="text-align: left;" class="control-label">${parent.name}</label>
					    </div>
					</div>
		        </c:if>
		
		        <div class="control-group">
		            <form:label path="name" cssClass="control-label"><c:if test="${not empty parent}">子</c:if>名称：</form:label>
		            <div class="controls">
				        <form:input path="name"/>
				    </div>
		        </div>
		        
		        <div class="control-group">
		            <form:label path="type" cssClass="control-label">类型：</form:label>
		            <div class="controls">
		            	<form:select id="sel_type" path="type" items="${types}" itemLabel="info"/>
		            </div>
		        </div>
		
		        <div class="control-group">
		            <form:label path="url" cssClass="control-label">URL路径：</form:label>
		            <div class="controls">
		            	<form:input path="url"/>
		            </div>
		        </div>
		
		        <div class="control-group">
		            <form:label path="permission" cssClass="control-label">权限字符串：</form:label>
		            <div class="controls">
		            	<c:if test="${empty permission}">
		            		<form:input path="permission"/>
		            	</c:if>
		            	<c:if test="${!empty permission}">
		            		<input type="text" name="permission" value="${permission}">
		            	</c:if>
		            </div>
		        </div>
		
		        <div class="control-group">
		            <div class="controls">
		                <button type="submit" class="btn btn-info btn-small"><i class="${icon_class}"></i>&nbsp;${op}</button>
		                <a href="<app:BackURL/>" class="btn btn-small"><i class="icon-reply"></i>&nbsp;返回</a>
		            </div>
		        </div>
		
		    </form:form>
		</div>
	</div>
</div>
<script type="text/javascript">

	$(function(){
		$("#sel_type").select2({
			width:206
		});
	})

</script>
</body>
</html>