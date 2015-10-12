package com.qam.web.extension.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.SftpException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.web.facade.servlet.BaseServlet;

/**
 * 
 * <p>
 * application name: 附件下载
 * </p>
 * 
 * <p>
 * application describing:附件下载
 * </p>
 * 
 * 
 * @author zhou
 * @version ver 1.0
 */
public final class DoDownloadServlet extends BaseServlet {
	private static final Log log = LogFactory.getLog(DoDownloadServlet.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 816577451190200012L;

	/**
	 * Constructor of the object.
	 */
	public DoDownloadServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred 
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fname = request.getParameter("filePath");
		String sftpName = request.getParameter("fileName"); 
		sftpName=new String(sftpName.getBytes("ISO-8859-1"), "UTF-8");   
		log.info("准备下载文件：fname=" + fname+"   sftpName="+sftpName);
		try {
			String fileName = sftpName;//fname.substring(fname.lastIndexOf("/") + 1);
			
			String path = ApplicationConfig.getInstance("/").REAL_PATH;
			path = path.substring(0, path.indexOf("WEB-INF"));
			String agent = request.getHeader("User-Agent");
			if (agent.toLowerCase().indexOf("firefox") > 0)
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");// firefox浏览器
			else if (agent.toUpperCase().indexOf("MSIE") > 0){
				fileName = URLEncoder.encode(fileName, "UTF-8");// IE浏览器
				fileName = fileName.replace("+", "%20");
			}else{// IE11浏览器及其他浏览器
				fileName = URLEncoder.encode(fileName, "UTF-8");
				fileName = fileName.replace("+", "%20");
			}
			response.reset();
			response.setContentType("application/x-download charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ fileName + "\"");  
			response.setHeader("Connection", "close");

			if (sftpName == null || "".equals(sftpName)||"pl".equals(sftpName)) {
				fileName = fname.substring(fname.lastIndexOf("/") + 1);
			} else {
				fileName = sftpName;
			}
			String ftpname = fname.substring(0, fname.lastIndexOf("/") + 1);
			String ul = ApplicationConfig.getInstance("/").REAL_PATH;
			File file_url = new File(ul);
			ul = file_url.getParent().substring(
					file_url.getParent().lastIndexOf("\\") + 1);
			Boolean bool = true;
			String leixing = getProperties("leixing");
			if (!"pl".equals(sftpName)) {
				if (fname.toString().indexOf(String.valueOf("upload")) != -1) {
					if ("1".equals(leixing)) {
						SFTPChannel channel = new SFTPChannel();
						ChannelSftp chSftp = channel.getChannel(6000);
						if (chSftp != null) {
							bool = downloadFile(ul + "/" + ftpname, path
									+ ftpname, fileName, chSftp);
							channel.closeChannel();
						}
					} else if ("2".equals(leixing)) {
						bool = FtpUpload.downFile(getProperties("localhost"),
								Integer.parseInt(getProperties("port")),
								getProperties("ursrname"),
								getProperties("password"), ul + "/" + ftpname,
								fileName, path + ftpname);
					}
				}
			}
			if (bool == true) {
				//远程下载知了树资源开始
				if (fname.toString().indexOf(String.valueOf(request.getSession().getAttribute("imgUrl"))) != -1) {
					downloadFile(fname,fileName,request,response);  
				}
				//远程下载知了树资源结束
				else{
					//下载本地资源
					ServletOutputStream sos = response.getOutputStream();
					FileInputStream fis = null;
					File file = new File(path + fname);
					if (file.exists()) {
						fis = new FileInputStream(path + fname);
						byte b[] = new byte[1000]; // 输入流的读取速率
						int j;
						while ((j = fis.read(b)) != -1) {
							try {
								sos.write(b, 0, j);
							} catch (IOException exp) {
								log.error("文件流写入错误", exp);
							}
						}
						fis.close();
						sos.flush();
						sos.close();
					}
				}

			}
			log.info("文件下载完成");
		} catch (Exception e) {
			log.error("文件下载异常", e);
		}

	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

	/**
	 * 下载单个文件
	 * 
	 * @param remotPath
	 *            远程下载目录(以路径符号结束)
	 * @param localPath
	 *            本地保存目录(以路径符号结束)
	 * @param localFileName
	 *            保存文件名
	 * @return
	 */
	public boolean downloadFile(String remotePath, String localPath,
			String localFileName, ChannelSftp chSftp) {
		try {
			chSftp.cd(remotePath);
			File file = new File(localPath + localFileName);
			mkdirs(localPath + localFileName);
			FileOutputStream us=new FileOutputStream(file);
			chSftp.get(localFileName, us);
			us.close();
			return true;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (SftpException e) {
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 如果目录不存在就创建目录
	 * 
	 * @param path
	 */
	public void mkdirs(String path) {
		File f = new File(path);

		String fs = f.getParent();

		f = new File(fs);

		if (!f.exists()) {
			f.mkdirs();
		}
	}

	public String getProperties(String zhi) {
		String url = ApplicationConfig.getInstance().REAL_PATH
				+ "upload.properties";
		Properties p = new Properties();
		File configFile = new File(url);
		FileInputStream inputStream = null;
		try {
			inputStream = new FileInputStream(configFile);
			p.load(inputStream);
		} catch (IOException e) {
			log.error(e.getMessage());
			return null;
		} finally {
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (Exception e) {
				log.error(e.getMessage());
				return null;
			}
		}
		return p.getProperty(zhi);
	}
	/**  
    * 下载远程文件并保存到本地  
    * @param remoteFilePath 远程文件路径   
    */
   public void downloadFile(String remoteFilePath, String name,HttpServletRequest request,HttpServletResponse response)throws Exception
   {
	   //下载文件重命名
	   String rname=name+remoteFilePath.substring(remoteFilePath.lastIndexOf("."));
	   //根据浏览器转码
	   log.debug("--------------------"+rname);
	   String agent = request.getHeader("User-Agent");
		if (agent.toLowerCase().indexOf("firefox") > 0)
			rname = new String(rname.getBytes("UTF-8"), "ISO-8859-1");// firefox浏览器
		else if (agent.toUpperCase().indexOf("MSIE") > 0){
			rname = URLEncoder.encode(rname, "UTF-8");// IE浏览器
			rname = rname.replace("+", "%20");
		}else{// IE11浏览器及其他浏览器
			rname = URLEncoder.encode(rname, "UTF-8");
			rname = rname.replace("+", "%20");
		}
		log.debug("===================="+rname);  
	   //设置下载文件参数  
	   response.reset(); 
	   response.setCharacterEncoding("UTF-8");
	   response.setContentType("application/x-download charset=UTF-8"); 
	   response.setHeader("Content-Disposition", "attachment;filename=\""+ rname + "\"");
	   response.setHeader("Connection", "close"); 
       URL urlfile = null;
       HttpURLConnection httpUrl = null;
       BufferedInputStream bis = null;
       ServletOutputStream bos = null;
       try
       {
           urlfile = new URL(remoteFilePath);
           httpUrl = (HttpURLConnection)urlfile.openConnection();
           httpUrl.connect();
           bis = new BufferedInputStream(httpUrl.getInputStream());
           bos = response.getOutputStream();
           int len = 2048;
           byte[] b = new byte[len];
           while ((len = bis.read(b)) != -1)
           {
               bos.write(b, 0, len);
           }
           bos.flush();
           bis.close();
           httpUrl.disconnect();
       }
       catch (Exception e)
       {
           e.printStackTrace();
       }
       finally
       {
           try
           {
               bis.close();
               bos.close();
           }
           catch (IOException e)
           {
               e.printStackTrace();
           }
       }
   }
}
