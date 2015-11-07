<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
<!--
a:hover{
	text-decoration:none;
	color:#fff;
}
p a:HOVER {
	color:#ffa829;
	text-decoration:underline;
}

code {
    background-color: #e1e1e8;
    border: 1px solid #e1e1e8;
    color: #d14;
    padding: 2px 4px;
    white-space: nowrap;
}
-->
</style>
<link type="text/css" href="${ctx}/static/css/menu.css" rel="stylesheet">
<script src="${ctx}/static/js/jquery.collapse.js"></script>
<div id="menu">
	<c:forEach items="${menus}" var="m">
		<h5 id="${m.id}" style="line-height: 15px;">${m.name}</h5>
		<div id="div_${m.id}" class="divcss">
			<!-- 加载子菜单 -->
		</div>
	</c:forEach>
	<script>
		new jQueryCollapse($("#menu"), {
			open : function() {
				var id = $(this.context).attr("id");
				if($("#div_"+id+":has(p)").length == 0){   //判断是否有子元素，有说明菜单已经加载，不再重新请求服务器
					jQuery.ajax( {
			    		type : "get",
			    		async:false,
			    		cache:true,
			            url : "${ctx}/submenu?parent_id="+id,
			            dataType: "json",
			            success : function(data) {
			            	data = eval(data);
			            	var html = "";
			            	for(var i=0; i<data.length; i++){ 
			            		var i_class = "icon-angle-right";
			            		var url = "${ctx}/"+data[i].url;
			            		var tar = "";
			            		var on_click="";
			            		if(data[i].isChild){
			            			i_class = "icon-double-angle-right";
			            			url = "javascript:void(0);";
			            			on_click = 'onclick="openChild(this);"';
			            		}else{
			            			tar = 'target="content"';
			            			on_click = 'onclick="sel(this);"';
			            		}
			            		html += '<p><i style="margin-left: 0px;" class="menu-icon '+i_class+'"></i><code class="codeClass"><a data-id="'+data[i].id+'" id="a_'+data[i].id+'" href = "'+url+'" '+tar+' '+on_click+' >'+data[i].name+'</a></code></p>'
		            	  	} 
			            	$("#div_"+id).html(html);
			            }
			        });
					this.slideDown(150);
				}else{
					$("#div_"+id).slideDown(150);
				}
			},
			close_ : function() {
				this.slideUp(150);
			}
		});
		
		
		//展开子元素
		function openChild(obj){
			var id = $(obj).data("id");
			var margin_left= parseInt($(obj).parent().prev().css('marginLeft'));
			$('.codeClass a').css("color","");
			$(obj).css("color","#ffa829");
			if($(obj).parent().parent().children("div").length == 0){ 
				jQuery.ajax( {
		    		type : "get",
		    		async:true,
		    		cache:true,
		            url : "${ctx}/submenu?parent_id="+id,
		            dataType: "json",
		            success : function(data) {
		            	data = eval(data);
		            	var html = "";
		            	for(var i=0; i<data.length; i++){ 
		            		var i_class = "icon-angle-right";
		            		var url = "${ctx}/"+data[i].url;
		            		var tar = "";
		            		var on_click="";
		            		if(data[i].isChild){
		            			i_class = "icon-double-angle-right";
		            			url = "javascript:void(0);";
		            			on_click = 'onclick="openChild(this);"';
		            		}else{
		            			tar = 'target="content"';
		            			on_click = 'onclick="sel(this);"';
		            		}
		            		html += '<div style="margin-top:5px;"><p><i class="menu-icon '+i_class+'" style="margin-left: '+(margin_left+13)+'px;"></i><code class="codeClass"><a data-id="'+data[i].id+'" id="a_'+data[i].id+'" href = "'+url+'" '+tar+' '+on_click+' >'+data[i].name+'</a></code></p></div>';
		            	}
		            	$(obj).parent().parent().append(html);
		            }
				});
			}
		}
	    
	    function sel(obj){
			$('.codeClass').css("background-color","#e1e1e8");
			$('.codeClass a').css("color","");
			$(obj).parent().css("background-color","#f7f7f9");
	    	$(obj).css("color","#ffa829");
		}
	</script>
</div>
