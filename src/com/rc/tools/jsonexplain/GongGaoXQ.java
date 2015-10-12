package com.rc.tools.jsonexplain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

/**
 * 
 * @author 公告详情
 * 
 *
 */
public class GongGaoXQ {
		
		/**
		 * 解析JSON字符串
		 * 
		 * @return nodes 
		 */
		public List<Object> getJSONGongGaoXQBS(String key,String uid,String articleId){
			 HttpWebs wes = new HttpWebs();
			 wes.init();
			 List<Object> list =new ArrayList<Object>();
			 Map<String, String> parmMap = new HashMap<String, String>();
			 parmMap.put("key",key);
				parmMap.put("uid",uid);
				parmMap.put("articleId",articleId);
				GetUrl ur=new GetUrl();
				String url=ur.getUrl("GongGaoXQ_url");
				String str = wes.callByPost(url, parmMap);
				if(str==null){return list;}
				str = Base64Util.decrypt(str);// 解密
				JSONObject ob=JSONObject.fromObject(str);
				list.add(ob.get("msgCode"));//返回码（0/1）
				list.add(ob.get("msg"));//返回信息
				list.add(ob.get("notice"));//结果集
				return list;
		    }
			/**
			 * 公告详情信息
			 * @param obj
			 * @return
			 */
			public Map<String,String> getJsonGGXQ(Object obj){
				Map<String,String> map =new HashMap<String,String>();
				JSONObject jsonNode = JSONObject.fromObject(obj);
					if(jsonNode.containsKey("afterId")){
						map.put("afterId",jsonNode.getString("afterId"));        //下一条ID
						map.put("afterTitle",jsonNode.getString("afterTitle"));  //下一条标题
					}else{
						map.put("afterId","");        							 //下一条ID
						map.put("afterTitle","");  								 //下一条标题
					}
					if(jsonNode.containsKey("beforId")){
						map.put("beforId",jsonNode.getString("beforId"));        //上一条ID
						map.put("beforTitle",jsonNode.getString("beforTitle"));  //上一条标题
					}else{
						map.put("beforId","");                               //上一条ID
						map.put("beforTitle","");  							 //上一条标题
					}					
					map.put("content",jsonNode.getString("content"));        //内容
					map.put("createTime",jsonNode.getString("createTime"));  //创建时间
					map.put("id",jsonNode.getString("id"));                  //ID
					map.put("title",jsonNode.getString("title"));            //标题
					map.put("type",jsonNode.getString("type"));              //类型
																             //作者
				return map;
			}
		 
}
