<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%--	// 考虑到以后的结合开发，本处使用request属性范围传递
	request.setAttribute("columnData",columnData) ;	// 属性名称
	request.setAttribute("handleUrl",dept_list_url) ;
	request.setAttribute("keyWord",keyWord) ;
	request.setAttribute("column",column) ;
	request.setAttribute("currentPage",currentPage) ;
	request.setAttribute("lineSize",lineSize) ;
	request.setAttribute("allRecorders",allRecorders) ;
--%>

<%
	request.setCharacterEncoding("UTF-8") ;
%>
<%
	String handleUrl = null ; 
	String column = (String) request.getAttribute("column") ;
	String keyWord = (String) request.getAttribute("keyWord") ;
	long allRecorders = 0 ;
	long currentPage = 1 ;
	long allPages = 1 ;
	int lineSize = 5 ;
	try {
		handleUrl = application.getAttribute("basePath2").toString() +  request.getAttribute("handleUrl") ;
	} catch (Exception e) {}
	try {
		currentPage = (Long) request.getAttribute("currentPage") ;
	} catch (Exception e) {}
	try {
		allRecorders = (Long) request.getAttribute("allRecorders") ;
	} catch (Exception e) {}
	try {
		lineSize = (Integer) request.getAttribute("lineSize") ;
	} catch (Exception e) {}
%>
<%
	if (allRecorders > 0) {	// 有记录
		allPages = (allRecorders + lineSize - 1) / lineSize ;
	}
	int seed = 3 ;	// 设置一个种子数
%>
<%
	if (keyWord == null) {
		keyWord = "" ;
	}
%>
<div id="splitControlDiv" style="float:right">
	<ul class="pagination"> 
		<li class="<%=currentPage == 1 ? "active" : ""%>"><a href="<%=handleUrl%>?cp=1&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>">1</a></li>
<%
	if (allPages >= seed * 2 ) {	// 表示后面的页数已经超过了5页
		if (currentPage < seed * 2 - 1) {
			for (int x = 2 ; x < seed * 2 ; x ++) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=handleUrl%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
			}
		} else {
			if (currentPage > seed * 2 - 1) {
%>
				<li class="disabled"><span>...</span></li>
<%
			}
			long startPage = currentPage - seed ;
			long endPage = currentPage + seed ;
			if (endPage >= allPages) {	// 计算后的结果大于了总页数
				endPage = allPages - 1 ;
			}
			for (long x = startPage ; x <= endPage ; x ++) {
%>
				<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=handleUrl%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
			}
		}
		if ((currentPage + seed + 1) < allPages) {
%>
			<li class="disabled"><span>...</span></li>
<%
		}
	} else {	// 页数不多，可以一次性全部显示
		for (int x = 2 ; x < allPages ; x ++) {
%>
		<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=handleUrl%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=x%></a></li>
<%
		}
	}
%>
<%
	if (allPages > 1) {
%>
		<li class="<%=currentPage == allPages ? "active" : ""%>"><a href="<%=handleUrl%>?cp=<%=allPages%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>"><%=allPages%></a></li>
<%
	}
%>
	</ul><br>
	<!--总记录数：<%=allRecorders%>、总页数：<%=allPages%>-->
</div>