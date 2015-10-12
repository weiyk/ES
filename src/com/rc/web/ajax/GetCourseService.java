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
 * 课程查询
 * @author admin
 */
public class GetCourseService implements IAjaxService {
	private static Log log = LogFactory.getLog("GetCourseService");
	private static IDataBaseAccess dataBaseAccess = null;
	
	@Override
	public String execute(AjaxServiceParameter params) throws Exception {
		// 课程编号
		String courseID = params.getParameter("courseID");
		
		ResultSet rs = null;
		try {
			// 获得连接
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();
			dataBaseAccess.openConnection();
			String sql = "select bianHao, xueDuan, nianJi, keMu, keBenLX, jiaoXueMS, beiKeMS, zhuangTai,BianMuBH from jskj_kecheng where bianHao='" + courseID + "'";
			// 查询结果
			rs = dataBaseAccess.executeQuery(sql);
			JSONObject courseInfo = new JSONObject();
			while (rs.next()) {
				courseInfo.put("bianHao", rs.getString("bianHao"));	// 编号
				courseInfo.put("xueDuan", rs.getString("xueDuan"));	// 学段
				courseInfo.put("nianJi", rs.getString("nianJi"));		// 年级
				courseInfo.put("keMu", rs.getString("keMu"));			// 科目
				courseInfo.put("keBenLX", rs.getString("keBenLX"));	// 课本类型
				courseInfo.put("jiaoXueMS", rs.getString("jiaoXueMS"));	// 教学模式
				courseInfo.put("beiKeMS", rs.getString("beiKeMS"));		// 备课模式
				courseInfo.put("zhuangTai", rs.getString("zhuangTai"));	// 状态
				courseInfo.put("bianMuBH", rs.getString("BianMuBH"));	// 编目编号
			}
			return courseInfo.toString();
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
