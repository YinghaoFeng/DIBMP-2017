package cn.mldn.dibmp.web.action.back;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.mldn.util.action.abs.AbstractAction;
import cn.mldn.util.web.SplitPageUtil;

@Controller
@RequestMapping("/pages/back/admin/distribution/*")
public class DistributionActionBack extends AbstractAction {
	private static final String TITLE = "商品出库" ;
	@RequestMapping("goods_list") 
	public ModelAndView listGoods() {
		ModelAndView mav = new ModelAndView(super.getPage("distribution.goods.list.page"));
		return mav;
	}
	@RequestMapping("add_pre") 
	public ModelAndView addPre() {
		ModelAndView mav = new ModelAndView(super.getPage("distribution.add.page"));
		return mav;
	}
	@RequestMapping("list_myself") 
	public ModelAndView listMyself() {
		SplitPageUtil spu = new SplitPageUtil("出库单编号:did|申请标题:title", "customer.list.myself.action") ;
		ModelAndView mav = new ModelAndView(super.getPage("distribution.list.myself.page"));
		return mav;
	}
	@RequestMapping("list_details") 
	public ModelAndView listDetails() {
		SplitPageUtil spu = new SplitPageUtil("出库单编号:did|申请标题:title", "customer.list.myself.action") ;
		ModelAndView mav = new ModelAndView(super.getPage("distribution.list.details.page"));
		return mav;
	}
}
