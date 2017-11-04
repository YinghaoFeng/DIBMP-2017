package cn.mldn.util.validate;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;

/**
 * 实现Action数据的验证处理类
 * @author mldn
 */
public class ActionValidationUtil {
	private Logger logger = LoggerFactory.getLogger(ActionValidationUtil.class);
	private Map<String,String> errors = new HashMap<String,String>() ;	// 保存错误信息
	private String rule ; // 保存验证规则
	private HttpServletRequest request ; // 请求对象
	private MessageSource messageSource ;
	/**
	 * 实例化Action数据验证工具类对象，在此类之中可以直接实现数据验证以及错误信息保存
	 * @param rule 要执行的数据验证规则
	 * @param request 通过该参数可以取得用户的请求参数
	 * @param messageSource 所有的消息资源的文字提示信息
	 */
	public ActionValidationUtil(String rule, HttpServletRequest request, MessageSource messageSource) {
		this.rule = rule ;
		this.request = request ;
		this.messageSource = messageSource ;
		this.handleValidator(); // 构造方法里面直接就处理好所有的验证操作
	}
	/**
	 * 实现验证的具体操作，根据指定的验证规则来获取验证数据以实现各个数据的检测处理
	 */
	private void handleValidator() {
		String rulesResult [] = this.rule.split("\\|") ;	// 首先对全部的验证规则拆分
		for (int x = 0 ; x < rulesResult.length ; x ++) {
			// 第一个元素为请求参数、第二个元素为验证的规则
			String temp [] = rulesResult[x].split(":")	;// 获取每一个规则
			try {
				String paramterValue = this.request.getParameter(temp[0]) ;// 根据参数获取数据
				switch(temp[1]) {	// 直接利用switch定义处理验证操作
					case "int" : {
						if (!this.validateInt(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.int.msg",null,null)) ;
						}
						break ; 
					}
					case "string" : {
						if (!this.validateString(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.string.msg",null,null)) ;
						}
						break ;
					}
					case "rand" : {
						if (!this.validateRand(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.rand.msg",null,null)) ;
						}
						break ;
					}
					case "double" : {
						if (!this.validateDouble(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.double.msg",null,null)) ;
						}
						break ;
					}
					case "long" : {
						if (!this.validateLong(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.long.msg",null,null)) ;
						}
						break ;
					}
					case "date" : {
						if (!this.validateDate(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.date.msg",null,null)) ;
						}
						break ;
					}
					case "datetime" : {
						if (!this.validateDatetime(paramterValue)) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.datetime.msg",null,null)) ;
						}
						break ;
					}
					case "string[]" : {
						if (!this.validateStringArray(this.request.getParameterValues(temp[0]))) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.string.msg",null,null)) ;
						}
						break ;
					}
					case "long[]" : {
						if (!this.validateLongArray(this.request.getParameterValues(temp[0]))) {	// 没有验证通过
							this.errors.put(temp[0], this.messageSource.getMessage("validation.long.msg",null,null)) ;
						}
						break ;
					} 
				}
			} catch (Exception e) {
				this.logger.error(e.toString()); 
			}
		}
	}
	/**
	 * 验证字符串的数据是否为空（null和""）
	 * @param str 要验证的字符串数据
	 * @return 如果不为空返回true，为空返回false
	 */
	private boolean validateString(String str) {
		if (str == null || "".equals(str)) {
			return false ;
		}
		return true ;
	}
	/**
	 * 验证字符串的数据是否为空（null和""）
	 * @param str 要验证的字符串数据
	 * @return 如果不为空返回true，为空返回false
	 */
	private boolean validateStringArray(String str[]) {
		if (str == null || str.length == 0) {
			return false ;
		} else {	// 验证里面的内容是否为空
			for (int x = 0 ; x < str.length ; x ++) {
				if (str[x] == null || "".equals(str[x])) {
					return false ;
				}
			}
		}
		return true ;
	}
	
	/**
	 * 验证指定的字符串是否由数字所组成
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateInt(String str) {
		if (this.validateString(str)) {	// 验证通过
			return str.matches("\\d+") ;
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是否由数字所组成
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateLong(String str) {
		if (this.validateString(str)) {	// 验证通过
			return str.matches("\\d+") ;
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是否由数字所组成
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateLongArray(String str[]) {
		if (this.validateStringArray(str)) {	// 验证通过
			for (int x = 0 ; x < str.length ; x ++) {
				if (this.validateString(str[x])) {
					if (!str[x].matches("\\d+")) {	// 没有验证通过
						return false ;
					}
				} else {	// 有内容为空
					return false ;
				}
			}
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是否由数字所组成
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateDouble(String str) {
		if (this.validateString(str)) {	// 验证通过
			return str.matches("\\d+(\\.\\d+)") ;
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是否为日期格式
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateDate(String str) {
		if (this.validateString(str)) {	// 验证通过
			return str.matches("\\d{4}-\\d{2}-\\d{2}") ;
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是否为日期时间格式
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateDatetime(String str) {
		if (this.validateString(str)) {	// 验证通过
			return str.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}") ;
		}
		return false ;
	}
	/**
	 * 验证指定的字符串是与指定的验证码相符合
	 * @param str 字符串
	 * @return 如果全部由数字所组成返回true
	 */
	private boolean validateRand(String str) {
		String rand = (String) this.request.getSession().getAttribute("rand") ;
		if (this.validateString(str) && this.validateString(rand)) {	// 验证通过
			return str.equalsIgnoreCase(rand) ;
		}
		return false ;
	}
	
	/**
	 * 获取全部的错误信息，如果没有错误则集合的长度为0
	 * @return 错误内容
	 */
	public Map<String, String> getErrors() {
		return errors;
	}
}
