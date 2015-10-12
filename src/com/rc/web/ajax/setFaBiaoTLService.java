package com.rc.web.ajax;

import java.net.URLEncoder;
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
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

/**
 * 发表讨论
 * @author admin
 */
public class setFaBiaoTLService implements IAjaxService {
	private static Log log = LogFactory.getLog("GetCourseService");

	@Override
	public String execute(AjaxServiceParameter param) throws Exception {
		// 课程编号
		String neirong = param.getParameter("NeiRong");
		String yonghubh=(String) param.getRequest().getSession().getAttribute("XiTongHYBH");
		String key=(String) param.getRequest().getSession().getAttribute("QuanZhi");
		String kechengbh=param.getParameter("KeChengBH");
		String kechengmc=param.getParameter("kechengmc");
		
		String wallid=getKongJianID(kechengbh);
		HttpWebs web = new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("FaTie_url");
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("title", kechengmc);
		parmMap.put("uid", yonghubh);
		parmMap.put("wallid", wallid);
		parmMap.put("content", URLEncoder.encode(neirong,"utf-8"));
		parmMap.put("key", key);
		String json=web.callByPost(url, parmMap);
		JSONArray array = JSONArray.fromObject("[" + Base64Util.decrypt(json) + "]");
		JSONObject jsonObject = array.getJSONObject(0);
		String msgCode = jsonObject.get("msgCode").toString();
		String ret="";
		if("0".equals(msgCode)){
			ret="发布失败！";
		}
		return ret;
	}
	public static void main(String[] args) {
		HttpWebs web = new HttpWebs();
		web.init();
		String url="http://118.26.134.24/jymis/szxx/space/createPost.do";
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("title", "ceshi222");
		parmMap.put("uid", "1441793");
		parmMap.put("wallid", "55c315bb6c5d3a00000000a0");
		parmMap.put("content", "4444");
		parmMap.put("key", "3C5CB9B064AE58A8B791038E28ACDDFA3C5374E6");
		String json=web.callByPost(url, parmMap);
		System.out.println(Base64Util.decrypt(json) );
	}
	public String getKongJianID(String kcbh) throws SQLException {
		StringBuffer sql = new StringBuffer();
		String kongjianid = "";
		sql.append("select KongJianID from JK_KeChengKJTXLGX where kechengbh='"
				+ kcbh + "'");
		log.debug("查询是否存在记录：" + sql.toString());
		ResultSet rs = null;
		IDataBaseAccess dba=null;
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
}
