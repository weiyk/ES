package com.rc.tools.jsonexplain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jfree.util.Log;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

/**
 * 
 * @author 资源订阅
 * 
 *
 */
public class SubscribeJson {
		
		/**
		 * 解析资源订阅JSON字符串
		 * 
		 * @return nodes 
		 */
		public List<Object> getSubscribeJsonBS(String keyword,String like,String uid,
				String collect,String pagecount,String pagesize,String resTypes,String subjectId,String download){
			 HttpWebs wes = new HttpWebs();
			 wes.init();
			 List<Object> list =new ArrayList<Object>();
			 Map<String,String> parmMap = new HashMap<String, String>();
			 	parmMap.put("keyword",keyword);		//资源名
			 	parmMap.put("like",like);			//点赞
			 	parmMap.put("uid",uid); 			//用户ID
			 	parmMap.put("collect",collect);		//收藏
			 	parmMap.put("pagecount",pagecount); //当前页数		
			 	parmMap.put("pagesize",pagesize);   //每页记录数
			 	parmMap.put("resTypes",resTypes);	//类别
			 	parmMap.put("subjectId",subjectId); //当前类别编号
			 	parmMap.put("download",download);   //下载
				GetUrl ur=new GetUrl();
				String url=ur.getUrl("resSearch_url");
				String str = wes.callByPost(url, parmMap);
				if(str==null){return list;}
				str = Base64Util.decrypt(str);// 解密
				try {
					JSONObject ob=JSONObject.fromObject(str);
					list.add(ob.get("msgCode"));//返回码（0/1）
					list.add(ob.get("msg"));//返回信息
					list.add(ob.get("count"));//资源总数
					list.add(ob.get("Lres"));//资源列表
				} catch (JSONException e) {
					Log.debug(e.getMessage());
				}
				return list;
		    }
			/**
			 * 资源订阅详情信息
			 * @param obj
			 * @return
			 */
			public List<Map<String,Object>> getSubscribeJsonXQ(Object obj){
				List<Map<String,Object>> list =new ArrayList<Map<String,Object>>();
				try {
					JSONArray json = JSONArray.fromObject(obj);
					for(int i=0;i<json.size();i++){
						JSONObject jsonNode = JSONObject.fromObject(json.get(i));
						Map<String,Object> map =new HashMap<String,Object>();
						map.put("author",jsonNode.getString("author"));         	
						map.put("companyName",jsonNode.getString("companyName"));   
						map.put("creatTime", jsonNode.getString("creatTime"));
						map.put("downCount",jsonNode.getString("downCount"));		 		
						map.put("downUrl",jsonNode.getString("downUrl")); 
						map.put("icon",jsonNode.getString("icon")); 
						map.put("id",jsonNode.getString("id")); 
						map.put("introduction",jsonNode.getString("introduction")); 
						map.put("name",jsonNode.getString("name")); 
						map.put("rightCount",jsonNode.getString("rightCount")); 
						map.put("size",jsonNode.getString("size")); 
						list.add(map);
					}
				} catch (JSONException e) {
					Log.debug(e.getMessage());
				}
				return list;
			}
		 
}
