package com.rc.web.ajax;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
public class YongHuXXTBService implements IAjaxService {
	private static Log log = LogFactory.getLog("GetCourseService");
	private static IDataBaseAccess dba ;
	private static HttpWebs web;
	@Override
	public String execute(AjaxServiceParameter param)  {
		web = new HttpWebs();
		web.init();
		String result="";
		try {
			dba= ContextService.lookupDefaultDataBaseAccess();
			setXX();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return "同步失败！";
		}
	}
	private void setXX() throws Exception{
		
		String loginIds=getProperties("loginId");
		String passwords=getProperties("password");
		String csid=getProperties("cid");
		if(loginIds.indexOf(",") != -1){
			String[] loginId=loginIds.split(",");
			String[] password=passwords.split(",");
			String[] csids=csid.split(",");
			for(int k=0;k<loginId.length;k++){
				insertXX(loginId[k],password[k],csids[k]);
				
			}
		}else{
			insertXX(loginIds,passwords,csid);
		}
		
	}
	private void insertXX(String loginId,String password ,String csid) throws Exception{
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("key_url");
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("loginId", loginId);
		parmMap.put("password", password);
		parmMap.put("cid", csid);
		String json=web.callByPost(url, parmMap);
		String uid=getUID(Base64Util.decrypt(json));
		url=getUrl.getUrl("XueXiao_url");
		parmMap = new HashMap<String, String>();
		parmMap.put("cid", uid);
		json=web.callByPost(url, parmMap);
		String sids=getSID(Base64Util.decrypt(json));
		if(!"".equals(sids)&&sids!=null){
			String[] sidlist=sids.split(",");
			for(int i =0;i<sidlist.length;i++){
				String sid=sidlist[i];
				//path="http://118.26.134.24/jymis/szxx/info/findSchoolById.do?sid="+sid;
				url=getUrl.getUrl("XueXiaoxx_url");
				parmMap = new HashMap<String, String>();
				parmMap.put("sid", sid);
				json=web.callByPost(url, parmMap);
				deleteSchool(sid);
				insertSchool(Base64Util.decrypt(json));
				//path="http://118.26.134.24/jymis/szxx/info/findClassBySchoolId.do?sid="+sid;
				url=getUrl.getUrl("BanJi_url");
				parmMap = new HashMap<String, String>();
				parmMap.put("sid", sid);
				json=web.callByPost(url, parmMap);
				String cids=getCID(Base64Util.decrypt(json));
				if(!"".equals(cids)&&cids!=null){
					String[] cidlist=cids.split(",");
					for(int j =0;j<cidlist.length;j++){
						String cid=cidlist[j];
						//path="http://118.26.134.24/jymis/szxx/relation/findClazzInfo.do?cid="+cid;
						//json =getvalue(path);
						url=getUrl.getUrl("BanJixx_url");
						parmMap = new HashMap<String, String>();
						parmMap.put("cid", cid);
						json=web.callByPost(url, parmMap);
						deleteClass(cid);
						insertClass(Base64Util.decrypt(json),sid);
					}
				}
				
			}
		}
		//path="http://118.26.134.24/jymis/szxx/space/findCustomersByChannlId.do?cid="+uid;
		url=getUrl.getUrl("yonghu_url");
		parmMap = new HashMap<String, String>();
		parmMap.put("cid", uid);
		json=web.callByPost(url, parmMap);
		insertYongHu(Base64Util.decrypt(json));
	}
	private static String getUID(String json){
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        String uid="";
        if("1".equals(msgCode)){
        	String channel=jsonObject.get("channel").toString();
        	JSONArray channel_array = JSONArray.fromObject("["+channel+"]");
        	JSONObject channelObject = channel_array.getJSONObject(0);
        	uid=channelObject.get("uid").toString();
        }
		return uid;
	}
	private static String getSID(String json){
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        String sid="";
        if("1".equals(msgCode)){
        	sid=jsonObject.get("sids").toString();
        }
        
		return sid;
	}
	private static String getCID(String json){
		json=json.replace("\"cids\":", "\"cids\":\"");
		json=json.replace("}", "\"}");
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        String cids="";
        if("1".equals(msgCode)){
        	cids =jsonObject.get("cids").toString();
        }
        
		return cids;
	}
	private void deleteSchool(String sid) throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		sql.append("delete from JCSJ_XueXiao where id='"+sid+"'");
		log.debug("删除学校学校:"+sql.toString());
		dba.execute(sql.toString());
	}
	private void insertSchool(String json) throws QamFrameworkException{
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	String school=jsonObject.get("school").toString();
        	JSONArray school_array = JSONArray.fromObject("["+school+"]");
        	List<String> sqlList = new ArrayList<String>(100);
        	for(int i=0;i<school_array.size();i++){
        		JSONObject schoolObject = school_array.getJSONObject(i);
        		StringBuffer sql=new StringBuffer();
        		sql.append("insert into JCSJ_XueXiao (id,name,linkman ,linkmanPhone,nameshort,schoolurl," +
        				"createTime ,descn ,code,manager ,phone,email ,action_note ,wallID ,telephone ," +
        				"cellphone ,region ,address ,zip ,status ,is_del ,type ,rank ,schoolclass )");
        		sql.append("values(");
        		sql.append("'").append(schoolObject.get("id").toString()).append("',");
        		sql.append("'").append(getValue(schoolObject,"name")).append("',");
        		sql.append("'").append(getValue(schoolObject,"linkman")).append("',");
        		sql.append("'").append(getValue(schoolObject,"linkmanPhone")).append("',");
        		sql.append("'").append(getValue(schoolObject,"nameshort")).append("',");
        		sql.append("'").append(getValue(schoolObject,"schoolurl")).append("',");
        		sql.append("").append(schoolObject.get("createTime").toString()).append(",");
        		sql.append("'").append(getValue(schoolObject,"descn")).append("',");
        		sql.append("'").append(getValue(schoolObject,"code")).append("',");
        		sql.append("'").append(getValue(schoolObject,"manager")).append("',");
        		sql.append("'").append(getValue(schoolObject,"phone")).append("',");
        		sql.append("'").append(getValue(schoolObject,"email")).append("',");
        		sql.append("'").append(getValue(schoolObject,"action_note")).append("',");
        		sql.append("'").append(getValue(schoolObject,"wallID")).append("',");
        		sql.append("'").append(getValue(schoolObject,"telephone")).append("',");
        		sql.append("'").append(getValue(schoolObject,"cellphone")).append("',");
        		sql.append("'").append(schoolObject.get("region").toString()).append("',");
        		sql.append("'").append(getValue(schoolObject,"address")).append("',");
        		sql.append("'").append(getValue(schoolObject,"zip")).append("',");
        		sql.append("'").append(getValue(schoolObject,"status")).append("',");
        		sql.append("'").append(getValue(schoolObject,"is_del")).append("',");
        		sql.append("'").append(getValue(schoolObject,"type")).append("',");
        		sql.append("'").append(getValue(schoolObject,"rank")).append("',");
        		sql.append("'").append(getValue(schoolObject,"schoolclass")).append("'");
        		sql.append(")");
        		log.debug("新增学校学校:"+sql.toString());
        		sqlList.add(sql.toString());
        	}
        	dba.executeBatch(sqlList);
        }
		
	}
	private String getValue(JSONObject object,String key){
		return (String) (object.get(key)==null?"":object.get(key));
	}
	private void deleteClass(String cid) throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		sql.append("delete from JCSC_BanJi where classId='"+cid+"'");
		log.debug("删除班级信息:"+sql.toString());
		dba.execute(sql.toString());
	}
	private void insertClass(String json,String sid) throws QamFrameworkException{
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	String classGrade=jsonObject.get("classGrade").toString();
        	JSONArray classGrade_array = JSONArray.fromObject("["+classGrade+"]");
        	List<String> sqlList = new ArrayList<String>(100);
        	for(int i=0;i<classGrade_array.size();i++){
        		JSONObject classGradeObject = classGrade_array.getJSONObject(i);
        		StringBuffer sql=new StringBuffer();
        		sql.append("insert into JCSC_BanJi(classId,className ,gradealias ,managerId ,managerTeacher " +
        				",stuNumber ,classType ,classWord,schoolId )");
        		sql.append("values(");
        		sql.append("'").append(classGradeObject.get("classId").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("className").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("gradealias").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("managerId").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("managerTeacher").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("stuNumber").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("classType").toString()).append("',");
        		sql.append("'").append(classGradeObject.get("classWord").toString()).append("',");
        		sql.append("'"+sid+"')");
        		log.debug("新增班级信息:"+sql.toString());
        		sqlList.add(sql.toString());
        	}
        	dba.executeBatch(sqlList);
        }
	}
	
	private void insertYongHu(String json) throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from xt_yonghu_copy ");
		log.debug("删除用户信息:"+sql.toString());
		dba.execute(sql.toString());
		JSONArray array = JSONArray.fromObject("["+json+"]");
		JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	String custoemrs=jsonObject.get("custoemrs").toString();
        	JSONArray custoemrs_array = JSONArray.fromObject(custoemrs);
        	List<String> sqlList = new ArrayList<String>(100);
        	for(int i=0;i<custoemrs_array.size();i++){
        		JSONObject custoemrsObject = custoemrs_array.getJSONObject(i);
        		sql.delete(0, sql.length());
        		sql.append("insert into xt_yonghu_copy(BIANHAO,DENGLUM ,XINGMING ,KOULING ,zhuangtai," +
        				"loginId,email,mobile,sex,birthday,regionID,image,classIds,type)");
        		sql.append("values(");
        		sql.append("'").append(custoemrsObject.get("id").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("name").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("name").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("password").toString()).append("',");
        		sql.append("'1',");
        		sql.append("'").append(custoemrsObject.get("loginId").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("email").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("mobile").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("sex").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("birthday")==null?"":custoemrsObject.get("birthday")).append("',");
        		sql.append("'").append(custoemrsObject.get("regionID")==null?"":custoemrsObject.get("regionID")).append("',");
        		//sql.append("'").append(custoemrsObject.get("descn").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("image").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("classIds").toString()).append("',");
        		sql.append("'").append(custoemrsObject.get("type").toString()).append("'");
        		sql.append(")");
        		log.debug("新增用户信息:"+sql.toString());
        		sqlList.add(sql.toString());
        	}
        	dba.executeBatch(sqlList);
        	updateYongHu();
        }
	}
	private void updateYongHu() throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		sql.append("update xt_yonghu a ,xt_yonghu_copy b set a.DENGLUM=b.DENGLUM, ");
		sql.append(" a.XINGMING=b.XINGMING ,");
		sql.append("a.KOULING=b.KOULING, ");
		sql.append("a.loginId=b.loginId,");
		sql.append("a.email=b.email,");
		sql.append("a.mobile=b.mobile,");
		sql.append("a.sex=b.sex,");
		sql.append("a.birthday=b.birthday,");
		sql.append("a.regionID=b.regionID,");
		sql.append("a.image=b.image,");
		sql.append("a.classIds=b.classIds,a.type=b.type");
		sql.append(" where a.BIANHAO=b.BIANHAO");
		log.debug("修改用户信息:"+sql.toString());
		dba.execute(sql.toString());
		sql.delete(0, sql.length());
		sql.append("insert into xt_yonghu select * from xt_yonghu_copy where bianhao not in (select bianhao from xt_yonghu) ");
		log.debug("新增用户信息:"+sql.toString());
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
