package com.rc.web.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

public class OracleUtils {
	private static Log log = LogFactory.getLog(OracleUtils.class);
	/**
	 * 获取一个字段值
	 * @param tableName
	 * @param fieldName
	 * @param Condition
	 * @param isTren 多个结果是否用,串联
	 * @return
	 * @throws QamFrameworkException 
	 * @throws SQLException 
	 */
	public static String getOneFieldValue(String tableName, String fieldName, String condition, Boolean isTren) throws QamFrameworkException, SQLException{
		IDataBaseAccess dba = null;
		ResultSet rs = null;
		StringBuffer result = new StringBuffer();
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();
			dba.openConnection();
			String sql = getSql(tableName,fieldName,condition);
			rs = dba.executeQuery(sql);
			if(isTren){
				while(rs.next()){
					result.append(rs.getString(1)).append(",");
				}
				result.delete(result.length()-1, result.length());
			}else{
				if(rs.next()){
					result.append(rs.getString(1));
				}
			}
		}finally{
			if(dba!=null){
				dba.closeConnection();
			}
			if(rs!=null){
				rs.close();
			}
		}
		log.debug("返回结果为：" + result.toString());
		return result.toString();
	}
	/**
	 * 
	 * @param tableName
	 * @param fieldName
	 * @param condition
	 * @return
	 * @throws QamFrameworkException
	 * @throws SQLException
	 */
	public static String getOneFieldValue(String tableName, String fieldName, String condition) throws QamFrameworkException, SQLException{
		return getOneFieldValue(tableName, fieldName, condition, false);
	}
	private static String getSql(String tableName, String fieldName,
			String condition) {
		if(condition.toLowerCase().startsWith("where")){
			condition = condition.substring(5);
		}
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ").append(fieldName).append(" FROM ").append(tableName).append(" where ").append(condition);
		log.debug("获取字段值sql:" + sql.toString());
		return sql.toString();
	}
	
	public static String getOnFieldValueBySQL(String sql,String... key) throws SQLException, QamFrameworkException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StringBuffer result = new StringBuffer();
		try {
			conn = ContextService.lookupDefaultDataBaseAccess().getConnection();
			ps = conn.prepareStatement(sql);
			int i =1;
			for(String item : key){
				ps.setString(i, item);
				i++;
			}
			rs = ps.executeQuery();
			if(rs.next()){
				return rs.getString(1);
			}
		}finally{
			if(conn!=null && !conn.isClosed()){
				conn.close();
			}
		}
		log.debug("返回结果为：" + result.toString());
		return result.toString();
	}
}
