package com.qam.web.extension.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Vector;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;
/**
 * 
 * <p>application name:      附件上传到sftp</p>
 
 * <p>application describing:附件上传到sftp</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class SFTPTest {

	public SFTPTest() {
	}

	/**
	 * 上传单个文件
	 * 
	 * @param remotePath
	 *            远程保存目录
	 * @param remoteFileName
	 *            保存文件名
	 * @param localPath
	 *            本地上传目录(以路径符号结束)
	 * @param localFileName
	 *            上传的文件名
	 * @return
	 */
	public boolean uploadFile(String remotePath, String remoteFileName,
			String localPath, ChannelSftp channel, String localFileName) {
		FileInputStream in = null;
		try {
			createDir(remotePath, channel);
			File file = new File(localPath +"\\"+ localFileName);
			in = new FileInputStream(file);
			channel.put(in, remoteFileName);
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

	/**
	 * 批量上传文件
	 * 
	 * @param remotePath
	 *            远程保存目录
	 * @param localPath
	 *            本地上传目录(以路径符号结束)
	 * @param del
	 *            上传后是否删除本地文件
	 * @return
	 */
	public boolean bacthUploadFile(String remotePath, String localPath,
			 boolean del) {
		SFTPChannel sftp = new SFTPChannel();
		ChannelSftp channel = sftp.getChannel(60000);
		try {
			File file = new File(localPath);
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				if (files[i].isFile()
						&& files[i].getName().indexOf("bak") == -1) {
					if (this.uploadFile(remotePath, files[i].getName(),
							localPath, channel, files[i].getName()) && del) {

					}
				}
			}
			sftp.closeChannel();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return false;

	}

	/**
	 * 创建目录
	 * 
	 * @param createpath
	 * @return
	 */
	public boolean createDir(String createpath, ChannelSftp channel) {
		try {
			if (isDirExist(createpath, channel)) {
				channel.cd(createpath);
				return true;
			}
			String pathArry[] = createpath.split("/");
			StringBuffer filePath = new StringBuffer("");
			for (String path : pathArry) {
				if (path.equals("")) {
					continue;
				}
				filePath.append(path + "/");
				if (isDirExist(filePath.toString(), channel)) {
					//channel.cd(filePath.toString());
				} else {
					// 建立目录
					channel.mkdir(filePath.toString());
					// 进入并设置为当前目录
					//channel.cd(filePath.toString());
				}

			}
			channel.cd(createpath);
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
	public boolean isDirExist(String directory, ChannelSftp channel) {
		boolean isDirExistFlag = false;
		try {
			SftpATTRS sftpATTRS = channel.lstat(directory);
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

	/**
	 * 列出目录下的文件
	 * 
	 * @param directory
	 *            要列出的目录
	 * @param sftp
	 * @return
	 * @throws SftpException
	 */
	public Vector listFiles(String directory, ChannelSftp channel)
			throws SftpException {
		return channel.ls(directory);
	}
public static void main(String[] args) {
	SFTPTest ftp = new SFTPTest();
	ftp.sftpWJSC();
}
	public void sftpWJSC() {
		SFTPTest ftp = new SFTPTest();
		String realPath = ftp.getClass().getClassLoader().getResource("")
				.getPath();
		realPath = realPath.substring(1, realPath.indexOf("WEB-INF"));
		File file = new File(realPath + "\\upload\\");
		ftp.bacthUploadFile("fcms/upload/", file.toString(),  false);
		ftp.FileList(file, ftp);
		
	}

	public void FileList(File file, SFTPTest ftp) {
		File[] files = file.listFiles();
		if (files != null) {

			// 判断目录下是不是空的
			for (File f : files) {
				if (f.isDirectory()) {// 判断是否文件夹
					int c = f.toString().indexOf("upload");
					if (c > 0) {
						String xx = "";
						if (f.toString().substring(c)
								.indexOf(String.valueOf('\\')) == -1) {
							xx = f.toString().substring(c);
							// 字符串中不存在c
						} else {
							xx = f.toString().substring(c)
									.replaceAll("\\\\", "/");
						}
						ftp.bacthUploadFile("fcms/" + xx + "/", f.toString()
								+ "\\",  false);
					}
					FileList(f, ftp);// 调用自身,查找子目录
				}
			}
		}
	}
}
