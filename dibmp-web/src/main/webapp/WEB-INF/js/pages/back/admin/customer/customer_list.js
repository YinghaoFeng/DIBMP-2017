cid = 0 ;
$(function(){
	$("span[id^=mid-]").each(function(){
		$(this).on("click",function(){
			mid = this.id.split("-")[1] ;
			$("#memberInfo").modal("toggle") ;
		}) ;
	}) ;
	$("span[id^=cid-]").each(function(){
		$(this).on("click",function(){
			cid = this.id.split("-")[1] ;
			loadData() ;
			$("#customerRecordInfo").modal("toggle") ;
		}) ;
	}) ;
	$("button[id^=out-]").each(function(){
		$(this).on("click",function(){
			cid = this.id.split("-")[1] ;
			operateAlert(true,"出库客户追加成功！","出库客户追加失败！") ;
		}) ;
	}) ;
	$("button[id^=input-]").each(function(){
		$(this).on("click",function(){
			cid = this.id.split("-")[1] ;
			$("#customerRecordInputInfo").modal("toggle") ;
		}) ;
	}) ;
	$("#myform").validate({
		debug : true, // 取消表单的提交操作
		submitHandler : function(form) {
			// 发送ajax请求进行异步数据处理操作
			$("#customerRecordInputInfo").modal("toggle") ;
			operateAlert(true,"客户联系记录追加成功！","客户联系记录追加失败！") ;
		},
		errorPlacement : function(error, element) {
			$("#" + $(element).attr("id").replace(".", "\\.") + "Msg").append(error);
		},
		highlight : function(element, errorClass) {
			$(element).fadeOut(1,function() {
				$(element).fadeIn(1, function() {
					$("#" + $(element).attr("id").replace(".","\\.") + "Div").attr("class","form-group has-error");
				});

			})
		},
		unhighlight : function(element, errorClass) {
			$(element).fadeOut(1,function() {
				$(element).fadeIn(1,function() {
						$("#" + $(element).attr("id").replace(".","\\.") + "Div").attr("class","form-group has-success");
				});
			})
		},
		errorClass : "text-danger",
		rules : {
			"title" : {
				required : true
			} ,
			"bid" : {
				required : true
			} ,
			"note" : { 
				required : true 
			}
		}
	});
}) ;
function loadData() {	// 该函数名称一定要固定，不许修改
	// 如果要想进行分页的处理列表前首先查询出部门编号
	console.log("客户编号：" + cid) ;
	// $("#memberBasicInfo tr:gt(0)").remove() ; // 加载之前要进行原有数据删除
	createSplitBar(10) ;	// 创建分页控制项
}