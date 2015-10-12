package com.qam.web.extension.servlet;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

import com.qam.framework.context.ApplicationConfig;
/**
 * 
 * <p>application name:      附件上传ftp</p>
 
 * <p>application describing:</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class FtpUpload {
	/**
	 * Description: 向FTP服务器上传文件
	 * 
	 * @param url
	 *            FTP服务器hostname
	 * @param port
	 *            FTP服务器端口
	 * @param username
	 *            FTP登录账号
	 * @param password
	 *            FTP登录密码
	 * @param path
	 *            FTP服务器保存目录
	 * @param filename
	 *            上传到FTP服务器上的文件名
	 * @param input
	 *            输入流
	 * @return 成功返回true，否则返回false
	 */
	public static boolean uploadFile(FTPClient ftp, String path, String filename, InputStream input) {
		// 初始表示上传失败
		boolean success = false;
		// 创建FTPClient对象
		try {
			String ul=ApplicationConfig.getInstance("/").REAL_PATH;
			File file_url=new File(ul);
			ul=file_url.getParent().substring(file_url.getParent().lastIndexOf("\\")+1);
			ftp.makeDirectory(ul);
			String[] paths = path.split("/");
			String dir = "";
			for (int i = 0; i < paths.length; i++) {
				dir += paths[i] + "/";
				ftp.makeDirectory(ul + "/"+ dir);
			}
			// 转到指定上传目录
			ftp.changeWorkingDirectory(ul+ "/"+ path);
			// 将上传文件存储到指定目录
			// 设置文件类型（二进制）
			ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
			ftp.storeFile(new String(filename.getBytes("utf-8"), "iso-8859-1"),
					input);

			// 关闭输入流
			input.close();
			// 退出ftp
			ftp.logout();
			// 表示上传成功
			success = true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return success;
	}
	public FTPClient ftpClient(String url, int port, String username,
			String password){
		// 创建FTPClient对象
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			// 连接FTP服务器
			// 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
			ftp.connect(url, port);
			// 登录ftp
			ftp.login(username, password);
			// 看返回的值是不是230，如果是，表示登陆成功
			reply = ftp.getReplyCode();
			// 以2开头的返回值就会为真
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftp.disconnect();
				return null;
			}
			}catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (ftp.isConnected()) {
					try {
						ftp.disconnect();
					} catch (IOException ioe) {
					}
				}
			}
			return ftp;
	}

	public static byte[] getBytesFromFile(File f) {
		if (f == null) {
			return null;
		}
		try {
			FileInputStream stream = new FileInputStream(f);
			ByteArrayOutputStream out = new ByteArrayOutputStream(1000);
			byte[] b = new byte[1000];
			int n;
			while ((n = stream.read(b)) != -1)
				out.write(b, 0, n);
			stream.close();
			out.close();
			return out.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Description: 从FTP服务器下载文件
	 * 
	 * @param url
	 *            FTP服务器hostname
	 * @param port
	 *            FTP服务器端口
	 * @param username
	 *            FTP登录账号
	 * @param password
	 *            FTP登录密码
	 * @param remotePath
	 *            FTP服务器上的相对路径
	 * @param fileName
	 *            要下载的文件名
	 * @param localPath
	 *            下载后保存到本地的路径
	 * @return
	 */
	public static boolean downFile(String url, int port, String username,
			String password, String remotePath, String fileName,
			String localPath) {
		// 初始表示下载失败
		boolean success = false;
		// 创建FTPClient对象
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			// 连接FTP服务器
			// 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
			ftp.connect(url, port);
			// 登录ftp
			ftp.login(username, password);
			ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
			reply = ftp.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftp.disconnect();
				return success;
			} // 转到指定下载目录
			ftp.changeWorkingDirectory(remotePath);
			// 列出该目录下所有文件
			FTPFile[] fs = ftp.listFiles();
			// 遍历所有文件，找到指定的文件
			for (FTPFile ff : fs) {
				String ftpName = new String(
						ff.getName().getBytes("ISO-8859-1"), "UTF-8");
				if (ftpName.equals(fileName)) {
					// 根据绝对路径初始化文件
					File localFile = new File(localPath);
					// 输出流
					OutputStream is = new FileOutputStream(localFile);
					// 下载文件
					ftp.retrieveFile(ff.getName(), is);
				}
			}
			// 退出ftp
			ftp.logout();
			// 下载成功
			success = true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return success;
	}
	public static boolean deleteFTPFile(String url, int port, String username,
			String password, String filename) {
		// 初始表示下载失败
		boolean success = false;
		// 创建FTPClient对象
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			// 连接FTP服务器
			// 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
			ftp.connect(url, port);
			// 登录ftp
			ftp.login(username, password);
			ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
			reply = ftp.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftp.disconnect();
				return success;
			} // 转到指定下载目录
			String remotePath=filename.substring(0, filename.lastIndexOf("/")+1);
			String ftpName = filename.substring(filename.lastIndexOf("/") + 1);
			ftp.changeWorkingDirectory(remotePath);
			// 列出该目录下所有文件
			FTPFile[] fs = ftp.listFiles();
			// 遍历所有文件，找到指定的文件
			for (FTPFile ff : fs) {
				String name = new String(
						ff.getName().getBytes("ISO-8859-1"), "UTF-8");
				if (name.equals(ftpName)) {
					ftp.deleteFile("/"+remotePath+name);
				}
			}
			// 退出ftp
			ftp.logout();
			// 下载成功
			success = true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return success;
	}
}