package com.rc.web.extension.component.getjiekouxx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

public class GetInterfacesValue {
	private static Log log = LogFactory.getLog(GetInterfacesValue.class);
	private static HttpWebs web;
	private static IDataBaseAccess dba = null;

	public String getJson(String pagesize, String yonghubh, String key,
			String kcbh) throws SQLException {
		String wallid=getKongJianID(kcbh);
		String json = getValue(pagesize, yonghubh, key,wallid,"3");
		return json;
	}

	public String getKongJianID(String kcbh) throws SQLException {
		StringBuffer sql = new StringBuffer();
		String kongjianid = "";
		sql.append("select KongJianID from JK_KeChengKJTXLGX where kechengbh='"
				+ kcbh + "'");
		log.debug("查询是否存在记录：" + sql.toString());
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				kongjianid = rs.getString(1);
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dba != null)
				dba.closeConnection();
		}
		return kongjianid;
	}

	public static void main(String[] args) {

	}

	/**
	 * 获取总条数
	 * 
	 * @param pagesize
	 * @param yonghubh
	 * @param key
	 * @return
	 * @throws SQLException 
	 */
	public int getPageCount(String yonghubh, String key,String kcbh) throws SQLException {
		String wallid=getKongJianID(kcbh);
		String json = getValue("all", yonghubh, key,wallid,"");
		JSONArray array_post = JSONArray.fromObject(json);
		return array_post.size();
	}

	private String getValue(String pagesize, String yonghubh, String key,String wallid,String limit) {
		web = new HttpWebs();
		web.init();
		if("".equals(wallid)||wallid==null){
			wallid="null";
		}
		String json = "[]";
		String path = "http://118.26.134.24/jymis/szxx/space/findPost.do";
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("uid", yonghubh);
		parmMap.put("wallid", wallid);
		parmMap.put("page_size", pagesize);
		parmMap.put("limit", limit);
		parmMap.put("key", key);
		String jsonlist = web.callByGet(path, parmMap);
		if(jsonlist.indexOf("您没有操作权限")==-1){
			jsonlist = Base64Util.decrypt(jsonlist);
			JSONArray array = JSONArray.fromObject("[" + jsonlist + "]");
			JSONObject jsonObject = array.getJSONObject(0);
			String msgCode = jsonObject.get("msgCode").toString();
			if ("1".equals(msgCode)) {
				json = jsonObject.get("posts").toString();
			}
		}
		//System.out.println(json);
		return json;
	}
	public Map<String, String> getUser(String uid){
		StringBuffer sql = new StringBuffer();
		Map<String, String> map=new HashMap<String, String>();
		sql.append("select xt_yonghu.xingming,xt_yonghu.image,jcsc_banji.className,jcsj_xuexiao.name,jcsj_xuexiao.id FROM jcsc_banji ,xt_yonghu ,jcsj_xuexiao where jcsc_banji.classId=substring_index(substring_index(xt_yonghu.classIds,',',xt_yonghu.bianhao),',',-1) and jcsc_banji.schoolId=jcsj_xuexiao.id and xt_yonghu.bianhao='"+uid+"'");
		log.debug("查询是否存在记录：" + sql.toString()); 
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				map.put("xingming", rs.getString(1));
				map.put("image", rs.getString(2));
				map.put("className",rs.getString(3));  
				map.put("schoolName",rs.getString(4)); 
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
		return map;
	}

}
