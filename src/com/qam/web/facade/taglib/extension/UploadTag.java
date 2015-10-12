package com.qam.web.facade.taglib.extension;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.taglib.support.TagUtil;

public class UploadTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 816577451190300159L;

	private String folderPath = "";// 文件存放的路径

	private String fileRename = "";// 文件重命名

	private String fileExistedAction = "override"; // 文件存在后的处理,有效值

	private long maxFileSize = 100*1024*1024;//缺省值为30MB

	private long totalMaxFileSize = 0;

	private String allowedFilesList = ""; // 允许上传的文件扩展名列表

	private String deniedFilesList = "exe,bat"; // 禁止上传的文件扩展名列表

	private String fileAttribute = " style=\"width:80%;height:20px\"";

	private String buttonName = "上传";

	private String buttonAttribute = "";

	private String frameAttribute = "width=\"100%\" frameborder=\"0\" marginwidth=\"0\" frameborder=\"0\" scrolling=\"no\"";

	private String id = "u_ifujian";
	
	private boolean rename = true;


	public boolean isRename() {
		return rename;
	}

	public void setRename(boolean rename) {
		this.rename = rename;
	}

	private String frameHeight = "30";

	private String doAfterUpload = "";

	private String doBeforeUpload = "";

	private String doBeforeDel = "";

	private String doAfterDel = "";

	private boolean useButton = true;
	
	private boolean useButton_cam = true;

	private boolean showMessage = true;

	private boolean showFileList = true;

	private int fileCount = 0; // 允许上传的文件数量

	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public boolean isShowMessage() {
		return showMessage;
	}

	public void setShowMessage(boolean showMessage) {
		this.showMessage = showMessage;
	}

	private String buildUpload() {
		String contextPath = ((HttpServletRequest) pageContext.getRequest())
				.getContextPath();
		StringBuffer html = new StringBuffer();

		html.append("<iframe id=\"").append(getId()).append("\" ");
				//.append(getId()).append("\" ");
		html.append(this.frameAttribute);
		TagUtil.prepareAttribute(html, "height", this.getFrameHeight());
		html.append("src=\"");
		html.append(contextPath);
		html.append("/common/upload.jsp?folderPath=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(folderPath)));
		html.append("&id=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(id)));
		html.append("&allowedFilesList=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(allowedFilesList)));
		html.append("&deniedFilesList=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(deniedFilesList)));
		html.append("&fileRename=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(fileRename)));
		html.append("&fileExistedAction=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(fileExistedAction)));
		html.append("&totalMaxFileSize=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(String
				.valueOf(totalMaxFileSize))));
		html.append("&maxFileSize=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(String
				.valueOf(maxFileSize))));
		html.append("&doAfterUpload=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(doAfterUpload)));
		html.append("&doBeforeUpload=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(doBeforeUpload)));
		html.append("&doBeforeDel=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(this.doBeforeDel)));
		html.append("&doAfterDel=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(this.doAfterDel)));
		html.append("&buttonName=");
		html.append(CommonUtils.null2Blank(TagUtil.parseURLEncode(buttonName)));
		html.append("&buttonAttribute=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(buttonAttribute)));
		html.append("&fileAttribute=");
		html.append(CommonUtils.null2Blank(TagUtil
				.parseURLEncode(fileAttribute)));
		html.append("&fileCount=");
		html.append(fileCount);
		html.append("&useButton=");
		html.append(useButton);
		html.append("&useButton_cam=");
		html.append(useButton_cam);
		html.append("&showMessage=");
		html.append(showMessage);
		html.append("&isRename=");
		html.append(isRename());
		html.append("&showFileList=");
		html.append(showFileList);
		html.append("\"></iframe>");
		html.append("\n<script type=\"text/javascript\">\n\t var ").append(
				getId()).append("=window.frames[window.frames.length-1];\n</script>");
		return html.toString();
	}

	public int doEndTag() throws JspException {
		this.release();
		return EVAL_PAGE;
	}

	public int doStartTag() throws JspException {
		TagUtil.write(pageContext, buildUpload());
		return EVAL_BODY_INCLUDE;
	}

	public String getButtonName() {
		return buttonName;
	}

	public void setButtonName(String name) {
		this.buttonName = name;
	}

	public String getFileAttribute() {
		return fileAttribute;
	}

	public void setFileAttribute(String size) {
		this.fileAttribute = size;
	}

	public String getFolderPath() {
		return folderPath;
	}

	public void setFolderPath(String folderPath) {
		this.folderPath = folderPath;
	}

	public void release() {
		super.release();

		folderPath = "";
		fileAttribute = " style=\"width:80%;height:20px\" ";
		buttonName = "上传";
		doAfterUpload = "";
		allowedFilesList = "";
		doBeforeDel = "";
		doAfterDel = "";
		deniedFilesList = "exe,bat";
		fileRename = "";
		fileExistedAction = "override";
		maxFileSize = 0;
		totalMaxFileSize = 0;
		useButton = true;
		useButton_cam=true;
		buttonAttribute = "";
		frameAttribute = "width=\"100%\" frameborder=\"0\" marginwidth=\"0\" frameborder=\"0\" scrolling=\"no\"";
		frameHeight = "30";
		doBeforeUpload = "";
		showMessage = true;
		id = "u_ifujian";
		fileCount = 0;
		showFileList = true;
		rename = true;
	}

	public String getAllowedFilesList() {
		return allowedFilesList;
	}

	public void setAllowedFilesList(String allowedFilesList) {
		this.allowedFilesList = allowedFilesList;
	}

	public String getDoAfterUpload() {
		return doAfterUpload;
	}

	public void setDoAfterUpload(String callBack) {
		if (callBack != null && callBack.length() > 0) {
			if (callBack.indexOf("(") > 0) {
				callBack = callBack.substring(0, callBack.indexOf("("));
			}
		}
		this.doAfterUpload = callBack;
	}

	public String getDeniedFilesList() {
		return deniedFilesList;
	}

	public void setDeniedFilesList(String deniedFilesList) {
		this.deniedFilesList = deniedFilesList;
	}

	public String getFileExistedAction() {
		return fileExistedAction;
	}

	public void setFileExistedAction(String fileExistedAction) {
		this.fileExistedAction = fileExistedAction;
	}

	public String getFileRename() {
		return fileRename;
	}

	public void setFileRename(String filerename) {
		this.fileRename = filerename;
	}

	public long getMaxFileSize() {
		return maxFileSize;
	}

	public void setMaxFileSize(long maxFileSize) {
		this.maxFileSize = maxFileSize*1024;
	}

	public long getTotalMaxFileSize() {
		return totalMaxFileSize;
	}

	public void setTotalMaxFileSize(long totalMaxFileSize) {
		this.totalMaxFileSize = totalMaxFileSize*1024;
	}

	public boolean isUseButton() {
		return useButton;
	}

	public void setUseButton(boolean displayFileInput) {
		this.useButton = displayFileInput;
	}

	public String getButtonAttribute() {
		return buttonAttribute;
	}

	public void setButtonAttribute(String buttonAttribute) {
		this.buttonAttribute = buttonAttribute;
	}

	public String getFrameAttribute() {
		return frameAttribute;
	}

	public void setFrameAttribute(String frameAttribute) {
		this.frameAttribute = frameAttribute;
	}

	public String getFrameHeight() {
		return frameHeight;
	}

	public void setFrameHeight(String frameHeight) {
		this.frameHeight = frameHeight;
	}

	public String getDoBeforeUpload() {
		return doBeforeUpload;
	}

	public void setDoBeforeUpload(String doBeforeUpload) {
		if (doBeforeUpload != null && doBeforeUpload.length() > 0) {
			if (doBeforeUpload.indexOf("(") == -1) {
				doBeforeUpload = doBeforeUpload + "()";
			}
		}
		this.doBeforeUpload = doBeforeUpload;
	}

	public String getId() {
		return id;
	}

	public void setId(String frameId) {
		this.id = frameId;
	}

	public boolean isShowFileList() {
		return showFileList;
	}

	public void setShowFileList(boolean showFileList) {
		this.showFileList = showFileList;
	}

	public String getDoAfterDel() {
		return doAfterDel;
	}

	public void setDoAfterDel(String afterDeleteCallBack) {
		if (afterDeleteCallBack != null && afterDeleteCallBack.length() > 0) {
			if (afterDeleteCallBack.indexOf("(") > 0) {
				afterDeleteCallBack = afterDeleteCallBack.substring(0,
						afterDeleteCallBack.indexOf("("));
			}
		}
		this.doAfterDel = afterDeleteCallBack;
	}

	public String getDoBeforeDel() {
		return doBeforeDel;
	}

	public void setDoBeforeDel(String beroreDeleteCallBack) {
		if (beroreDeleteCallBack != null && beroreDeleteCallBack.length() > 0) {
			if (beroreDeleteCallBack.indexOf("(") == -1) {
				beroreDeleteCallBack = beroreDeleteCallBack + "()";
			}
		}
		this.doBeforeDel = beroreDeleteCallBack;
	}
	public boolean isUseButton_cam() {
		return useButton_cam;
	}

	public void setUseButton_cam(boolean useButton_cam) {
		this.useButton_cam = useButton_cam;
	}
}
