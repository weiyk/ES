package com.rc.web.extension.component.upload;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.ChannelSftp;
import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.core.transaction.execution.CanReturnException;
import com.qam.framework.extension.component.impl.AbstractComponent;
import com.qam.framework.util.CommonUtils;
import com.qam.web.extension.servlet.FtpUpload;
import com.qam.web.extension.servlet.SFTPChannel;

/**
 * <p>
 * application name: 上传附件 组件
 * </p>
 * 
 * <p>
 * application describing:对附件及附件关系表进行全删全增操作
 * </p>
 * @author hdx
 * @version ver 1.0
 */
public class Upload extends AbstractComponent {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(Upload.class);
	private String fuJianLJ = "";// 附件路径
	private String fuJianBH = "";// 附件名称
	private String FengMianLJ="";
	public void upload() throws Exception {
		Object obj = null;
		obj = this.getValue("BianHao");
		if (obj != null) {
			this.fuJianBH = obj.toString();
		}
		obj = this.getValue("FuJianLJ");
		if(obj != null){
			this.fuJianLJ = obj.toString();
		}
		deleteFJ(fuJianLJ);
		obj = this.getValue("FengMianLJ");
		if(obj != null){
			this.FengMianLJ = obj.toString();
		}
		deleteFJ(FengMianLJ);
	}
	private void deleteFJ(String fjlj){
		String realPath = ApplicationConfig.getInstance().REAL_PATH;
		realPath = realPath.substring(0, realPath.indexOf("WEB-INF"));
			File deleteF = new File(realPath + fjlj);
			if (deleteF.exists()) {
				deleteF.delete();
			}
	}
}
