package com.rc.web.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;


import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.artofsolving.jodconverter.document.DefaultDocumentFormatRegistry;
import org.artofsolving.jodconverter.document.DocumentFormat;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;



import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.util.CommonUtils;
/**
 * flexpager工具类
 * @author Administrator
 *
 */
public class FlexPagerUtils {
	private static final Log log = LogFactory.getLog(FlexPagerUtils.class);
	static Properties PROPERTIES;
	private static String DEFULAT_HOST = "127.0.0.1";
	private static String DEFULAT_PORT = "8100";
	static final String CONFIGPATH = ApplicationConfig.getInstance().REAL_PATH + "/flexpaper.properties";
	private static OfficeManager officeManager;
	static String OS="";
	private static Process PROCESS;
	static {
		FileInputStream stream = null;
		try {
			File configFile = new File(CONFIGPATH);
			PROPERTIES = new Properties();
			stream = new FileInputStream(configFile);
			PROPERTIES.load(stream);
			OS = System.getProperty("os.name");
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			try {
				if (stream != null)
					stream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 启动openoffice服务
	 * @throws IOException 
	 */
	public static void runOpenOfficeService() throws IOException{
		if(PROCESS != null) return;
		Runtime r = Runtime.getRuntime();
		Object host = getHost();
		Object port = getPort();
		StringBuffer cmd = new StringBuffer("");
		cmd.append("\""+PROPERTIES.get("libreOfficeProgram"));
		if(OS.startsWith("Windows")){
			cmd.append("\\soffice.exe\" -headless -accept=\"socket,host=");
			cmd.append(host).append(",port=").append(port).append(";urp;\" -nofirststartwizard ");
		}else if(OS.startsWith("Linux")){
			cmd.append(" ./soffice \"-accept=socket,host=").append(host).append(",port=").append(port).append(";urp;StarOffice.ServiceManager\" -nologo -headless -nofirststartwizard &");
		} else if (OS.startsWith("Mac OS X")) {
			
		}
		log.debug(cmd);
		PROCESS = r.exec(cmd.toString().replaceAll("\\\\", "/"));
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(PROCESS.getInputStream()));
		String line = null;
		while ((line = bufferedReader.readLine()) != null){
			try {
			  log.debug("openoffice:"+line);
			} catch (Exception e) {
			 log.error(e.getMessage());
			}
		}
	}
	/**
	 * 3.0开启服务
	 */
	public static void startService(){
		DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
		try {
			log.debug("=====6");
			configuration.setOfficeHome(getOfficeHome());
			log.debug("=====7");
			configuration.setPortNumbers(getPort());
			log.debug("=====8");
			configuration.setTaskExecutionTimeout(1000*60*2L);//设置任务执行超时为5分钟
			configuration.setTaskQueueTimeout(1000*60*60*5L);//设置任务队列超时为24小时
			officeManager = configuration.buildOfficeManager();
			log.debug("=====9"); 
			officeManager.start();
			log.debug("=====10");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 停止服务
	 */
	public static void stopService(){
		if(officeManager != null){
			officeManager.stop();
			officeManager = null;
		}
	}
	/**
	 * 转换方法
	 * @param inputFile
	 * @param outputFile
	 * @throws Exception
	 */
	public static boolean convert2PDF(String inputFile,String outputFile){
		log.debug("=====1");
		String fileName = FilenameUtils.getFullPath(inputFile)+FilenameUtils.getBaseName(inputFile);
		String extension = FilenameUtils.getExtension(inputFile);
		if(CommonUtils.null2Blank(extension).length() <= 0) return false;
		log.debug("=====2");
		File odt = null;
		if("pdf".equalsIgnoreCase(extension)) return true;//若为pdf则直接转swf。
		log.debug("=====3");
		try{
			if(getDocumentFormat(extension) == null){
				return false;
			}
			log.debug("=====4");
			if("txt".equalsIgnoreCase(extension) ){
				String odtFile = fileName+".odt";
				if(OS.contains("Linux")){
					Runtime r = Runtime.getRuntime();
					String projectPath=PROPERTIES.get("projectPath").toString();
					Process p = r.exec(projectPath+"/WEB-INF/iconv_shell.sh "+ inputFile.replaceAll("\\\\", "/") + " "+ odtFile.replaceAll("\\\\", "/"));
					log.debug("iconv -f gb2312 -t utf-8 "+ inputFile.replaceAll("\\\\", "/") + " > "+ odtFile.replaceAll("\\\\", "/"));
					BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(p.getInputStream()));
					String line = null;
					while ((line = bufferedReader.readLine()) != null){
						try {
						  log.debug("openoffice:"+line); 
						} catch (Exception e) {
						 log.error(e.getMessage());  
						}
					}
					inputFile = odtFile;
				}else{
					odt = new File(odtFile);
					if(odt.exists()){
						inputFile = odtFile;
					}else{
						FileUtils.copyFile(new File(inputFile), odt);
						inputFile = odtFile;
					}
				}
			}
			log.debug("=====5");
			//startService();
			log.debug("=====11"); 
			//OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
			log.debug("=====12"+inputFile+"==="+outputFile);
			//converter.convert(new File(inputFile), new File(outputFile));
			office2PDF(inputFile,outputFile);
			log.debug("=====13"); 
			//stopService();  
			log.debug("=====14");   
			return true;
		}catch(Exception e){
			log.error(e.getMessage());
			return false;
		}finally{ 
			if(odt!= null && odt.exists()) odt.delete();
			//stopService();  
		}
	}
	/** 
	      * 将Office文档转换为PDF. 
	      * @param sourceFile 
	      *            源文件, 绝对路径. 可以是Office2003-2007全部格式的文档, Office2010的没测试. 包括.doc, 
	      *            .docx, .xls, .xlsx, .ppt, .pptx等. 示例: F:\\office\\source.doc 
	      * @param destFile 
	      *            目标文件. 绝对路径. 示例: F:\\pdf\\dest.pdf 
	      * @return 操作成功与否的提示信息. 如果返回 -1, 表示找不到源文件, 或url.properties配置错误; 如果返回 0, 
	      *         则表示操作成功; 返回1, 则表示转换失败 
	      */  
	     public static void office2PDF(String sourceFile, String destFile) {  
	         try {  
	        	 //根据下载的本地文件转换PDF
	             File inputFile = new File(sourceFile);  
	             if (!inputFile.exists()) {  
	            	 log.error("找不到源文件>"+inputFile);// 找不到源文件
	             }  
	             // 如果目标路径不存在, 则新建该路径  
	             File outputFile = new File(destFile);  
	             if (!outputFile.getParentFile().exists()) {  
	                 outputFile.getParentFile().mkdirs();  
	             }  
	             //执行转换pdf命令 
	             StringBuffer command = new StringBuffer("");
	     		if(OS.startsWith("Windows")){
	     			command.append("\""+PROPERTIES.get("libreOfficeProgram"));
	     			command.append("\\soffice.exe\" --headless --invisible  --convert-to pdf ");
	     			command.append(sourceFile);
	     			command.append(" --outdir ");
	     			command.append(destFile.substring(0,destFile.lastIndexOf("\\")));
	     		}else if(OS.startsWith("Linux")){
	     			command.append("soffice --headless --invisible  --convert-to pdf ");
	     			command.append(sourceFile);
	     			command.append(" --outdir "); 
	     			command.append(destFile.substring(0,destFile.lastIndexOf("/")));
	     		} 
	             log.debug("转换pdf命令："+command.toString());
	             Process pro = Runtime.getRuntime().exec(command.toString());  
	             BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(pro.getInputStream()));
					String line = null;
					while ((line = bufferedReader.readLine()) != null){
						try {
						  log.debug("libreffice:"+line); 
						} catch (Exception e) {
						 log.error(e.getMessage());  
						} 
					}
	             pro.destroy();  
	         } catch (ConnectException e) {  
	             e.printStackTrace(); 
	             log.error(e.getMessage()); 
	         } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				log.error(e.getMessage()); 
			} 
	     }  

	/**
	 * 消除进程方法
	 */
	public static void destory(){
		if(PROCESS != null){
			PROCESS.destroy();
			PROCESS = null;
		}
	}
	/**
	 * 根据文件类型获取SWFTools 转换PDF命令
	 * @param 文件类型
	 * @return
	 */
	public static String getSWFToolsCMD(String type){
		StringBuffer cmd = new StringBuffer();
		if(OS.startsWith("Windows")){
			cmd.append("\""+PROPERTIES.getProperty("SWFToolsFolder"));
		}
		if(".JPEG".equalsIgnoreCase(type)){
			cmd.append(OS.startsWith("Windows") ? "/jpeg2swf.exe\" -T 9 " : (OS.startsWith("Linux") ? " jpeg2swf -T 9 " : ""));
		}else if(".GIF".equalsIgnoreCase(type)){
			cmd.append(OS.startsWith("Windows") ? "/gif2swf.exe\" " : (OS.startsWith("Linux") ? " gif2swf " : ""));
		}else if(".PNG".equalsIgnoreCase(type)){
			cmd.append(OS.startsWith("Windows") ? "/png2swf.exe\" -T 9 " : (OS.startsWith("Linux") ? " png2swf -T 9 " : ""));
		}else if(".PDF".equalsIgnoreCase(type)){
			cmd.append(OS.startsWith("Windows") ? "/pdf2swf.exe\" " : (OS.startsWith("Linux") ? "pdf2swf -s languagedir="+PROPERTIES.getProperty("languagedir")+" " : ""));
		}
		return cmd.toString();
	}
	/**
	 * 获取服务器地址
	 * @return
	 */
	public static String getHost(){
		return PROPERTIES.getProperty("serverName",DEFULAT_HOST); 
	}
	public static String getOfficeHome(){
		return PROPERTIES.getProperty("libreOfficeProgram");
	}

	/**
	 * 获取端口
	 * @return
	 */
	public static int getPort(){
		return Integer.parseInt(PROPERTIES.getProperty("port", DEFULAT_PORT));
	}
	/**
	 * 根据后缀名获取类型
	 * @param extension
	 * @return
	 */
	public static DocumentFormat getDocumentFormat(String extension){
		return new DefaultDocumentFormatRegistry().getFormatByExtension(extension);
	}
	
	/**

	 * 下载zip文件
	 * 返回zip的文件路径
	 */
	public String downLoadFileSaveLocal(String remoteFilePath, String localFilePath) {
		int bytesum = 0;
		int byteread = 0;
		BufferedInputStream inStream = null;
		FileOutputStream fs = null;
		HttpURLConnection conn=null;
		String downloadURL=localFilePath;
		if(OS.startsWith("Linux")){
			downloadURL=downloadURL.replaceAll("\\\\","/"); 
		}
		// 如果目标路径不存在, 则新建该路径  
        File outputFile = new File(downloadURL);  
        if (!outputFile.getParentFile().exists()) {  
            outputFile.getParentFile().mkdirs();  
        } 
		try {
			URL url = new URL(remoteFilePath);
			conn = (HttpURLConnection)url.openConnection();
			conn.setConnectTimeout(30000);  
			conn.setReadTimeout(30000); 
			conn.connect();
			inStream = new BufferedInputStream(conn.getInputStream());
			fs = new FileOutputStream(downloadURL);
			byte[] buffer = new byte[4028];
			while ((byteread = inStream.read(buffer)) != -1) {
				bytesum += byteread;
				fs.write(buffer, 0, byteread);
			}
			fs.flush();
			fs.close();
			conn.disconnect();
			log.debug("downLoadFileSaveLocal");
			log.debug("remoteFilePath:"+remoteFilePath);
			log.debug("localFilePath:"+localFilePath);
			log.debug("文件下载成功.....");
		} catch (Exception e) {
			e.printStackTrace(); 
			log.debug("下载异常:"+e.getMessage());
			return "您访问的资源不存在，请查看其他资源！";
		} finally {
			try {
				if (inStream != null) {
					inStream.close();
				}
			} catch (IOException e) {
				inStream = null;
			}
			try {
				if (fs != null) {
					fs.flush();
					fs.close();
				}
			} catch (IOException e) {
				fs = null;
			}
			if (conn != null) {
				conn.disconnect();
			}
		}
		return downloadURL;

	}
	public static void main(String[] args) {
		FlexPagerUtils ss=new FlexPagerUtils();
		ss.downLoadFileSaveLocal("http://localhost:8080/eschool/upload/teacher/ziyuankejian/WJ201508210005.docx","f:\\123.doc");
	}
}
