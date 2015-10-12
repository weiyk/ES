package com.rc.web.ajax;

import java.io.File;
import java.sql.ResultSet;

import uk.ltd.getahead.dwr.util.Logger;

import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * @File Name : DelVideo.java
 * @Description : 删除教学视频
 * @Date : 2015年9月17日
 * @author : wyk
 * @version : 1.0
 * @Others :
 * @History 1.<br/>
 *          Date : <br/>
 *          Author : <br/>
 *          Modification: <br/>
 */
public class DelVideo implements IAjaxService {
	private static final Logger logger = Logger.getLogger(DelVideo.class);
	private static IDataBaseAccess dataBaseAccess = null;

	@Override
	public String execute(AjaxServiceParameter params) throws Exception {
		// 视频编号
		String shiPinBH = params.getParameter("shiPinBH");

		ResultSet rs = null;
		try {
			// 获得连接
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();
			dataBaseAccess.openConnection();
			StringBuffer sqlBuffer = new StringBuffer();

			/**
			 * 查找教学视频
			 */
			// 视频路径
			String shiPinLJ = null;
			sqlBuffer.append("select BianHao, ShiPinLJ");
			sqlBuffer.append(" from JSKJ_JiaoXueSP");
			sqlBuffer.append(" where BianHao='" + shiPinBH + "'");
			rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
			if (rs.next()) {
				shiPinLJ = rs.getString("ShiPinLJ");
			}

			/**
			 * 删除资源文件
			 */
			// 绝对路径
			String tmp = ApplicationConfig.getInstance().REAL_PATH;
			String basePath = tmp.substring(0, tmp.lastIndexOf("\\") + 1);
			// 资源File
			File fuJianFile = new File(basePath + shiPinLJ);
			if (fuJianFile.exists()) {
				fuJianFile.delete();
			}

			/**
			 * 删除数据库记录
			 */
			// 删除资源
			sqlBuffer.delete(0, sqlBuffer.length());
			sqlBuffer.append("delete from JSKJ_JiaoXueSP where BianHao='" + shiPinBH + "'");
			dataBaseAccess.executeUpdate(sqlBuffer.toString());

		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		} finally {
			if (dataBaseAccess != null)
				dataBaseAccess.closeConnection();
		}
		return null;
	}

}
