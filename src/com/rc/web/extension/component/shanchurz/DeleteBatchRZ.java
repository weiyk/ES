package com.rc.web.extension.component.shanchurz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.extension.component.impl.AbstractComponent;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.util.CommonUtils;
/**
 * <p>application name:      根据日期批量删除日志</p>
 
 * <p>application describing:批量删除日志没输入条件进行全部删除</p>
 * @author hdx
 * @version ver 1.0
 */
public class DeleteBatchRZ extends AbstractComponent{
	private static final long serialVersionUID = 1L; 
	private static final Log log = LogFactory.getLog(DeleteBatchRZ.class);
	public void doDelete() throws Exception{
		Object obj = null; 
		String kssj = "";//开始时间
		String jssj = "";//结束时间   
		obj = this.getValue("KaiShiSJ");
		if(obj != null){
			kssj = obj.toString();
		}
		obj = this.getValue("JieShuSJ");
		if(obj != null){
			jssj = obj.toString();
		}
		StringBuffer sql = new StringBuffer(18);
		sql.append(" DELETE FROM XT_RiZhi WHERE 1=1 ");
		if(CommonUtils.null2Blank(kssj).length() > 0){
			sql.append(" AND JIANLISJ >= '").append(kssj).append("' ");
		}
		if(CommonUtils.null2Blank(jssj).length() > 0){
			sql.append(" AND JIANLISJ <= '").append(jssj).append("'");
		}
		log.debug("删除SQL："+sql);
		IDataBaseAccess dbm = null;
		try{
			dbm = ContextService.lookupDefaultDataBaseAccess();
			dbm.beginTransaction();
			dbm.execute(sql.toString());
			dbm.commit();
		}catch(Exception e){
			log.error(e.getMessage());
			dbm.rollback();
		}finally{
			dbm.closeConnection();
		}
	}
}
