package com.rc.web.ajax;

import java.sql.ResultSet;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * 验证课程是否重复
 * @author admin
 *
 */
public class ValidateCourse implements IAjaxService {
	private static Log log = LogFactory.getLog("ValidateCourse");
	private static IDataBaseAccess dataBaseAccess = null;
	
	@Override
	public String execute(AjaxServiceParameter params) throws Exception {
		// 年级编号
		String nianJiBH = params.getParameter("nianJi");
		// 科目编号
		String keMuBH = params.getParameter("keMu");
		// 选段编号
		String xueDuanBH = params.getParameter("xueDuan");
		// 用户编号
		String yongHuBH = (String) params.getRequest().getSession().getAttribute("XiTongHYBH");
		
		// 是否存在匹配数据
		JSONObject courseInfo = new JSONObject();
		ResultSet rs = null;
		try {
			// 获得连接
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();
			dataBaseAccess.openConnection();
			StringBuffer sqlBuffer = new StringBuffer();
			sqlBuffer.append("select kc.JianLiR ");
			sqlBuffer.append(",(select zhi from qam_jiheyz where JiHeYLX='JH_KeMu' and BianMa=kc.KeMu) keMu");
			sqlBuffer.append(",(select zhi from qam_jiheyz where JiHeYLX='JH_NianJi' and BianMa=NianJi) nianJi");
			sqlBuffer.append(" from jskj_kecheng kc");
			sqlBuffer.append(" where kc.XueDuan= '" + xueDuanBH + "'");
			sqlBuffer.append(" and kc.NianJi = '" + nianJiBH + "'");
			sqlBuffer.append(" and kc.KeMu='" + keMuBH + "'");
			sqlBuffer.append(" and kc.JianLiR='" + yongHuBH + "'");
			// 查询结果
			rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
			if (rs.next()) {
				courseInfo.put("state", "1");
				String msg = "已经存在" + rs.getString("nianJi") + rs.getString("keMu") + "课程！";
				courseInfo.put("msg", msg);
			} else {
				courseInfo.put("state", "0");
				courseInfo.put("msg", "");
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dataBaseAccess != null)
				dataBaseAccess.closeConnection();
		}
		return courseInfo.toString();
	}

}
