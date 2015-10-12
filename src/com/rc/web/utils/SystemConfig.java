package com.rc.web.utils;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.janino.Java.NewAnonymousClassInstance;

import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.util.CommonUtils;
/**
 * 
 * <p>application name:      文件上传路径</p>
 
 * <p>application describing:文件上传路径</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class SystemConfig {
	private static Log log = LogFactory.getLog(SystemConfig.class);
	public static List<String> tList = new ArrayList<String>(10);
	public static List<String> sList = new ArrayList<String>(10);
	static{
		tList.add("GNDH_JiaoXueKJ");
		tList.add("GNDH_JiaoXueZB");
		tList.add("GNDH_JiaoShiFZ");
		tList.add("GNDH_YingYongZX");
		tList.add("GNDH_JiaoXueGZS");
		tList.add("GNDH_ZiYuanZX");
		tList.add("GNDH_LaoShiGRKJ");
		tList.add("GNDH_ChaKanJA");
		tList.add("GNDH_JiaoXueJHCX");
		tList.add("GNDH_JiaoXueSP");
		tList.add("GNDH_KaiShiBK");
		tList.add("GNDH_KeChengLB");
		tList.add("GNDH_KeChengNR");
		tList.add("GNDH_KeQianDX");
		tList.add("GNDH_QuanBuKC");
		tList.add("GNDH_XueXiZY");
		tList.add("GNDH_XueXiHD");
		tList.add("GNDH_XueXiMB");
		tList.add("GNDH_YuLanKC");
		tList.add("GNDH_JiaoXueJHTJ");
		//学生
		sList.add("GNDH_XueShengKJ");
		sList.add("GNDH_XueYiXue");
		sList.add("GNDH_DuYiDu");
		sList.add("GNDH_LianYiLian");
		sList.add("GNDH_CeYiCe");
		sList.add("GNDH_XueShengGRKJ");
	}
	private static final String CONFIGPATH=ApplicationConfig.getInstance().REAL_PATH+"/rc-config.properties";
	private static Properties PROPERTIES = null;
	private static final String TITLEKEY="title";
	private static final String LOGINIMAGEKEY="login.image.path";
	private static final String LOGOIMAGEKEY="logo.image.path";
	private static final String CORPRATIONKEY="copyright.corpration.name";	
	private static final String COPYRIGHTGANGE = "copyright.corpration.range";
	private static final String DEFAULT_TITLE="&#x4F01;&#x4E1A;&#x5173;&#x8054;&#x4EA4;&#x6613;&#x5BA1;&#x67E5;&#x5E73;&#x53F0;";
	private static final String DEFAULT_LOGO_PATH="/common/skins/default/erqi/images/logo.jpg";
	private static final String DEFAULT_LOGIN_PATH="common/skins/default/images/login_bj.jpg";
	private static final String DEFAULT_COPYRIGHT_CORPATION="XXXXXX";
	private static final String DEFAULT_COPYRIGHT_RANGE = "2012-2014";
	private static final String RC_UPLOAD_PATHC = "rc.upload.path";//文件上传路径
	private static final String RC_UPLOAD_DR_PATHC = "rc.upload.dr.path";//文件上传路径
	private static final String RC_PROCESS_PATH = "rc.process.path";//流程图片存放路径
	private static final String RC_WORKFLOW_FILES = "workFlowFiles";
	private static long LAST_MODIFY_TIME =0;
	public static String getTitle(){
		return (String)convertNullValue(loadProperties().getProperty(TITLEKEY),DEFAULT_TITLE);
	}
	public static String getLoginImagePath(){
		return (String)convertNullValue(loadProperties().getProperty(LOGINIMAGEKEY),DEFAULT_LOGIN_PATH);
	}
	public static String getLogoImagePath(){
		return (String)convertNullValue(loadProperties().getProperty(LOGOIMAGEKEY),DEFAULT_LOGO_PATH);
	}
	public static String getUploadPath(){
		return (String) convertNullValue(loadProperties().getProperty(RC_UPLOAD_PATHC), "upload");
	}
	
	public static String getUploadDRPath(){
		return (String) convertNullValue(loadProperties().getProperty(RC_UPLOAD_DR_PATHC), "excel");
	}
	public static String getWorkFlowFiles(){
		return (String) convertNullValue(loadProperties().getProperty(RC_WORKFLOW_FILES), "workFlowFiles");
	}
	public static String getProcessImgPath(){
		return (String) convertNullValue(loadProperties().getProperty(RC_PROCESS_PATH), "processImg");
	}
	public static String getCorprationName(){
		return (String)convertNullValue(loadProperties().getProperty(CORPRATIONKEY),DEFAULT_COPYRIGHT_CORPATION);
	}
	public static String getRange(){
		return (String)convertNullValue(loadProperties().getProperty(COPYRIGHTGANGE),DEFAULT_COPYRIGHT_RANGE);
	}
	private static Object convertNullValue(Object source,Object defaultValue){
		return source ==null?defaultValue:source;
	}
	public static String getValue(String key){
		return loadProperties().getProperty(key);
	}
	/**
	 * 获取单位预算事项sql对应字段id(ShiXiangBH[事项编号],ShiXiangBM[事项编码],ShiXiangMC[事项名称],ShangJiBH[上级事项编号],GuanKongLX[事项管控类型],Self[是否允许自定义],GuanLiZZBH[单位编号])
	 * @param danWeiBH 预算单位
	 * @param ysnd 预算年度
	 * @return
	 */
	public static String getDanWeiNBYSSXSql(String danWeiBH,String ysnd){
		if(CommonUtils.null2Blank(ysnd).length() == 0) return "";
		if(CommonUtils.null2Blank(danWeiBH).length() == 0){
			danWeiBH = "{P}";
		}
		StringBuffer sql = new StringBuffer(128);
		sql.append("(SELECT DISTINCT T1.* FROM (SELECT SX.ANSHANGJIYSPFSXE ANSHANGJIYSPFSXE,SX.BianHao ShiXiangBH,SHIXIANGBM, SHIXIANGMC,SHANGJIBH,GuanKongLX,DWSX.SHIFIUYXZDYJFZCJG SELF,");
		sql.append("NEIBUYSSXBH,GUANLIZZBH,ShiFouDC,BeiZhu,ZhuangTai,NianDu,JiCi FROM YSPZ_NEIBUYSSX SX LEFT JOIN YSPZ_DANWEINBYSSX DWSX ON SX.BIANHAO = DWSX.NEIBUYSSXBH  ");
		sql.append("	AND DWSX.GUANLIZZBH = '").append(danWeiBH).append("' WHERE SX.NianDu=").append(ysnd).append(" AND SX.ZHUANGTAI = '0') T1 CONNECT BY PRIOR T1.SHANGJIBH = T1.ShiXiangBH ");
		sql.append(" START WITH ShiXiangBH = T1.NEIBUYSSXBH  ORDER SIBLINGS BY T1.ShiXiangBH)");
		return sql.toString();
	}
	public static Properties loadProperties(){
		FileInputStream stream=null;
		try{
			File configFile = new File(CONFIGPATH);
			long currentTime = configFile.lastModified();
			if(currentTime ==LAST_MODIFY_TIME && PROPERTIES!=null)
				return PROPERTIES;				
			LAST_MODIFY_TIME = currentTime;
			PROPERTIES = new Properties();
			stream = new FileInputStream(configFile);
			PROPERTIES.load(stream);		
			
		}catch(IOException e){
//			e.printStackTrace();
			log.error(e.getMessage());
		}finally{
			try{				
				if(stream !=null)
					stream.close();
			}catch(Exception e){
				e.printStackTrace();
			}			
		}
		return PROPERTIES;
	}	
	public static long getLastModifyTime(){
		return LAST_MODIFY_TIME;			
	}
	/*public static final String getApplicationAuthenticationValidateType(){
		return SystemConfig.getValue(ApplicationAuthenticationValidator.TYPE_KEY);
	}*/
	/**
	public static void main(String[] args){
		long t = 40576;
		long tt = t*24*60*60*1000;
		Calendar ca = Calendar.getInstance();
		ca.setTimeInMillis(tt);
		int year = ca.get(Calendar.YEAR) -70;
		int day = ca.get(Calendar.DAY_OF_YEAR)-1;
		ca.set(Calendar.YEAR, year);
		ca.set(Calendar.DAY_OF_YEAR, day);
		
		Date dd = ca.getTime();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(df.format(dd));
		System.out.println(df.format(ca.getTime()));
	}
	*/
}