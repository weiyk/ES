package com.qam.web.extension.servlet;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.log4j.Logger;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelSftp.LsEntry;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.servlet.BaseServlet;
/**
 * 
 * <p>application name:      附件上传的servlet</p>
 
 * <p>application describing:附件上传的servlet</p>
 * 
 * @author zhou
 * @version ver 1.0
 */
public final class DoUploadServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	private Logger log = Logger.getLogger(DoUploadServlet.class);

	private static final String FILE_EXISTED_ACTION_OVERRIDE = "override";

	private static final String FILE_EXISTED_ACTION_ALERT = "alert";

	/**
	 * Constructor of the object.
	 */
	public DoUploadServlet() {
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
		doPost(request, response);
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
	 * @throws IOException
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		String msg = "";// 返回信息
		int flag = 1;
		response.setContentType(CONTENT_TYPE);

		long maxFileSize = 0;// 单个文件大小控制
		if (request.getParameter("maxFileSize") != null
				&& request.getParameter("maxFileSize").length() > 0) {
			maxFileSize = Long.parseLong(request.getParameter("maxFileSize"));
		}

		long totalMaxFileSize = 0;// 文件大小总控
		if (request.getParameter("totalMaxFileSize") != null
				&& request.getParameter("totalMaxFileSize").length() > 0) {
			totalMaxFileSize = Long.parseLong(request
					.getParameter("totalMaxFileSize"));// 单个文件大小控制
		}

		String allowedFilesList = CommonUtils.null2Blank(request
				.getParameter("allowedFilesList"));// 允许上传的文件
		String deniedFilesList = CommonUtils.null2Blank(request
				.getParameter("deniedFilesList"));// 禁止上传的文件
		String filerename = CommonUtils.null2Blank(request
				.getParameter("fileRename")); // 指定的文件重命名
		String folderPath = CommonUtils.null2Blank(request
				.getParameter("folderPath")); // 指定的文件路径
		String fileExistedAction = CommonUtils.null2Blank(request
				.getParameter("fileExistedAction")); // 文件存在后的处理,有效值
		String sftpName = CommonUtils.null2Blank(request
				.getParameter("SFTPname")); // 上传到sftp的文件名
		if(sftpName==null||"".equals(sftpName)){
			sftpName=filerename;
		}else{
			sftpName=sftpName.substring(sftpName.lastIndexOf("FJ"));
		}
		String fileName = "";// 最终保存的文件名
		String filePath = "";// 最终保存的文件路径

		PrintWriter out = null;
		try {
			out = response.getWriter();

			SmartUpload su = new SmartUpload();
			// 初始化jsp页面
			// su.initialize(pageContext);

			su.initialize(this.getServletConfig(), request, response);

			// 设定上传限制
			// 1.限制每个上传文件的最大长度。
			if (maxFileSize > 0) {
				su.setMaxFileSize(maxFileSize);
			}
			// 2.限制总上传数据的长度。
			if (totalMaxFileSize > 0) {
				su.setTotalMaxFileSize(totalMaxFileSize);
			}

			// 3.设定允许上传的文件（通过扩展名限制）,例如允许doc,txt文件。
			if (!"".equals(allowedFilesList)) {
				// su.setAllowedFilesList(allowedFilesList.toLowerCase()+","+allowedFilesList.toUpperCase());
			}
			// 4.设定禁止上传的文件（通过扩展名限制）,例如禁止上传带有exe,bat,jsp,htm,html扩展名的文件和没有扩展名的文件。
			if (!"".equals(deniedFilesList)) {
				// su.setDeniedFilesList(deniedFilesList);
			}
			// 上传文件数据
			su.upload();

			fileName = su.getFiles().getFile(0).getFileName();
			if (folderPath.length() > 0) {
				if (folderPath.startsWith("/")) {
					folderPath = folderPath.substring(1);
				}
				if (folderPath.endsWith("/")) {
					folderPath = folderPath.substring(0,
							folderPath.length() - 1);
				}

			} else {
				folderPath = "upload";
			}

			java.io.File forder = new java.io.File(this.getServletContext()
					.getRealPath(folderPath));
			if (!forder.exists())// 临时目录不存在
			{
				forder.mkdirs();
				su.save(folderPath);
				msg = "上传文件成功!";

			} else// 临时目录tmp已经创建
			{
				String[] fileList = forder.list();
				for (int i = fileList.length - 1; i >= 0; i--) {
					if (fileList[i].equals(fileName)
							|| fileList[i].equals(filerename)) {
						if (FILE_EXISTED_ACTION_OVERRIDE
								.equals(fileExistedAction)) {
							if (forder.listFiles()[i].isFile()) {
								forder.listFiles()[i].delete();
							}
						} else if (FILE_EXISTED_ACTION_ALERT
								.equals(fileExistedAction)) {
							flag = 2;
							msg = "文件已存在，是否覆盖原有文件？";
							break;

						} else {
							flag = 0;
							msg = "文件已存在,请重新上传！";
							break;
						}
					}
				}
				if (flag == 1) {
					su.save(folderPath);
					msg = "上传文件成功！";
				}
			}
			// 重命名
			if (filerename.length() > 0) {
				java.io.File file = new java.io.File(this.getServletContext()
						.getRealPath(folderPath) + "/" + fileName);
				file.renameTo(new java.io.File(this.getServletContext()
						.getRealPath(folderPath) + "/" + filerename));
			}
			if (sftpName.length() > 0) {
				java.io.File file = new java.io.File(this.getServletContext()
						.getRealPath(folderPath) + "//" + filerename);
				java.io.File reFile = new java.io.File(this.getServletContext()
						.getRealPath(folderPath) + "//" + sftpName);
				file.renameTo(reFile);
			}
			if (filerename.length() >= 0) {
				fileName = filerename;
			}
			filePath = folderPath + "/" + sftpName;

			String file = request.getSession().getServletContext()
					.getRealPath("/");
			String ul = request.getContextPath();
			File f = new File(file + filePath);
			if (flag == 1) {
				String leixing = getProperties("leixing");
				if (f.toString().indexOf(String.valueOf("upload")) != -1) {
					if ("1".equals(leixing)) {
						SFTPChannel channel = new SFTPChannel();
						ChannelSftp chSftp = channel.getChannel(6000);
						if (chSftp != null) {
							boolean b = isDirExist(ul + "/" + folderPath,
									chSftp);
							if (b == true) {
								Vector<LsEntry> v = chSftp.ls(ul + "/"
										+ folderPath);
								for (LsEntry e : v) {
									if (!e.getFilename().startsWith(".")) {
										if (e.getFilename().equals(sftpName)) {
											if (FILE_EXISTED_ACTION_ALERT
													.equals(fileExistedAction)) {
												flag = 2;
												msg = "文件已存在，是否覆盖原有文件？";
												break;

											} else {
												flag = 0;
												msg = "文件已存在,请重新上传！";
												break;
											}
										}
									}
								}
							}
							if (flag == 1) {
								Boolean bool = uploadFile(
										ul + "/" + folderPath, file+"/"
												+ folderPath + "/", sftpName,
										chSftp);
								if (bool == true) {
									msg = "上传文件成功！";
									if (folderPath.indexOf(String
											.valueOf("upload")) != -1) {
										f.delete();// 删除附件
									}
								} else {
									flag = 0;
									msg = "上传文件失败！";
								}
							}
							channel.closeChannel();
						}

					} else if ("2".equals(leixing)) {
						FtpUpload ftp = new FtpUpload();
						InputStream is = new ByteArrayInputStream(
								FtpUpload.getBytesFromFile(f));
						FTPClient ftpClient = ftp.ftpClient(
								getProperties("localhost"),
								Integer.parseInt(getProperties("port")),
								getProperties("ursrname"),
								getProperties("password"));
						if (ftpClient != null) {
							ftpClient.changeWorkingDirectory(ul + "/"
									+ folderPath);
							FTPFile[] files = ftpClient.listFiles();
							for (FTPFile ftpFile : files) {
								if (ftpFile.isFile()) {
									if (ftpFile.getName().equals(sftpName)) {
										if (FILE_EXISTED_ACTION_ALERT
												.equals(fileExistedAction)) {
											flag = 2;
											msg = "文件已存在，是否覆盖原有文件？";
											break;

										} else {
											flag = 0;
											msg = "文件已存在,请重新上传！";
											break;
										}
									}
								}
							}
						}
						if (flag == 1) {
							Boolean bool = FtpUpload.uploadFile(ftpClient,
									folderPath, sftpName, is);
							if (bool == true) {
								msg = "上传文件成功！";
								f.delete();// 删除附件
							} else {
								flag = 0;
								msg = "上传文件失败！";
							}
						}
						if(ftpClient.isConnected()) ftpClient.disconnect();
					}
				} else {
					msg = "上传文件成功！";
				}
			}
		} catch (ServletException e) {
			log.error("请求异常", e);
			flag = 0;
			msg = "文件上传失败";
			e.printStackTrace();
		} catch (IOException e) {
			log.error("处理异常", e);
			flag = 0;
			msg = "文件上传失败";
			e.printStackTrace();
		} catch (SmartUploadException e) {
			log.error("处理异常", e);
			flag = 0;
			msg = "文件上传失败";
			e.printStackTrace();
		} catch (SecurityException e) {
			log.error("上传文件超过规定大小或者禁止上传此类型文件,请重新上传!", e);
			flag = 0;
			msg = "上传文件超过规定大小或者禁止上传此类型文件,请重新上传!";
			e.printStackTrace();
		} catch (Exception e) {
			log.error("处理异常", e);
			flag = 0;
			msg = "文件上传失败";
			e.printStackTrace();
		}
		StringBuffer outStr = new StringBuffer();
		outStr.append("<script type=\"text/javascript\">");
		if (flag == 1) {
			outStr.append("\n\tparent.state=2;");
			outStr.append("\n\tparent.message='").append(msg).append("';");
			outStr.append("\n\tparent.fileName='").append(fileName)
					.append("';");
			outStr.append("\n\tparent.filePath='")
					.append(folderPath + "/" + fileName).append("';");
			outStr.append("\n\tparent._callBack();");
		} else if (flag == 0) {
			outStr.append("\n\tparent.state=3;");
			outStr.append("\n\tparent.message='").append(msg).append("';");
			outStr.append("\n\tparent.fileName='';");
			outStr.append("\n\tparent.filePath='';");
			outStr.append("\n\tparent._callBack();");
		} else {
			outStr.append("\n\tparent._doConfirm('").append(msg).append("');");
		}

		outStr.append("\n</script>");
		out.print(outStr);

	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	public void init() throws ServletException {
		// Just puts "init" string in log
		// Put your code here
	}

	/**
	 * 创建目录
	 * 
	 * @param createpath
	 * @return
	 */
	public boolean createDir(String createpath, ChannelSftp chSftp) {
		try {
			if (isDirExist(createpath, chSftp)) {
				chSftp.cd(createpath);
				return true;
			}
			String pathArry[] = createpath.split("/");
			StringBuffer filePath = new StringBuffer("");
			for (String path : pathArry) {
				if (path.equals("")) {
					continue;
				}
				filePath.append(path + "/");
				if (isDirExist(filePath.toString(), chSftp)) {
					// chSftp.cd(filePath.toString());
				} else {
					// 建立目录
					chSftp.mkdir(filePath.toString());
					// 进入并设置为当前目录
					// chSftp.cd(filePath.toString());
				}

			}
			chSftp.cd(createpath);
			return true;
		} catch (SftpException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 判断目录是否存在
	 * 
	 * @param directory
	 * @return
	 */
	public boolean isDirExist(String directory, ChannelSftp chSftp) {
		boolean isDirExistFlag = false;
		try {
			SftpATTRS sftpATTRS = chSftp.lstat(directory);
			isDirExistFlag = true;
			return sftpATTRS.isDir();
		} catch (Exception e) {
			if (e.getMessage().toLowerCase().equals("no such file")) {
				isDirExistFlag = false;
			}
		}
		return isDirExistFlag;
	}

	/**
	 * 上传单个文件
	 * 
	 * @param remotePath
	 *            远程保存目录
	 * @param localPath
	 *            本地上传目录(以路径符号结束)
	 * @param localFileName
	 *            上传的文件名
	 * @return
	 */
	public boolean uploadFile(String remotePath, String localPath,
			String sftpName, ChannelSftp chSftp) {
		FileInputStream in = null;
		try {
			createDir(remotePath, chSftp);
			File file = new File(localPath + sftpName);
			in = new FileInputStream(file);
			chSftp.put(in, sftpName);
			return true;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (SftpException e) {
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return false;
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
}
