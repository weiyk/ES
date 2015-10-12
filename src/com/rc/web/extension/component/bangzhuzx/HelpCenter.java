package com.rc.web.extension.component.bangzhuzx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

public class HelpCenter {
	private static Log log = LogFactory.getLog(HelpCenter.class);
	private static IDataBaseAccess dba = null;
	/***
	 * 获取问题列表
	 * currentPage 当前页数
	 * counts 每页显示条数
	 * @return
	 * @throws SQLException
	 */
	public List<String> getQuestionList(int currentPage,int counts) throws SQLException {
		List<String> questionList=new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("select BianHao,BiaoTi,JianLiSJ from jcsj_wentiliebiao where 1=1 order by JianLiSJ desc limit ");
		sql.append((currentPage-1)*counts);
		sql.append(",");
		sql.append(currentPage*counts);
		log.debug("获取问题列表sql：" + sql.toString());
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			while (rs.next()) {
				String value=rs.getString("BianHao")+"&"+rs.getString("BiaoTi")+"&"+TimeConvert(rs.getString("JianLiSJ"));
				questionList.add(value); 
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dba != null)
				dba.closeConnection();
		}
		return questionList;
	}
	/**
	 * 获取总条数
	 */
	public int getTotalCount() throws SQLException {
		int count=0;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) total from jcsj_wentiliebiao where 1=1 ");
		log.debug("获取问题列表总数sql：" + sql.toString());
		ResultSet rs = null;
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			rs = dba.executeQuery(sql.toString());
			if (rs.next()) {
				count=rs.getInt("total");
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (dba != null)
				dba.closeConnection();
		}
		return count;
	}
	/***
	 * 返回问题明细
	 * @param bh
	 * @return
	 */
	public Map<String, String> getQuestionDetail(String bh)throws SQLException{
		IDataBaseAccess dba_up=null;
		IDataBaseAccess dba=null;
		IDataBaseAccess dba_down=null;
		Map<String, String> queDet=new HashMap<String, String>();
		//上条
		StringBuffer sql_up = new StringBuffer(); 
		sql_up.append("select BianHao,BiaoTi,NeiRong,JianLiSJ from jcsj_wentiliebiao where 1=1 and bianhao <'"+bh+"'  ORDER BY BianHao DESC LIMIT 1 ");
		log.debug("获取问题明细上条sql：" + sql_up.toString());
		//本条
		StringBuffer sql = new StringBuffer(); 
		sql.append("select BianHao,BiaoTi,NeiRong,JianLiSJ from jcsj_wentiliebiao where 1=1 and bianhao ='"+bh+"'  ORDER BY BianHao DESC LIMIT 1 ");
		log.debug("获取问题明细本条sql：" + sql.toString());
		//下条
		StringBuffer sql_down = new StringBuffer(); 
		sql_down.append("select BianHao,BiaoTi,NeiRong,JianLiSJ from jcsj_wentiliebiao where 1=1 and bianhao >'"+bh+"'  ORDER BY BianHao LIMIT 1 ");
		log.debug("获取问题明细下条sql：" + sql_down.toString());
		ResultSet rs_up = null;
		ResultSet rs = null;
		ResultSet rs_down = null;
		try {
			dba_up = ContextService.lookupDefaultDataBaseAccess();
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba_down = ContextService.lookupDefaultDataBaseAccess();
			dba_up.openConnection();
			dba.openConnection();
			dba_down.openConnection();
			rs_up = dba_up.executeQuery(sql_up.toString());
			rs = dba.executeQuery(sql.toString());
			rs_down = dba_down.executeQuery(sql_down.toString()); 
			if (rs_up.next()) {
				//上一条
				queDet.put("beforId", rs_up.getString("BianHao"));
				queDet.put("beforTitle", rs_up.getString("BiaoTi"));
			}
			//当前条
			if(rs.next()){ 
				queDet.put("id", rs.getString("BianHao"));
				queDet.put("title", rs.getString("BiaoTi"));
				queDet.put("content", rs.getString("NeiRong"));
				queDet.put("createTime", TimeConvert(rs.getString("JianLiSJ")));
			}
			//下一条
			if(rs_down.next()){
				queDet.put("afterId", rs_down.getString("BianHao")); 
				queDet.put("afterTitle", rs_down.getString("BiaoTi")); 
			}
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally {
			if (rs_up != null)
				rs_up.close();
			if (rs != null)
				rs.close();
			if (rs_down != null)
				rs_down.close();
			if (dba_up != null)
				dba_up.closeConnection();
			if (dba != null)
				dba.closeConnection(); 
			if (dba_down != null)
				dba_down.closeConnection();
		}
		return queDet;
	}
	/***
	 * 格式化时间
	 * @param time
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String TimeConvert(String time){
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Date dat=null;
        try{
        	dat= format.parse(time);   
        }catch (Exception e) {
			// TODO: handle exception
		}
        String sb=format.format(dat); 
        return sb;
	}
}
