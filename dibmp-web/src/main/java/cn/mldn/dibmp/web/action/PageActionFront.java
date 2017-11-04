package cn.mldn.dibmp.web.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.mldn.util.action.abs.AbstractAction;


@Controller
public class PageActionFront extends AbstractAction {
	@ResponseBody
	@RequestMapping("/check_rand")
	public Object check(String code) {
		String rand = (String) super.getRequest().getSession().getAttribute("rand") ;
		if (rand == null || "".equals(rand)) {
			return false ;
		} else {
			return rand.equalsIgnoreCase(code);
		}
	}
	@RequestMapping("/loginForm")
	public String loginForm() {
		return super.getPage("login.page") ;
	}
	@RequestMapping("/pages/back/index")
	public String index() {
		return super.getPage("index.page") ;
	}
	@RequestMapping("/logout")
	public String logout() {
		return "login" ;
	} 
	@RequestMapping("/unauth")
	public String unauth() {
		super.getRequest().setAttribute("error", super.getMessage("unauth.msg"));
		return super.getPage("error.page") ;
	}
}
