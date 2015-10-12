package com.rc.web.extension.ajax;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * <p>application name: 添加学习记录（异步）</p>
 
 * <p>application describing:</p>
 * 
 * @author Tim
 * @version ver 1.0
 */
public class TianJiaXXJL implements IAjaxService {
	private static Log log = LogFactory.getLog(TianJiaXXJL.class);
	public String execute(AjaxServiceParameter param) throws Exception {
		String yonghubh=(String) param.getRequest().getSession().getAttribute("XiTongHYBH");
		String kechengbh = param.getParameter("kechengbh");//课程编号
		String keshibh = param.getParameter("keshibh");//课时编号
		String keshilx = param.getParameter("keshilx");//课时类型 
		String zhangjiebm = param.getParameter("zhangjiebm");//章节编码
		String bianHao = ContextService.lookupSequenceService().generateId("SEQ_XueXiJLBH");
		StringBuffer sql = new StringBuffer(); 
		sql.append("insert into xskj_xuexijl (xueshengbh,bianhao,kechenbh,xuexisj,keshibh,keshilx,zhangjiebm)values(");
		sql.append("'"+yonghubh+"',");
		sql.append("'"+bianHao+"',");
		sql.append("'"+kechengbh+"',");
		sql.append("now(),");
		sql.append("'"+keshibh+"',");
		sql.append("'"+keshilx+"',");
		sql.append("'"+zhangjiebm+"'");
		sql.append(")");
		log.debug("添加学生学习记录sql:"+sql);
		IDataBaseAccess dbm = null;
		try{
			dbm = ContextService.lookupDefaultDataBaseAccess();
			dbm.openConnection();
			dbm.executeUpdate(sql.toString());
			//this.getDataBaseAccess().executeUpdate(sql.toString());
		}catch (Exception e) {
			dbm.rollback();
			e.printStackTrace();
			throw e;
		}finally{
			dbm.closeConnection();
		}
		return "";
	}

}
