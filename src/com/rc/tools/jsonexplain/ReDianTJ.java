package com.rc.tools.jsonexplain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;
/**
 * 
 * @author 热点推荐
 *
 */
public class ReDianTJ {
	/**
	 * 
	 * @return 热点推荐标识
	 */
	public Map<String,Object> getJSONReDianTJBS(){
		Map<String, Object> map = new HashMap<String, Object>();
		HttpWebs wes = new HttpWebs();
		wes.init();
		Map<String, String> parmMap = new HashMap<String, String>();
		GetUrl ur=new GetUrl();
		String url=ur.getUrl("ReDianTJ_url");
		String str = wes.callByPost(url, parmMap);
		str = Base64Util.decrypt(str);// 解密
		JSONObject ob=JSONObject.fromObject(str);
		map.put("msgCode", ob.get("msgCode"));//返回码（0/1）
		map.put("msg", ob.get("msg"));        //返回信息
		map.put("notice", ob.get("notice"));  //结果集
		return map;
	}
	/**
	 * 
	 * @param obj  热点推荐列表
	 * @return 热点推荐List集合
	 */
	 public List<Map<String,Object>> getJSONReDianTJLB(Object obj){
		 	List<Map<String,Object>> list =new ArrayList<Map<String,Object>>();
			JSONArray json = JSONArray.fromObject(obj);
			for(int i=0;i<json.size();i++){
				JSONObject jsonNode = JSONObject.fromObject(json.get(i));
				Map<String,Object> map =new HashMap<String,Object>();
				map.put("hotId",jsonNode.getString("hotId")); //序号
				map.put("id",jsonNode.getString("id"));       //热点ID
				map.put("title",jsonNode.getString("title")); //标题
				list.add(map);
			}
			return list;
		}
}
