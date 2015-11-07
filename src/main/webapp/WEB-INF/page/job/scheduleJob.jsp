<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<form action="${ctx}/job/createScheduleJob?id=${scheduleJob.scheduleJobId}" method="post" class="form-horizontal" style="margin-top: 10px;">
			    <div class="control-group">
				    <label for="scheduleJobName" class="control-label">定时器名称：</label>
				    <div class="controls">
				        <input type="text" id="scheduleJobName" required="required" name="scheduleJobName" value="${scheduleJob.scheduleJobName}" />
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
				    </div>
				</div>
				<div class="control-group">
				    <label for="scheduleJobCronExpression" class="control-label">表达式：</label>
				    <div class="controls">
				        <input type="text" id="scheduleJobCronExpression" required="required" name="scheduleJobCronExpression" value="${scheduleJob.scheduleJobCronExpression}" />
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
				    </div>
				</div>
				<div class="control-group">
				    <label for="scheduleJobClass" class="control-label">调用类：</label>
				    <div class="controls">
				        <input type="text" id="scheduleJobClass" required="required" name="scheduleJobClass" value="${scheduleJob.scheduleJobClass}" />
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
				    </div>
				</div>
				<div class="control-group">
				    <label for="scheduleJobMethod" class="control-label">调用方法：</label>
				    <div class="controls">
				        <input type="text" id="scheduleJobMethod" required="required" name="scheduleJobMethod" value="${scheduleJob.scheduleJobMethod}" />
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
				    </div>
				</div>
				<div class="control-group">
				    <label for="scheduleJobGroupId" class="control-label">定时器分组：</label>
				    <div class="controls">
				        <select name="scheduleJobGroupId" id="scheduleJobGroupId">
				        	<c:forEach items="${scheduleJobGroups}" var="scheduleJobGroups">
				        		<option <c:if test="${scheduleJob.scheduleJobGroupId eq scheduleJobGroups.scheduleJobGroupId}">selected="selected" </c:if> value="${scheduleJobGroups.scheduleJobGroupId}">${scheduleJobGroups.scheduleJobGroupName}</option>
				        	</c:forEach>
				        </select>
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
				    </div>
				</div>
				<div class="control-group">
				    <label for="scheduleJobDescription" class="control-label">定时器描述：</label>
				    <div class="controls">
				        <textarea id="scheduleJobDescription" name="scheduleJobDescription" required="required" rows="3" style="width: 300px;font-size: 12px;">${scheduleJob.scheduleJobDescription}</textarea>
				    </div>
				</div>
				<div class="control-group">
			        <div class="controls">
			        	<c:if test="${empty scheduleJob}">
			            	<button type="submit" class="btn btn-info btn-small" id="add" title="新添加的任务不会立即执行，请手动开启"><i class="icon-plus"></i>&nbsp;新增&nbsp;</button>
			            </c:if>
			            <c:if test="${!empty scheduleJob}">
			            	<button type="submit" class="btn btn-info btn-small" id="update" title="更新之后会将此任务停止，请手动开启"><i class="icon-edit"></i>&nbsp;修改&nbsp;</button>
			            </c:if>
			            <button class="btn btn-small" data-dismiss="modal" aria-hidden="true"><i class="icon-remove"></i>&nbsp;关闭</button>
			            <c:if test="${empty scheduleJob}">
			            	<label style="margin-top: 10px; color: red;">新添加的任务不会立即执行，请手动开启</label>
			            </c:if>
			            <c:if test="${!empty scheduleJob}">
			            	<label style="margin-top: 10px; color: red;">更新之后会将此任务停止，请手动开启</label>
			            </c:if>
			        </div>
			    </div>
			</form>
		</div>
	</div>
</div>
<script>
$(function(){
	$("#scheduleJobGroupId").select2({
		width:206
	});
})
</script>