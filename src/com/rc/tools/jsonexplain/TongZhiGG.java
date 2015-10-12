package com.rc.tools.jsonexplain;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import javax.servlet.http.HttpServletRequest;

import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;


/**
 * 
 * @author 通知公告列表查询
 * 
 * 
 * 1.发送请求获取通知公告列表以JSON对象输出
 * 2.解析返回的JSON对象用于前台展示
 *
 */
public class TongZhiGG{
		/**
		 * 
		 * @return 公告标识
		 */
		public List<Object> getJSONGongGaoBS(String sid,String key,String uid,String type,String pagecount,String counts){
			 HttpWebs wes = new HttpWebs();
			 wes.init();
			 List<Object> list =new ArrayList<Object>();
			 Map<String, String> parmMap = new HashMap<String, String>();
			 	parmMap.put("sid",sid);
			 	parmMap.put("key",key);
			 	parmMap.put("uid",uid);
			 	parmMap.put("type",type);
			 	parmMap.put("pagecount",pagecount);//页数
			 	parmMap.put("counts",counts);   //每页记录数
			 	GetUrl ur=new GetUrl();
			 	String url=ur.getUrl("GongGaoLB_url");
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
		  * 
		  * @param obj  公告列表
		  * @return
		  */
		 public List<Map<String,Object>> getJSONGongGaoLB(Object obj){
			 	List<Map<String,Object>> list =new ArrayList<Map<String,Object>>();
				JSONArray json = JSONArray.fromObject(obj);
				for(int i=0;i<json.size();i++){
					JSONObject jsonNode = JSONObject.fromObject(json.get(i));
					Map<String,Object> map =new HashMap<String,Object>();
					map.put("id",jsonNode.getString("id"));         		//公告ID
					map.put("title",jsonNode.getString("title"));      		//标题
					map.put("type",jsonNode.getString("type"));		 		//类型
					map.put("createTime",jsonNode.getString("createTime")); //创建时间
					list.add(map);
				}
				return list;
			}
}