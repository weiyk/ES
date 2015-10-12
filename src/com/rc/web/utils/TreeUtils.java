package com.rc.web.utils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeNode;

public class TreeUtils {
	private static Log log = LogFactory.getLog(TreeUtils.class);
	public static List<SimpleTreeNode> getGroundNode(SimpleTreeNode simpleTreeNode,List<SimpleTreeNode> nodeList){
		if(simpleTreeNode == null) return null;
		if(simpleTreeNode.getChildNodes() == null || simpleTreeNode.getChildNodes().size() == 0){
			nodeList.add(simpleTreeNode);
			return nodeList;
		}else{
			for(Object obj:simpleTreeNode.getChildNodes()){
				SimpleTreeNode treeNode = (SimpleTreeNode)obj;
				TreeUtils.getGroundNode(treeNode, nodeList);
			}
			return nodeList;
		}
	}
	public static String list2Json(List<SimpleTreeNode> nodes){
		StringBuffer json = new StringBuffer("[");
		for(int i = 0; i < nodes.size(); i++){
			SimpleTreeNode treeNode = (SimpleTreeNode) nodes.get(i);
			json.append("{id:\"").append(treeNode.getId()).append("\",pId:\"").append(treeNode.getParentId()).append("\",");
			json.append("name:\"").append(treeNode.getText()).append("\",");
			if(treeNode.getUrl() != null && treeNode.getUrl().length()>0){
				json.append("taburl:\"").append(treeNode.getUrl()).append("\",");
			}
			//工作组设置与用户设置改变图标
			if("CD_user".equalsIgnoreCase(treeNode.getId()) || "CD_workbench".equalsIgnoreCase(treeNode.getId())){
				json.append("icon:\"").append(treeNode.getTip()).append("\",");
			}
			if(treeNode.getChildNodes() != null && treeNode.getChildNodes().size()>0){
				String children = TreeUtils.list2Json(treeNode.getChildNodes());
				json.append("children:").append(children).append("},");
			}else{
				json.delete(json.length()-1, json.length());
				json.append("},");
			}
		}
		if(json.toString().endsWith(",")){
			json.delete(json.length()-1, json.length());
		}
		json.append("]");
		log.debug("我的工作台json" + json.toString());
		return json.toString();
	}
	
	public static String getDefaultNode(String userId,List<SimpleTreeNode> menuList) throws SQLException{
		return getDefaultNode(userId,menuList,"");
	}
	/**
	 * 构造用户设置
	 * @return
	 */
	private static SimpleTreeNode buildSetUser(String prefix){
		SimpleTreeNode node = new SimpleTreeNode();
		node.setId("CD_user");
		node.setText("用户设置");
		node.setTip(prefix +"/common/ztree/zTreeStyle/img/diy/lxr.png");//暂时存放图标信息
		node.setUrl(prefix + "/mainframe/yonghummxg.jsp?_qam_dialog=GNDH_YongHuMMXG&_qam_dialog_state=DHZT_ChaXun");
		return node;
	}
	
	/**
	 * 构造工作台菜单
	 * @return
	 */
	private static SimpleTreeNode buildBenchNode(String prefix){
		SimpleTreeNode node = new SimpleTreeNode();
		node.setId("CD_workbench");
		node.setTip(prefix +"/common/ztree/zTreeStyle/img/diy/set.png");//暂时存放图标信息
		node.setText("工作台设置");
		node.setUrl(prefix + "/mainframe/wodegzt.jsp?_qam_dialog=GNDH_WoDeGZT&_qam_dialog_state=DHZT_JinRu");
		return node;
	}
	/**
	 * 构造委托办理记录菜单/业务委托授权
	 * @return
	 */
	private static SimpleTreeNode buildShouQuanNode(String prefix){
		SimpleTreeNode node = new SimpleTreeNode();
		node.setId("CD_shouquan");
		node.setText("业务委托授权");
		node.setUrl(prefix + "/mainframe/weituosq/yewuwtsq.jsp?_qam_dialog=GNDH_YeWuWTSQ&_qam_dialog_state=DHZT_JinRu");
		return node;
	}
	/**
	 * 构造业务委托授权
	 * @return
	 */
	private static SimpleTreeNode buildRecodeNode(String prefix){
		SimpleTreeNode node = new SimpleTreeNode();
		node.setId("CD_banlijl");
		node.setText("委托办理记录");
		node.setUrl(prefix + "/mainframe/weituosq/weituobljl.jsp?_qam_dialog=GNDH_WeiTuoBLJL&_qam_dialog_state=DHZT_JinRu");
		return node;
	}
	

	public static String getDefaultNode(String userId,
			List<SimpleTreeNode> menuList, String prefix) {
		
		List<SimpleTreeNode> groundNodes = new ArrayList<SimpleTreeNode>();
		List<SimpleTreeNode> benchList = new ArrayList<SimpleTreeNode>();
		benchList.add(buildBenchNode(prefix));
		benchList.add(buildSetUser(prefix));
		benchList.add(buildShouQuanNode(prefix));
		benchList.add(buildRecodeNode(prefix));
		for (SimpleTreeNode node : menuList) {
			groundNodes.addAll(TreeUtils.getGroundNode(node, new ArrayList<SimpleTreeNode>()));
		}
		IDataBaseAccess dba = null;
		ResultSet rs = null;
		try{
			dba = ContextService.lookupDefaultDataBaseAccess();
			String sql = "Select XiTongCDBH FROM XT_WoDeGZT WHERE XiTongYHBH = '" +userId+"'";
			log.debug("获取当前用户工作台菜单sql：" + sql);
			dba.openConnection();
			rs = dba.executeQuery(sql);
			while(rs.next()){
				String menuId = rs.getString("XiTongCDBH");
				for (SimpleTreeNode node : groundNodes) {
					if(node.getId().equalsIgnoreCase(menuId)){
						benchList.add(node);
					}
				}
			}
			log.debug("当前工作台菜单是：" + benchList);
			String jsonArr = TreeUtils.list2Json(benchList);
			StringBuffer json = new StringBuffer("{\"name\":\"我的工作台\",open:true,\"children\":");
			json.append(jsonArr).append("}");
			log.debug("当前工作台json：" + json.toString());
			return json.toString();
		}catch(Exception e){
			log.error("我的工作台获取默认节点异常" + e.getMessage());
			e.printStackTrace();
		}finally{
			if(rs != null){
				//rs.close();
			}
			if(dba != null){
				dba.closeConnection();
			}
		}
		return null;
	}
}
