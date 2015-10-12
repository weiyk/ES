package com.rc.web.ajax;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.util.CommonUtils;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
/**
 * 
 * <p>application name:      获取全局变量</p>
 
 * <p>application describing:获取全局变量</p>
 
 * 
 * @author zhou 
 * @version ver 1.0
 */
public class GetSessionService implements IAjaxService {
	private Log log = LogFactory.getLog(GetSessionService.class);
	public String execute(AjaxServiceParameter param) throws Exception { 
		String sessionId = (String) param.getParameter("sessionId");  
		String sessionValue = (String) param.getRequest().getSession().getAttribute(sessionId);
		log.debug(sessionId+":"+sessionValue);
		return CommonUtils.null2Blank(sessionValue);
	}
}
