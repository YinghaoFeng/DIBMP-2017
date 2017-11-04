loadFlag = false ;
$(function() {
	$("button[id^=storage-]").each(function(){
		$(this).on("click",function(){
			mid = this.id.split("-")[1] ;
			$("#goodsRecordInfo").modal("toggle") ; 
		}) ;
	}) ;
	$('#storageDetails').on('show.bs.collapse', function () {
		if (loadFlag == false) {
			// ajax异步加载库存信息
			operateAlert(true,"商品库存信息加载成功！","商品库存信息加载失败！") ;
			loadFlag = true ; // 数据已经加载完成
			$("span[id^=mid-]").each(function(){
				$(this).on("click",function(){
					mid = this.id.split("-")[1] ;
					$("#memberInfo").modal("toggle") ;
				}) ;
			}) ;
		}
	}) ;
})