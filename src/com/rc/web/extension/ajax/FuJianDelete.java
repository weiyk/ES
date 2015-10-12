package com.rc.web.extension.ajax;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ApplicationConfig;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
/**
 * <p>application name:     附件异步删除</p>
 
 * <p>application describing:异步在上传时 先删除附件</p>
 
 * 
 * @author hdx
 * @version ver 1.0
 */
public class FuJianDelete implements IAjaxService  {
	private static Log log = LogFactory.getLog(FuJianDelete.class);
	public String execute(AjaxServiceParameter param) throws Exception {
		String fjpath = param.getParameter("fjpath");//文件名
		String fjname = param.getParameter("fjname");//文件名
		String leixing=getProperties("leixing");
		String realPath = ApplicationConfig.getInstance().REAL_PATH;
		realPath = realPath.substring(0, realPath.indexOf("WEB-INF"));
		File f = new File(realPath+fjpath+"/"+fjname);
		if(!"3".equals(leixing)){
			if(f.exists()){
				f.delete();
			}
		}
		return "";
	}
	public String getProperties(String zhi) {
		String url = ApplicationConfig.getInstance().REAL_PATH+"upload.properties";
		Properties p = new Properties();
		File configFile = new File(url);
		FileInputStream inputStream = null;
		try{
			inputStream=new FileInputStream(configFile);
			p.load(inputStream);
		}catch(IOException e){
			log.error(e.getMessage());
			return null;
		}finally{
			try{				
				if(inputStream !=null)
					inputStream.close();
			}catch(Exception e){
				log.error(e.getMessage());
				return null;
			}	
		}
		return p.getProperty(zhi);
	}
}
