package com.qam.web.facade.taglib.base;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.qam.framework.beans.dialog.CommandParameter;
import com.qam.framework.beans.dialog.CommandStructure;
import com.qam.framework.beans.dialog.Dialog;
import com.qam.framework.beans.dialog.DialogItem;
import com.qam.framework.beans.enumeration.CommandBindModel;
import com.qam.framework.beans.enumeration.CommandItemSourceType;
import com.qam.framework.beans.enumeration.ControllerType;
import com.qam.framework.beans.enumeration.DialogGroupType;
import com.qam.framework.beans.submitreturn.Record;
import com.qam.framework.beans.submitreturn.RecordItem;
import com.qam.framework.context.ContextService;
import com.qam.framework.context.ObjectNotFoundException;
import com.qam.framework.util.CommonUtils;
import com.qam.web.QamWebDataConstants;
import com.qam.web.facade.beans.ExecuteResultEntry;
import com.qam.web.facade.taglib.IBaseHtml;
import com.qam.web.facade.taglib.support.TagUtil;
/**
 * 
 * <p>application name:      按钮样式</p>
 
 * <p>application describing:按钮样式</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class CommandTag extends TagSupport implements IBaseHtml {

	private static final long serialVersionUID = -3037150300702526566L;

	private static final String ROWINDEX = "[ROWINDEX]";

	public int doEndTag() throws JspException {
		this.release();
		return EVAL_PAGE;
	}

	public CommandTag() {
		super();
	}

	private String id;//id

	private String windowWidth;//宽度

	private String windowHeight;//高度

	private String modeStyle;//按钮样式

	private String style;//stytle属性

	private CommandStructure command;//command对象

	private Record record;//结果集

	private Dialog dialog;//对话

	private String value;//值

	private String rowNumber;//行号

	private boolean enabled = true;//是否可编辑
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWindowWidth() {
		return windowWidth;
	}

	public void setWindowWidth(String windowWidth) {
		this.windowWidth = windowWidth;
	}

	public String getWindowHeight() {
		return windowHeight;
	}

	public void setWindowHeight(String windowHeight) {
		this.windowHeight = windowHeight;
	}

	public String getModeStyle() {
		return modeStyle;
	}

	public void setModeStyle(String modeStyle) {
		this.modeStyle = modeStyle;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public CommandStructure getCommand() {
		return command;
	}

	public void setCommand(CommandStructure command) {
		this.command = command;
	}

	public Record getRecord() {
		return record;
	}

	public void setRecord(Record record) {
		this.record = record;
	}

	public Dialog getDialog() {
		return dialog;
	}

	public void setDialog(Dialog dialog) {
		this.dialog = dialog;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(String rowNumber) {
		this.rowNumber = rowNumber;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	/**
	 * 初始化command及rowNumber
	 */
	public void init() {
		ExecuteResultEntry entry = TagUtil.getExecuteResultEntry(pageContext);
		if (entry == null)
			return;
		dialog = entry.getDialog();
		if (command != null)
			return;
		if (id != null) {
			command = dialog.findCommandStructure(id);
		}
		if (this.rowNumber == null || this.rowNumber.length() == 0) {
			Object rowNumber = pageContext.getAttribute(QamWebDataConstants.QAM_PAGE_ROWNUMBER);
			if (rowNumber != null) {
				this.rowNumber = rowNumber.toString();
			}
		}
	}
	public int doStartTag() throws JspException {
		init();
		TagUtil.write(pageContext, this.toHTML());
		return SKIP_BODY;
	}
	/**
	 * 点选完成返回
	 * @return
	 */
	private String buildSelectOkPara(){
		StringBuffer paras = new StringBuffer(64);
		if (command.getCommandParameters() != null) {
			for (int i = 0; i < command.getCommandParameters().size(); i++) {
				CommandParameter parameter = (CommandParameter) command
						.getCommandParameters().get(i);

				if (CommandItemSourceType.ConstValue.equals(parameter
						.getSourceType())) {
					// 常值原样返回
					paras.append("['").append(parameter.getId()).append("','").append(getParameterRelateValue(parameter)).append("'],");
				} else {
					paras.append("['").append(parameter.getId()).append("','").append("").append(CommonUtils.addBr(
									getParameterRelateValue(parameter))
									.replaceAll("'", "\\\\'").replaceAll("\"",
											"&quot;")).append("'],");

				}
			}
			paras.delete(paras.lastIndexOf(","), paras.length());
		}
		return  paras.insert(0,"[").insert(paras.length(), "]").toString();
	}
	/**
	 * 构建函数体参数
	 * 
	 * @return
	 */
	private String buildFuncPara() {
		String paras = "";
		if (command.getCommandParameters() != null) {
			for (int i = 0; i < command.getCommandParameters().size(); i++) {
				CommandParameter parameter = (CommandParameter) command
						.getCommandParameters().get(i);

				if (CommandItemSourceType.ConstValue.equals(parameter
						.getSourceType())) {
					// 常值原样返回
					paras += getParameterRelateValue(parameter) + ",";
				} else {
					paras += "'"
							+ CommonUtils.addBr(
									getParameterRelateValue(parameter))
									.replaceAll("'", "\\\\'").replaceAll("\"",
											"&quot;") + "',";

				}
			}
		}
		if (paras.length() > 0)
			return paras.substring(0, paras.length() - 1);
		return "";
	}
	/**
	 * 获取命令参数值
	 * 
	 * @param parameter
	 * @return
	 */
	private String getParameterRelateValue(CommandParameter parameter) {
		// try {
		String value = null;
		if (CommandItemSourceType.DialogItem.equals(parameter.getSourceType())) {
			// 关联类型为对话数据项
			if (record != null) {
				// 如果record不为空，则优先有record中取参数值(多条建立时)
				RecordItem item = record.getRecordItem(parameter
						.getRelateValue());

				if (item != null)
					value = item.getValue();
			}
			// 从单条建立的数据项中获取参数值
			if (value == null) {
				DialogItem dialogItem = dialog.findDialogItem(parameter
						.getRelateValue());
				if (dialogItem != null)
					value = dialogItem.getValue();
			}

		} else if (CommandItemSourceType.Parameter.equals(parameter
				.getSourceType())) {
			// 关联类型为对话参数
			if (pageContext != null)
				value = pageContext.getRequest().getParameter(
						parameter.getRelateValue());

		} else {
			value = parameter.getRelateValue();
		}
		return value;
	}
	private String buildSelectFunc(){
		String paras = "";
		if (command.getCommandParameters() != null) {
			for (int i = 0; i < command.getCommandParameters().size(); i++) {
				CommandParameter parameter = (CommandParameter) command
						.getCommandParameters().get(i);
				if (CommandItemSourceType.DialogItem.equals(parameter
						.getSourceType())) {
					DialogItem dialogItem = dialog.findDialogItem(parameter
							.getRelateValue());
					paras = paras + "['" + parameter.getId() + "','";
					if (dialogItem != null
							&& dialogItem.getDialogGroup() != null
							&& (DialogGroupType.Mutiple.equals(dialogItem
									.getDialogGroup().getType()) || DialogGroupType.QueryResult
									.equals(dialogItem.getDialogGroup()
											.getType()))
							&& getRowNumber() != null
							&& getRowNumber().length() > 0)
						paras = paras + parameter.getRelateValue() + "','"
								+ getRowNumber() + "','"+dialogItem.getDialogGroup().getId()+"'],";
					else
						paras = paras + parameter.getRelateValue() + "'],";
				}
			}
		}
		if (paras.length() > 0)
			return "[" + paras.substring(0, paras.length() - 1) + "]";
		return "";
	}
	/**
	 * 构建command事件
	 * @throws ObjectNotFoundException 
	 */
	private String buildCommandEvent() throws ObjectNotFoundException{
		StringBuffer script = new StringBuffer();
		if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_FUNC.equals(command
				.getCommandOpenType())) {
			// 命令控制结构触发方式为函数调用，此时约束表达式即是触发函数
			if (CommonUtils.null2Blank(command.getConstrainExp()).length() > 0) {
				script.append(command.getConstrainExp());
				String commandFuncPara = buildFuncPara();
				if (command.getConstrainExp().endsWith(")")) {
					int last = script.lastIndexOf(")");
					if (command.getConstrainExp().lastIndexOf("(") != last - 1) {
						if (commandFuncPara != null
								&& commandFuncPara.length() > 0)
							script.insert(last, "," + commandFuncPara);
					} else {
						script.insert(last, buildFuncPara());
					}
				} else {
					script.append("(").append(buildFuncPara()).append(")");
				}
			}
		}else if(QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT.equals(command.getCommandOpenType())){
			String selectFuncPara =
				//"'" + command.getId() + "'," +
				buildSelectFunc() + ",'" + buildUrl(false) + "','"+
				command.getTargetDialogId()+"',"
			+ command.getWindowWidth() + "," + command.getWindowHeight() + ",'"+
			ContextService.lookupDialog(command.getTargetDialogId()).getName()+"'";
	// 此时约束表达式为自定义的触发选择函数
	if (CommonUtils.null2Blank(command.getConstrainExp()).length() > 0) {
		script.append(command.getConstrainExp());
		if (command.getConstrainExp().endsWith(")")) {
			int last = script.lastIndexOf(")");
			if (command.getConstrainExp().lastIndexOf("(") != last - 1) {
				if (selectFuncPara != null
						&& selectFuncPara.length() > 0)
					script.insert(last, "," + selectFuncPara);
			} else {
				script.insert(last, selectFuncPara);
			}
		} else {
			script.append("(").append(selectFuncPara).append(")");
		}
	} else {
		// 自动产生触发选择函数
		//script.append("ExtFunctionCM.").append("SelectValue(")
				//.append(selectFuncPara).append(")");
		script.append("$(this)._selectValue(").append(selectFuncPara).append(")");
	}
		}else if(QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT_COMPLETE
				.equals(command.getCommandOpenType())){
			// 选择返回函数
			if (CommonUtils.null2Blank(command.getConstrainExp()).length() > 0) {
				script.append(command.getConstrainExp());
				String commandFuncPara = buildFuncPara();
				if (command.getConstrainExp().endsWith(")")) {
					int last = script.lastIndexOf(")");
					if (command.getConstrainExp().lastIndexOf("(") != last - 1) {
						if (commandFuncPara != null
								&& commandFuncPara.length() > 0)
							script.insert(last, "," + commandFuncPara);
					} else {
						script.insert(last, buildFuncPara());
					}
				} else {
					script.append("(").append(buildFuncPara()).append(")");
				}
			} else {
				script.append("$(this)._selectok").append(
						"(").append(buildSelectOkPara()).append(")");
			}
		}else{
			// 命令控制结构触发方式为页面条转或提交，此时需要满足约束表达式才条转或提交
			if (CommonUtils.null2Blank(command.getConstrainExp()).length() > 0) {
				String temp = command.getConstrainExp();
				if (!command.getConstrainExp().endsWith(")")
						&& !"true".equalsIgnoreCase(command.getConstrainExp())
						&& !"false".equalsIgnoreCase(command.getConstrainExp()))
					temp = command.getConstrainExp() + "(" + buildFuncPara()
							+ ")";
				script.append(" javascript:if(!");
				script.append(temp);
				script.append(") return;");
			}
			if (command.getExecuteProcessId() != null
					&& command.getExecuteProcessId().length() > 0
					|| QamWebDataConstants.QAM_COMMAND_OPENTYPE_SUBMIT
							.equals(command.getCommandOpenType())) {
				// 命令控制结构为执行事务或触发方式为submit_,此时做表单提交
				script.append("$(this)._submit('");
				script.append(buildUrl(true));
				script.append("')");
			}else{
				if (command.getCommandOpenType().length() == 0
						|| QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELF
								.equals(command.getCommandOpenType())) {
					// 当前窗口打开链接
					script.append("$(this)._self('");
					script.append(buildUrl(false));
					script.append("')");
				}else if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_BLANK
						.equals(command.getCommandOpenType())) {
					// 弹出新窗口
					script.append("$(this)._dialog('");
					script.append(buildUrl(false));
					script.append("','");
					script.append(command.getTargetDialogId());
					script.append("',");
					script.append(command.getWindowWidth());
					script.append(",");
					script.append(command.getWindowHeight());
					script.append(",'");
					script.append(ContextService.lookupDialog(command.getTargetDialogId()).getName());//缺省为对话名称
					script.append("')");
				}  else if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_CLOSE
						.equals(command.getCommandOpenType())) {
					// 关闭窗口
					script.append("$(this)._close('").append(command.getConstrainExp()).append("')");
				}
			}
		}
		String str = script.toString();
		if (this.rowNumber != null && this.rowNumber.length() > 0) {
			int poin = 0;
			while ((poin = str.indexOf(ROWINDEX)) > 0) {
				str = str.substring(0, poin) + this.rowNumber
						+ str.substring(poin + ROWINDEX.length());
				if (script.toString().equals(str)) {
					break;
				}
			}
		}
		return str.toString();
	}
	/**
	 * 构建命令跳转url
	 * 
	 * @param controlFlag
	 *            是否经过jspcontrolservlet控制
	 * @return
	 */
	private String buildUrl(boolean controlFlag) {
		StringBuffer url = new StringBuffer(128);
		if (controlFlag) {
			// 表单提交，此时需要提交标志为当前对话
			url.append(TagUtil.buildFullPath(pageContext,
					QamWebDataConstants.QAM_SERVLET_CONTROL));
			url.append("?");
			url.append(QamWebDataConstants.QAM_SUBMIT_COMMAND);
			url.append("=");
			url.append(command.getId());
			url.append("&");
			url.append(QamWebDataConstants.QAM_SUBMIT_DIALOG);
			url.append("=");
			url.append(dialog.getId());
			if (command.getDialogState() == null
					|| command.getDialogState().length() == 0) {
				if (dialog.getId().equals(command.getTargetDialogId())) {
					url.append("&");
					url.append(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE);
					url.append("=");
					url
							.append((String) pageContext
									.getAttribute("dialogState"));
				}
			}
			url.append("&");
			url.append(QamWebDataConstants.QAM_SUBMIT_SUBMITFLAG + "="
					+ dialog.getId());
		} else {
			// 页面跳转，不进行表单提交
			url.append(TagUtil.buildFullPath(pageContext,
					QamWebDataConstants.QAM_SERVLET_DISPATCH));
			url.append("?");
			url.append(QamWebDataConstants.QAM_SUBMIT_DIALOG);
			url.append("=");
			url.append(command.getTargetDialogId());
			url.append("&");
			url.append(QamWebDataConstants.QAM_SUBMIT_DIALOGSTATE);
			url.append("=");
			if (command.getDialogState() == null
					|| command.getDialogState().length() == 0) {
				if (dialog.getId().equals(command.getTargetDialogId())) {
					url
							.append((String) pageContext
									.getAttribute("dialogState"));
				}
			} else {
				url.append(command.getDialogState());

			}
			url.append("&");

		}
		String source = "";
		if (command.getCommandParameters() != null) {
			// 构建url参数
			for (int i = 0; i < command.getCommandParameters().size(); i++) {
				CommandParameter parameter = (CommandParameter) command
						.getCommandParameters().get(i);
				url.append("&");
				url.append(parameter.getId());
				url.append("=");
				source += parameter.getId() + ",";
				if (CommandItemSourceType.DialogItem.equals(parameter
						.getSourceType())) {
					DialogItem dialogItem = dialog.findDialogItem(parameter
							.getRelateValue());
					if (dialogItem != null
							&& !ControllerType.Label.equals(dialogItem
									.getControlType())) {
						if (!QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT
								.equals(command.getCommandOpenType())) {
							//url.append("'+");
							url.append(getParameterRelateValue(parameter));
							//url.append("$(this)._getValue('");
							//url.append("ExtFunctionCM.encodeURI(ExtFunctionCM.");
							//url.append("getObject('");
							//url.append(dialogItem.getId()).append("'");
						}
						/*source += dialogItem.getId();
						if (dialogItem.getDialogGroup() != null
								&& (DialogGroupType.Mutiple.equals(dialogItem
										.getDialogGroup().getType()) || DialogGroupType.QueryResult
										.equals(dialogItem.getDialogGroup()
												.getType()))
								&& getRowNumber() != null
								&& getRowNumber().length() > 0) {
							if (!QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT
									.equals(command.getCommandOpenType())) {
								url.append(",'");
								url.append(dialogItem.getDialogGroup().getId());
								url.append("',");
								url.append(getRowNumber());
							}
							source += "_" + getRowNumber();
						}
						if (!QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT
								.equals(command.getCommandOpenType())) {
							url.append(")+'");
						}*/
					} else {
						source += parameter.getRelateValue();
						url.append(CommonUtils
										.null2Blank(TagUtil
												.parseURLEncode(getParameterRelateValue(parameter))));

					}
				} else {
					source += parameter.getRelateValue();
					url.append(CommonUtils.null2Blank(TagUtil
											.parseURLEncode(getParameterRelateValue(parameter))));
				}
				source += ";";
			}

		}
		//url.append("&_qam_para_source=").append(source);
		return url.toString();
	}
	public String toHTML() {
		StringBuffer s = new StringBuffer(64);
		toHTML(s);
		String str = s.toString();
		s = null;
		return str;
	}
	/**
	 * 资源释放
	 */
	public void release() {
		super.release();
		id = null;
		command = null;
		record = null;
		windowWidth = null;
		windowHeight = null;
		rowNumber = null;
		value = null;
		enabled = true;
		modeStyle = null;
		style = null;
	}
	public void toHTML(StringBuffer handlers) {

		BaseTag baseTag = null;
		if (command == null)
			return;
		if (CommandBindModel.Button.equals(command.getBindModel())) {
			if (!command.isDisplay())
				return;
			baseTag = new ButtonTag();
			baseTag.setId(command.getId());
			baseTag.setName(command.getId());
			baseTag.setValue(this.getValue() == null ? command.getName() : getValue());
			baseTag.setModeStyle(getModeStyle());
			if (QamWebDataConstants.QAM_COMMAND_OPENTYPE_SELECT.equals(command
					.getCommandOpenType())) {
				baseTag = new SpanTag();
				baseTag.setStyle(getStyle());
				baseTag.setId(command.getId());
				baseTag.setValue(this.getValue() == null ? "" : getValue());
				baseTag.setModeStyle(getModeStyle());
				if (this.getValue() == null || this.getValue().length() <= 0) {
					baseTag.setModeStyle(this.getModeStyle() == null ? "f_btn_select" : getModeStyle());
				}
			}
			baseTag.setStyle(getStyle());
			if (!command.isEnabled()) {
				// 没有操作权限，按钮不可用
				baseTag.setDisabled(true);
				baseTag.toHTML(handlers);
				return;
			} else if (!enabled) {
				baseTag.setDisabled(true);
			}
		} else if (CommandBindModel.Link.equals(command.getBindModel())) {
			baseTag = new LinkTag();
			String titleValue = "";
			if (record != null) {
				RecordItem reocrdItem = record.getRecordItem(command
						.getBindDialogItemId());
				DialogItem dialogItem = this.dialog.findDialogItem(command
						.getBindDialogItemId());
				if (reocrdItem != null) {
					if (CommonUtils.null2Blank(reocrdItem.getValue()).length() > 0) {
						baseTag.setValue(dialogItem.getFormatValue(reocrdItem
								.getValue()));
						titleValue = reocrdItem.getValue();
					} else {
						return;
					}
				} else {
					baseTag.setValue(dialogItem.getFormatValue(command
							.getName()));
					titleValue = command.getName();
				}
			} else {
				DialogItem dialogItem = this.dialog.findDialogItem(command
						.getBindDialogItemId());
				if (dialogItem != null) {
					if (dialogItem.getFormatValue() != null
							&& dialogItem.getFormatValue().length() > 0) {
						baseTag.setValue(dialogItem.getFormatValue());
						titleValue = dialogItem.getValue();
					} else {
						return;
					}
				} else {
					if (this.getValue() == null
							|| this.getValue().length() == 0) {
						baseTag.setValue(command.getName());
						titleValue = command.getName();
					} else {
						baseTag.setValue(this.getValue());
						titleValue = this.getValue();
					}
				}
			}
			if (!command.isDisplay()) {
				handlers.append(baseTag.getValue());
				return;
			}
			if (!command.isEnabled() || !enabled) {
				// 没有操作权限，超链接不可用
				LabelTag label = new LabelTag();
				label.setValue(baseTag.getValue());
				label.toHTML(handlers);
				return;
			}
			baseTag.setTitle(titleValue);
			baseTag.setModeStyle(getModeStyle());
			baseTag.setStyle(getStyle());

		}
		try {
			baseTag.setOnclick(buildCommandEvent());
		} catch (ObjectNotFoundException e) {
			e.printStackTrace();
		}
		baseTag.toHTML(handlers);
	}
}
