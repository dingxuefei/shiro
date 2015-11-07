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
		    <form method="post" class="form-horizontal" style="margin-top: 20px;">
		        <div class="control-group">
		            <label for="newPassword" class="control-label">新密码：</label>
		            <div class="controls">
		            	<input type="text" id="newPassword" name="newPassword"/>
		            </div>
		        </div>
		        <div class="control-group">
		            <div class="controls">
		                <button type="submit" class="btn btn-info"><i class="${icon_class}"></i>${op}&nbsp;</button>
		                <a href="<app:BackURL/>" class="btn"><i class="icon-reply"></i>返回&nbsp;</a>
		            </div>
		        </div>
		    </form>
		</div>
	</div>
</div>
</body>
</html>