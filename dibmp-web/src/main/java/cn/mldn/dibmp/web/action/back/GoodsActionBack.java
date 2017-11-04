package cn.mldn.dibmp.web.action.back;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.mldn.util.action.abs.AbstractAction;
import cn.mldn.util.web.SplitPageUtil;

@Controller
@RequestMapping("/pages/back/admin/goods/*")
public class GoodsActionBack extends AbstractAction {
	private static final String TITLE = "商品" ;
	@RequestMapping("add_pre")
	public ModelAndView addPre() {
		ModelAndView mav = new ModelAndView(super.getPage("goods.add.page"));
		return mav;
	}
	@RequestMapping("add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView(super.getPage("forward.page"));
		super.setMsgAndUrl(mav, "goods.add.action", "vo.add.success", TITLE);
		return mav;
	} 
	@RequestMapping("show")
	public ModelAndView show() { 
		ModelAndView mav = new ModelAndView(super.getPage("goods.show.page"));
		return mav;
	}
	@RequestMapping("edit_pre")
	public ModelAndView editPre() { 
		ModelAndView mav = new ModelAndView(super.getPage("goods.edit.page"));
		return mav;
	} 
	@RequestMapping("edit")
	public ModelAndView edit() {
		ModelAndView mav = new ModelAndView(super.getPage("forward.page"));
		super.setMsgAndUrl(mav, "goods.list.action", "vo.edit.success", TITLE);
		return mav;
	}
	@RequestMapping("list") 
	public ModelAndView list() {
		SplitPageUtil spu = new SplitPageUtil("商品编号:gid|商品名称:name", "goods.list.action") ;
		ModelAndView mav = new ModelAndView(super.getPage("goods.list.page"));
		return mav;
	}
}
