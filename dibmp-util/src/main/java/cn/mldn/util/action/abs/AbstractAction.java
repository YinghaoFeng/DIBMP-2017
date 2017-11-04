package cn.mldn.util.action.abs;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

public abstract class AbstractAction {
	@Resource
	protected MessageSource messageSource ;
	/**
	 * 拆分后转为Set集合
	 * @param str
	 * @return
	 */
	public Set<Long> stringToLong(String str) {
		String num [] = str.split(",") ;
		return this.stringToLong(num) ; 
	}
	/**
	 * 设置提示信息
	 * @param mav
	 * @param urlKey
	 * @param msgKey
	 * @param msgs
	 */
	public void setMsgAndUrl(ModelAndView mav,String urlKey,String msgKey,String ... msgs) {
		mav.addObject("url", this.getPage(urlKey)) ;
		mav.addObject("msg",this.getMessage(msgKey,msgs)) ;
	} 
	/**
	 * 负责创建上传文件的名称
	 * @param file
	 * @return
	 */
	public String getNewFileName(MultipartFile file) {
		String fileExt = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		String fileName = UUID.randomUUID() + fileExt;
		return fileName ;
	}
	/**
	 * 可以将数组变为Set集合
	 * @param num
	 * @return
	 */
	public Set<Long> longToSet(long num[]) {
		Set<Long> all = new HashSet<Long>() ;
		for (int x = 0 ; x < num.length ; x ++) {
			all.add(num[x]) ;
		}
		return all ;
	}
	public Set<Long> stringToLong(String num[]) {
		Set<Long> all = new HashSet<Long>() ;
		for (int x = 0 ; x < num.length ; x ++) {
			try {
				all.add(Long.parseLong(num[x])) ;
			} catch (Exception e) {}
		}
		return all ;
	}
	/**
	 * 可以获得Request对象
	 * @return 方便获得
	 */
	public HttpServletRequest getRequest() {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest() ;
	} 
	/**
	 * 该方法的主要功能是根据指定的key获得资源文件中对应的内容
	 * @param key 要执行的跳转路径key
	 * @return 返回路径
	 */
	public String getPage(String key) {
		try {
			return this.messageSource.getMessage(key, null, null) ;
		} catch (Exception e) {
			this.getRequest().setAttribute("errors", "NoPath"); 
			return this.messageSource.getMessage("error.page", null,null) ;
		}
	}
	/**
	 * 获得提示文字信息
	 * @param key 要执行的跳转路径key
	 * @return 返回路径
	 */
	public String getMessage(String key,String ... args) {
		try {
			return this.messageSource.getMessage(key, args, null) ;
		} catch (Exception e) {
			return null ;
		}
	}
}
