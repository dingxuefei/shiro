<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/include/tagtld.jspf"%>
<style>
<!--
    a:HOVER {
		color:#ffa829;
		text-decoration:underline;
	}
-->
</style>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<form action="${ctx}/job/createScheduleJobGroup?id=${scheduleJobGroup.scheduleJobGroupId}" method="post" class="form-horizontal" style="margin-top: 10px;">
				<div class="control-group">
					<label for="scheduleJobGroupName" class="control-label">定时器分组名称：</label>
					<div class="controls">
						<input type="text" id="scheduleJobGroupName" required="required" name="scheduleJobGroupName" value="${scheduleJobGroup.scheduleJobGroupName}" />
				        <label style="display: inline;padding-left: 5px;color: red;">*</label>
					</div>
				</div>
				<div class="control-group">
					<label for="scheduleJobGroupDescription" class="control-label">定时器分组描述：</label>
					<div class="controls">
						<textarea id="scheduleJobGroupDescription" name="scheduleJobGroupDescription" required="required" rows="3" style="width: 300px;font-size: 12px;">${scheduleJobGroup.scheduleJobGroupDescription}</textarea>
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<c:if test="${empty scheduleJobGroup}">
			            <button type="submit" class="btn btn-info btn-small"><i class="icon-plus"></i>&nbsp;新增&nbsp;</button>
			            </c:if>
			            <c:if test="${!empty scheduleJobGroup}">
			            <button type="submit" class="btn btn-info btn-small"><i class="icon-edit"></i>&nbsp;修改&nbsp;</button>
			            </c:if>
						<button class="btn btn-small" data-dismiss="modal" aria-hidden="true">
							<i class="icon-remove"></i>&nbsp;关闭
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>