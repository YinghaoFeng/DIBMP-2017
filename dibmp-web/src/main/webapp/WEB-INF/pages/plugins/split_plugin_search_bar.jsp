<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8") ;
%>
<%--	// 考虑到以后的结合开发，本处使用request属性范围传递
	request.setAttribute("columnData",columnData) ;	// 属性名称
	request.setAttribute("handleUrl",dept_list_url) ;
	request.setAttribute("keyWord",keyWord) ;
	request.setAttribute("column",column) ;
--%>
<%	// columnData格式：标签名称:字段名称|标签名称:字段名称|
	String columnData = (String) request.getAttribute("columnData") ;
	String keyWord = (String) request.getAttribute("keyWord") ;
	String column = (String) request.getAttribute("column") ;
%>
<div id="searchPageDiv" class="text-center">
	<form action="${basePath2}${handleUrl}" method="post" class="form-group">
<%
	if (!(columnData == null || "".equals(columnData))) {
%>
	<div class="col-md-3">
		<select id="col" name="col" class="form-control">
	<%
		String columnResults [] = columnData.split("\\|") ;
		for (int x = 0 ; x < columnResults.length ; x ++) {
			String temp [] = columnResults[x].split(":") ;
	%>
			<option value="<%=temp[1]%>" <%=temp[1].equals(column) ? "selected" : ""%>><%=temp[0]%></option>
	<%
		}
	%>
		</select>
	</div>
<%
	}
%>
	<div class="col-md-5">
		<input type="text" id="kw" name="kw" value="<%=keyWord == null ? "" : keyWord%>" class="form-control input-sm">
	</div>
	<div class="col-md-2">
		<input type="hidden" name="${paramName}" id="${paramName}" value="${paramValue}">
		<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>&nbsp;检索</button>
	</div>
	</form>
</div>