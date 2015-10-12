package com.rc.web.extension.ajax;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
public class UpdateDownLoadCount  implements IAjaxService {
	private static Log log = LogFactory.getLog("UpdateDownLoadCount");
	public String execute(AjaxServiceParameter params) throws Exception {
		HttpSession session = params.getRequest().getSession();
		String id = params.getParameter("id");      //资源编号
		String uid = (String) session.getAttribute("XiTongHYBH");//用户编号
		HttpWebs wes = new HttpWebs();
		wes.init();
		String msg="";//返回提示信息
		try {
			Map<String, String> parmMap = new HashMap<String, String>();
			parmMap.put("resId",id);   //资源编号
			parmMap.put("userId",uid);	//用户编号 
			GetUrl ur=new GetUrl();
			String url=ur.getUrl("downloadcount_url");
			//返回Json数据
			String str = Base64Util.decrypt(wes.callByPost(url, parmMap));// 解密
			String msgCode=str.substring(str.indexOf(":")+1, str.indexOf(":")+2);
			if(msgCode.equals("1")){ 
				log.debug("》》》》》》》》》更新资源下载数成功！");
			}else{
				log.debug("》》》》》》》》》更新资源下载数失败！");
			}
			
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
		return msg;
	}
}
