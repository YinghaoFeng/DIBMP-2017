<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<%!
	public static final String INDEX_URL = "pages/back/index.action" ;	
	public static final String WAREHOUSE_ADD_URL = "pages/back/admin/warehouse/add_pre.action" ;	
	public static final String WAREHOUSE_LIST_URL = "pages/back/admin/warehouse/list.action" ;	

	public static final String CUSTOMER_ADD_URL = "pages/back/admin/customer/add_pre.action" ;	
	public static final String CUSTOMER_LIST_URL = "pages/back/admin/customer/list.action" ;
	
	public static final String STORAGE_ADD_URL = "pages/back/admin/storage/add_pre.action" ;
	public static final String STORAGE_LIST_URL = "pages/back/admin/storage/list_myself.action" ;
	
	public static final String STORAGE_AUDIT_LIST_URL = "pages/back/admin/storageaudit/list_prepare.action" ;
	public static final String STORAGE_AUDIT_HISTORY_URL = "pages/back/admin/storageaudit/list_history.action" ;

	public static final String GOODS_ADD_URL = "pages/back/admin/goods/add_pre.action" ;	
	public static final String GOODS_LIST_URL = "pages/back/admin/goods/list.action" ;
	
	public static final String DISTRIBUTION_GOODS_LIST_URL = "pages/back/admin/distribution/goods_list.action" ;
	public static final String DISTRIBUTION_LIST_URL = "pages/back/admin/distribution/list_myself.action" ;
	public static final String DISTRIBUTION_CLEAR_URL = "pages/back/admin/distribution/clear.action" ;
	
	
	public static final String MANAGE_STORAGE_INPUT_URL = "pages/back/admin/manage/storage_input_pre.action" ;
	public static final String MANAGE_DISTRIBUTION_INPUT_URL = "pages/back/admin/manage/distribution_input_pre.action" ;
	
%>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="upload/member/nophoto.png" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${name}</p>
			</div> 
		</div>
		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header"><i class="fa fa-university"></i> 分销业务平台</li>
				<shiro:hasRole name="warehouse">
					<li class="treeview ${param.mi==1 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i
							class="fa fa-institution"></i> <span>仓库管理</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==11 ? 'active' : ''}"><a href="<%=WAREHOUSE_ADD_URL%>"><i class="fa fa-cube"></i>
								增设仓库</a></li>
							<li class="${param.msi==12 ? 'active' : ''}"><a href="<%=WAREHOUSE_LIST_URL%>"><i class="fa fa-object-group"></i>
								仓库列表</a></li>
					</ul></li>
				</shiro:hasRole>	
				<shiro:hasAnyRoles name="goods,salegoods">
					<li class="treeview ${param.mi==5 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-gift"></i>
						<span>商品信息</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<shiro:hasPermission name="goods:add">
							<li class="${param.msi==51 ? 'active' : ''}"><a href="<%=GOODS_ADD_URL%>"><i
								class="fa fa-gamepad"></i> 增加商品</a></li>
						</shiro:hasPermission>
							<li class="${param.msi==52 ? 'active' : ''}"><a href="<%=GOODS_LIST_URL%>"><i
								class="fa fa-list-alt"></i> 商品清单</a></li>
					</ul></li>
				</shiro:hasAnyRoles>
				<shiro:hasRole name="customer">
					<li class="treeview ${param.mi==2 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i
							class="fa fa-sitemap"></i> <span>客户管理</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==21 ? 'active' : ''}"><a href="<%=CUSTOMER_ADD_URL%>"><i class="fa fa-user-plus"></i>
								增加客户</a></li>
							<li class="${param.msi==22 ? 'active' : ''}"><a href="<%=CUSTOMER_LIST_URL%>"><i class="fa fa-users"></i>
								客户列表</a></li>
					</ul></li>
				</shiro:hasRole>
				<shiro:hasRole name="storage">
					<li class="treeview ${param.mi==3 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-dropbox"></i>
						<span>商品入库</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==31 ? 'active' : ''}"><a href="<%=STORAGE_ADD_URL%>"><i
								class="fa fa-train"></i> 入库申请单</a></li>
							<li class="${param.msi==32 ? 'active' : ''}"><a href="<%=STORAGE_LIST_URL%>"><i
								class="fa fa-history"></i> 我的入库申请</a></li>
					</ul></li>
				</shiro:hasRole>
				<shiro:hasRole name="storageaudit">
					<li class="treeview ${param.mi==4 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-bitbucket-square"></i>
						<span>入库审核</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==41 ? 'active' : ''}"><a href="<%=STORAGE_AUDIT_LIST_URL%>"><i
								class="fa fa-slideshare"></i> 待审核申请</a></li>
							<li class="${param.msi==42 ? 'active' : ''}"><a href="<%=STORAGE_AUDIT_HISTORY_URL%>"><i
								class="fa fa-tasks"></i> 历史入库审核</a></li>
					</ul></li>
				</shiro:hasRole>	
				<shiro:hasRole name="distribution">
					<li class="treeview ${param.mi==7 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-truck"></i>
						<span>商品出库</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==71 ? 'active' : ''}"><a href="<%=DISTRIBUTION_GOODS_LIST_URL%>"><i
								class="fa fa-edit"></i> 待出库商品</a></li>
							<li class="${param.msi==72 ? 'active' : ''}"><a href="<%=DISTRIBUTION_LIST_URL%>"><i
								class="fa fa-fax"></i> 我的出库申请</a></li>
							<li class="${param.msi==73 ? 'active' : ''}"><a href="<%=DISTRIBUTION_CLEAR_URL%>"><i
								class="glyphicon glyphicon-trash"></i> 取消出库申请</a></li>
					</ul></li>
				</shiro:hasRole>
				<shiro:hasRole name="manage">	
					<li class="treeview ${param.mi==6 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-trello"></i>
						<span>仓储管理</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
							<li class="${param.msi==61 ? 'active' : ''}"><a href="<%=MANAGE_STORAGE_INPUT_URL%>"><i
								class="fa fa-puzzle-piece"></i> 入库处理</a></li>
							<li class="${param.msi==62 ? 'active' : ''}"><a href="<%=MANAGE_DISTRIBUTION_INPUT_URL%>"><i
								class="fa fa-paste"></i> 出库处理</a></li>
					</ul></li>
				</shiro:hasRole>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>