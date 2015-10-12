package com.rc.web.ajax;

import java.sql.ResultSet;
import org.apache.log4j.Logger;
import net.sf.json.JSONObject;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * @File Name   : GetVideoInfo.java
 * @Description : 获得教学视频信息
 * @Date        : 2015年9月17日
 * @author      : wyk
 * @version     : 1.0
 * @Others      : 
 * @History
 * 1.<br/>
 * Date   : <br/>
 * Author : <br/>
 * Modification: <br/>
 */
public class GetVideoInfo implements IAjaxService {
	private static final Logger logger = Logger.getLogger(GetVideoInfo.class);
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
			sqlBuffer.append("select BianHao, KeShiBH, ShiPinMC, ShiPinJJ, XueXiao, ZhuJiangR, ShiPinLJ");
			sqlBuffer.append(" from JSKJ_JiaoXueSP ");
			sqlBuffer.append(" where BianHao='" + shiPinBH + "'");
			// 查询结果
			rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
			JSONObject resourceInfo = new JSONObject();
			while (rs.next()) {
				resourceInfo.put("BianHao", rs.getString("BianHao")); // 视频编号
				resourceInfo.put("KeShiBH", rs.getString("KeShiBH")); // 课时编号
				resourceInfo.put("ShiPinMC", rs.getString("ShiPinMC")); // 视频名称
				resourceInfo.put("ShiPinJJ", rs.getString("ShiPinJJ")); // 简介
				resourceInfo.put("XueXiao", rs.getString("XueXiao")); // 学校
				resourceInfo.put("ZhuJiangR", rs.getString("ZhuJiangR")); // 主讲人
				resourceInfo.put("ShiPinLJ", rs.getString("ShiPinLJ")); // 路径
			}
			return resourceInfo.toString();
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dataBaseAccess != null)
				dataBaseAccess.closeConnection();
		}
		return null;
	}

}
