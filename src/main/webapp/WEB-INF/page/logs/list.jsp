<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<html>
<head>
    <title>操作日志</title>
    <style type="text/css">
    	input {
			width: 110px;
		}
		a:HOVER {
			color:#ffa829;
			text-decoration:underline;
		}
		.icon-th::before {
		    margin-top: 4px;
		}
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
			
			<!-- 日志详情 -->
			<div id="logDetail" class="modal hide fade" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-header">
			    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			    <h3 id="myModalLabel">日志详情</h3>
			  </div>
			  <div class="modal-body" id="logDetail_modal_body">
			  	<!-- 加载内容 -->
			  </div>
			  <div class="modal-footer">
			    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
			  </div>
			</div>
			<ul class="nav nav-pills" style="margin:0px;">
				<form class="form-inline" action="${ctx}/logs" method="post" style="margin-top: 10px;margin-bottom: 10px;float: right;">
		            <label class="label-left">操作者：</label><input type="text" id="userName" name="userName" value="${userName}">
		           	<label class="label-left">操作对象：</label><input type="text" id="story" name="story" value="${story}">
		            <label class="label-left">操作时间：</label>
		            <div class="input-append date form_date">
	                    <input id="beginTime" readonly="readonly" type="text" name="beginTime" style="border-radius:4px 0 0 4px;" value="${beginTime}" />
						<span class="add-on" style="height: 18px;"><i class="icon-th"></i></span>
	                </div>
	                &nbsp;&nbsp;-&nbsp;&nbsp;
	                <div class="input-append date form_date">
	                    <input id="endTime" readonly="readonly" type="text" name="endTime" style="border-radius:4px 0 0 4px;" value="${endTime}" />
						<span class="add-on" style="height: 18px;"><i class="icon-th"></i></span>
	                </div>
		            <button type="button" id="search" onclick="sub();" class="btn btn-primary btn-small">查询</button>
		    	</form>
			</ul>
						
			<table id="table" class="table table-bordered table-hover table-condensed">
			    <thead style="background-color:silver; font-family: arial;">
			        <tr>
			            <th>操作者</th>
			            <th>操作对象</th>
			            <th>操作时间</th>
			            <th>操作</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${logs}" var="logs">
			            <tr>
			                <td>${shiro_fn:userName(logs.userId)}</td>
			                <td>${logs.story}</td>
			                <td><shiro_fmt:formatTimestamp value="${logs.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			                <td>
			                    <shiro:hasPermission name="sys:log:detail">
			                        <a data-toggle="modal" data-target="#logDetail" href="${ctx}/logs/${logs.id}/detail">查看详细</a>
			                    </shiro:hasPermission>
			
			                    <shiro:hasPermission name="sys:log:delete">
			                        <a href="${ctx}/logs/${logs.id}/delete">删除</a>
			                    </shiro:hasPermission>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
			</table>
			<app:page url="${ctx}/logs?userName=${userName}&beginTime=${beginTime}&endTime=${endTime}&story=${story}&" page="${page}" />
		</div>
	</div>
</div>
<script type="text/javascript">

$('#logDetail').on('hidden', function () {
    $(this).removeData("modal");
    $('#logDetail_modal_body').html("");
});

$('.form_date').datetimepicker({
    language:  'zh-CN',
    todayBtn:  1,
	autoclose: 1,
	todayHighlight: 1,
	startView: 2,
	forceParse: 1,
	minView: 0,
	pickerPosition: "bottom-left",
	format:'yyyy-mm-dd hh:ii'
});

function sub(){
	$(".form-inline").submit();
}

$("#userName").keyup(function(event) {
    if(event.keyCode == 13) {
    	$(".form-inline").submit();
    }
});

$("#story").keyup(function(event) {
    if(event.keyCode == 13) {
    	$(".form-inline").submit();
    }
});

</script>
</body>
</html>