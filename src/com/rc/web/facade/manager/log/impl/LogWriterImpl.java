package com.rc.web.facade.manager.log.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.groovy.antlr.treewalker.PreOrderTraversal;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.beans.dialog.Dialog;
import com.qam.framework.beans.dialog.DialogParameter;
import com.qam.framework.beans.enumeration.ExecuteType;
import com.qam.framework.beans.enumeration.KeyFlag;
import com.qam.framework.beans.process.AccessPathItem;
import com.qam.framework.beans.process.ProcessItem;
import com.qam.framework.beans.process.ProcessUnit;
import com.qam.framework.beans.process.TableItem;
import com.qam.framework.cache.SysCache;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.context.ObjectNotFoundException;
import com.qam.framework.core.transmit.EvaluateResultWrapper;
import com.qam.framework.extension.component.impl.AbstractComponent;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.sequence.ISequenceService;
import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.beans.LogBean;
import com.qam.web.facade.manager.log.ILogWriter;
import com.qam.web.listener.ProeritesWriterListener;
import com.sun.xml.bind.CycleRecoverable.Context;
/**
 * 
 * <p>application name:      写入系统日志文件</p>
 
 * <p>application describing:写入系统日志文件</p>
 
 * @author zhou
 * @version ver 1.0
 */
@SuppressWarnings("all")
public class LogWriterImpl implements ILogWriter, Serializable {

	public LogWriterImpl() {
		sequenceService = ContextService.lookupSequenceService();
	}
	public static ThreadLocal<Connection> local_con = new ThreadLocal<Connection>();

