package com.qam.web.facade.taglib.extension;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.Map;


import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.taglib.base.BaseTag;
import com.qam.web.facade.taglib.base.HiddenTag;
import com.qam.web.facade.taglib.base.TextTag;

/**
 * 
 * <p>application name:      下拉框扩展</p>
 
 * <p>application describing:下拉框扩展</p>
 
 * 
 * @author hdx
 * @version ver 1.0
 */
public class SelectExtensionTag extends BaseTag {
	public String getDataBase() {
		return dataBase;
	}

	public void setDataBase(String dataBase) {
		this.dataBase = dataBase;
	}

	public String getEnumSQL() {
		return enumSQL;
	}

	public void setEnumSQL(String enumSQL) {
		this.enumSQL = enumSQL;
	}

	public SelectExtensionTag() {
		width = 148;
		height = 150;
		doReadonly = true;
		doDisabled = true;
		opMap = new HashMap<String, String>(20);
	}

	public String getEnumType() {
		if(CommonUtils.null2Blank(enumType).length() > 0){
			return enumType;
		}
		if(this.getDialogItem() != null && this.getDialogItem().getSourceType() != null){
			return this.getDialogItem().getSourceType().getName();
		}
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
		//opMap = null;
	}

	public String getSerchFiled() {
		return serchFiled;
	}

