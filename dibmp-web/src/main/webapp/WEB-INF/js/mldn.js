function round(num,scale) {
    return Math.round(num * Math.pow(10,scale)) /Math.pow(10,scale) ;
}


function bindAddcar() {
	$("button[id*=addCar-]").each(function(){
		var gid = $(this).attr("id").split("-")[1] ;
		$(this).on("click",function(){
			// console.log("*** gid = " + gid) ;
			$.post("pages/front/center/shopcar/ShopcarActionFront!add.action",{"gid":gid},
					function(data){
				operateAlert(data.trim() == "true","购物车添加成功！","购物车添加失败！") ;
			},"text") ;
		}) ;
	}) ; 
}
// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.format = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, //月份 
		"d+" : this.getDate(), //日 
		"h+" : this.getHours(), //小时 
		"m+" : this.getMinutes(), //分 
		"s+" : this.getSeconds(), //秒 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
		"S" : this.getMilliseconds()
	//毫秒 
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
} 

/**
 * 复选框批量选择
 * @param ele 要批量选择的复选框对象
 * @param ckd 触发此组件的当前选中状态
 */
function checkboxSelectAll(ele, ckd) {
	if (ckd == true) {
		$("input[id='" + ele + "']").prop("checked",true) ;
	} else {
		$("input[id='" + ele + "']").prop("checked",false) ;
	} 
}
/**
 * 批量操作数据执行操作
 * @param title 要进行的提示信息
 * @param elename 要操作的元素信息
 * @param url 要执行的url操作
 */
function operateChecked(title,elename,url) {
	var ids = "" ;
	$("input[id='"+elename+"']:checked").each(function() {
		ids += $(this).val() + "|" ;
	}) ;
	if (ids == "") {
		$("#alertDiv").attr("class","alert alert-danger") ;
        $("#alertText").text("您还未选择任何数据，请确认您的操作！") ;
		$("#alertDiv").fadeIn(1000,function(){
            $("#alertDiv").fadeOut(3000) ;
        }) ;
	} else {
		if (window.confirm("您确定要继续执行此操作吗？")) {
			url += "&ids=" + ids ;
			window.location = url ;
		}
	}
}
/**
 * 警告框操作信息，ID必须为“alertDiv”
 * @param flag 操作成功或失败的标记
 * @param suctext 操作成功时的显示文本内容
 * @param faltext 操作失败时的显示文本内容
 */
function operateAlert(flag,suctext,faltext) {
	if (flag) {
		$("#alertDiv").attr("class","alert alert-success") ;
		$("#alertText").text(suctext) ;
	} else {
		$("#alertDiv").attr("class","alert alert-danger") ;
		$("#alertText").text(faltext) ;
	}
	$("#alertDiv").fadeIn(1000,function(){
        $("#alertDiv").fadeOut(3000) ;
    }) ;
}
