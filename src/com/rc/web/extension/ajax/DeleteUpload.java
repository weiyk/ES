package com.rc.web.extension.ajax;

import java.io.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * 
 * @author 删除课堂封面路径文件
 *
 */
public class DeleteUpload  implements IAjaxService {
	private static Log log = LogFactory.getLog("DeleteUpload");
	public String execute(AjaxServiceParameter params) throws Exception {
		String name = params.getParameter("name");//获取文件名
		String path=params.getParameter("panfu");//获取盘符
		path=path+"upload/teacher/youxiuketang/ketangfengmian/";
		File file=new File(path);
		//得到当前文件夹下所有文件
		File[] files = file.listFiles();	
		if(files != null && files.length > 0){
			for(int i=0;i<files.length;i++){
				if(files[i].isFile() && files[i].exists()){
					if(name.equalsIgnoreCase(files[i].getName())){
						log.debug("开始删除"+name);
						files[i].delete(); 
						log.debug("删除文件"+name+"成功！");
					}
				}
			}
		}
		return "";
	}
}
