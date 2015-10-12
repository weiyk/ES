package com.rc.web.extension.ajax;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;


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
public class UpdatecollectCount  implements IAjaxService {
	private static Log log = LogFactory.getLog("UpdatecollectCount");
	public String execute(AjaxServiceParameter params) throws Exception {
		HttpSession session = params.getRequest().getSession();
		String id = params.getParameter("id");      //资源编号
		String url_=params.getParameter("url");       //访问URL
		String uid = (String) session.getAttribute("XiTongHYBH");//用户编号
		HttpWebs wes = new HttpWebs();
		wes.init();
		String msg="访问知了树平台失败,请稍后再试!";//返回提示信息
		try {
			Map<String, String> parmMap = new HashMap<String, String>();
			parmMap.put("resId",id);   //资源编号
			parmMap.put("userId",uid);	//用户编号 
			GetUrl ur=new GetUrl();
			String url=ur.getUrl(url_); 
			//返回Json数据
			String str = Base64Util.decrypt(wes.callByPost(url, parmMap));// 解密
			String msgCode=str.substring(str.indexOf(":")+1, str.indexOf(":")+2);
			if(msgCode.equals("1")){ 
				if(url_.indexOf("save")!=-1){
					msg="收藏成功！";
					log.debug("》》》》》》》》》收藏资源成功！");
				}else{
					msg="取消收藏成功！";
					log.debug("》》》》》》》》》取消收藏成功！");
				}
			}else{ 
					msg=str.substring(str.lastIndexOf(":")+2, str.lastIndexOf("}")-1);
					log.debug("》》》》》》》》》"+msg);  
			}
			
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
		return msg;
	}
}
