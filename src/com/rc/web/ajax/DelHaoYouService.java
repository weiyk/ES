package com.rc.web.ajax;

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
public class DelHaoYouService implements IAjaxService {
	private static Log log = LogFactory.getLog("GetCourseService");

	@Override
	public String execute(AjaxServiceParameter param) throws Exception {
		// 课程编号
		String uid = param.getParameter("uid");
		String yonghubh=(String) param.getRequest().getSession().getAttribute("XiTongHYBH");
		String key=(String) param.getRequest().getSession().getAttribute("QuanZhi");
		HttpWebs web = new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("DeleteHY_url");
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("oid", uid);
		parmMap.put("uid", yonghubh);
		parmMap.put("key", key);
		String json=web.callByPost(url, parmMap);
		JSONArray array = JSONArray.fromObject("[" + Base64Util.decrypt(json) + "]");
		JSONObject jsonObject = array.getJSONObject(0);
		String msgCode = jsonObject.get("msgCode").toString();
		String ret="";
		if("0".equals(msgCode)){
			ret="删除失败！";
		}
		return ret;
	}
	public static void main(String[] args) {
		HttpWebs web = new HttpWebs();
		web.init();
		String url="http://118.26.134.24/jymis/szxx/friend/removeFriend.do";
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("oid", "1441792");
		parmMap.put("uid", "1441793");
		parmMap.put("key", "4165D738045934A0D8F2DCF5E6DE08FC624E348B");
		String json=web.callByPost(url, parmMap);
	}
	public String getYongHuBH(String loginId) throws SQLException {
		StringBuffer sql = new StringBuffer();
		String yonghubh = "";
		sql.append("select bianhao from xt_yonghu where loginId='"
				+ loginId + "'");
		log.debug("查询用户编号：" + sql.toString());
		ResultSet rs = null;
		IDataBaseAccess dba=null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				yonghubh = rs.getString(1);
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
		return yonghubh;
	}
}
