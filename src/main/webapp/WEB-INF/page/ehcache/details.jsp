<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<style>
    .detail {
        word-break: break-all;
    }
    a:HOVER {
		color:#ffa829;
		text-decoration:underline;
	}
</style>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div data-table="table" class="panel">
				<ul class="nav nav-pills" style="margin-bottom: 10px;">
				    <a href="<app:BackURL/>" class="btn btn-link pull-right">返回</a>
			    	<a href="?BackURL=<app:BackURL/>" class="btn btn-link pull-right">刷新</a>
				    <shiro:hasPermission name="monitor:ehcache:clean">
				    	<a class="btn btn-link pull-right btn-clear">清空</a>
				    </shiro:hasPermission>
				</ul>
			    
			
			    <table class="table table-bordered table-condensed">
			        <tbody>
			
			        <tr class="bold info">
			            <td colspan="2">
			                ${cacheName} 键列表
			            </td>
			        </tr>
			
			        <c:forEach items="${keys}" var="key">
			            <tr>
			                <td style="width: 40%">${key}</td>
			                <td data-key="${key}">
			                	<shiro:hasPermission name="monitor:ehcache:detail">
			                    	<a class="btn btn-link no-padding btn-details">查看详细</a>
			                    </shiro:hasPermission>
			                    <shiro:hasPermission name="monitor:ehcache:delete">
			                    	<a class="btn btn-link no-padding btn-delete1">删除</a>
			                    </shiro:hasPermission>
			                </td>
			            </tr>
			        </c:forEach>
			
			        </tbody>
			    </table>
			    <br/><br/>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {

    $(".btn-details").click(function() {
        var td = $(this).closest("td");
        var key = td.data("key");
        var url = "${ctx}/ehcaches/${cacheName}/" + key + "/details";
        jQuery.ajax({
            type : "get",
            url : url,
            dataType: "json",
            success : function(data) {
	            var detail = td.find(".detail");
	            if(detail.length) {
	                detail.remove();
	            }
	            detail = $("<div class='detail alert alert-block alert-info in fade'><button type='button' class='close' data-dismiss='alert'>&times;</button></div>");
	            var detailInfo = "";
	            detailInfo += "命中次数:" + data.hitCount;
	            detailInfo +=" | ";
	            detailInfo += "大小:" + data.size;
	            detailInfo +=" | ";
	            detailInfo += "最后创建/更新时间:" + data.latestOfCreationAndUpdateTime;
	            detailInfo +=" | ";
	            detailInfo += ",最后访问时间:" + data.lastAccessTime;
	            detailInfo +=" | ";
	            detailInfo += "过期时间:" + data.expirationTime;
	            detailInfo +=" | ";
	            detailInfo += "timeToIdle(秒):" + data.timeToIdle;
	            detailInfo +=" | ";
	            detailInfo += "timeToLive(秒):" + data.timeToLive;
	            detailInfo +=" | ";
	            detailInfo += "version:" + data.version;
	
	            detailInfo +="<br/><br/>";
	            detailInfo +="值:" + data.objectValue;
	
	            detail.append(detailInfo);
	            
	            td.append(detail);
	
	            td.find(".alert").alert();
            }
        });
    });
    
    
    $(".btn-delete1").click(function() {
    	var td = $(this).closest("td");
    	var key = td.data("key");
    	$.app.confirm({
            title: "确认删除缓存",
            message: "确认删除 "+key+" 的缓存吗？",
            ok: function () {
                var url = "${ctx}/ehcaches/${cacheName}/" + key + "/delete";
                jQuery.ajax({
                    type : "get",
                    url : url,
                    success : function(data) {
                        td.closest("tr").remove();
                    }
                });
            }
    	});
    });

    $(".btn-clear").click(function() {
        $.app.confirm({
            title: "确认清空缓存",
            message: "确认清空整个缓存吗？",
            ok: function () {
                $.app.waiting("正在执行..");
                var url = "${ctx}/ehcaches/${cacheName}/clear";
                $.get(url, function(data) {
                    $.app.waitingOver();
                    window.location.reload();
                });
            }
        });
    });
});

</script>