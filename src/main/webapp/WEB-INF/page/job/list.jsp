<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/include/tagtld.jspf"%>
<%@ include file="../jspf/import-css.jspf"%>
<%@ include file="../jspf/import-js.jspf"%>
<html lang="zh-CN">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
						<span class="icon-ok-sign icon-large"></span> ${msg}
					</div>
				</c:if>

				<!-- 添加定时任务 -->
				<div id="addScheduleJob" class="modal hide fade" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加/修改定时器</h3>
					</div>
					<div class="modal-body" style="max-height: 435px;"
						id="addScheduleJob_modal_body">
						<!-- 加载内容 -->
					</div>
				</div>

				<!-- 添加定时器分组类型 -->
				<div id="addScheduleJobGroup" class="modal hide fade" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h3 id="myModalLabel">添加/修改定时器分组</h3>
					</div>
					<div class="modal-body" id="addScheduleJobGroup_modal_body">
						<!-- 加载内容 -->
					</div>
				</div>


				<!-- 查看quartz表达式 -->
				<div id="cron-expression" class="modal hide fade" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h3 id="myModalLabel">查看quartz时间表达式</h3>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-hover table-condensed">
							<tr>
								<td>秒 0-59 , – * /</td>
								<td>分 0-59 , – * /</td>
								<td>小时 0-23 , – * /</td>
								<td>日期 1-31 , – * ? / L W C</td>
							</tr>
							<tr>
								<td>月份 1-12 或者 JAN-DEC , – * /</td>
								<td>星期 1-7 或者 SUN-SAT , – * ? / L C #</td>
								<td colspan="2">年（可选） 留空, 1970-2099 , – * /</td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: center;">表达式意义</td>
							</tr>
							<tr>
								<td>0 0 12 * * ?</td>
								<td>每天中午12点触发</td>
								<td>0 15 10 ? * *</td>
								<td>每天上午10:15触发</td>
							</tr>
							<tr>
								<td>0 15 10 * * ? 2005</td>
								<td>2005年的每天上午10:15触发</td>
								<td>0 * 14 * * ?</td>
								<td>在每天下午2点到下午2:59期间的每1分钟触发</td>
							</tr>
							<tr>
								<td>0 0/5 14 * * ?</td>
								<td>在每天下午2点到下午2:55期间的每5分钟触发</td>
								<td>0 0/5 14,18 * * ?</td>
								<td>在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发</td>
							</tr>
							<tr>
								<td>0 0-5 14 * * ?</td>
								<td>在每天下午2点到下午2:05期间的每1分钟触发</td>
								<td>0 10,44 14 ? 3 WED</td>
								<td>每年三月的星期三的下午2:10和2:44触发</td>
							</tr>
							<tr>
								<td>0 15 10 ? * MON-FRI</td>
								<td>周一至周五的上午10:15触发</td>
								<td>0 15 10 15 * ?</td>
								<td>每月15日上午10:15触发</td>
							</tr>
							<tr>
								<td>0 15 10 L * ?</td>
								<td>每月最后一日的上午10:15触发</td>
								<td>0 15 10 ? * 6L</td>
								<td>每月的最后一个星期五上午10:15触发</td>
							</tr>
							<tr>
								<td>0 15 10 ? * 6L 2002-2005</td>
								<td>2002年至2005年的每月的最后一个星期五上午10:15触发</td>
								<td>0 15 10 ? * 6#3</td>
								<td>每月的第三个星期五上午10:15触发</td>
							</tr>
							<tr>
								<td>0 6 * * *</td>
								<td>每天早上6点</td>
								<td>0 * /2 * * *</td>
								<td>每两个小时</td>
							</tr>
							<tr>
								<td>0 23-7/2，8 * * *</td>
								<td>晚上11点到早上8点之间每两个小时，早上八点</td>
								<td>0 11 4 * 1-3</td>
								<td>每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点</td>
							</tr>
							<tr>
								<td>0 4 1 1 * */</td>
								<td colspan="3">1月1日早上4点</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
					</div>
				</div>

				<div class="tabbable">
					<ul class="nav nav-tabs">
						<li <c:if test="${active eq 1 || empty active}">class="active"</c:if>><a href="#tab1" data-toggle="tab">定时器列表</a></li>
						<li <c:if test="${active eq 2}">class="active"</c:if>><a href="#tab2" data-toggle="tab">定时器分组</a></li>
					</ul>

					<div class="tab-content">
						<div class='tab-pane<c:if test="${active eq 1 || empty active}"> active</c:if>' id="tab1">
							<shiro:hasPermission name="maintain:job:create">
								<ul class="nav nav-pills">
									<li class='active'><a data-toggle="modal" data-target="#addScheduleJob" href="${ctx}/job/scheduleJobView">新增定时器</a></li>
									<li class='active' id="async"><a href="${ctx}/job/async">同步所有任务</a></li>
									<li class='active' id="async"><a href="#cron-expression" data-toggle="modal">查看quartz时间表达式</a></li>
									<a href="${ctx}/job/1" class="btn btn-link pull-right">刷新</a>
								</ul>

							</shiro:hasPermission>

							<table id="table_job" class="table table-bordered table-hover table-condensed">
								<thead style="background-color: silver; font-family: arial;">
									<tr>
										<th>定时器名称</th>
										<th>表达式</th>
										<th>调用类</th>
										<th>调用方法</th>
										<th>定时器分组</th>
										<th>创建时间</th>
										<th>定时器状态</th>
										<th>定时器描述</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${scheduleJobs}" var="scheduleJob">
										<tr>
											<td>${scheduleJob.scheduleJobName}</td>
											<td>${scheduleJob.scheduleJobCronExpression}</td>
											<td>${scheduleJob.scheduleJobClass}</td>
											<td>${scheduleJob.scheduleJobMethod}</td>
											<td>${shiro_fn:scheduleJobGroupName(scheduleJob.scheduleJobGroupId)}</td>
											<td><shiro_fmt:formatTimestamp value="${scheduleJob.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td>${scheduleJob.status eq 0 ? '<label style="color: #468847;margin-bottom:0px;">运行中</label>':'<label style="color: red;margin-bottom:0px;">停止</label>'}</td>
											<td>${scheduleJob.scheduleJobDescription}</td>
											<td data-url="${ctx}/job/${scheduleJob.scheduleJobId}/deleteScheduleJob">
												<c:if test="${scheduleJob.status eq 0}">
													<shiro:hasPermission name="maintain:job:stop">
														<a href="${ctx}/job/${scheduleJob.scheduleJobId}/stopScheduleJob">停止</a>
													</shiro:hasPermission>
												</c:if> 
												<c:if test="${scheduleJob.status eq 1}">
													<shiro:hasPermission name="maintain:job:start">
														<a href="${ctx}/job/${scheduleJob.scheduleJobId}/startScheduleJob">启动</a>
													</shiro:hasPermission>
												</c:if> 
												<shiro:hasPermission name="maintain:job:start">
													<a href="${ctx}/job/${scheduleJob.scheduleJobId}/restartScheduleJob">重启</a>
												</shiro:hasPermission> 
												<shiro:hasPermission name="maintain:job:update">
													<a data-toggle="modal" data-target="#addScheduleJob" href="${ctx}/job/scheduleJobView?id=${scheduleJob.scheduleJobId}">修改</a>
												</shiro:hasPermission> 
												<shiro:hasPermission name="maintain:job:delete">
													<a class="btn-delete" href="javascript:void(0);">删除</a>
												</shiro:hasPermission>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<div class='tab-pane<c:if test="${active eq 2}"> active</c:if>'
							id="tab2">
							<shiro:hasPermission name="maintain:job:create">
								<ul class="nav nav-pills">
									<li class='active'><a data-toggle="modal" data-target="#addScheduleJobGroup" href="${ctx}/job/scheduleJobGroupView">新增定时器组</a></li>
									<a href="${ctx}/job/2" class="btn btn-link pull-right">刷新</a>
								</ul>
							</shiro:hasPermission>

							<table id="table_jobGroup" class="table table-bordered table-hover table-condensed">
								<thead style="background-color: silver; font-family: arial;">
									<tr>
										<th>定时器分组名称</th>
										<th>创建时间</th>
										<th>定时器分组状态</th>
										<th>定时器分组描述</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${scheduleJobGroups}" var="scheduleJobGroup">
										<tr>
											<td>${scheduleJobGroup.scheduleJobGroupName}</td>
											<td><shiro_fmt:formatTimestamp value="${scheduleJobGroup.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td>${scheduleJobGroup.status eq 0 ? '<label style="color: #468847;margin-bottom:0px;">运行中</label>':'<label style="color: red;margin-bottom:0px;">冻结</label>'}</td>
											<td>${scheduleJobGroup.scheduleJobGroupDescription}</td>
											<td data-url="${ctx}/job/${scheduleJobGroup.scheduleJobGroupId}/deleteScheduleJobGroup">
												<c:if test="${scheduleJobGroup.status eq 0}">
													<shiro:hasPermission name="maintain:job:stop">
														<a href="${ctx}/job/${scheduleJobGroup.scheduleJobGroupId}/1/updateJobGroupstatus">停止</a>
													</shiro:hasPermission>
												</c:if> 
												<c:if test="${scheduleJobGroup.status eq 1}">
													<shiro:hasPermission name="maintain:job:start">
														<a href="${ctx}/job/${scheduleJobGroup.scheduleJobGroupId}/0/updateJobGroupstatus">启动</a>
													</shiro:hasPermission>
												</c:if> 
												<shiro:hasPermission name="maintain:job:update">
													<a data-toggle="modal" data-target="#addScheduleJobGroup" href="${ctx}/job/scheduleJobGroupView?id=${scheduleJobGroup.scheduleJobGroupId}">修改</a>
												</shiro:hasPermission> 
												<shiro:hasPermission name="maintain:job:delete">
													<a class="btn-delete" href="javascript:void(0);">删除</a>
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
					$('#addScheduleJob').on('hidden', function() {
						$(this).removeData("modal");
						$('#addScheduleJob_modal_body').html("");
					});

					$('#addScheduleJobGroup').on('hidden', function() {
						$(this).removeData("modal");
						$("#addScheduleJobGroup_modal_body").html("");
					});

					$(function() {
						$("#table_job tr").mouseover(function() {
							$(this).removeClass("warning").addClass("success");
						}).mouseout(function() {
							$(this).removeClass("success");
							$("#table_job tr:even").addClass("warning");
						});
						$("#table_job tr:even").addClass("warning"); //给表格的偶数行添加class值为warning
						$("#table_job tr:odd").addClass(""); //加偶数行样式 
					});

					$(function() {
						$("#table_jobGroup tr").mouseover(function() {
							$(this).removeClass("warning").addClass("success");
						}).mouseout(function() {
							$(this).removeClass("success");
							$("#table_jobGroup tr:even").addClass("warning");
						});
						$("#table_jobGroup tr:even").addClass("warning"); //给表格的偶数行添加class值为warning
						$("#table_jobGroup tr:odd").addClass(""); //加偶数行样式 
					});

					$('#async').tooltip({
						title : '和数据库同步所有定时任务'
					})
					
				</script>
			</div>
		</div>
	</div>
</body>
</html>