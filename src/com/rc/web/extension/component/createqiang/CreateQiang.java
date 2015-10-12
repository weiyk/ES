package com.rc.web.extension.component.createqiang;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ContextService;
import com.qam.framework.extension.component.impl.AbstractComponent;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;


public class CreateQiang extends AbstractComponent {
	private static final long serialVersionUID = 2181538442591154535L;
	private HttpServletRequest request;
	private static Log log = LogFactory.getLog(CreateQiang.class);
	private static HttpWebs web;
	public void createWall()throws Exception{
		request = (HttpServletRequest) this.getViewSubmit().getViewObject();
		String kechengmc = this.getParamValue("kechengmc");
		String kechengbh=this.getParamValue("kechengbh");
		String yonghubh=(String) request.getSession().getAttribute("XiTongHYBH");
		String name=(String) request.getSession().getAttribute("YONGHUXM");
		String jianquan=(String) request.getSession().getAttribute("QuanZhi");
		//kechengbh="KC20150804006";
		web= new HttpWebs();
		web.init();
		int count=getCount(kechengbh);
		if(count>0){
			deletesql(kechengbh);
			String kjid=getKongjianid(kechengbh);
			deleteWall(kjid,yonghubh,jianquan);
		}
		String wallId=getWallID(kechengmc,yonghubh,jianquan);
		String cid=getCID(yonghubh,name,jianquan);
		if(!"".equals(wallId)&&wallId!=null){
			if(!"".equals(cid)&&cid!=null){
				insertsql(kechengbh,wallId,cid);
			}
		}
	}
	private String getWallID(String kechengmc,String yonghuid,String jianquan){
		GetUrl getUrl=new GetUrl();
		String path=getUrl.getUrl("addWall_url");
		Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("title", kechengmc);
		parmMap.put("uid", yonghuid);
		parmMap.put("key", jianquan);
		String json=web.callByPost(path,parmMap);
        JSONArray array = JSONArray.fromObject("["+Base64Util.decrypt(json)+"]");
        JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        String value="";
        if("1".equals(msgCode)){
        	value=jsonObject.get("wallid").toString();
        }
        return value;
	}
	private void deleteWall(String wallid,String yonghuid,String jianquan){
		GetUrl getUrl=new GetUrl();
		String path=getUrl.getUrl("deleteWall_url");
		Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("wallid", wallid);
		parmMap.put("uid", yonghuid);
		parmMap.put("key", jianquan);
		web.callByPost(path,parmMap);
	}
	
	private String getCID(String yonghubh,String yonghuxm,String jianquan){
		GetUrl getUrl=new GetUrl();
		String path=getUrl.getUrl("TongXunL_url");
		Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("uid", yonghubh);
		parmMap.put("name", yonghuxm);
		parmMap.put("key", jianquan);
		String json=web.callByPost(path,parmMap);
        JSONArray array = JSONArray.fromObject("["+Base64Util.decrypt(json)+"]");
        JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        String value="";
        if("1".equals(msgCode)){
        	value=jsonObject.get("cid").toString();
        }
        return value;
	}
	
	private void insertsql(String kechengbh,String wallid,String cid) throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		String bianhao = this.getSeq("SEQ_KeChengKJ");
		sql.append(" insert into JK_KeChengKJTXLGX(BianHao,kechengbh,kongjianid,tongxunlid) values ('"+bianhao+"','"+kechengbh+"','"+wallid+"','"+cid+"')");
		log.debug("接口-课程空间通讯录："+sql.toString());
		this.getDataBaseAccess().execute(sql.toString());
	}
	private void deletesql(String kechengbh) throws QamFrameworkException{
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from JK_KeChengKJTXLGX where kechengbh='"+kechengbh+"'");
		log.debug("接口-课程空间通讯录："+sql.toString());
		this.getDataBaseAccess().execute(sql.toString());
	}
	private int getCount(String kechengbh) throws QamFrameworkException, SQLException{
		StringBuffer sql=new StringBuffer();
		int count=0;
		sql.append("select count(*) from JK_KeChengKJTXLGX where kechengbh='"+kechengbh+"'");
		log.debug("查询是否存在记录："+sql.toString());
		ResultSet rs = this.getDataBaseAccess().executeQuery(sql.toString());
		while(rs.next()){
			count =Integer.parseInt(rs.getString(1));
		}
		return count;
	}
	private String getKongjianid(String kechengbh) throws QamFrameworkException, SQLException{
		StringBuffer sql=new StringBuffer();
		String id="";
		sql.append("select kongjianid from JK_KeChengKJTXLGX where kechengbh='"+kechengbh+"'");
		log.debug("查询空间ID："+sql.toString());
		ResultSet rs = this.getDataBaseAccess().executeQuery(sql.toString());
		while(rs.next()){
			id =rs.getString(1);
		}
		return id;
	}
	
	/**
     * 获取应用组件 参数
     * @param param
     * @return
     * @throws Exception
     */
    private String getParamValue(String param) throws Exception{
        Object obj = this.getValue(param);
        if(obj != null){
            return obj.toString();
        }
        return null;
    }
    private String getSeq(String seqId) {
		return ContextService.lookupSequenceService().generateId(seqId);
	}
    public static void main(String[] args) {
    	DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

    	long now = System.currentTimeMillis();

    	Calendar calendar = Calendar.getInstance();
    	 calendar.setTimeInMillis(Long.parseLong("1439244318321"));

    	System.out.println(now + " = " + formatter.format(calendar.getTime()));
	}
}
