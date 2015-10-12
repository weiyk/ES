package com.rc.web.extension.component.gethaoyouxx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

public class GetHaoYouLB {
	private static HttpWebs web;
	private static IDataBaseAccess dba = null;
	private static List<List> list;
	public List<List> getHaoYou(String yhbh,String key){
		web= new HttpWebs();
		web.init();
		list=new ArrayList<List>();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("findFriend_url");
    	Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("uid", yhbh);
		parmMap.put("key", key);
    	String sb=web.callByGet(url,parmMap);
        JSONArray array = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        try {
        if("1".equals(msgCode)){
        	String uids=jsonObject.get("uids").toString();
        	String[] uidlist=uids.split(",");
        	for(int i=0;i<uidlist.length;i++){
        		String uid=uidlist[i];
					printHtml(uid);
        	}
        }
        return list;
        } catch (SQLException e) {
			e.printStackTrace();
			return list;
		}
        
	}
	
	private static void printHtml(String uid) throws SQLException{
		StringBuffer sql =new StringBuffer();
		sql.append("select xingming,image,classIds,bianhao,type from xt_yonghu  where bianhao='"+uid+"'");
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				List<String> tem=new ArrayList<String>();
				tem.add(rs.getString(1));
				tem.add(rs.getString(2));
				tem.add(getBanJi(rs.getString(3)));
				tem.add(rs.getString(4));
				tem.add(rs.getString(5));
				list.add(tem);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dba != null)
				dba.closeConnection();
		}
	}
	
	private static String getBanJi(String cids){
		StringBuffer sql =new StringBuffer();
		StringBuffer classid=new StringBuffer();
		StringBuffer condition = new StringBuffer(63);
		if(!"".equals(cids)&&cids!=null){
			if(cids.indexOf(",") != -1){
				String[] cid=cids.split(",");
				condition.append("where classId  in (");
				for(int i=0;i<cid.length;i++){
					condition.append("'"+cid[i]+"',");
				}
				condition.delete(condition.length()-1, condition.length());
				condition.append(" )");
			}else{
				condition.append("where classId ='"+cids+"'");
			}
			sql.append("select className from jcsc_BanJi ").append(condition);
			ResultSet rs = null;
			try {
				rs = dba.executeQuery(sql.toString());
				while (rs.next()) {
					classid.append(rs.getString(1)+",");
				}
				if(classid.length()>0){
					classid.setLength(classid.length() - 1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		
		return classid.toString();
	}
}

