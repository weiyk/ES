package com.rc.web.extension.menu;

import java.io.Serializable;
import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.logging.LogFactory;
import org.apache.commons.logging.Log;
import com.qam.framework.util.CommonUtils;
import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.controls.tree.BaseTreeBuilder;
import com.qam.web.facade.controls.tree.simpletree.ISimpleTreeBuildCallBack;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeBuilder;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeNode;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeParameter;
import com.qam.web.facade.manager.right.IRight;
import com.qam.web.facade.manager.right.RightManager;
import com.qam.web.facade.taglib.support.TagUtil;
/**
 * 
 * <p>application name:      系统菜单树</p>
 
 * <p>application describing:系统菜单树</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class MenuTree implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 816577451190200008L;
	private static Log log = LogFactory.getLog(MenuTree.class);
	/**
	 * 程序发布路径
	 */
	private String contextPath;

	/**
	 * 权限类
	 */
	private static final IRight right = RightManager.getRight();

	public MenuTree(String contextPath) {
		this.contextPath = contextPath;
	}

	/**
	 * 
	 * @return
	 */
	public List build(String userId) {
		return build(userId,"1");
	}
	/**
	 * 
	 * @param id 
	 * @param leiXing 1,用户编号;2,委托模板编号
	 * @return
	 */
	public List build(String id, String leiXing){
		SimpleTreeParameter treePara = new SimpleTreeParameter();
		// 菜单查询sql主体语句
		String sql = "select CD.MingCheng,CD.BieMing,CD.ShangJiCD,CD.DiCengBZ,CD.DuiHuaCFFS,"
				+ "CD.DuiHuaLJ,CD.MuBiaoDH,CD.MuBiaoDHJRZT,CD.TiShi ";
		// 菜单查询sql语句
		String sqls = "";
		if (right == null || right.isAdmin(id)) {
			// 没有权限控制或admin用户，所有菜单均可见
			sqls = sql + " from QAM_XiTonGCD CD ";
		} else {
			// 不受权限控制的菜单
			sqls = sql
					+ " from QAM_XiTonGCD CD where CD.RuKouSW is null or CD.RuKouSW=''";
			sqls += " union "
					+ sql
					+ " from QAM_XiTonGCD CD,QAM_GongNengHD HD where CD.RuKouSW is not Null "
					+ " And CD.RuKouSW = HD.BieMing And HD.QuanXianBZ ='0'";
			// 受行权限约束的菜单
			sqls += " union " + sql
					+ " from QAM_XiTonGCD CD where CD.RuKouSW is not Null ";
			if("1".equals(leiXing)){
				sqls += "and CD.RuKouSW in " + right.userProcess(id);
			}else if("2".equals(leiXing)){
				sqls += "and CD.RuKouSW IN (select HuoDongID FROM WTGL_WeiTuoQXSZ WHERE MoBanBH = '"+id+"')";
			}

		}

		sqls = "select distinct * from (" + sqls
				+ ")  A order by A.ShangJiCD,A.BieMing,A.MingCheng";
		/**
		 * 构造树参数
		 */
		treePara.setSelfSql(sqls);
		treePara.setIdField("BieMing");
		treePara.setParentField("ShangJiCD");
		treePara.setNodeTypeField("DiCengBZ");
		treePara.setTextField("MingCheng");
		treePara.setTipField("MingCheng");
		treePara.setRootId("root");
		/**
		 * 创建树，提供回调接口来创建树节点的url属性
		 */
		BaseTreeBuilder treeBuilder = new SimpleTreeBuilder(new UrlCallBack());
		List list = treeBuilder.build(treePara);
		if (list != null && !list.isEmpty()) {
			int size = list.size();
			for (int i = size - 1; i >= 0; i--) {
				SimpleTreeNode childNode = (SimpleTreeNode) list.get(i);
				if(!hasLeafMenuNode(childNode)){
					list.remove(i);
				}
			}
		}
		return list;
	}
	/**
	 * 构造权限树
	 * @param userID
	 */
	public List buildPrivilegeTree(String userID){
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT bianhao,shangjibh,mingcheng,TYPE,CASE WHEN func_isleafnode ('v_GongNengHD', 'ShangJiBH', bianhao) = 0 THEN 0 ELSE 1 END leaf FROM v_gongnenghd");
		if(right != null && !right.isAdmin(userID)){
			sql.append(" WHERE bianhao in (select bianhao from v_gongnenghd connect by prior shangjibh = bianhao start with bianhao in ").append(right.userProcess(userID)).append(")");
		}
		sql.append(" ORDER BY shangjibh, yewubm");
		SimpleTreeParameter treePara = new SimpleTreeParameter();
		treePara.setSelfSql(sql.toString());
		treePara.setIdField("bianhao");
		treePara.setParentField("shangjibh");
		treePara.setNodeTypeField("leaf");
		treePara.setTextField("mingcheng");
		treePara.setTipField("mingcheng");
		treePara.setRootId("root");
		BaseTreeBuilder treeBuilder = new SimpleTreeBuilder(new UrlCallBack());
		List list = treeBuilder.build(treePara);
		return list;
	}
	/**
	 * 判断节点是否有底层菜单节点，如果没有返回false;
	 * 
	 * @param node
	 *            节点
	 * @return
	 */
	private boolean hasLeafMenuNode(SimpleTreeNode node) {
		if (node.getChildNodes() != null && !node.getChildNodes().isEmpty()) {

			boolean hasLeaf = false;
			List list = node.getChildNodes();
			int size = list.size();
			for (int i = size - 1; i >= 0; i--) {
				SimpleTreeNode childNode = (SimpleTreeNode) list.get(i);
				// 递归调用判断，如果节点下面都没有底层菜单节点就把它移除掉
				if (hasLeafMenuNode(childNode)) {
					hasLeaf = true;
				} else {
					list.remove(i);
				}
			}
			return hasLeaf;
		}
		return "0".equals(node.getAttribute("DiCengBZ"));
	}
	
	private String encodeURI(String parameters) {
		String url = "";
		if (parameters.indexOf("&") > 0) {
			String[] str = parameters.split("&");
			for (int i = 0; i < str.length; i++) {
				url += "&" + encodeOneParameter(str[i]);
			}
		} else {
			url += encodeOneParameter(parameters);
		}
		return url;
	}

	private String encodeOneParameter(String parameter) {
		String leftStr = "";
		String rightStr = "";
		if (parameter.indexOf("=") > 0) {
			leftStr = parameter.substring(0, parameter.indexOf("=") + 1);
			rightStr = CommonUtils.null2Blank(TagUtil.parseURLEncode(parameter
					.substring(parameter.indexOf("=") + 1)));
			return leftStr + rightStr;
		}
		return parameter;

	}

	/**
	 * 回调接口，创建节点的url
	 * 
	 * @author masheng
	 * 
	 */
	private class UrlCallBack implements ISimpleTreeBuildCallBack {

		@Override
		public void doInCall(SimpleTreeNode treeNode, ResultSet rs) {
			try {
				String daKaiFS = rs.getString("DuiHuaCFFS");
				String luJing = rs.getString("DuiHuaLJ");
				String duiHua = rs.getString("MuBiaoDH");
				String zhuangTai = rs.getString("MuBiaoDHJRZT");
				String fuJiaCS = rs.getString("TiShi");// TiShi字段用来存储url附加参数
				treeNode.addAttribute("DiCengBZ", rs.getString("DiCengBZ"));
				StringBuffer url = new StringBuffer();
				/*if (CommonUtils.null2Blank(daKaiFS).length() == 0
						|| CommonUtils.null2Blank(luJing).length() == 0) {
					return;
				}*/
				buildUrl(url, luJing, duiHua, zhuangTai, fuJiaCS);
				/*if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_BLANK
						.equals(daKaiFS)) {
					// 弹出新窗口
					//url.append(QamWebDataConstants.QAM_EXTFUNCTIONCM).append("openNewWin('");
					buildUrl(url, luJing, duiHua, zhuangTai, fuJiaCS);
					//url.append("','").append(rs.getString("BieMing")).append("','600','400','')");
				} else if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELF
						.equals(daKaiFS)) {
					// 当前窗口打开
					//url.append("location.href='");
					buildUrl(url, luJing, duiHua, zhuangTai, fuJiaCS);
					//url.append("'");
				} else if (daKaiFS != null) {
					// 指定的frame
					//url.append("parent.").append(daKaiFS).append(".location.href='");
					buildUrl(url, luJing, duiHua, zhuangTai, fuJiaCS);
					//url.append("'");
				}*/
				treeNode.setUrl(url.toString());

			} catch (Exception e) {
				log.error(e.getMessage());
			}

		}

		/**
		 * 创建url
		 * 
		 * @param url
		 * @param luJing
		 *            对话路径
		 * @param duiHua
		 *            对话别名
		 * @param zhuangTai
		 *            进入状态
		 * @param fuJiaCS
		 *            附加参数
		 */
		private void buildUrl(StringBuffer url, String luJing, String duiHua,
				String zhuangTai, String fuJiaCS) {
			if(luJing == null) luJing = "";
			if (!luJing.trim().startsWith(contextPath)) {
				if (luJing.startsWith("/")) {
					luJing = contextPath + luJing;
				} else {
					luJing = contextPath + "/" + luJing;
				}
			}
			url.append(luJing);
			if (duiHua != null || zhuangTai != null || fuJiaCS != null) {
				if (luJing.indexOf("?") < 0) {
					url.append("?");
				} else {
					url.append("&");
				}
				if (duiHua != null) {
					url.append(QamWebDataConstants.QAM_SUBMIT_DIALOG).append(
							"=").append(duiHua).append("&");

				}
				if (zhuangTai != null) {
					url.append(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE)
							.append("=").append(zhuangTai).append("&");
				}

				if (fuJiaCS != null) {
					url.append(encodeURI(fuJiaCS));
				}
			}

		}
	}
}
