package com.rc.web.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.beans.License;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.security.TransformPassword;
import com.qam.framework.util.CommonUtils;
import com.qam.framework.util.LicUtil;
import com.qam.web.facade.controls.tree.simpletree.SimpleTreeNode;
import com.qam.web.facade.servlet.BaseServlet;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.tools.jsonexplain.LoginJson;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;


/**
 * 
 * <p>application name:      登陆servlet</p>
 
 * <p>application describing:登陆servlet</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class LoginServlet extends BaseServlet {
	
	private static final long serialVersionUID = 816577451190200009L;
	private final String LOGIN_NAME = "loginName";
	private final String LOGIN_PWD = "loginPwd";
	private final String LOGIN_YZM = "yanZhenM";
	private final String ADMIN_WIN = "adminWin";//管理员窗口
	private static IDataBaseAccess dba = null;
	private static final Log log = LogFactory.getLog(LoginServlet.class);
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
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		//调用接口类
		HttpWebs wes = new HttpWebs();
		wes.init();
		try {
			HttpSession session = request.getSession(false);
			if (session == null) {
				session = request.getSession(true);
			}
			//地方课登录传递参数，判断本地、地方课登录依据
			String page_type=request.getParameter("page_type");
			if(page_type==null){//本地登录
				doValidateInput(request);
				//登录名
				String loginName = request.getParameter(this.LOGIN_NAME).trim();
				//密码
				String loginPwd = request.getParameter(this.LOGIN_PWD).trim();	
				Map<String, String> parmMap = new HashMap<String, String>();
				parmMap.put("loginId", loginName);
				parmMap.put("password",TransformPassword.transform(loginPwd));
				GetUrl ur=new GetUrl();
				String url=ur.getUrl("user_url");
				String str = wes.callByPost(url, parmMap);
				str = Base64Util.decrypt(str);// 解密
				LoginJson lj=new LoginJson();
				List <Object> obj=lj.getJson(str);
				String msgCode=(String) obj.get(2);
				if(msgCode.equals("成功")){
					List<String> list=lj.getJsonUser(obj.get(3));
					session.setAttribute("TYPE",list.get(3));//类别
					session.setAttribute("XiTongHYBH",list.get(4));//UID
					session.setAttribute("YONGHUXM",list.get(2));//用户姓名
					session.setAttribute("DengLuM",loginName);//登录名
					session.setAttribute("QuanZhi",obj.get(1));//权值
					session.setAttribute("TouXiang", list.get(1));
					session.setAttribute("Image", list.get(1));
					
					
					getBanJiXX(list.get(4),session);
					setImgUrl(session);
					log.debug("登录成功，加载用户菜单");
					String type=(String)list.get(3);
					String successUrl="";
					//创建同步类对象
					SelectUser su=new SelectUser();
					if(type.equals("3")){//老师
						 su.UserUtil(loginName, loginPwd);//同步用户
						 successUrl ="/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ";
						 session.setAttribute("tid","tid");
						 session.setAttribute("sid","");
					}else if(type.equals("2")){//学生
						su.UserUtil(loginName, loginPwd);//同步用户
						successUrl="/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ";
						session.setAttribute("sid","sid");
						session.setAttribute("tid","");
					}else if(type.equals("1")){//家长 
						successUrl="";
					}
					request.setAttribute("islogin","true");
					this.forwarToTarget(successUrl, request, response);
				}else if(msgCode.equals("失败！")){
					throw new Exception("用户名或密码错误，请重新输入！");
				}
			}else{//地方课登录
				//登录名
				String loginName = request.getParameter("stu_n").trim();
				//密码
				String loginPwd = request.getParameter("stu_p").trim();	
				//跳转类型
				String type=request.getParameter("page_type");
				Map<String, String> parmMap = new HashMap<String, String>();
				parmMap.put("loginId", loginName);
				parmMap.put("password",DESCoder.decrypt(loginPwd));
				GetUrl ur=new GetUrl();
				String url=ur.getUrl("user_url");
				String str = wes.callByPost(url, parmMap);
				str = Base64Util.decrypt(str);// 解密
				LoginJson lj=new LoginJson();
				List <Object> obj=lj.getJson(str);
				String msgCode=(String) obj.get(2);
				if(msgCode.equals("成功")){
					List<String> list=lj.getJsonUser(obj.get(3));
					session.setAttribute("TYPE",list.get(3));//类别
					session.setAttribute("XiTongHYBH",list.get(4));//UID
					session.setAttribute("YONGHUXM",list.get(2));//用户姓名
					session.setAttribute("DengLuM",loginName);//登录名
					session.setAttribute("QuanZhi",obj.get(1));//权值
					session.setAttribute("TouXiang", list.get(1));
					session.setAttribute("Image", list.get(1));
					getBanJiXX(list.get(4),session);
					setImgUrl(session);
					log.debug("登录成功，加载用户菜单");
					String successUrl="";
					//根据类型跳转
					if(type.equals("1")){//学一学
						 successUrl ="/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue";
					}else if(type.equals("2")){//读一读
						successUrl="/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu";
					}else if(type.equals("3")){//测一测 
						successUrl="/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe";
					}
					this.forwarToTarget(successUrl, request, response);
				}else if(msgCode.equals("失败！")){
					throw new Exception("用户名或密码错误，请重新输入！");
				}
			}
		} catch (Exception e) {
			log.error("用户登录失败", e);
			this.forwarToTarget("/login.jsp?errInfo=" + e.getMessage(),request, response);
		}
	}
	/**
	 * 转换json
	 * @param json
	 * @param node
	 */
	@SuppressWarnings("unused")
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
		if(request.getParameter(this.LOGIN_PWD).trim().length() <6){
			throw new Exception("密码不能小于六位");
		}
		//3代表无验证码
		String canshuz="1";
		if(CommonUtils.null2Blank(canshuz).length() > 0 && !"3".equals(canshuz)){
			if (request.getParameter(this.LOGIN_YZM) == null
					|| request.getParameter(this.LOGIN_YZM).trim().length() == 0) {
				throw new Exception("请输验证码！");
			}else if(request.getParameter(this.LOGIN_YZM).trim().length()>4){
				throw new Exception("验证码不能超过4个字符！");
			}else if(!request.getParameter(this.LOGIN_YZM).trim().equalsIgnoreCase((String)request.getSession().getAttribute("rand"))){
				log.debug(request.getParameter(this.LOGIN_YZM)+":"+(String)request.getSession().getAttribute("rand"));
				throw new Exception("验证码输入错误！");
			}
		}
		//验证License
		String  msg=checkLicense(request); 
		if(CommonUtils.null2Blank(msg).length() > 0 ){
			throw new Exception(msg);
		}
	}
	private String checkLicense(HttpServletRequest request) throws Exception{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		License license = ContextService.lookupLicenseService().getLicense();
		String msg = "";
	   	if(!ContextService.lookupLicenseService().validateAuthorize(license)){
	   		msg = "授权文件无效!";
	   	}else if(!ContextService.lookupLicenseService().validateExpiration(request)){
	   		msg = "授权已经过期!";
	   	}else if(!LicUtil.expirationIsUnlimited(license.getExpiration())){ 
	   		cal.setTime(sdf.parse(sdf.format(cal.getTime())));
	   		cal.add(Calendar.DAY_OF_YEAR,7);
	   		Calendar c = Calendar.getInstance();
	   		c.setTime(sdf.parse(license.getExpiration()));
	   		if(cal.compareTo(c) == 0){
	   			msg = "授权即将于"+c.get(Calendar.YEAR)+"年"+(c.get(Calendar.MONTH)+1)+"月"+c.get(Calendar.DAY_OF_MONTH)+"日到期";
	   		}
	   	}
		return msg;
	}
	private void getBanJiXX(String uid,HttpSession session){
		StringBuffer sql=new StringBuffer();
		sql.append("select className,jcsj_xuexiao.name,jcsj_xuexiao.id FROM jcsc_banji ,xt_yonghu ,jcsj_xuexiao where jcsc_banji.classId=substring_index(substring_index(xt_yonghu.classIds,',',xt_yonghu.bianhao),',',-1) and jcsc_banji.schoolId=jcsj_xuexiao.id and xt_yonghu.bianhao='"+uid+"'");
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				session.setAttribute("className",rs.getString(1));
				session.setAttribute("schoolName",rs.getString(2));
				session.setAttribute("schoolId",rs.getString(3));
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (dba != null)
				dba.closeConnection();
		}
	}
	public void setImgUrl(HttpSession session){
		String url = ApplicationConfig.getInstance().REAL_PATH+"admin.properties";
		Properties p = new Properties();
		File configFile = new File(url);
		FileInputStream inputStream = null;
		try {
			inputStream=new FileInputStream(configFile);
			p.load(inputStream);
			session.setAttribute("imgUrl", p.getProperty("imgUrl"));
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
}