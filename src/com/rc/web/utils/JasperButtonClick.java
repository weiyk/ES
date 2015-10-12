package com.rc.web.utils;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;

import com.qam.framework.context.ContextService;
import com.qam.framework.util.CommonUtils;
/**
 * 
 * <p>application name:      统计报表</p>
 
 * <p>application describing:统计报表</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class JasperButtonClick {
	public static String path = "/platform/tongjifenxi";
	private static final Log log = LogFactory.getLog(JasperButtonClick.class);
	
	public void jasperbuttonclick(
			String path,Map<String,Object> parameters,HttpServletRequest request,HttpServletResponse response,String value,String type,String filename) throws Exception{
		Connection conn = ContextService.lookupDefaultDataBaseAccess().getConnection();
		try {
			// HTML报表呈现方式
			JasperRunManager.runReportToHtmlFile(path, parameters, conn);
			// JasperRunManager.run
			// JasperExportManager.e
			// 导出文件
			if ("1".equals(value)) {
				JasperPrint jasperPrint = JasperFillManager.fillReport(path,
						parameters, conn);
				JasperUtils.HandleJasperPrinter(jasperPrint);
				JasperUtils.setWidth(jasperPrint);
				JasperUtils.export(jasperPrint, type, response, request,
						filename);
			}
		}catch(Exception e){
			e.printStackTrace();
			log.error("err:"+e.toString());
		}finally{
			conn.close();
		}
	}
	//取当前日期
	public String getDate(){
		String today = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		today = sdf.format(new java.util.Date());
		return today;
		
	}
	//获得JasperPrint对象以便打印
	public JasperPrint getJasperPrint(
			String path,Map<String,Object> parameters,HttpServletRequest request,HttpServletResponse response) throws Exception{
		Connection conn = ContextService.lookupDefaultDataBaseAccess().getConnection();
		JasperPrint jasperprint = JasperFillManager.fillReport(
			       path,parameters,conn);
		return jasperprint;
		
	}
	 
	/** 
     * Map转换String 
     *  
     * @param map 
     *            :需要转换的Map 
     * @return String转换后的字符串 
     */  
    public static String MapToString(Map<?, ?> map) {  
        StringBuffer sb = new StringBuffer();  
        // 遍历map   
        for (Object obj : map.keySet()) {  
            if (obj == null) {  
                continue;  
            }  
            Object key = obj;  
            Object value = map.get(key);  
            if (value instanceof Map<?, ?>) {  
                sb.append(key.toString() + ":"  
                        + MapToString((Map<?, ?>) value));  
                sb.append(";");  
            } else {  
                sb.append(key.toString() + ":" + value.toString());  
                sb.append(";");  
            }  
        }  
        return sb.toString().substring(0,sb.toString().length()-1);  
    }  

    /** 
     * String转换Map 
     *  
     * @param mapText 
     *            :需要转换的字符串 
     * @param KeySeparator 
     *            :字符串中的分隔符每一个key与value中的分割 
     * @param ElementSeparator 
     *            :字符串中每个元素的分割 
     * @return Map<?,?> 
     */  
    public Map<String, Object> StringToMap(String mapText) {  
    	Map<String,Object> map = null;
    	if (CommonUtils.null2Blank(mapText).length() > 0) {
			map = new HashMap<String, Object>(5);
			for (String var : mapText.split(";")) {
				String[] vars = var.split(":");	
				if(vars.length < 2) continue;
				try {
					map.put(vars[0], vars[1]);
				} catch (Exception e) {
					log.error(e.getMessage());
				}	     	
			}
		}
        return map;  
    }  

}
