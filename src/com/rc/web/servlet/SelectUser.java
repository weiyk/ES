package com.rc.web.servlet;

import java.sql.ResultSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.security.TransformPassword;

/**
 * 
 * @author 查询用户
 *
 */
public class SelectUser {
	private static final Log log = LogFactory.getLog(SelectUser.class);
	/**
	 * 查询用户
	 * 
	 * @param loginId 用户名
	 * @return password 口令密码
	 */
	private String getUser(String loginId){
		IDataBaseAccess dataBaseAccess = null;
		ResultSet rs = null;
		String password="";//密码
		try {
			StringBuffer sql = new StringBuffer(64);
			sql.append("SELECT * FROM XT_YONGHU WHERE DENGLUM='").append(loginId).append("'");
			log.debug("用户sql:"+sql);
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
			dataBaseAccess.openConnection();
			rs = dataBaseAccess.executeQuery(sql.toString());
			while (rs.next()) {
				password=rs.getString("KOULING");//密码
			}
		} catch (Exception e) {
			log.error("查询失败", e);
		}finally{
			try{
				rs.close();
				dataBaseAccess.closeConnection();
			}catch(Exception e){
				log.error("关闭数据库连接出错",e);
			}
		}
		return password;
	}
	/**
	 * 修改用户密码
	 * 
	 * @param loginId 用户名
	 * @param password 口令密码
	 */
	private void UpdateUser(String loginId,String password){
		IDataBaseAccess dataBaseAccess = null;
		try {
			StringBuffer sql = new StringBuffer(64);
			sql.append("UPDATE XT_YONGHU SET KOULING='").append(password)
			.append("' WHERE DENGLUM='").append(loginId).append("'");
			log.debug("用户sql:"+sql);
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
			dataBaseAccess.openConnection();
			int count = dataBaseAccess.executeUpdate(sql.toString());
			if(count>0){
				log.debug("修改密码成功！");
			}else{
				log.debug("修改密码失败！");
			}
		} catch (Exception e) {
			try {
				dataBaseAccess.rollback();//回滚
			} catch (QamFrameworkException e1) {
				e1.printStackTrace();
			}
			log.error("修改密码失败", e);
		}finally{
			try{
				dataBaseAccess.closeConnection();
			}catch(Exception e){
				log.error("关闭数据库连接出错",e);
			}
		}
	}
	
	/**
	 * 同步用户名密码
	 * 
	 * @param loginName 用户名
	 * @param loginPwd  密码
	 */
	public void UserUtil(String loginName,String loginPwd){
		String password=this.getUser(loginName);						//获取本地数据库密码
		if(!password.equals("")){										//判断是否有次用户
			if(!password.equals(TransformPassword.transform(loginPwd))){//判断密码是否相同
				this.UpdateUser(loginName, TransformPassword.transform(loginPwd));//如果不相同，就同步修改密码
			}
		}
	}
	
	
}
