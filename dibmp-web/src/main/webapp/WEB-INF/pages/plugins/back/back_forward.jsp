<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp" />
		<div class="content-wrapper text-left">
			<div class="panel panel-primary">
					<div class="panel-heading">
						<strong><span class="glyphicon glyphicon-user"></span>&nbsp;信息提示</strong>
					</div>
					<div class="panel-body">
							<script type="text/javascript">
								window.onload = function() {
									goForward() ;
								}
								function goForward() {
									spanObject = document.getElementById("countSpan") ;
									count = parseInt(spanObject.innerHTML) ;	// 取得当前计数的内容
									count -- ;
									if (count <= 0) {	// 要进行跳转
										window.location = "${pageContext.request.contextPath}${url}" ;	// 跳转
									} else {
										spanObject.innerHTML = count ;
										setTimeout(goForward,1000) ; 
									}
								}
							</script>
							<div>${msg}</div> 
							<div><span id="countSpan">${count != null ? count : 5}</span>秒后跳转到其它页面，如果没有跳转请按<a href="${pageContext.request.contextPath}${url}">这里</a>！</div>
					</div>
					<div class="panel-footer">
						<div class="alert alert-success" id="alertDiv" style="display: none;">
	                        <button type="button" class="close" data-dismiss="alert">&times;</button>
	                        <span id="alertText"></span>
	                    </div>
					</div>
				</div>
		</div>
		<!-- 导入公司尾部认证信息 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_foot.jsp" />
		<!-- 导入右边工具设置栏 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_sidebar.jsp" />
		<div class="control-sidebar-bg"></div>
	</div>
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
