package com.rc.web.extension.component.tongxinlu;

import java.util.HashMap;
import java.util.Map;

import org.jfree.util.Log;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

public class insertTongXinL {
	private static IDataBaseAccess dba = null;
	private static HttpWebs web;
	public void insertXueXiLU(String yonghubh,String kechengbh){
		StringBuffer sql=new StringBuffer();
		//SEQ_XueXiJLBH
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			String bianHao = ContextService.lookupSequenceService().generateId("SEQ_XueXiJLBH");
			sql.append("insert into xskj_xuexijl (xueshengbh,bianhao,kechenbh,xuexisj)values('"+yonghubh+"','"+bianHao+"','"+kechengbh+"',now())");
			dba.execute(sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (dba != null)
				dba.closeConnection();
		}
	}
	public void insertTXL(String uid,String name,String key,String kechengbh){
		web = new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String path=getUrl.getUrl("TongXunL_url");
		Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("uid", uid);
		parmMap.put("name", name);
		parmMap.put("key", key);
		String jsonlist = web.callByGet(path, parmMap);
		jsonlist = Base64Util.decrypt(jsonlist);
		JSONArray array = JSONArray.fromObject("[" + jsonlist + "]");
		JSONObject jsonObject = array.getJSONObject(0);
		String msgCode = jsonObject.get("msgCode").toString();
		if ("1".equals(msgCode)) {
			//insertXueXiLU(uid,kechengbh);
			Log.debug("通讯录添加人员成功>人员姓名："+name);
		}
	}
	public static void main(String[] args) {
		web = new HttpWebs();
		web.init();
		String path="http://118.26.134.24/jymis/szxx/circle/createCourseCircle.do";
		Map<String, String> parmMap = new HashMap<String, String>();
		//11
    	parmMap.put("uid", "1441793");
		parmMap.put("name", "11");
		parmMap.put("key", "B71FF20AF5397574966CA5F86C5B681E9D76B6F2");
		String jsonlist = web.callByGet(path, parmMap);
		jsonlist = Base64Util.decrypt(jsonlist);
		System.out.println(jsonlist);
	}
}
