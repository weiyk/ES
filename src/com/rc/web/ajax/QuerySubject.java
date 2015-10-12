package com.rc.web.ajax;

import java.sql.ResultSet;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import net.sf.json.JSONObject;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * 查询下级编目信息
 * @author admin
 *
 */
public class QuerySubject implements IAjaxService{
	private static Log log = LogFactory.getLog("QuerySubject");
	private static IDataBaseAccess dataBaseAccess = null;
	@Override
	public String execute(AjaxServiceParameter params) throws Exception {
		// 上级编目编号
		String parentID = params.getParameter("parentID");
		
		ResultSet rs = null;
		try {
			// 获得连接
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();
			dataBaseAccess.openConnection();
			String sql = "SELECT bm.BianHao, bm.BianMuBM, bm.BianMuMC, bm.ShangJiBH from jskj_kechengbm bm where bm.ShangJiBH = '" + parentID + "'";
			// 查询结果
			rs = dataBaseAccess.executeQuery(sql);
			JSONObject bianMu = new JSONObject();
			while (rs.next()) {
				bianMu.put(rs.getString("BianHao"), rs.getString("BianMuMC"));
			}
			return bianMu.toString();
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
