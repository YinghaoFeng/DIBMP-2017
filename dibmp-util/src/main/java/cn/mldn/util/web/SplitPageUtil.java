package cn.mldn.util.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 进行分页的参数处理操作
 * @author mldn
 */
public class SplitPageUtil {
	private long currentPage = 1 ;	// 参数：cp
	private int lineSize = 5 ;		// 参数：ls
	private String column ;		// 参数：col
	private String keyWord ;	// 参数：kw
	private HttpServletRequest request ;
	/**
	 * 将你需要进行模糊查询的columnData（下拉框）传递到组件之中，目的是为了属性操作
	 * @param columnData 分页搜索的下拉列表数据
	 * @param handleUrlKey 设置分页路径的key
 	 */
	public SplitPageUtil(String columnData,String handleUrlKey) {
		this.request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest() ;
		this.request.setAttribute("columnData", columnData);
		this.request.setAttribute("handleUrl", handleUrlKey); 
		try {	// 这行代码出错只有不传递或传递非法参数的时候出现
			this.currentPage = Long.parseLong(this.request.getParameter("cp")) ;
		} catch (Exception e) {}
		try {	// 如果出错就使用默认值
			this.lineSize = Integer.parseInt(this.request.getParameter("ls")) ;
		} catch (Exception e) {}
		this.column = this.request.getParameter("col") ;
		this.keyWord = this.request.getParameter("kw") ;
		if (this.column == null) {
			this.column = "" ;
		}
		if (this.keyWord == null) {
			this.keyWord = "" ;
		}
		this.request.setAttribute("currentPage", this.currentPage);
		this.request.setAttribute("lineSize", this.lineSize);
		this.request.setAttribute("keyWord", this.keyWord);
		this.request.setAttribute("column", this.column);
	}
	public long getCurrentPage() {
		return currentPage;
	}
	public int getLineSize() {
		return lineSize;
	}
	public String getColumn() {
		return column;
	}
	public String getKeyWord() {
		return keyWord;
	}
}
