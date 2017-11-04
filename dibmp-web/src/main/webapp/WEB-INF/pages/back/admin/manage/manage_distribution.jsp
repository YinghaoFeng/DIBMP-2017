<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/manage/manage_distribution.js"></script>
<script type="text/javascript" src="js/split_page.js"></script>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="6"/>
			<jsp:param name="msi" value="62"/>
		</jsp:include>
		<div class="content-wrapper text-left">
		<div class="panel panel-info">
			<div class="panel-heading">
				<strong><span class="glyphicon glyphicon-list"></span>&nbsp;我的出库申请单</strong>
			</div>
			<div class="panel-body">
				<div>
					<table class="table table-striped table-bordered table-hover">
						<tr> 
							<td style="width:150px;"><strong>出库标题：</strong></td>
							<td>双13备货</td>
						</tr>
						<tr>
							<td><strong>出库城市：</strong></td>
							<td>北京市 北京市</td>
						</tr>
						<tr>
							<td><strong>商品数量：</strong></td>
							<td>223</td>
						</tr>
						<tr>
							<td><strong>商品总价：</strong></td>
							<td>￥223.23</td>
						</tr>
						<tr>
							<td><strong>备注信息：</strong></td>
							<td>我要上</td>
						</tr>
					</table>
				</div>
				<div>
					<table class="table table-condensed" id="detailsTab">
						<thead>
							<tr>
								<th class="text-left" style="width:10%;">商品编号</th> 
								<th class="text-left" style="width:20%;">商品名称</th> 
								<th class="text-left" style="width:25%;">出库仓库</th> 
								<th class="text-center" style="width:10%;">出库数量</th>
								<th class="text-center" style="width:10%;">商品单价（元）</th>
								<th class="text-center" style="width:10%;">总价</th>
								<th class="text-center" style="width:15%;">操作</th>
							</tr>
						</thead>
						<tbody>
							<tr id="dettr-1" class="text-success">
								<td class="text-left">100001</td>
								<td class="text-left">衣服</td>
								<td class="text-left">北京 北京 通州一号仓库</td>
								<td class="text-center">50</td>
								<td class="text-center">39.2</td>
								<td class="text-center">200</td>
								<td>
									<button id="access-1" class="btn btn-primary btn-xs">
										<span class="glyphicon glyphicon-edit"></span>&nbsp;允许出库</button>
									<button id="denied-1" class="btn btn-danger btn-xs">
										<span class="glyphicon glyphicon-edit"></span>&nbsp;拒绝出库</button>
								</td>
							</tr>
						</tbody>
					</table>
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
