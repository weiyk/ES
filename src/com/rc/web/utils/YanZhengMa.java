package com.rc.web.utils;

import java.sql.ResultSet;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
/**
 * 查询验证码的状态
 * 
 * return 状态
 * @author Cui-YH
 *
 */
public  class YanZhengMa {
	public static String yanzhengma(){
		IDataBaseAccess dataBaseAccess = null;
		ResultSet rs = null;
		
		//查询验证码的状态
		String canshuz="";//参数值
		String sql="select canshuz from XT_CanShuPZ where 1=1 and leixing='6' and canshubm='YanZhengMa'";
		dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
		try {
			dataBaseAccess.openConnection();
			rs = dataBaseAccess.executeQuery(sql.toString());
			while(rs.next()){
				canshuz=rs.getString("canshuz");
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dataBaseAccess.closeConnection();
		}
	
		return canshuz;
	}
	
}
