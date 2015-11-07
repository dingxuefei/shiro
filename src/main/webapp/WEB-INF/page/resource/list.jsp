<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<html>
<head>
    <title></title>
    <style>
        #table th, #table td {
            font-size: 12px;
            padding : 8px;
        }
	    a:HOVER {
			color:#ffa829;
			text-decoration:underline;
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
			
			<table id="table" style="font-size: 12px;" class="table table-bordered table-hover table-condensed">
			    <thead>
			        <tr>
			            <th>名称</th>
			            <th>类型</th>
			            <th>URL路径</th>
			            <th>权限字符串</th>
			            <th>操作</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach items="${resourceList}" var="resource">
			            <tr data-tt-id='${resource.id}' <c:if test="${not resource.rootNode}">data-tt-parent-id='${resource.parentId}'</c:if>>
			                <td>${resource.name}</td>
			                <td>${resource.type.info}</td>
			                <td>${resource.url}</td>
			                <td>${resource.permission}</td>
			                <td>
			                    <shiro:hasPermission name="sys:resource:create">
			                        <c:if test="${resource.type ne 'button'}">
			                        <a href="${ctx}/resource/${resource.id}/appendChild">添加子节点</a>
			                        </c:if>
			                    </shiro:hasPermission>
			
			                    <shiro:hasPermission name="sys:resource:update">
			                        <a href="${ctx}/resource/${resource.id}/update">修改</a>
			                    </shiro:hasPermission>
			                    <c:if test="${not resource.rootNode}">
			
			                    <shiro:hasPermission name="sys:resource:delete">
			                        <a class="deleteBtn" href="javascript:void(0);" data-id="${resource.id}">删除</a>
			                    </shiro:hasPermission>
			                    </c:if>
			                </td>
			            </tr>
			        </c:forEach>
			    </tbody>
			</table>
		</div>
	</div>
</div>
<script>
    $(function() {
        $("#table").treetable({ expandable: true}).treetable("expandNode", 1);
        $(".deleteBtn").click(function() {
    	    var id = $(this).data("id");
    		$.app.confirm({
    	        ok: function () {
    	        	location.href = "${ctx}/resource/"+id+"/delete";
    	        }
    		});
    	});
    });
</script>
</body>
</html>