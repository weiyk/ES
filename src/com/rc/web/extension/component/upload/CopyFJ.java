package com.rc.web.extension.component.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;
/**
 * 
 * <p>application name:      附件copy</p>
 
 * <p>application describing:附件copy</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class CopyFJ {
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
			chSftp.get(localFileName, new FileOutputStream(file));
			return true;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (SftpException e) {
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
			String sftpName,String fuwu, ChannelSftp chSftp) {
		FileInputStream in = null;
		try {
			createDir(remotePath, chSftp);
			File file = new File(localPath + sftpName);
			in = new FileInputStream(file);
			chSftp.put(in, fuwu);
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

}
