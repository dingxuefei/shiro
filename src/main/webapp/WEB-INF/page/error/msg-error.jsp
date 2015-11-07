<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/tagtld.jspf"%>
<%@ include file="../jspf/import-css.jspf"%>
<%@ include file="../jspf/import-js.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
   	 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>welcome</title>
		<style>
		<!--
		    a:HOVER {
				color:#ffa829;
				text-decoration:underline;
			}
		-->
		</style>
	</head>
	<body style="text-align:center;margin-top:60px;font-size: 14px;">
			操作失败：<font style="color:red">${message}</font><br/><br/><a class="btn" href="<app:BackURL/>"><i class="icon-reply"></i>&nbsp;返回</a>
			<br>
			<div class="accordion" id="accordion2">
				<div>
				    <a class="btn btn-link btn-detail" data-toggle="collapse" data-parent="#accordion2" href="#detail">点击显示详细错误信息</a>
				    <div class="detail collapse" id="detail" style="text-align:left;font-size: 12px;">
				        ${error.stackTrace}
				    </div>
				</div>
			</div>
	</body>
	
	
<script type="text/javascript">
    $('#detail').on('hidden', function () {
    	$(this).removeClass("prettyprint");
    })
    $('#detail').on('show', function () {
    	$(this).addClass("prettyprint");
    })
</script>
</html>
