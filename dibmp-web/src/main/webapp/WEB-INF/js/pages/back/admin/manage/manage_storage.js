$(function(){
	$("button[id^=access-]").each(function(){
		$(this).on("click",function(){
			sdid = this.id.split("-")[1] ;
			operateAlert(true,"商品成功入库存储！","商品入库失败！") ;
		}) ;
	}) ;
	$("button[id^=denied-]").each(function(){ 
		$(this).on("click",function(){
			sdid = this.id.split("-")[1] ;
			operateAlert(false,"商品成功入库存储！","商品入库失败！") ;
		}) ;
	}) ;
})