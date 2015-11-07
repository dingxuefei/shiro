<%--
 分页格式
   首页 <<   1   2   3   4   5   6   7   8   9   10  11>  >> 尾页
   首页 <<   1   2   3   4   5   6   7   8   9   ... 11  12 >  >> 尾页
   首页 <<   1   2  ...  4   5   6   7   8   9   10 ... 12  13 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  12  13 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  ... 13  14 >  >> 尾页
   首页 <<   1   2  ...  5   6   7   8   9   10  11  ...   21  22 >  >> 尾页
--%>
<%@ tag pageEncoding="UTF-8" description="分页" %>
<%@ attribute name="page" type="com.shiro.util.Page" required="true" description="分页" %>
<%@ attribute name="pageSize" type="java.lang.Integer" required="false" description="每页大小" %>
<%@ attribute name="url" type="java.lang.String" required="true" description="url地址" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="app" %>
<c:if test="${empty pageSize}">
    <c:set var="pageSize" value="${page.pageSize}"/>
</c:if>

<c:set var="displaySize" value="2"/>
<c:set var="current" value="${page.pageNo}"/>

<c:set var="begin" value="${current - displaySize}"/>
<c:if test="${begin <= displaySize}">
    <c:set var="begin" value="${1}"/>
</c:if>
<c:set var="end" value="${current + displaySize}"/>
<c:if test="${end > page.pageCount - displaySize}">
    <c:set var="end" value="${page.pageCount - displaySize}"/>
</c:if>
<c:if test="${end < 0 or page.pageCount < displaySize * 4}">
    <c:set var="end" value="${page.pageCount}"/>
</c:if>

<hr style="margin-top: 20px;margin-bottom: 0px;">
<div class="pagination" style="margin:10px 0px;">
    <ul style="margin-bottom: -7px;">
        <c:choose>
            <c:when test="${page.firstPage}">
                <li class="disabled"><a title="首页">首页</a></li>
                <li class="disabled"><a title="上一页">&lt;&lt;</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=1&pageSize=${pageSize}')" title="首页">首页</a></li>
                <li><a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${current -1}&pageSize=${pageSize}')" title="上一页">&lt;&lt;</a></li>
            </c:otherwise>
        </c:choose>

        <c:forEach begin="1" end="${begin == 1 ? 0 : 2}" var="i">
            <li <c:if test="${current == i}"> class="active"</c:if>>
                <a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${i}&pageSize=${pageSize}')" title="第${i}页">${i}</a>
            </li>
        </c:forEach>

        <c:if test="${begin > displaySize + 1}">
            <li><a>...</a></li>
        </c:if>

        <c:forEach begin="${begin}" end="${end}" var="i">
            <li <c:if test="${current == i}"> class="active"</c:if>>
                <a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${i}&pageSize=${pageSize}')" title="第${i}页">${i}</a>
            </li>
        </c:forEach>


        <c:if test="${end < page.pageCount - displaySize}">
            <li><a>...</a></li>
        </c:if>

        <c:forEach begin="${end < page.pageCount ? page.pageCount - 1 : page.pageCount + 1}" end="${page.pageCount}" var="i">
            <li <c:if test="${current == i}"> class="active"</c:if>>
                <a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${i}&pageSize=${pageSize}')" title="第${i}页">${i}</a>
            </li>
        </c:forEach>

        <c:choose>
            <c:when test="${page.lastPage}">
                <li class="disabled"><a title="下一页">&gt;&gt;</a></li>
                <li class="disabled"><a title="尾页">尾页</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${current + 1}&pageSize=${pageSize}')" title="下一页">&gt;&gt;</a></li>
                <li><a href="javascript:void(0);" onclick="javascript:location.replace('${url}pageNo=${page.pageCount}&pageSize=${pageSize}')"  title="尾页">尾页</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
    <div style="display: inline;">
        <span class="page-input">
           	 <label style="display: inline;margin: 10px;">第</label><input id="jump_pages" style="text-align: center;" type="text" class="input-mini" value="${current}" onblur="href(this.value,'${pageSize}');" /><label style="display: inline;margin: 10px;">页</label>
        </span>
        &nbsp;
        <select class="input-small" onchange="href('1',this.value);" style="width: 50px;">
            <option value="10" <c:if test="${pageSize eq 10}">selected="selected" </c:if>>10</option>
			<option value="20" <c:if test="${pageSize eq 20}">selected="selected" </c:if>>20</option>
            <option value="30" <c:if test="${pageSize eq 30}">selected="selected" </c:if>>30</option>
            <option value="50" <c:if test="${pageSize eq 50}">selected="selected" </c:if>>50</option>
        </select>
        <span class="page-info" style="margin: 10px;">[共${page.pageCount}页/${page.totalCount}条]</span >
    </div>
</div>

<script>
	function href(pageNo, pageSize){
		location.replace("${url}pageNo="+pageNo+"&pageSize="+pageSize);
	}
	
	
	$("#jump_pages").keyup(function(event) {
	    if(event.keyCode == 13) {
	    	var pageNo = $("#jump_pages").val();
	    	location.replace("${url}pageNo="+pageNo+"&pageSize=${pageSize}");
	    }
	});
</script>