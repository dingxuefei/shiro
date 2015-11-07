<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/include/tagtld.jspf" %>
<%@ include file="../jspf/import-css.jspf" %>
<%@ include file="../jspf/import-js.jspf" %>
<html>
<head>
    <title></title>
    <style>
        ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:200px;overflow-y:scroll;overflow-x:auto;}
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
		    <form:form method="post" commandName="role" cssClass="form-horizontal" cssStyle="margin-top: 20px;">
		        <form:hidden path="id"/>
		        <form:hidden path="available"/>
		
		        <div class="control-group">
				    <form:label path="role" cssClass="control-label">角色名：</form:label>
				    <div class="controls">
				        <form:input path="role"/>
				    </div>
				</div>
				
				<div class="control-group">
				    <form:label path="description" cssClass="control-label">角色描述：</form:label>
				    <div class="controls">
				        <form:input path="description"/>
				    </div>
				</div>
				
				<div class="control-group">
				    <form:label path="resourceIds" cssClass="control-label">拥有的资源列表：</form:label>
				    <div class="controls">
				        <form:hidden path="resourceIds"/>
			            <textarea type="text" rows="5" style="width: 500px;font-size: 12px;" id="resourceName" name="resourceName" readonly >${shiro_fn:resourceNames(role.resourceIds)}</textarea>
			            <a id="menuBtn" href="javascript:void(0);">选择</a>
				    </div>
				</div>
				
		        <div class="control-group">
		            <div class="controls">
		                <button type="submit" class="btn btn-info btn-small"><i class="${icon_class}"></i>&nbsp;${op}</button>
		                <a href="<app:BackURL/>" class="btn btn-small"><i class="icon-reply"></i>&nbsp;返回</a>
		            </div>
		        </div>
		
		    </form:form>
		
		
		    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		        <ul id="tree" class="ztree" style="margin-top:0; width:300px;height: 500px;"></ul>
		    </div>
		</div>
	</div>
</div>
    <script>
        $(function () {
            var setting = {
                check: {
                    enable: true ,
                    chkboxType: { "Y": "", "N": "" }
                },
                view: {
                    dblClickExpand: false
                },
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    onCheck: onCheck
                }
            };

            var zNodes =[
                <c:forEach items="${resourceList}" var="r">
	                <c:if test="${not r.rootNode}">
	                	{ id:${r.id}, pId:${r.parentId}, name:"${r.name}", checked:${shiro_fn:in(role.resourceIds, r.id)}},
	                </c:if>
                </c:forEach>
            ];

            function onCheck(e, treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj("tree"),
                        nodes = zTree.getCheckedNodes(true),
                        id = "",
                        name = "";
                nodes.sort(function compare(a,b){return a.id-b.id;});
                for (var i=0, l=nodes.length; i<l; i++) {
                    id += nodes[i].id + ",";
                    name += nodes[i].name + ",";
                }
                if (id.length > 0 ) id = id.substring(0, id.length-1);
                if (name.length > 0 ) name = name.substring(0, name.length-1);
                $("#resourceIds").val(id);
                $("#resourceName").val(name);
            }

            function showMenu() {
                var cityObj = $("#resourceName");
                var cityOffset = $("#resourceName").offset();
                $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

                $("body").bind("mousedown", onBodyDown);
            }
            function hideMenu() {
                $("#menuContent").fadeOut("fast");
                $("body").unbind("mousedown", onBodyDown);
            }
            function onBodyDown(event) {
                if (!(event.target.id == "menuBtn" || event.target.id == "resourceName" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                    hideMenu();
                }
            }

            $.fn.zTree.init($("#tree"), setting, zNodes);
            $("#menuBtn").click(showMenu);
            $("#resourceName").click(showMenu);
        });
    </script>


</body>
</html>