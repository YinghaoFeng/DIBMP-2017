wid = 0 ;
$(function(){
	$("span[id^=mid-]").each(function(){
		$(this).on("click",function(){
			mid = this.id.split("-")[1] ;
			console.log("仓库管理员编号：" + mid) ;
			$("#memberInfo").modal("toggle") ;
		}) ;
	}) ;
	$("button[id^=editadmin-]").each(function(){
		$(this).on("click",function(){
			wid = this.id.split("-")[1] ;
			console.log("修改仓库管理员，仓库编号：" + wid) ;
			loadData() ; // 异步数据加载与分页控制
			$("#memberDeptInfo").modal("toggle") ;
		}) ;
	}) ;
	$("button[id^=addadmin-]").each(function(){
		$(this).on("click",function(){
			mid = this.id.split("-")[1] ;
			console.log("新的仓库管理员编号：" + mid) ;
			name = $("#memberName").text() ; 
			ele = $("<span id='mid-admin' style='cursor:pointer;'>"+name+"</span>") ;
			ele.on("click",function(){
				console.log("仓库管理员ID：" + mid) ;
				$("#memberInfo").modal("toggle") ;
			}) ;
			$("#admin-" + wid).html(ele) ;
			$("#memberDeptInfo").modal("toggle") ;
			operateAlert(true,"仓库管理员修改成功！","仓库管理员修改失败！") ;
		}) ;
	})
}) ;
function loadData() {	// 该函数名称一定要固定，不许修改
	// 如果要想进行分页的处理列表前首先查询出部门编号
	did = $("#did").val() ;	// 取得指定组件的value
	tid = $("#tid").val() ;
	console.log("部门编号：" + did) ;
	// $("#memberBasicInfo tr:gt(0)").remove() ; // 加载之前要进行原有数据删除
	createSplitBar(10) ;	// 创建分页控制项
}