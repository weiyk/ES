package com.rc.web.ajax;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeNode;
import com.rc.web.utils.TreeUtils;

public class GetMenuService implements IAjaxService{

	@Override
	public String execute(AjaxServiceParameter param) throws Exception {
		HttpSession session = param.getRequest().getSession();
		String yongHuBH = (String) session.getAttribute("YongHuBH");
		String prefix = param.getRequest().getContextPath();
		List<SimpleTreeNode> menuList = null;
		if(session.getAttribute(QamWebDataConstants.QAM_SESSION_USERMENU)!=null){
			menuList = (List<SimpleTreeNode>)session.getAttribute(QamWebDataConstants.QAM_SESSION_USERMENU);
			return "'" + TreeUtils.getDefaultNode(yongHuBH, menuList,prefix) + "'";
		}
		return null;
	}

}