	public void setSerchFiled(String serchFiled) {
		this.serchFiled = serchFiled;
	}
	/**
	 * 生成扩展标签
	 * @return
	 */
	private String genSelTag(){
		String optionValue = this.getOptions();
		String[] optionValues = optionValue.split(";");
		StringBuffer html = new StringBuffer(128);
		html.append("<span class=\"combo");
		if(getModeStyle() != null){
			html.append(" " + getModeStyle());
		}
		html.append("\"");
		if(CommonUtils.null2Blank(this.getStyle()).length() > 0){
			html.append(" style=\"").append(this.getStyle()).append("\"");
		}
		html.append(">");
		TextTag textTag = new TextTag();
		textTag.setId(getId()+"_ComSelect");
		textTag.setName(textTag.getId());
		if (getValue() != null)
			textTag.setValue(this.opMap.get(getValue()));
		textTag.setOndblclick(getOndblclick());
		if(getDialogItem() != null && getDialogItem().getDialogGroup() != null){
			textTag.setDialogItem(getDialogItem().getDialogGroup().findDialogItem(textTag.getId()));
		}
		textTag.setOnkeypress(getOnkeypress());
		textTag.setOnmousedown(getOnmousedown());
		textTag.setOnmousemove(getOnmousemove());
		textTag.setOnmouseup(getOnmouseup());
		textTag.setOther(getOther());
		textTag.setReadonly(true);
		textTag.setMaxLength(maxLength);
		textTag.setModeStyle("combo-text");
		if (getWidth() != 0)
			width = getWidth();
		if(this.getTextStyle() != null){
			textTag.setStyle(getTextStyle());
		}else{
			if(getStyle() != null){
				textTag.setStyle(getStyle());
			}else{
				textTag.setStyle("width:" + width + "px;height:20px;"+getDialogItem().getStyle()+";");
			}
		}
		html.append(textTag.toHTML());
		HiddenTag hidden = new HiddenTag();
		hidden.setId(getId());
		hidden.setName(getId());
		if ((this.getValue() == null || this.getValue().length() == 0) && getDialogItem() != null)
			hidden.setValue(getDialogItem().getValue());
		else
			hidden.setValue(getValue());
		html.append(hidden.toHTML());
		html.append("<span class=\"combo-arrow\"");
		if(!this.isReadonly() && !this.isDisabled()){
			html.append(" onclick=\"$(this)._showMenu('").append(this.getId()).append("_ComSelect','").append(this.getId()).append("_Sel');return false;\" ");
		}
		html.append("/></span>");
		html.append(this.getDataArea(optionValues));
		return html.toString();
	}
	/**
	 * 获取数据区
	 * @param optionValues
	 * @return
	 */
	private String getDataArea(String... optionValues){
		StringBuffer data = new StringBuffer(128);
		data.append("<div  style=\"top: 0; left: 0; z-index: 1;position: absolute;\"><div id=\"").append(this.getId()).append("_Sel\"")
			.append(" class=\"combox_tree ");
		if(getModeStyle() != null){
			data.append(getModeStyle());
		}
		data.append("\" style=\"position: absolute;overflow-x:auto;overflow-y:auto; display: none;");
		if(getHeight() != 0){
			data.append("height:").append(getHeight()).append("px;");
		}else{
			data.append("height:150px;");
		}
		data.append("\">");
		data.append("<table width=\"100%\">");
		//如果有缺省显示值则放到底第一位
		if(this.getInitText() != null){
			data.append("<tr><td style=\"cursor: pointer;\" value=\"").append(this.getInitValue()).append("\" text=\"").append(this.getInitText()).append("\"");
			data.append(" onclick=\"$(this)._select_click('").append(this.getId()).append("',this)\">").append(this.getInitText()).append("</td></tr>");
		}
		for(String op : optionValues){
			String[] ops = op.split(",");
			if(ops.length < 2) continue;
			data.append("<tr><td style=\"cursor: pointer;\" value=\"").append(ops[1]).append("\" text=\"").append(ops[0]).append("\"");
			data.append(" onclick=\"$(this)._select_click('").append(this.getId()).append("',this)\" onmousemove=\"");
			if(getOnmousemove() != null){
				data.append(getOnmousemove());
			}else{
				data.append("$(this)._select_mousemoveOrout(this,'move')");
			}
			data.append("\" onmouseout=\"");
			if(getOnmouseout() != null){
				data.append(getOnmouseout());
			}else{
				data.append("$(this)._select_mousemoveOrout(this,'out')");
			}
			data.append("\">").append(ops[0]).append("</td></tr>");
		}
		data.append("</table></div></div>");
		return data.toString() ;
	}
	public void toHTML(StringBuffer html) {
		html.append(this.genSelTag());
	}
	/**
	 * 获取搜索字段的值
	 * 
	 * @return
	 */
	private String getOptions() {
		StringBuffer searchValue = new StringBuffer(128);
		IDataBaseAccess dbm = null;
		ResultSet rs = null;
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
				rs = dbm.executeQuery(this.getEnumSQL());
				int count = 0;
				while (rs.next()) {
					if (count == 0) {
						ResultSetMetaData md = rs.getMetaData();
						count = md.getColumnCount();
					}
					if (count >= 2) {
						searchValue.append(rs.getString(1));// text
						searchValue.append(",");
						searchValue.append(rs.getString(2));// value
					}
					searchValue.append(";");
					opMap.put(rs.getString(2), rs.getString(1));
				}
			}
			if (this.getOptionValues() != null && this.getOptionValues().length() > 0) {
				for(String op : this.getOptionValues().split(";")){
					opMap.put(op.split(",")[1], op.split(",")[0]);
				}
				searchValue.append(this.getOptionValues());
			}
			if(this.getEnumType() != null && this.getEnumType().length() > 0){
				if(searchValue.lastIndexOf(";") != searchValue.length() - 1){
					searchValue.append(";");
				}
				rs = dbm.executeQuery("SELECT ZHI,BIANMA FROM QAM_JIHEYZ WHERE ZHUANGTAI = '1' AND JIHEYLX = '"+this.getEnumType()+"'");
				while(rs.next()){
					searchValue.append(rs.getString(1));// text
					searchValue.append(",");
					searchValue.append(rs.getString(2));// value
					searchValue.append(";");
					opMap.put(rs.getString(2), rs.getString(1));
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

	private static final long serialVersionUID = 816577451190300056L;
	private int width;
	private int height;
	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}


	private String maxLength;
	private String serchFiled;
	private String optionValues;
	private String enumType;
	private String dataBase;
	private Map<String, String> opMap = null;
	private String textStyle;
	private String initValue;
	public String getInitValue() {
		return initValue;
	}

	public void setInitValue(String initValue) {
		this.initValue = initValue;
	}

	public String getInitText() {
		return initText;
	}

	public void setInitText(String initText) {
		this.initText = initText;
	}

	private String initText;
	public String getTextStyle() {
		return textStyle;
	}

	public void setTextStyle(String textStyle) {
		this.textStyle = textStyle;
	}

	/**异步条件*/

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
