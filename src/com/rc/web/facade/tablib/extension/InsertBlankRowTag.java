package com.rc.web.facade.tablib.extension;

import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.beans.InsertRowEntry;
import com.qam.web.facade.taglib.support.TagUtil;
/**
 * 
 * <p>application name:      多条建立时,添加空白标签(已没用)</p>
 
 * <p>application describing:多条建立时,添加空白标签</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class InsertBlankRowTag extends TagSupport {

	private static final long serialVersionUID = 816577451190300090L;
	public int doEndTag() throws JspException {
		super.release();
		return EVAL_PAGE;
	}
	public InsertBlankRowTag() {
		super();
		
	}
	public int doStartTag() throws JspException{
		TagUtil.write(pageContext,ouputInsertBlankRow());		
		return SKIP_BODY;
	}
	private String ouputInsertBlankRow(){
		Object obj = pageContext.getAttribute(QamWebDataConstants.QAM_INSERT_BLANK_ROWS);
		
		if(obj!=null){
			List list = (List) obj;
			StringBuffer scripts=new StringBuffer();
			scripts.append("<script language=\"javascript\">");
			for(int i=0;i<list.size();i++){
				InsertRowEntry entry = (InsertRowEntry)list.get(i);
				scripts.append(" \n\tvar _qam_");
				scripts.append(entry.getId());
				scripts.append("_index=");
				scripts.append(entry.getIndex());
				scripts.append(";");
			}
			
			scripts.append("\n\tfunction insertBlankRow(groupId){");			
			for(int i=0;i<list.size();i++){
				InsertRowEntry entry = (InsertRowEntry)list.get(i);
				
				scripts.append("\n\t\tif(\"");
				scripts.append(entry.getId());
				scripts.append("\"==groupId){");
				scripts.append("\n\t\t\t");
				scripts.append(QamWebDataConstants.QAM_EXTFUNCTIONCM);
				scripts.append("insertTable(document.getElementById(groupId),\"");
				//zhuqm,2010-11-11增加 修正脚本中出现"\\"导致脚本出错
				String str = entry.getScripts().replaceAll("\\\\","\\\\\\\\");
				//ted,2009-12-3增加
				//String str = entry.getScripts().replaceAll("\\","\\\\\\\\");
				//ted,2009-12-3增加
				str = str.replaceAll("\"","\\\\\"");
				str = str.replaceAll("\t","");
				str = str.replaceAll("\n","");
				str = str.replaceAll("_qam_"+entry.getId()+"_index","\"+_qam_"+entry.getId()+"_index+\"");
				//处理combox hdx 2012-03-20
				String s = "";
				if(str.indexOf("<script") != -1){
					s = str.substring(str.indexOf("<script"),str.indexOf("</script>")+9);
					str = str.replace(s, "");
					s = s.replaceAll("\"", "'");
					s = s.substring(s.indexOf("initCombox"),s.indexOf("</script>")-3);
				}
				scripts.append(str);
				scripts.append("\");");
				//处理combox hdx 2012-03-20
				scripts.append(s);
				scripts.append("\n\t\t\t_qam_");
				scripts.append(entry.getId());
				scripts.append("_index++;");
				scripts.append("\n\t\t");
				scripts.append(QamWebDataConstants.QAM_EXTFUNCTIONCM);
				scripts.append("getObject(\"");
				scripts.append(QamWebDataConstants.QAM_SUBMIT_ROWCOUNT);				
				scripts.append(entry.getId());
				scripts.append("\").value =");
				scripts.append("_qam_");
				scripts.append(entry.getId());
				scripts.append("_index;");
				
				scripts.append("\n\t\t\treturn;\n\t\t}");
			}
			scripts.append("\n\t}");
			scripts.append("\n</script>");
			return scripts.toString();
		}
		return "";
	}
}
