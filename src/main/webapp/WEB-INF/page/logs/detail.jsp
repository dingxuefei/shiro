<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<style>
<!--
 .form-horizontal .control-label{
 	width: 120px;
 }
 .form-horizontal .controls{
 	margin-left: 140px;
 }
.input-detail {
	width: 160px;
}
a:HOVER {
	color:#ffa829;
	text-decoration:underline;
}
-->
</style>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="form-horizontal" >
				<div class="control-group">
				 	<label class="control-label">操作者：</label>
				 	<div class="controls">
				    	<input type="text" class="input-detail" disabled="disabled" value="${shiro_fn:userName(log.userId)}" />
				    </div>
				</div>
				<div class="control-group">
				    <label class="control-label">操作对象：</label>
				    <div class="controls">
				        <input type="text" class="input-detail" disabled="disabled" value="${log.story}" />
				    </div>
				</div>
				<div class="control-group">
				    <label class="control-label">操作时间：</label>
				    <div class="controls">
				        <input type="text" class="input-detail" disabled="disabled" value="<shiro_fmt:formatTimestamp value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				    </div>
				</div>
				<div class="control-group">
				    <label class="control-label">操作后数据：</label>
				    <div class="controls">
				        <textarea disabled="disabled" rows="6" style="width: 350px;">${log.afterContent}</textarea>
				    </div>
				</div>
			</div>
		</div>
	</div>
</div>