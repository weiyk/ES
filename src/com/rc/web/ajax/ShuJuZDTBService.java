package com.rc.web.ajax;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ApplicationConfig;
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
public class ShuJuZDTBService implements IAjaxService {
	private static Log log = LogFactory.getLog("GetCourseService");
	private static IDataBaseAccess dba ;
	@Override
	public String execute(AjaxServiceParameter param)  {
		HttpWebs web = new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("ShuJuZD_url");
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("pageCount", "all");
		parmMap.put("count", "");
		parmMap.put("cid", getProperties("cid"));
		String json=web.callByPost(url, parmMap);
		JSONArray array = JSONArray.fromObject("[" + Base64Util.decrypt(json) + "]");
		JSONObject jsonObject = array.getJSONObject(0);
		String msgCode = jsonObject.get("msgCode").toString();
		String ret="";
		if("0".equals(msgCode)){
			ret="发布失败！";
		}else{
			try {
				dba= ContextService.lookupDefaultDataBaseAccess();
				insertJHY(jsonObject.get("result").toString());
				insertJHYXX();
			} catch (Exception e) {
				try {
					dba.rollback();
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
			}finally{
				if(dba != null){
					dba.closeConnection();
				}
			}
		}
		return ret;
	}

	private static void insertJHY(String json) throws QamFrameworkException, UnsupportedEncodingException{
		JSONArray array = JSONArray.fromObject(json);
		List<String> sqlList = new ArrayList<String>(100);
		StringBuffer sql =new StringBuffer();
		sql.append(" delete from JHY_ShuJuZD ");
		log.debug("删除信息:"+sql.toString());
		dba.execute(sql.toString());
		for(int i=0;i<array.size();i++){
			JSONObject jsonObject = array.getJSONObject(i);
			sql.delete(0, sql.length());
			sql.append("insert into JHY_ShuJuZD (dictCode,dictDesc,dictKey,dictName,id) values(");
			sql.append("'").append(jsonObject.get("dictCode").toString()).append("',");
			sql.append("'").append(jsonObject.get("dictDesc").toString()).append("',");
			sql.append("'").append(jsonObject.get("dictKey").toString()).append("',");
			sql.append("'").append(URLEncoder.encode(jsonObject.get("dictName").toString(),"utf-8")).append("',");
			sql.append("'").append(jsonObject.get("id").toString()).append("'");
			sql.append(")");
			log.debug("新增数据字典信息:"+sql.toString());
			sqlList.add(sql.toString());
		}
		dba.executeBatch(sqlList);
	}
	
	private static void insertJHYXX() throws QamFrameworkException{
		StringBuffer sql =new StringBuffer();
		sql.append(" delete from qam_jihey where  bieming in (select dictCode from JHY_ShuJuZD where dictKey  not in ( select  dictCode from JHY_ShuJuZD ))");
		log.debug("删除集合率信息:"+sql.toString());
		dba.execute(sql.toString());
		sql.delete(0, sql.length());
		sql.append("insert into qam_jihey (mingcheng,bieming,jibenlx,luojicd,jiheylx)   ");
		sql.append(" select dictDesc,dictCode,'String','20','3' from JHY_ShuJuZD where dictKey  not in ( select  dictCode from JHY_ShuJuZD ) ");
		log.debug("新增集合率信息:"+sql.toString());
		dba.execute(sql.toString());
		sql.delete(0, sql.length());
		sql.append(" delete from qam_jiheyz where  bianma in (select dictCode from JHY_ShuJuZD where dictKey  in ( select  dictCode from JHY_ShuJuZD ))");
		log.debug("删除集合率值信息:"+sql.toString());
		dba.execute(sql.toString());
		sql.delete(0, sql.length());
		sql.append("insert into qam_jiheyz (jiheylx,bianma,zhi,zhuangtai)   ");
		sql.append(" select dictKey,dictCode,dictDesc,'1' from JHY_ShuJuZD where dictKey   in ( select  dictCode from JHY_ShuJuZD ) ");
		log.debug("新增集合率值信息:"+sql.toString());
		dba.execute(sql.toString());
	}
	public String getProperties(String key){
		String url = ApplicationConfig.getInstance().REAL_PATH+"admin.properties";
		Properties p = new Properties();
		File configFile = new File(url);
		FileInputStream inputStream = null;
		try {
			inputStream=new FileInputStream(configFile);
			p.load(inputStream);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return p.getProperty(key);
	}
}
