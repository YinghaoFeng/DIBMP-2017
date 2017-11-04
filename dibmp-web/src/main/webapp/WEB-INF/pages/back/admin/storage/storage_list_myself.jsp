<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/storage/storage_list_myself.js"></script>
<script type="text/javascript" src="js/split_page.js"></script>
<%!
	public static final String STORAGE_SUBMIT_URL = "pages/back/admin/storage/submit.action" ;
	public static final String STORAGE_EDIT_URL = "pages/back/admin/storage/edit_pre.action" ;
	public static final String STORAGE_LIST_DETAILS_URL = "pages/back/admin/storage/list_details.action" ;
	public static final String STORAGE_DELETE_URL = "pages/back/admin/storage/remove.action" ;
%>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="3"/>
			<jsp:param name="msi" value="32"/>
		</jsp:include>
		<div class="content-wrapper text-left">
		<div class="panel panel-info">
			<div class="panel-heading">
				<strong><span class="glyphicon glyphicon-list"></span>&nbsp;编辑入库清单</strong>
			</div>
			<div class="panel-body">
				<div>
					<jsp:include page="/WEB-INF/pages/plugins/split_plugin_search_bar.jsp"/>
				</div>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th class="text-center" style="width:10%;">入库单编号 </th> 
							<th class="text-left" style="width:20%;">申请标题</th> 
							<th class="text-left" style="width:20%;">入库仓库</th>
							<th class="text-center" style="width:10%;">商品类型</th>
							<th class="text-center" style="width:10%;">申请状态</th>
							<th class="text-center" style="width:10%;">商品数量</th>
							<th class="text-left" style="width:20%;">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="text-center" style="width:10%;">20001010</th> 
							<td class="text-left">
								<a href="<%=STORAGE_EDIT_URL%>?sid=1">2017双十一衣帽入库</a></td>
							<td class="text-left">北京通州仓库一号库</td>
							<td class="text-center">服装衣帽</td>
							<td class="text-center">未提交</td>
							<td class="text-center">100</td>
							<td class="text-left">
								<a href="<%=STORAGE_SUBMIT_URL%>?sid=1" class="btn btn-primary btn-xs">
									<span class="fa fa-rocket"></span>&nbsp;提交申请</a>
								<a href="<%=STORAGE_LIST_DETAILS_URL%>?sid=1" class="btn btn-warning btn-xs">
									<span class="fa fa-th-list"></span>&nbsp;入库清单</a>
								<a href="<%=STORAGE_DELETE_URL%>?sid=1" class="btn btn-danger btn-xs">
									<span class="glyphicon glyphicon-trash"></span>&nbsp;删除申请</a>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="splitBarDiv" style="float:right">
					<jsp:include page="/WEB-INF/pages/plugins/split_plugin_page_bar.jsp"/> 
				</div>
			</div>
			<div class="panel-footer" style="height:100px;">
				<jsp:include page="/WEB-INF/pages/plugins/include_alert.jsp"/>
			</div>
		</div>
		</div>
		<!-- 导入公司尾部认证信息 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_foot.jsp" />
		<!-- 导入右边工具设置栏 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_sidebar.jsp" />
		<div class="control-sidebar-bg"></div>
	</div>
	<jsp:include page="/WEB-INF/pages/plugins/back/info/member_info_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/info/member_dept_list_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
