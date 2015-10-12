package com.qam.web.facade.taglib.base;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import com.qam.framework.beans.enumeration.DialogGroupType;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.beans.ui.OptionBean;
import com.qam.web.facade.taglib.base.BaseTag;
import com.qam.web.facade.taglib.base.SelectTag;
import com.qam.web.facade.taglib.base.TextTag;
/**
 * 
 * <p>application name:      处理combox</p>
 
 * <p>application describing:处理combox</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public final class ComboboxTag extends BaseTag {

	public String getDataBase() {
		return dataBase;
	}

	public void setDataBase(String dataBase) {
		this.dataBase = dataBase;
	}

	
	
	public String getEnumSQL() {
		if("false".equalsIgnoreCase(this.getAsync()) && CommonUtils.null2Blank(enumSQL).length() > 0){
			this.enumSQL = enumSQL.replaceAll("'", ";").replaceAll("%", ":");
		}else{
			return "";
		}
		return enumSQL;
	}

	public void setEnumSQL(String enumSQL) {
		this.enumSQL = enumSQL;
	}

	public ComboboxTag() {
		width = 148;
		doReadonly = true;
		doDisabled = true;
	}

	public String getEnumType() {
		return enumType;
	}

	public void setEnumType(String enumType) {
		this.enumType = enumType;
	}

	public String getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(String maxLength) {
		this.maxLength = maxLength;
	}

	public String getOptionValues() {
		return optionValues;
	}

	public void setOptionValues(String optionValues) {
		this.optionValues = optionValues;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public void release() {
		super.release();
		maxLength = null;
		width = 100;
		enumType = null;
		optionValues = null;
	}

	public String getSerchFiled() {
		return serchFiled;
	}

	public void setSerchFiled(String serchFiled) {
		this.serchFiled = serchFiled;
	}

	public void toHTML(StringBuffer html) {
		boolean isEmpty = getDialogItem().isEmpty();
		TextTag textTag = new TextTag();
		textTag.setId("box_"+getId());
		textTag.setName(textTag.getId());
		if (getValue() != null)
			textTag.setValue(getValue());
		textTag.setOndblclick(getOndblclick());
		textTag.setDialogItem(getDialogItem().getDialogGroup().findDialogItem("box_"+getId()));
		textTag.setOnkeypress(getOnkeypress());
		textTag.setOnmousedown(getOnmousedown());
		textTag.setOnmousemove(getOnmousemove());
		textTag.setOnmouseup(getOnmouseup());
		textTag.setOther(getOther());
		textTag.setMaxLength(maxLength);
		textTag.setModeStyle(getModeStyle());
		if (getWidth() != 0)
			width = getWidth();
		if(getStyle() != null){
			textTag.setStyle(getStyle());
		}else{
			textTag.setStyle("width:" + width + "px;height:20px;"+getDialogItem().getStyle()+";");
		}
		if(getDialogItem().getDialogGroup().getType()==DialogGroupType.Mutiple){
			textTag.setOnchange("ExtFunctionCM.changeRowState("+getId().substring(getId().length()-1)+",'_qam_row_state_"+getDialogItem().getDialogGroup().getId()+"');");
		}
		textTag.toHTML(html);
		SelectTag selectTag = null;
		if("true".equals(this.getAsync())){//同步输出select
			selectTag = new SelectTag();
			selectTag.setInitText("");
			selectTag.setInitValue("");
			selectTag.setDialogItem(getDialogItem());
			selectTag.setOptionValues(optionValues);
			selectTag.setEnumType(enumType);
			selectTag.setId(getId());
			selectTag.setDataBase(dataBase);
			selectTag.setEnumSQL(enumSQL);
			selectTag.setName(selectTag.getId());
			selectTag.setStyle("width:" + width + "px;font-size:12px;display:none");
			selectTag.toHTML(html);
		}else if("false".equals(this.getAsync())){//异步输出隐藏text
			TextTag hiddenText = new TextTag();
			hiddenText.setId(getId());
			hiddenText.setName(hiddenText.getId());
			hiddenText.setStyle("display:none");
			hiddenText.setDialogItem(getDialogItem());
			hiddenText.toHTML(html);
		}
		html.append("\n\t<script language=\"javascript\">");
		html.append(getReadyScript(selectTag));
		html.append("\n\t</script>");
		getDialogItem().setEmpty(isEmpty);
	}

	/**
	 * 获取搜索字段的值
	 * 
	 * @return
	 */
	private String getSearchFieldValue() {
		StringBuffer searchValue = new StringBuffer(128);
		IDataBaseAccess dbm = null;
		try {
			if (this.getEnumSQL() != null && this.getEnumSQL().length() > 0) {// 枚举sql传字段
				if (this.getDataBase() != null
						&& this.getDataBase().length() > 0) {
					dbm = ContextService.lookupDataBaseAccess(this
							.getDataBase());
				} else {
					dbm = ContextService.lookupDefaultDataBaseAccess();
				}
				dbm.openConnection();
				ResultSet rs = dbm.executeQuery(this.getEnumSQL());
				int count = 0;
				while (rs.next()) {
					if (count == 0) {
						ResultSetMetaData md = rs.getMetaData();
						count = md.getColumnCount();
					}
					if (count >= 3) {
						searchValue.append(rs.getString(1));// text
						searchValue.append(",");
						searchValue.append(rs.getString(2));// value
						searchValue.append(",");
						searchValue.append(rs.getString(3));// code 简码
					} else if (count >= 2) {
						searchValue.append(rs.getString(1));// text
						searchValue.append(",");
						searchValue.append(rs.getString(2));// value
						searchValue.append(",");
						searchValue.append(rs.getString(2));// code 简码
					}
					searchValue.append(";");
				}
			}
			if (this.getOptionValues() != null
					&& this.getOptionValues().length() > 0) {
				StringBuffer s = new StringBuffer(64);
				for(String op : this.getOptionValues().split(";")){
					String[] option = op.split(",");
					if(option.length < 3){
						s.append(op).append(",").append(option[0]).append(";");
					}
				}
				if(s.length() > 0){
					searchValue.append(s);
				}else{
					searchValue.append(this.getOptionValues());
				}
				
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (dbm != null)
				dbm.closeConnection();
		}
		return searchValue.toString();
	}
	/**
	 * 字段生成脚本
	 * @param selectTag
	 * @return
	 */
	private String getReadyScript(SelectTag selectTag){
		StringBuffer script = new StringBuffer(128);
		StringBuffer value = new StringBuffer(64);
		String str = "";
		script.append("\n\t$().ready(function(){");
		if("true".equalsIgnoreCase(async)){
			str = this.getSearchFieldValue();
			if(str != null && str.length() > 0){
				value.append(str);
			}else{
				for(Object obj : selectTag.getEnumValues()){
					OptionBean op = (OptionBean) obj;
					value.append(op.getText()).append(",").append(op.getValue()).append(",").append(op.getText()).append(";");
				}
			}
		}
		script.append("\n\t\tinitCombox('").append(getId()).append("','"+value+"',"+this.getAsync()+",'"+this.getEnumSQL()+"','"+CommonUtils.null2Blank(this.getUnsyncCondition())+"','"+CommonUtils.null2Blank(this.getDataBase())+"',"+CommonUtils.null2Blank(this.getPageNum())+",'"+CommonUtils.null2Blank(this.getInitTip())+"');");
		script.append("\n\t});");	
		return script.toString();
	}

	
	private static final long serialVersionUID = 816577451190300056L;
	private int width;
	private String maxLength;
	private String serchFiled;
	private String optionValues;
	private String enumType;
	private String dataBase;
	/**异步条件*/
	private String unsyncCondition;
	/**初始化提示信息*/
	private String initTip;
	/**初始化提示信息*/
	private Integer pageNum=6;

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public String getInitTip() {
		return initTip;
	}

	public void setInitTip(String initTip) {
		this.initTip = initTip;
	}

	public String getUnsyncCondition() {
		if(CommonUtils.null2Blank(unsyncCondition).length() > 0){
			this.unsyncCondition = unsyncCondition.replaceAll("'", ";").replaceAll("%", ",");
		}
		return unsyncCondition;
	}

	public void setUnsyncCondition(String unsyncCondition) {
		this.unsyncCondition = unsyncCondition;
	}

	private String enumSQL;
	/**同步异步 缺省值为true*/
	private String async="true";
	public String getAsync() {
		return async;
	}

	public void setAsync(String async) {
		this.async = async;
	}
}