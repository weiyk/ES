package com.rc.web.extension.ajax;

import java.sql.ResultSet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
/**
 * <p>application name:     select异步</p>
 
 * <p>application describing:异步返回select的option如果value为多个则以逗号分隔</p>
 
 * 
 * @author hdx
 * @version ver 1.0
 */
public class GetOptionsService implements IAjaxService {
	private static Log log = LogFactory.getLog(GetOptionsService.class);
	public String execute(AjaxServiceParameter param) throws Exception {
		StringBuffer options = new StringBuffer(128);
		String tableName = param.getParameter("tableName");//表名称
		String textField = param.getParameter("textField");//显示字段名称
		String valueField = param.getParameter("valueField");//值名称
		String condition = param.getParameter("condition");//查询条件
		String initText = param.getParameter("initText");//缺省显示
		String dataSource = param.getParameter("dataSource");//数据源
		String seletcedValue = param.getParameter("seletcedValue");//需选择的选择项
		if(CommonUtils.null2Blank(initText).length() > 0){
			options.append("<option value=\"\">").append(initText).append("</option>");
		}
		if(CommonUtils.null2Blank(tableName).length() == 0 || CommonUtils.null2Blank(textField).length() == 0
			|| CommonUtils.null2Blank(valueField).length() == 0 || CommonUtils.null2Blank(condition).length() == 0){
			return options.toString();
		}
		IDataBaseAccess dbm = null;
		try{
			if(dataSource != null && dataSource.length() > 0){
				dbm = ContextService.lookupDataBaseAccess(dataSource);
			}else{
				dbm = ContextService.lookupDefaultDataBaseAccess();
			}
			String[] vFields = valueField.split(";");
			StringBuffer sql = new StringBuffer(128);
			sql.append("SELECT ").append(textField).append(",").append(valueField.replaceAll(";", ",")).append(" FROM ").append(tableName);
			if(condition.contains("WHERE") || condition.contains("where")){
				sql.append(" ").append(condition);
			}else{
				sql.append(" WHERE ").append(condition);
			}
			log.debug("optionsSQL:"+sql);
			dbm.openConnection();
			ResultSet rs = dbm.executeQuery(sql.toString());
			StringBuffer values = new StringBuffer(64);
			while(rs.next()){
				options.append("<option value='");
				values.delete(0, values.length());
				for(String field : vFields){
					if(field.indexOf("as")!= -1){//如果有别名
						field = field.split("as")[1];
					}else if(field.indexOf("AS") != -1){//如果有别名
						field = field.split("AS")[1];
					}
					values.append(rs.getString(field.trim())).append(",");
				}
				values.delete(values.length() - 1, values.length());
				options.append(values).append("'");
				//如果包含要选中的值，则自动添加选中属性
				if(CommonUtils.null2Blank(seletcedValue).length() > 0 && values.toString().contains(seletcedValue)){
					options.append(" selected='selected'");
				}
				options.append(">").append(rs.getString(1));
				options.append("</option>");
			}
			rs.close();
		}finally{
			if(dbm != null)dbm.closeConnection();
		}
		return options.toString();
	}
}
