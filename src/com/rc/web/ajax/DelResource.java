package com.rc.web.ajax;

import java.io.File;
import java.sql.ResultSet;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

public class DelResource implements IAjaxService{

	private static Log log = LogFactory.getLog("DelResource");
	private static IDataBaseAccess dataBaseAccess = null;
	
	@Override
	public String execute(AjaxServiceParameter params) throws Exception {
		// 资源编号
		String ziYuanBH = params.getParameter("ziYuanBH");
		
		ResultSet rs = null;
		try {
			// 获得连接
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();
			dataBaseAccess.openConnection();
			StringBuffer sqlBuffer = new StringBuffer();
			
			/**
			 * 查找资源附件
			 */
			// 资源附件编号
			String ziYuanFJBH = null;
			// 附件路径
			String fuJianLJ = null;
			// 封面路径
			String fengMianLJ = null;
			sqlBuffer.append("select c2.BianHao as FuJianBH, c2.FuJianLJ, c2.FengMianLJ");
			sqlBuffer.append(" from JSKJ_ZiYuan c1 inner join JSKJ_ZiYuanFJ c2 on c1.BianHao = c2.ZhuBiaoBH");
			sqlBuffer.append(" where c1.BianHao='" + ziYuanBH + "'");
			rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
			if (rs.next()) {
				ziYuanFJBH = rs.getString("FuJianBH");
				fuJianLJ = rs.getString("FuJianLJ");
				fengMianLJ = rs.getString("FengMianLJ");
			}
			
			/**
			 * 删除附件、封面文件
			 */
			// 绝对路径
			String tmp = ApplicationConfig.getInstance().REAL_PATH;
			String basePath = tmp.substring(0, tmp.lastIndexOf("\\") + 1);
			// 附件File
			File fuJianFile = new File(basePath + fuJianLJ);
			if (fuJianFile.exists()) {
				fuJianFile.delete();
			}
			// 封面文件
			File fengMianFile = new File(basePath + fengMianLJ);
			if (fengMianFile.exists()) {
				fengMianFile.delete();
			}
			
			/**
			 * 删除数据库记录
			 */
			// 删除资源
			sqlBuffer.delete(0, sqlBuffer.length());
			sqlBuffer.append("delete from JSKJ_ZiYuan where BianHao='" + ziYuanBH + "'");
			dataBaseAccess.executeUpdate(sqlBuffer.toString());
			
			// 删除资源附件
			sqlBuffer.delete(0, sqlBuffer.length());
			sqlBuffer.append("delete from JSKJ_ZiYuanFJ where BianHao = '" + ziYuanFJBH + "'");
			dataBaseAccess.executeUpdate(sqlBuffer.toString());
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (dataBaseAccess != null)
				dataBaseAccess.closeConnection();
		}
		return null;
	}
}
