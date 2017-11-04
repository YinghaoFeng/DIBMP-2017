temp_did = 1 ;
$(function(){
	$(addbut).on("click",function(){
		// 通过ajax保存一行新的数据，而后把详情id取得，替换掉如下的id设置
		addDetails("temp" + temp_did ++) ; // 设置一个临时 id信息
	}) ;
	$("button[id^=save-]").each(function(){
		$(this).on("click",function(){
			did = this.id.split("-") [1] ;
			saveDetails(did) ;
		}) ;
	}) ;
	$("button[id^=remove-]").each(function(){
		$(this).on("click",function(){
			did = this.id.split("-") [1] ;
			deleteDetails(did) ;
		}) ;
	}) ;
})
function addDetails(tdid) {
	trInfo = 	$("<tr id='dettr-"+tdid+"' class='text-danger'>" +
				"	<td><input type='text' id='gid-"+tdid+"' value='0'/></td>" + 
				"	<td><input type='text' id='name-"+tdid+"' value='等待查询...' size='50'/></td>" +
				"	<td><input type='text' id='amount-"+tdid+"' value='0' maxlength='8' size='8'/></td>" +
				"	<td><input type='text' id='price-"+tdid+"' value='0.0' maxlength='8' size='8'/></td>" +
				"	<td><input type='text' id='weight-"+tdid+"' value='0' maxlength='8' size='8'/></td>" +
				"	<td>" +
				"		<button id='save-"+tdid+"' class='btn btn-primary btn-xs'>" +
				"			<span class='glyphicon glyphicon-edit'></span>&nbsp;保存</button>" +
				"		<button id='remove-"+tdid+"' class='btn btn-danger btn-xs'>" +
				"			<span class='glyphicon glyphicon-edit'></span>&nbsp;移除</button>" +
				"	</td>" +
				"</tr>") ;
	$(detailsTab).append(trInfo) ;
	$("#save-" + tdid).on("click",function(){
		saveDetails(tdid) ;
	}) ;
	$("#remove-" + tdid).on("click",function(){
		deleteDetails(tdid) ;
	}) ;
}
function saveDetails(did) {
	console.log("【增加】详情编号：" + did) ;
	// 需要进行数据验证，而后再进行ajax提交处理，当提交成功后应该获取最后一次增长ID信息，替换掉原始的临时id
	operateAlert(true,"入库商品信息添加成功！","入库商品信息添加失败！") ;
	$("#dettr-" + did).attr("class","text-success") ;
}
function deleteDetails(did) {
	console.log("【删除】详情编号：" + did) ;
	// ajax移除信息，而后删除表格；
	$("#dettr-" + did).remove() ;
	operateAlert(true,"入库商品信息删除成功！","入库商品信息删除失败！") ;
}