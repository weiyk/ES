package com.rc.web.extension.ajax;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;
/**
 * 
 * @author 重置密码
 *
 */
public class ResetPassword  implements IAjaxService {
	private static Log log = LogFactory.getLog("ResetPassword");
	public String execute(AjaxServiceParameter params) throws Exception {
		String phone = params.getParameter("phone");      //电话号码
		String reset = params.getParameter("reset");	  //重置原因
		String userName = params.getParameter("userName");//重置原因
		HttpWebs wes = new HttpWebs();
		wes.init();
		String str="";//返回Json数据
		String msg="";
		try {
			Map<String, String> parmMap = new HashMap<String, String>();
			parmMap.put("mobile",phone);								//电话号码
			parmMap.put("content",URLEncoder.encode(reset, "utf-8"));	//重置原因
			parmMap.put("loginId",URLEncoder.encode(userName, "utf-8"));//登录名
			GetUrl ur=new GetUrl();
			String url=ur.getUrl("ChongZhiMM_url");
			str = Base64Util.decrypt(wes.callByPost(url, parmMap));// 解密
			String msgCode=str.substring(str.indexOf(":")+1, str.indexOf(":")+2);
			if(msgCode.equals("1")){
				msg="重置密码成功！";
			}else{
				msg="重置密码失败！";
			}
			
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
		return msg;
	}
}
