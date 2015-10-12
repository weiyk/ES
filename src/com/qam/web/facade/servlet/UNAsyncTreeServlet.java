package com.qam.web.facade.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.util.CommonUtils;
import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.taglib.extension.Ztree;
/**
 * 
 * <p>application name:      ztree 异步加载树</p>
 
 * <p>application describing:ztree 异步加载树</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class UNAsyncTreeServlet extends BaseServlet {
	private static final long serialVersionUID = -7825355637448948879L;
	private static final Log log = LogFactory.getLog(UNAsyncTreeServlet.class);
	private Map<String,String> fieldMap = null;//用于存放别名
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	/**
	 * 设置参数
	 * @param request
	 * @return
	 */
	private Ztree buildZtree(HttpServletRequest request){
		Ztree ztree = new Ztree();
		//Map<String, String> leafNode = null;//叶子节点
		ztree.setPId(request.getParameter("id"));//父节点id
		ztree.setTableName(request.getParameter(QamWebDataConstants.ZTREE_PARAM_TABLENAME));//数据表名称或者视图
		ztree.setIdField(request.getParameter(QamWebDataConstants.ZTREE_PARAM_IDFIELD));//节点id字段
		ztree.setTextField(request.getParameter(QamWebDataConstants.ZTREE_PARAM_TEXTFIELD));//显示字段
		ztree.setParentField(request.getParameter(QamWebDataConstants.ZTREE_PARAM_PARENTFIELD));//父节点字段
		ztree.setOtherField(request.getParameter(QamWebDataConstants.ZTREE_PARAM_OTHERFIELD));//其他字段
		ztree.setOrderField(request.getParameter(QamWebDataConstants.ZTREE_PARAM_ORDERFIELD));//排序字段
		ztree.setCondition(request.getParameter(QamWebDataConstants.ZTREE_PARAM_CONDITION));//查询条件
		ztree.setRootId(request.getParameter(QamWebDataConstants.ZTREE_PARAM_ROOTID));//rootid
		ztree.setRootText(request.getParameter(QamWebDataConstants.ZTREE_PARAM_ROOTTEXT));//rootTXT
		ztree.setDataSource(request.getParameter(QamWebDataConstants.ZTREE_PARAM_DATASOURCE));//数据源标识
		ztree.setAsync(request.getParameter(QamWebDataConstants.ZTREE_PARAM_ASYNC));//异步
		ztree.setChkDisabled(request.getParameter(QamWebDataConstants.ZTREE_PARAM_CHK_DISABLED));//复选框是否可选择
		ztree.setSelfTable(request.getParameter(QamWebDataConstants.ZTREE_PARAM_SELF_TABLE));//自定义sql
		ztree.setShiFouDC(request.getParameter(QamWebDataConstants.ZTREE_PARAM_SHI_FOUDC));//是否底层
		ztree.setExpandLevel(request.getParameter(QamWebDataConstants.ZTREE_PARAM_EXPANDLEVEL));//展开级次
		
		return ztree;
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType(CONTENT_TYPE);
		Ztree ztree = this.buildZtree(request);
		IDataBaseAccess idm = null;
		Connection conn  = null;
		fieldMap = new HashMap<String, String>(12);
		String searchValue = request.getParameter("searchValue");//搜索值
		String searchField = request.getParameter("searchField");//检索字段
		boolean isSearch = (CommonUtils.null2Blank(searchValue).length() > 0 && CommonUtils.null2Blank(searchField).length() > 0);
		try{
			if(CommonUtils.null2Blank(ztree.getDataSource()).length() > 0){
				idm = ContextService.lookupDataBaseAccess(ztree.getDataSource());
			}else{
				idm = ContextService.lookupDefaultDataBaseAccess();
			}
			conn = idm.getConnection();
			String sql = this.bulidSql(ztree,searchValue,searchField);
			log.debug("构造树sql:"+sql);
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			JSONArray array = new JSONArray();
			while(rs.next()){
				JSONObject json = new JSONObject();
				setData(json, rs,ztree,request,isSearch);
				array.put(json);
			}
			//如果设置了根节点
			if(CommonUtils.null2Blank(ztree.getRootText()).length() > 0 && CommonUtils.null2Blank(ztree.getPId()).length() <= 0){
				JSONObject root = new JSONObject();
				root.put("id", ztree.getRootId());
				root.put("name", ztree.getRootText());
				if(isSearch){
					root.put("open", true);
				}
				root.put("nocheck", true);
				array.put(root);
			}
			rs.close();
			ps.close();
			PrintWriter writer = response.getWriter();
			writer.write(array.toString());
			writer.flush();
			writer.close();
			//fieldMap.clear();
		}catch(Exception e){
			log.error("加载树异常",e);
			forWardToExceptionJSP(request, response, "树加载", e.getMessage());
		}finally{
			if(conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					log.error("连接异常"+e.getMessage());
					e.printStackTrace();
				}
		}
	}
	/**
	 * 设置json数据
	 * @param json
	 * @param rs
	 * @throws JSONException
	 * @throws SQLException
	 */
	private void setData(JSONObject json ,ResultSet rs,Ztree ztree,HttpServletRequest request,boolean isSearch) throws JSONException, SQLException {
		String id =  rs.getString(ztree.getIdField());
		json.put("id",id);
		json.put("name", rs.getString(ztree.getTextField()));
		boolean leaf = rs.getInt("leaf") > 0 ? false : true;
		if(isSearch){
			json.put("open", true);
		}else if("true".equalsIgnoreCase( ztree.getAsync())){
			json.put("open", leaf);
		}
		leaf = rs.getInt("leaf") > 0 ? true : false;
		json.put("pId", rs.getString(ztree.getParentField()));
		if("true".equalsIgnoreCase(ztree.getAsync()) && "true".equalsIgnoreCase(ztree.getChkDisabled())){
			json.put("chkDisabled", leaf);
		}else{
			json.put("chkDisabled", false);
		}
		//为底层节点更换图片
		if(CommonUtils.null2Blank(ztree.getShiFouDC()).length() > 0){
			json.put(ztree.getShiFouDC(), rs.getString("sfdc"));
			if("1".equalsIgnoreCase(rs.getString("sfdc"))){
				json.put("icon", request.getContextPath()+"/common/ztree/zTreeStyle/img/diy/2.png");
			}
		}
		json.put("isParent", leaf);
		if (CommonUtils.null2Blank(ztree.getOtherField()).length() > 0) {
			String[] other = ztree.getOtherField().split(",");
			for(int i = 0; i < other.length; i++){
				String otherField = other[i];
				if(otherField == null || otherField.length() <= 0 ) continue;
				String a_field = fieldMap.get(otherField.toUpperCase()) == null ? otherField : fieldMap.get(otherField.toUpperCase());//是否有别名 
				json.put(otherField, rs.getString(a_field));
			}
		}
	}
	/**
	 * 构建tree sql
	 * @return
	 */
	private String bulidSql(Ztree ztree,String searchValue,String searchField){
		StringBuffer sql = new StringBuffer(128);
		sql.append("SELECT DISTINCT T1.*,T2.CN leaf FROM (SELECT ");
		this.bulidColumn(sql,ztree);
		sql.append(" FROM ");
		if(CommonUtils.null2Blank(ztree.getSelfTable()).length() > 0){
			sql.append(ztree.getSelfTable());
		}else{
			sql.append(ztree.getTableName());
		}
		sql.append(" WHERE 1=1 ");
		
		if("true".equalsIgnoreCase(ztree.getAsync()) && CommonUtils.null2Blank(searchValue).length() == 0 &&
				CommonUtils.null2Blank(searchField).length() == 0){
			this.appendParent(sql,ztree);
		}
		if (CommonUtils.null2Blank(ztree.getCondition()).length() > 0) {
			if (ztree.getCondition().trim().toLowerCase().startsWith("AND")) {
				sql.append(ztree.getCondition());
			} else {
				sql.append(" AND ").append(ztree.getCondition());
			}
		}
		if(CommonUtils.null2Blank(searchValue).length() > 0 && CommonUtils.null2Blank(searchField).length() > 0){
			sql.append(" CONNECT BY PRIOR ").append(ztree.getParentField()).append("=").append(ztree.getIdField());
			sql.append(" START WITH (");
			String[] fields = searchField.split(",");
			for(String field : fields){
				sql.append(" "+field).append(" LIKE '").append(searchValue).append("%' OR");
			}
			sql.delete(sql.length()-2,sql.length()).append(")");
		}
		sql.append(" ORDER BY ").append(ztree.getParentField());
		if(CommonUtils.null2Blank(ztree.getOrderField()).length() > 0){
			sql.append(",").append(ztree.getOrderField());
		}
		sql.append(") T1 LEFT JOIN ");
		sql.append("(SELECT COUNT(*) CN,").append(ztree.getParentField()).append(" FROM ");
		if(CommonUtils.null2Blank(ztree.getSelfTable()).length() > 0){
			sql.append(ztree.getSelfTable());
		}else{
			sql.append(ztree.getTableName());
		}
		sql.append(" GROUP BY ").append(ztree.getParentField()).append(") T2 ON T1.").append(ztree.getIdField());
		sql.append(" = ").append("T2.").append(ztree.getParentField());
		
		return sql.toString();
	}

	/**
	 * 构造查询列
	 * @param sql
	 */
	private void bulidColumn(StringBuffer sql,Ztree ztree){
		sql.append(ztree.getIdField());
		if (ztree.getParentField() != null && ztree.getParentField().length() > 0) {
			sql.append(",").append(ztree.getParentField().toUpperCase());
		}
		if(CommonUtils.null2Blank(ztree.getShiFouDC()).length() > 0){
			sql.append(",").append(ztree.getShiFouDC().toUpperCase()).append(" sfdc");
		}
		if (CommonUtils.null2Blank(ztree.getTextField()).length() == 0) {
			sql.append(",").append(ztree.getIdField().toUpperCase()).append(" tree_text");
		} else {
			sql.append(",").append(ztree.getTextField().toUpperCase());
		}
		if (CommonUtils.null2Blank(ztree.getOtherField()).length() > 0) {
			String[] others = ztree.getOtherField().split(",");
			StringBuffer other = new StringBuffer();
			//若跟id 、parentid、 textid 等有相同字段则自动取别名
			for(String o : others){
				if(sql.indexOf(o.toUpperCase()) == -1){
					other.append(o.toUpperCase()).append(",");
				}else{
					other.append(o.toUpperCase()).append(" AS f_").append(o).append(",");
					fieldMap.put(o.toUpperCase(), "f_"+o);
				}
			}
			if(other.length() > 0){
				other.delete(other.length()-1, other.length());
				sql.append(",").append(other);
			}
		}
		//调用函数判断是否为叶子节点
		//sql.append(",FUNC_ISLEAFNODE('").append(ztree.getTableName()).append("','");
		//sql.append(ztree.getParentField()).append("',").append(ztree.getIdField()).append(") leaf");
	}
	/**
	 * 添加上级查询条件
	 * @param sql
	 */
	private void appendParent(StringBuffer sql,Ztree ztree){
		if(CommonUtils.null2Blank(ztree.getPId()).length() > 0 && !"undefined".equalsIgnoreCase(ztree.getPId())){
			sql.append(" AND ").append(ztree.getParentField()).append("='").append(ztree.getPId()).append("' ");
		}else{
			if(CommonUtils.null2Blank(ztree.getRootId()).length() > 0){
				sql.append(" AND ").append(ztree.getParentField()).append("='").append(ztree.getRootId()).append("'");
			}else{
				sql.append(" AND ").append(ztree.getParentField()).append(" IS NULL");
			}
		}
	}
}
