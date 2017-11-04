package cn.mldn.util.validate.rule;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.MessageSource;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerInterceptor;

import cn.mldn.util.validate.ActionValidationUtil; 

// 由于所有的抽象方法都使用了default关键字，那么此时不会再默认实现若干个抽象方法
public class ValidationInterceptor implements HandlerInterceptor {
//	private Logger logger = LoggerFactory.getLogger(ValidationInterceptor.class);
	@Resource
	private MessageSource messageSource ;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if (handler instanceof HandlerMethod) {	// 执行向下转型前应该首先判断其是否是指定类的实例
			HandlerMethod handlerMethod = (HandlerMethod) handler ;	// 强制转换
			// 本次的设计是没有考虑到重名类定义情况，因为实际的开发之中，如果要处理某一个信息有可能是有后台或前台；
			String validationRuleKey = handlerMethod.getBeanType().getSimpleName() + "." + handlerMethod.getMethod().getName() ;
			String validationRule = null ; // 保存要读取指定的资源key对应的验证规则
			try {	// 如果指定的key不存在，表示现在不需要进行验证
				validationRule = this.messageSource.getMessage(validationRuleKey, null, null) ;
			} catch (Exception e) {}
			if (validationRule != null) {	// 此时有验证处理操作，则需要进行验证处理
				// this.logger.info("【验证规则 - ｛"+request.getRequestURI()+"｝】" + validationRule);
				String errorPage = null ; 
				try {
					errorPage = this.messageSource.getMessage(validationRuleKey + ".error.page", null, null) ;
				} catch (Exception e) {	// 如果没有指定的路径则跳转到公共的errorPage
					errorPage = this.messageSource.getMessage("error.page", null, null) ;
				}
				ActionValidationUtil avu = new ActionValidationUtil(validationRule, request, this.messageSource) ;
				if (avu.getErrors().size() > 0) {	// 现在有错误信息
					request.setAttribute("errors", avu.getErrors());	// 跳转到指定路径
					request.getRequestDispatcher(errorPage).forward(request, response);
					return false ; 
				} else {	// 如果没有错误信息验证上传文件类型
					if (request instanceof DefaultMultipartHttpServletRequest) {	// 有文件上传
						String mimeRule = null; ;
						try {
							mimeRule = this.messageSource.getMessage(validationRuleKey + ".mime.rule", null,null) ;
						} catch (Exception e) {
							mimeRule = this.messageSource.getMessage("mime.rule", null,null) ;
						}
						ActionMIMEValidationUtil amvu = new ActionMIMEValidationUtil(mimeRule,request,this.messageSource) ;
						if (amvu.getErrors().size() > 0) {	// 现在有错误信息
							request.setAttribute("errors", amvu.getErrors()); 
							request.getRequestDispatcher(errorPage).forward(request, response);
							return false ; 
						}
					}
					return true ;	// 表示向后执行Action操作
				} 
			}
		}
		return true; // 返回true表示放行，而如果返回了false表示不执行后续的Action或拦截器
	}
}
 