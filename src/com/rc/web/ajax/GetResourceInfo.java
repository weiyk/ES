package com.rc.web.ajax;

import java.sql.ResultSet;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

public class GetResourceInfo implements IAjaxService{
	private static Log log = LogFactory.getLog("GetResourceInfo");
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
			sqlBuffer.append("select c1.BianHao as ZiYuanBH, c1.ZiYuanMC, c1.ZiYuanJJ, c1.SuoShuXK, c1.ShiYongNJ, c1.ZiYuanLB, c1.MeiTiLX");
			sqlBuffer.append(",c2.BianHao as FuJianBH, c2.FuJianLJ, c2.FengMianLJ");
			sqlBuffer.append(" from JSKJ_ZiYuan c1 inner join JSKJ_ZiYuanFJ c2 on c1.BianHao = c2.ZhuBiaoBH");
			sqlBuffer.append(" where c1.BianHao='" + ziYuanBH + "'");
			// 查询结果
			rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
			JSONObject resourceInfo = new JSONObject();
			while (rs.next()) {
				resourceInfo.put("ZiYuanBH", rs.getString("ZiYuanBH"));	// 资源编号
				resourceInfo.put("ZiYuanMC", rs.getString("ZiYuanMC"));	// 资源名称
				resourceInfo.put("FuJianBH", rs.getString("FuJianBH"));	// 附件编号
				resourceInfo.put("SuoShuXK", rs.getString("SuoShuXK"));	// 所属科目
				resourceInfo.put("ShiYongNJ", rs.getString("ShiYongNJ"));	// 使用年级
				resourceInfo.put("ZiYuanLB", rs.getString("ZiYuanLB"));		// 资源类别
				resourceInfo.put("MeiTiLX", rs.getString("MeiTiLX"));	// 媒体类型
				resourceInfo.put("ZiYuanJJ", rs.getString("ZiYuanJJ"));	// 简介
				resourceInfo.put("FuJianLJ", rs.getString("FuJianLJ"));		// 附件路径
				resourceInfo.put("FengMianLJ", rs.getString("FengMianLJ"));	// 封面路径
			}
			return resourceInfo.toString();
		} catch (Exception e) {
			log.error(e);
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
