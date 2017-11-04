package cn.mldn.dibmp.web.action.back;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.mldn.util.action.abs.AbstractAction;
import cn.mldn.util.web.SplitPageUtil;

@Controller
@RequestMapping("/pages/back/admin/manage/*")
public class ManageActionBack extends AbstractAction {
	private static final String TITLE = "仓库管理" ;
	@RequestMapping("storage_input_pre")
	public ModelAndView storageInputPre() {
		ModelAndView mav = new ModelAndView(super.getPage("manage.storage.input.page"));
		return mav;
	}
	@RequestMapping("storage_input")
	public ModelAndView storageInput() {
		ModelAndView mav = new ModelAndView(super.getPage("manage.storage.page"));
		return mav;
	}
	@RequestMapping("distribution_input_pre")
	public ModelAndView distributionInputPre() {
		ModelAndView mav = new ModelAndView(super.getPage("manage.distribution.input.page"));
		return mav;
	}
	@RequestMapping("distribution_input")
	public ModelAndView distributionInput() {
		ModelAndView mav = new ModelAndView(super.getPage("manage.distribution.page"));
		return mav;
	}
}
