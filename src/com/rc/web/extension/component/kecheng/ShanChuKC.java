package com.rc.web.extension.component.kecheng;

import java.sql.ResultSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.extension.component.impl.AbstractComponent;
import com.qam.framework.jdbc.IDataBaseAccess;
/**
 * <p>application name:      删除课程</p>
 
 * <p>application describing:删除课程</p>
 * @author Tim
 * @version ver 1.0
 */
public class ShanChuKC extends AbstractComponent{
	private static final long serialVersionUID = 1L; 
	private static final Log log = LogFactory.getLog(ShanChuKC.class);
	IDataBaseAccess dbm = null; 
	public void shanchukc() throws Exception{
		Object obj = null; 
		String kcbh = "";//课程编号
		obj = this.getValue("kcbh");
		if(obj != null){
			kcbh = obj.toString();
		}
		String ksbh = "";//课时编号
		obj = this.getValue("ksbh");
		if(obj != null){
			ksbh = obj.toString();
		}
		
		try{
			dbm = ContextService.lookupDefaultDataBaseAccess();
			dbm.beginTransaction();
			if(kcbh!=""){
				//删除课时
				//查找课程的所有课时
				ResultSet rs=dbm.executeQuery("select bianhao from jskj_keshi where kechengbh='"+kcbh+"'");
				while(rs.next()){
					this.shanchuks(rs.getString("bianhao"));
				}
				//删除教学计划
				StringBuffer sql_2 = new StringBuffer(18);
				sql_2.append(" DELETE FROM jskj_jiaoxuejh WHERE 1=1 and KeChengBH='");
				sql_2.append(kcbh);sql_2.append("'");
				log.debug("删除教学计划SQL："+sql_2);
				dbm.execute(sql_2.toString());
				//删除课程
				StringBuffer sql_1 = new StringBuffer(18); 
				sql_1.append(" DELETE FROM jskj_kecheng WHERE 1=1 and BianHao='");
				sql_1.append(kcbh);sql_1.append("'");
				log.debug("删除课程SQL："+sql_1); 
				dbm.execute(sql_1.toString());
			}
			if(ksbh!=""){
				this.shanchuks(ksbh);
			}
			dbm.commit();
		}catch(Exception e){
			log.error(e.getMessage());
			dbm.rollback();
		}finally{
			dbm.closeConnection();
		}
	}
	/***
	 * 删除课时
	 * @param ksbh 课时编号
	 * @throws Exception
	 */
	public void shanchuks(String ksbh) throws Exception{
			//删除教案
			StringBuffer sql_1 = new StringBuffer();
			sql_1.append(" DELETE FROM JSKJ_JiaoAnXX WHERE 1=1 and KeShiBH='");
			sql_1.append(ksbh);sql_1.append("'");
			log.debug("删除教案SQL："+sql_1);
			dbm.execute(sql_1.toString());
			//删除课前导学
			StringBuffer sql_2 = new StringBuffer();
			sql_2.append(" DELETE FROM jskj_keqiandx WHERE 1=1 and KeShiBH='");
			sql_2.append(ksbh);sql_2.append("'");
			log.debug("删除课前导学SQL："+sql_2);
			dbm.execute(sql_2.toString());
			//删除学习目标
			StringBuffer sql_3 = new StringBuffer();
			sql_3.append(" DELETE FROM jskj_xueximb WHERE 1=1 and KeShiBH='");
			sql_3.append(ksbh);sql_3.append("'");
			log.debug("删除学习目标SQL："+sql_3);
			dbm.execute(sql_3.toString());
			//删除学习资源
				//删除资源附件
				StringBuffer sql_4_1 = new StringBuffer();
				sql_4_1.append(" DELETE FROM jskj_ziyuankj WHERE 1=1 and XueXiZYBH in(select bianhao from jskj_xuexizy where KeShiBH ='");
				sql_4_1.append(ksbh);sql_4_1.append("')");
				log.debug("删除学习资源附件SQL："+sql_4_1);
				dbm.execute(sql_4_1.toString());
				//删除资源
				StringBuffer sql_4 = new StringBuffer();
				sql_4.append(" DELETE FROM jskj_xuexizy WHERE 1=1 and KeShiBH='");
				sql_4.append(ksbh);sql_4.append("'");
				log.debug("删除学习资源SQL："+sql_4);
				dbm.execute(sql_4.toString());
			//删除学习活动
			StringBuffer sql_5 = new StringBuffer();
			sql_5.append(" DELETE FROM jskj_xuexihd WHERE 1=1 and KeShiBH='");
			sql_5.append(ksbh);sql_5.append("'");
			log.debug("删除学习活动SQL："+sql_5);
			dbm.execute(sql_5.toString());
			//删除教学视频
			StringBuffer sql_6 = new StringBuffer();
			sql_6.append(" DELETE FROM jskj_jiaoxuesp WHERE 1=1 and KeShiBH='");
			sql_6.append(ksbh);sql_6.append("'");
			log.debug("删除教学视频SQL："+sql_6);
			dbm.execute(sql_6.toString());
			//删除课时
			StringBuffer sql_7 = new StringBuffer();
			sql_7.append(" DELETE FROM jskj_keshi WHERE 1=1 and BianHao='");
			sql_7.append(ksbh);sql_7.append("'");
			log.debug("删除课时SQL："+sql_7);
			dbm.execute(sql_7.toString());
	}
}
