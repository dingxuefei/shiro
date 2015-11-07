<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf"%>
<%@ include file="../jspf/import-css.jspf"%>
<%@ include file="../jspf/import-js.jspf"%>
<html>
<head>
    <title>Shiro</title>
</head>
<style>
	.bg {
		background: #eee;
		font-size: 14px;
	}
	
	.right_{
		text-align: right;
	}
    a:HOVER {
		color:#ffa829;
		text-decoration:underline;
	}
</style>
<body class="bg">

<iframe id="iframe" name="content" class="ui-layout-center" src="${ctx}/welcome" frameborder="1" scrolling="auto"></iframe>
<div class="ui-layout-north right_">欢迎[<shiro:principal/>]&nbsp;&nbsp;&nbsp;<a style="color: #0099ff;" href="${ctx}/logout">退出</a></div>
<div class="ui-layout-west menu">
    <%@include file="menu.jsp"%>
</div>


<script>
    $(function () {
        $(document).ready(function () {
            $('body').layout({ applyDemoStyles: true,north__resizable:false,west__closable:false,west__resizable:false,initClosed:false});
            $('body').css('margin','auto');
            $('body').css('width','70%');
            $('#iframe').css('left','auto');
            $('#iframe').css('width','1072px');
        });
    });
</script>
<script language="javascript" type="text/javascript">
	if(top.location!=self.location)top.location=self.location;
</script>
</body>
</html>