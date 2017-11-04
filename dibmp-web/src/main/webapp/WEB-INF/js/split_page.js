var jsCommonCp = 1 ; 						// 当前所在页，默认为第1页
var jsCommonLs = 5 ;						// 每页显示数据量
var jsCommonPageSize ;						// 总页数
function calcPageSize(allRecorders) {		// 计算总页数
    if (allRecorders == 0) {				// 没有数据量返回
        jsCommonPageSize = 1 ;				// 总页数为1
    } else {
        // 为避免产生小数点，所以使用parseInt()函数将数据变为整型
        jsCommonPageSize = parseInt((allRecorders + jsCommonLs - 1) / jsCommonLs) ;
    }
}
function createSplitBar(allRecorders) {		// 创建分页控制项
    calcPageSize(allRecorders) ;			// 计算总页数
    clearBar() ;							// 清空已有分页项
    if (jsCommonPageSize > 1) {
        previousPage() ;					// 设置上一页
        addBar(1) ;								// 设置首页页码
    }
    var seed = 3 ;							// 设置一个分页种子数
    if (jsCommonCp > seed * 2) {			// 当前页码很大
        addDetailPage() ;					// 设置省略页
        var startPage = jsCommonCp - seed ;	// 计算开始页
        for (var x = startPage ; x <= jsCommonCp + seed ; x ++) {
            if (x < jsCommonPageSize) {		// 页码是否超过总页数
                addBar(x) ;					// 增加页码
            }
        }
        if (jsCommonCp + seed * 2 < jsCommonPageSize) {
            addDetailPage() ;				// 增加省略页码
        }
    } else {								// 刚刚加载
        for (var x = 2 ; x <= jsCommonCp + seed ; x ++) {
            if (x < jsCommonPageSize) {		// 小于总页数
                addBar(x) ;					// 增加页码
            }
        }
        if (jsCommonCp + seed <= jsCommonPageSize) {
            addDetailPage() ;				// 省略页码
        }
    }
    addBar(jsCommonPageSize) ;				// 设置最后一页
    if (jsCommonPageSize > 1) {
        nextPage() ;						// 设置下一页
    }
}
function addBar(index) {					// 增加分页控制页码
    var liObj = $("<li></li>") ;			// 创建li元素
    var aObj = $("<a style='cursor : pointer;'>" + index + "</a>") ;	// 创建a元素
    if (jsCommonCp == index) {				// 判断是否为当前所在页
        liObj.addClass("active") ;			// 设置显示样式
    } else {								// 不是当前页
        aObj.on("click",function(){
            jsCommonCp = index ;			// 设置jsCommonCp内容
            loadData() ;					// 重新加载数据
        }) ;
    }
    liObj.append(aObj) ;					// 追加元素
    $("#pagecontrol").append(liObj) ;		// 创建分页控制
}
function clearBar() {						// 清除已有分页条数据
    $("#pagecontrol li").remove() ;
}
function addDetailPage() {					// 定义省略信息
    var liObj = $("<li><span>...</span></li>") ;
    $("#pagecontrol").append(liObj) ;		// 创建分页控制
}
function nextPage() {						// 加载下一页数据
    var liObj = $("<li></li>") ;			// 创建li元素
    var aObj = $("<a style='cursor : pointer;'>下一页</a>") ;			// 创建a元素
    if (jsCommonCp == jsCommonPageSize) {					// 判断是否为当前所在页
        liObj.addClass("disabled") ;		// 设置显示样式
    } else {								// 不是当前页
        aObj.on("click",function(){
            if (jsCommonCp < jsCommonPageSize) {			// 还有后续页
                jsCommonCp ++ ;						// 修改当前所在页
                loadData() ;				// 重新加载数据
            }
        }) ;
    }
    liObj.append(aObj) ;					// 追加元素
    $("#pagecontrol").append(liObj) ;		// 创建分页控制
}
function previousPage() {					// 加载上一页数据
    var liObj = $("<li></li>") ;			// 创建li元素
    var aObj = $("<a style='cursor : pointer;'>上一页</a>") ;			// 创建a元素
    if (jsCommonCp == 1) {							// 判断是否为当前所在页
        liObj.addClass("disabled") ;		// 设置显示样式
    } else {								// 不是当前页
        aObj.on("click",function(){
            if (jsCommonCp > 1) {					// 还有前页
                jsCommonCp -- ;						// 修改当前所在页
                loadData() ;				// 重新加载数据
            }
        }) ;
    }
    liObj.append(aObj) ;					// 追加元素
    $("#pagecontrol").append(liObj) ;		// 创建分页控制
}

// 设置全选的操作
// eleA是全选的触发组件选择器
// eleB是要被全选操作的组件选择器
function setSelectAll(eleA,eleB) {
    eleA.on("click",function(){
        eleB.each(function() {
            this.checked = eleA.prop("checked") ;  // this.checked
        }) ;
    }) ;
}
// 设置删除操作
// btn：要执行删除操作的元素
// ele：要选择数据的来源
// url：删除的提交路径
function setDelete(btn,ele,url) {
    btn.on("click",function() {
        var data = "" ;
        ele.each(function() {
            if (this.checked) {
                data += this.value + "|" ;
            }
        }) ;
        if (data == "") {
            alert("您还未选择任何的删除数据！") ;
        } else {
            $.post(url,{"ids": data},function(obj){
                if (obj.trim() == "true") {
                    $("#alertDiv").attr("class","alert alert-success") ;
                    $("#alertText").text("新闻数据删除成功！") ;
                    loadData() ;    // 重新加载数据
                } else {
                    $("#alertDiv").attr("class","alert alert-danger") ;
                    $("#alertText").text("新闻数据删除失败！") ;
                }
                $("#alertDiv").fadeIn(3000,function(){
                    $("#alertDiv").fadeOut(2000) ;
                }) ;
            },"text") ;
        }
    }) ;
}