	@Override
	public void write(LogBean logBean) {
		if (logBean != null) {
			addVariable(logBean);
			int flag = 0;
			Map<String,String> entrustMap = (Map<String, String>) logBean.getRequest().getSession().getServletContext().getAttribute("_QAM_CONTEXT_WEITUOGXYS");
			Map<String,String> updateMap = (Map<String, String>) logBean.getRequest().getSession().getServletContext().getAttribute("_QAM_CONTEXT_WEITUORZD");
			try {
				com.qam.framework.beans.process.Process process = null;
				EvaluateResultWrapper wrapper = SysCache.getProcess(logBean.getHuoDongBH());
				process = wrapper.getProcess();
				//com.qam.framework.beans.process.Process process = null;
				List list = process.getProcessUnits();
				ProcessUnit processUnit = null;
				ExecuteType executeType = null;
				List<List<String>> valueList = new ArrayList<List<String>>();
				List<String> pkList = new ArrayList<String>();
				List<String> tableList = new ArrayList<String>();
				for(int i =0;i<list.size();i++) {
					processUnit = (ProcessUnit) list.get(i);
					executeType = processUnit.getExecuteType();
					if(executeType==ExecuteType.Add || executeType==ExecuteType.Update || executeType==ExecuteType.Delete || executeType == ExecuteType.Component){//ֻ��¼��ɾ���ĵ����
						flag++;
						//查看是否委托
						String entrustPersonID = (String)logBean.getRequest().getSession().getAttribute("WeiTuoRBH");
						//委托人有值 并且不在ignoreList 中 ，记录日志
						if(CommonUtils.null2Blank(entrustPersonID).length()>0 && !ignoreList.contains(logBean.getHuoDongBH())){
							List<TableItem> itemList = processUnit.getTableItems();
							if(itemList != null && !itemList.isEmpty()){
								TableItem item = itemList.get(0);
								if( entrustMap.keySet().contains(item.getId().toUpperCase()) && executeType != ExecuteType.Delete){
									if(tableList.isEmpty()){
										tableList.add(item.getId().toLowerCase());
									}else{
										if(!tableList.contains(item.getId().toLowerCase())){
											continue;
										}
									}
									//update or delete then accessPath
									if(executeType == ExecuteType.Update ){
										for(Object obj : processUnit.getAccessPathItems()){
											if(((AccessPathItem)obj).getKeyFlag().equals(KeyFlag.PK)){
												String[] PKValues = ((AccessPathItem)obj).getValue().split(",");
												//多条处理
												String businessName = selOrUpdateContent("select GN.MINGCHENG from qam_gongneng gn ,qam_gongnenghd hd where GN.YEWUBM = hd.gongnengbm and hd.bieming = ?", logBean.getHuoDongBH(),null);
												String businessOparate = logBean.getHuoDongMC();
												String entrustID = (String) logBean.getRequest().getSession().getAttribute("WEITUOQXSXBH");
												for(String PKValue : PKValues){
													if(pkList.contains(PKValue)){
														continue;
													}
													pkList.add(PKValue);
													if(updateMap.containsKey(item.getId().toUpperCase())){
														//更新委托人
														this.selOrUpdateContent(updateMap.get(item.getId().toUpperCase()),PKValue, (String)logBean.getRequest().getSession().getAttribute("WeiTuoRBH"));
													}
													String content = selOrUpdateContent(entrustMap.get(item.getId().toUpperCase()), PKValue,null);
													if(content == null || "".equals(content)){
														content = PKValue;
													}
													HttpServletRequest re = logBean.getRequest();
													String key = re.getParameter("_qam_command")+ "&&" + re.getParameter("_qam_dialog") + "&&" + re.getParameter("_qam_dialog_state");
													if(rc_log.containsKey(key)){
														businessName = rc_log.getProperty(key).split(",")[0];
														businessOparate = rc_log.getProperty(key).split(",")[1];
													}
													List<String> valueItemList = new ArrayList<String>();
													String id = ContextService.lookupSequenceService().generateId("SEQ_WeiTuoBLLS");
													valueItemList.add(id);
													valueItemList.add(PKValue);
													valueItemList.add(content);
													valueItemList.add(businessName);
													valueItemList.add(businessOparate);
													valueItemList.add(entrustID);
													valueList.add(valueItemList);
												}
												break;
											}
										}
									}
									// add then processItem
									if(executeType == ExecuteType.Add){
										for (Object obj : processUnit.getProcessItems()) {
											if(((ProcessItem)obj).getKeyFlag().equals( KeyFlag.PK)){
												String[] PKValues = ((ProcessItem)obj).getValue().split(",");
												String businessName = selOrUpdateContent("select GN.MINGCHENG from qam_gongneng gn ,qam_gongnenghd hd where GN.YEWUBM = hd.gongnengbm and hd.bieming = ?", logBean.getHuoDongBH(),null);
												String businessOparate = logBean.getHuoDongMC();
												String entrustID = (String) logBean.getRequest().getSession().getAttribute("WEITUOQXSXBH");
												for(String PKValue : PKValues){
													if(pkList.contains(PKValue)){
														continue;
													}
													if(updateMap.containsKey(item.getId().toUpperCase())){
														//更新委托人
														this.selOrUpdateContent(updateMap.get(item.getId().toUpperCase()),PKValue, (String)logBean.getRequest().getSession().getAttribute("WeiTuoRBH"));
													}
													String content = selOrUpdateContent(entrustMap.get(item.getId().toUpperCase()), PKValue,null);
													HttpServletRequest re = logBean.getRequest();
													String key = re.getParameter("_qam_command")+ "&&" + re.getParameter("_qam_dialog") + "&&" + re.getParameter("_qam_dialog_state");
													if(rc_log.containsKey(key)){
														businessName = rc_log.getProperty(key).split(",")[0];
														businessOparate = rc_log.getProperty(key).split(",")[1];
													}
													List<String> valueItemList = new ArrayList<String>();
													String id = ContextService.lookupSequenceService().generateId("SEQ_WeiTuoBLLS");
													valueItemList.add(id);
													valueItemList.add(PKValue);
													valueItemList.add(content);
													valueItemList.add(businessName);
													valueItemList.add(businessOparate);
													valueItemList.add(entrustID);
													valueList.add(valueItemList);
												}
												
												break;
											}
										}
									}
									//break;//一个功能事务只记录一次
								}
							}
						}
					}
				}
				if(flag>0){
					add(logBean);
				}
				if(!valueList.isEmpty()){
					addBatch(valueList);
				}
			}catch (Exception e) {
				log.error(e.getMessage());
				e.printStackTrace();
			}finally{
				//清除缓存
				SysCache.clearProcess(logBean.getHuoDongBH());
				//清除ThreaLocal中的连接
				if(local_con.get()!=null){
					try {
						local_con.get().close();
						local_con.set(null);
					} catch (SQLException e) {
						e.printStackTrace();
						log.error("关闭连接出错");
					}
				}
			}

		}

	}

	
	/**
	 * 根据sql获取值
	 * @param sql
	 * @param PKValue
	 * @param flag  1,查询;2,更新
	 * @return
	 * @throws Exception
	 */
	private String selOrUpdateContent(String sql, String PKValue, String entrustPersonID) throws Exception {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		try{
			if(local_con.get() == null){
				local_con.set(ContextService.lookupDefaultDataBaseAccess().getConnection());
			}
			connection = local_con.get();
			connection.setAutoCommit(false);
			statement = connection.prepareStatement(sql);
			if(entrustPersonID==null){
				statement.setString(1, PKValue);
				log.debug(PKValue + ":" + sql);
				rs = statement.executeQuery();
				if(rs.next()){
					return rs.getString(1);
				}
			}else{
				statement.setString(2, PKValue);
				statement.setString(1, entrustPersonID);
				int count = statement.executeUpdate();
				log.debug("更新了"+ count + "条");
			}
			connection.commit();
		}catch (Exception e) {
			e.printStackTrace();
			log.error("出错");
		}finally{
			if(statement != null){
				statement.close();
			}
			if(rs != null){
				rs.close();
			}
		}
		return null;
		
		
	}
	private void addBatch(List<List<String>> valueList) throws SQLException{
		String sql = "INSERT INTO WTGL_WeiTuoWBL (BianHao,YeWuZJH,YeWuNR,YeWuMC,YeWuCZ,WeiTuoYWBM,BanLiYWSJ) Values (?,?,?,?,?,?,sysdate)";
		Connection connection = null;
		PreparedStatement statement = null;
		try{
			if(local_con.get() == null){
				local_con.set(ContextService.lookupDefaultDataBaseAccess().getConnection());
			}
			connection = local_con.get();
			connection.setAutoCommit(false);
			statement = connection.prepareStatement(sql);
			for(List<String> valueItemList : valueList){
				for (int i=1; i<= valueItemList.size(); i++) {
					statement.setString(i, valueItemList.get(i-1));
				}
				statement.addBatch();
			}
			int[] count = statement.executeBatch();
			statement.clearBatch();
			log.debug("执行了" + count.length + "行");
			connection.commit();
		}catch (Exception e) {
			log.error("插入办理历史出错" + e.getMessage());
			connection.rollback();
			e.printStackTrace();
		}finally{
			if(statement != null){
				statement.close();
			}
		}
	}
	private void add(LogBean logBean) {
		Connection connection = null;
		try {
			String bh = ContextService.lookupSequenceService().generateId("SEQ_XTRZBH");
			if(local_con.get()==null){
				local_con.set(ContextService.lookupDefaultDataBaseAccess().getConnection());
			}
			connection = local_con.get();
			log.debug("INSERT INTO XT_RIZHI (BianHao,DengLuM,XingMing,YongHuBH,HuoDongBH,HuoDongMC,JiLuSJ,CaoZuoNR,JiQiM,ip) VALUES(?,?,?,?,?,?,?,?,?,?)");
			PreparedStatement pt = connection.prepareStatement("INSERT INTO XT_RIZHI (DengLuM,XingMing,YongHuBH,HuoDongBH,HuoDongMC,JIANLISJ,NEIRONG,JiQiM,ip,BianHao) VALUES(?,?,?,?,?,now(),?,?,?,?)"); 
			String userId = CommonUtils.null2Blank(logBean.getRequest().getSession(false).getAttribute("DengLuM"));
			pt.setString(1, userId);
			String name = CommonUtils.null2Blank(logBean.getRequest().getSession(false).getAttribute("YONGHUXM"));
			pt.setString(2, name);
			pt.setString(3,logBean.getYongHuBH());
			pt.setString(4,logBean.getHuoDongBH());
			pt.setString(5,logBean.getHuoDongMC());
			//pt.setDate(6,new java.sql.Date(new Date().getTime()));
			pt.setString(6,logBean.getNeiRong());
			pt.setString(7,logBean.getJiQiM());
			pt.setString(8,logBean.getIp());
			pt.setString(9, bh);
			pt.executeUpdate();
			log.debug("添加日志:"+pt.toString());
		} catch (Exception e) {
			log.error("\u6DFB\u52A0\u65E5\u5FD7\u8BB0\u5F55\u5931\u8D25,sql:", e);
		}
	}
	/**
	 * 加载委托关系，加载委托人字段
	 * @param bean
	 */
	private void addVariable(LogBean bean){
		IDataBaseAccess dba = null;
		ResultSet rs = null;
		if(bean.getRequest().getSession().getServletContext().getAttribute(this.WEITUOGXYS) != null){
			return;
		}
		try {
			dba = ContextService.lookupDefaultDataBaseAccess();	
			dba.openConnection();
			Map<String,String> entrustMap = new HashMap<String, String>();
			String sql = "select bianma,zhi from qam_jiheyz where jiheylx = 'JH_WeiTuoYSGX'";
			rs = dba.executeQuery(sql.toString());
			while(rs.next()){
				entrustMap.put(rs.getString(1), rs.getString(2));
			}
			log.debug("加载委托关系" + entrustMap.toString());
			bean.getRequest().getSession().getServletContext().setAttribute(this.WEITUOGXYS, entrustMap);
			Map<String,String> entrustPersionMap = new HashMap<String,String>();
			sql="select bianma,zhi from qam_jiheyz where jiheylx = 'JH_WeiTuoRZD'";
			rs = dba.executeQuery(sql.toString());
			while(rs.next()){
				entrustPersionMap.put(rs.getString(1), rs.getString(2));
			}
			log.debug("加载委托人字段" + entrustPersionMap.toString());
			bean.getRequest().getSession().getServletContext().setAttribute(this.WEITUORZD, entrustPersionMap);
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally{
			if(dba != null){
				dba.closeConnection();
			}
		}
	}
	private static final long serialVersionUID = 816577451190300046L;
	private static final Log log;
	private ISequenceService sequenceService;
	private final String WEITUOGXYS = "_QAM_CONTEXT_WEITUOGXYS";
	private final String WEITUORZD = "_QAM_CONTEXT_WEITUORZD";
	private static final String CONFIGPATH=ApplicationConfig.getInstance().REAL_PATH+"/rc-entrust-config.properties";
	private static List<String> ignoreList = new ArrayList<String>();//不记录日志的功能集合
	private static Properties rc_log;
	//private String get
	static {
		log = LogFactory
				.getLog(com.rc.web.facade.manager.log.impl.LogWriterImpl.class);
		//获取不记录日志的功能集合 特殊事务
		/*Properties properties = new Properties();
		rc_log = new Properties();
		try {
			properties.load(new FileInputStream(new File(CONFIGPATH)));
			rc_log.load(new FileInputStream(new File(ApplicationConfig.getInstance().REAL_PATH+"/rc-entrust-log.properties")));
			String value = properties.getProperty("rc.log.ignoreList");
			
			String[] array = value.split(",");
			for (String item : array) {
				ignoreList.add(item);
			}
		} catch (IOException e) {
			log.error("加载/rc-config.properties失败");
			e.printStackTrace();
		}*/
	}
}