package com.rc.web.extension.component.gerenziliao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

public class GetGeRenZL {
	private static HttpWebs web;
	private static IDataBaseAccess dba = null;
	private static Map<String,String> map;
	public Map<String,String> getGeRen(String yhbh,String key){
		web= new HttpWebs();
		web.init();
		map =new HashMap<String, String>();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("GeRenZL_url");
    	Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("uid", yhbh);
		parmMap.put("key", key);
    	String sb=web.callByGet(url,parmMap);
    	setGeRenXX(yhbh);
        JSONArray array = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	String customer=jsonObject.get("customer").toString();
        	Json(customer);
        }
        return map;
	}
	public void Json(String customer){
		JSONArray array = JSONArray.fromObject("["+customer+"]");
		JSONObject jsonObject = array.getJSONObject(0);
		map.put("classIds", jsonObject.get("classIds").toString());
		map.put("email", jsonObject.get("email").toString());
		map.put("id", jsonObject.get("id").toString());
		map.put("image", jsonObject.get("image").toString());
		map.put("loginId", jsonObject.get("loginId").toString());
		map.put("mobile", jsonObject.get("mobile").toString());
		map.put("name", jsonObject.get("name").toString());
		map.put("password", jsonObject.get("password").toString());
		map.put("regionID", jsonObject.get("regionID").toString());
		map.put("sex", jsonObject.get("sex").toString());
		map.put("type", jsonObject.get("type").toString());
	}
	public void setGeRenXX(String uid){
		StringBuffer sql =new StringBuffer();
		sql.append("select descn,image,birthday,regionID,city.parent_id,province.parent_id from xt_yonghu left join pt_region city on city.region_id=regionID left join pt_region province on province.region_id=city.parent_id where bianhao='"+uid+"'");
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				if("null".equals(rs.getString(1))||"".equals(rs.getString(1))||rs.getString(1)==null){
					map.put("descn", "");
				}else{
					map.put("descn", rs.getString(1));
				}
				
				map.put("image", rs.getString(2));
				if("null".equals(rs.getString(3))||"".equals(rs.getString(3))||rs.getString(3)==null){
					map.put("birthday", "");
				}else{
					long l = Long.parseLong(rs.getString(3)); 
					Date d = new Date(l);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					map.put("birthday", sdf.format(d));
				}
				map.put("town", rs.getString(4));
				map.put("city", rs.getString(5));
				map.put("province", rs.getString(6));
			}
		} catch (Exception e) {
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
	public static void main(String[] args) {
		long l = Long.parseLong("1442505600000"); 
		Date d = new Date(l);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(sdf.format(d));
	}
}
