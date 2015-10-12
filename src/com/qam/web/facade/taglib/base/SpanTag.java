package com.qam.web.facade.taglib.base;

import com.qam.framework.util.CommonUtils;
/**
 * 
 * <p>application name:      span样式</p>
 
 * <p>application describing:span样式</p>
 
 * 
 * @author zhou
 * @version ver 1.0
 */
public class SpanTag extends BaseTag {
	private static final long serialVersionUID = -2518622467498971956L;

	public SpanTag() {
		super();
	}

	protected void prepareTagBegin(StringBuffer handlers) {
		handlers.append("<span ");

	}

	protected void prepareTagBody(StringBuffer handlers) {
		super.prepareTagBody(handlers);
		handlers.append(">");
	}

	protected void prepareTagEnd(StringBuffer handlers) {
		handlers.append("</span>");
	}

	protected void prepareTagValue(StringBuffer handlers) {
		handlers.append(CommonUtils.null2Blank(CommonUtils
				.convertToHTMLStr(getValue())));

	}

	protected void recombineTagProperties() {
		super.recombineTagProperties();
	}

	public void release() {
		super.release();
	}
}
