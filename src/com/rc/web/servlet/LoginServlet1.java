package com.rc.web.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.core.transaction.execution.CanReturnException;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.security.TransformPassword;
import com.qam.framework.util.CommonUtils;
import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeNode;
import com.qam.web.facade.servlet.BaseServlet;
import com.rc.web.extension.menu.MenuTree;


/**
 * 
 * <p>application name:      登陆servlet</p>
 
 * <p>application describing:登陆servlet</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class LoginServlet1 extends BaseServlet {
	
	private static final long serialVersionUID = 816577451190200009L;
	private final String LOGIN_NAME = "loginName";
	private final String LOGIN_PWD = "loginPwd";
	private final String LOGIN_YZM = "yanZhenM";
	private final String ADMIN_WIN = "adminWin";//管理员窗口
	private static final Log log = LogFactory.getLog(LoginServlet1.class);
	/**
	 * 不允许直接通过录入URL访问该servlet
	 * */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.forwarToTarget("/login.jsp",request,response);
	}

	/**
	 * 登录验证
	 * */
	@SuppressWarnings("rawtypes")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		response.setContentType(CONTENT_TYPE);
		IDataBaseAccess dataBaseAccess = null;
		ResultSet rs = null;
		try {
			doValidateInput(request);
			HttpSession session = request.getSession(false);
			if (session == null) {
				session = request.getSession(true);
			}
			String loginName = request.getParameter(this.LOGIN_NAME).trim();
			String loginPwd = request.getParameter(this.LOGIN_PWD).trim();	
			StringBuffer sql = new StringBuffer(64);
			sql.append("SELECT YH.BianHao BianHao, YH.DENGLUM DENGLUM,YH.XingMing XingMing,");
			sql.append("YH.KOULING KOULING FROM xt_yonghu YH ");
			sql.append(" WHERE  YH.ZHUANGTAI='1' AND DENGLUM ='").append(loginName).append("'");
			log.debug("用户sql:"+sql);
			int i = 0;
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
			dataBaseAccess.openConnection();
			rs = dataBaseAccess.executeQuery(sql.toString());
			while (rs.next()) {
				if (!TransformPassword.transform(loginPwd).equals(rs.getString("KOULING"))){
					throw new Exception("密码不正确，请重新输入！");
				}
				session.setAttribute("YONGHUXM", rs.getString("XingMing"));//用户姓名
				session.setAttribute("XingMing", rs.getString("XingMing"));//用户姓名
				session.setAttribute("XiTongYHBH", rs.getString("BianHao"));//编号
				session.setAttribute("YongHuBH", rs.getString("BianHao"));//权限用用户编号
				session.setAttribute("DengLuM", rs.getString("DENGLUM"));//登录名
				i++;
			}
			if (i <= 0) {
				throw new Exception("用户名不存在或已被冻结，请重新输入！");
			}else if(i>1){
				throw new Exception("用户名重复，登录失败");
			}	
			log.debug("登录成功，加载用户菜单");
			MenuTree menu = new MenuTree(request.getContextPath());
			List list = menu.build(String.valueOf(session.getAttribute("YongHuBH")));//根据角色控制菜单
			if (list != null) {
				session.setAttribute(QamWebDataConstants.QAM_SESSION_USERMENU,list);
			}
			StringBuffer json = new StringBuffer(128);
			json.append("{");
			for(int j = 0; j < list.size(); j++){
				SimpleTreeNode node = (SimpleTreeNode) list.get(j);
				json.append("\"").append(node.getId()).append("\":[");
				this.menuToJson(json, node);
				json.delete(json.length()-1, json.length());
				json.append("],");
			}
			json.delete(json.length()-1, json.length());
			json.append("}");
			session.setAttribute("menuJson", json.toString());
			String url = "/mainframe/mainframe.jsp";
			this.forwarToTarget(url, request, response);
		} catch (Exception e) {
			//log.error("用户登录失败", e);
			this.forwarToTarget("/login.jsp?errInfo=" + e.getMessage(),request, response);
		} finally {
			try{
				rs.close();
				dataBaseAccess.closeConnection();
			}catch(Exception e){
				log.error("关闭数据库连接出错",e);
			}
		}
	}
	/**
	 * 转换json
	 * @param json
	 * @param node
	 */
	private void menuToJson(StringBuffer json,SimpleTreeNode node){	
		List childNodes = node.getChildNodes();
		if(childNodes != null){
			for(int i = 0; i < childNodes.size(); i++){
				SimpleTreeNode treeNode = (SimpleTreeNode) childNodes.get(i);
				json.append("{id:\"").append(treeNode.getId()).append("\",pId:\"").append(node.getId()).append("\",");
				if(treeNode.getUrl() == null || treeNode.getUrl().length() <= 0){
					//json.append("open:true,");
				}else{
					json.append("taburl:\"").append(treeNode.getUrl()).append("\",");
				}
				json.append("name:\"").append(treeNode.getText()).append("\"},");
				this.menuToJson(json, treeNode);
			}
		}
	}
	
	private void doValidateInput(HttpServletRequest request) throws Exception {
		if (request.getParameter(this.LOGIN_NAME) == null
				|| request.getParameter(this.LOGIN_NAME).trim().length() == 0) {
			throw new Exception("请输入登录名！");
		}
		if (request.getParameter(this.LOGIN_PWD) == null
				|| request.getParameter(this.LOGIN_PWD).trim().length() == 0) {
			throw new Exception("请输密码！");
		}
		//3代表无验证码
		String canshuz="3";
		if(CommonUtils.null2Blank(canshuz).length() > 0 && !"3".equals(canshuz)){
			if (request.getParameter(this.LOGIN_YZM) == null
					|| request.getParameter(this.LOGIN_YZM).trim().length() == 0) {
				throw new Exception("请输验证码！");
			}else if(request.getParameter(this.LOGIN_YZM).trim().length()>4){
				throw new Exception("验证码不能超过4字符！");
			}else if(!request.getParameter(this.LOGIN_YZM).trim().equalsIgnoreCase((String)request.getSession().getAttribute("rand"))){
				log.debug(request.getParameter(this.LOGIN_YZM)+":"+(String)request.getSession().getAttribute("rand"));
				throw new Exception("验证码输入错误！");
			}
		}
	}

}