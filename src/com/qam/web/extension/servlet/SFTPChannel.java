package com.qam.web.extension.servlet;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.qam.framework.context.ApplicationConfig;
/**
 * 
 * <p>application name:      sftp的连接</p>
 
 * <p>application describing:</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class SFTPChannel {
	private static final Log log = LogFactory.getLog(SFTPChannel.class);
    Session session = null;
    Channel channel = null;


    public ChannelSftp getChannel(int timeout){

		JSch jsch = new JSch(); // 创建JSch对象
		try{
			if(!"".equals(getProperties("sftp_ursrname"))&&getProperties("sftp_ursrname")!=null){
				session = jsch.getSession(getProperties("sftp_ursrname"),
						getProperties("sftp_localhost"),
						Integer.parseInt(getProperties("sftp_port"))); // 根据用户名，主机ip，端口获取一个Session对象
				session.setPassword(getProperties("sftp_password")); // 设置密码
				Properties config = new Properties();
				config.put("StrictHostKeyChecking", "no");
				session.setConfig(config); // 为Session对象设置properties
				session.setTimeout(timeout); // 设置timeout时间
				session.connect(); // 通过Session建立链接
				channel = session.openChannel("sftp"); // 打开SFTP通道
				channel.connect(); // 建立SFTP通道的连接
			}
		}catch (JSchException e) {
			log.error(e.getMessage());
			return null;
		}  
		return (ChannelSftp) channel;
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
    public void closeChannel() {
        if (channel != null) {
            channel.disconnect();
        }
        if (session != null) {
            session.disconnect();
        }
    }
}