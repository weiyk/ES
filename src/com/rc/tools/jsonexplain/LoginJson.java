package com.rc.tools.jsonexplain;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

/**
 * 
 * @author 解析登录返回的JSON结果
 *
 */
public class LoginJson {
	/**
	 * 获取用户标识
	 * @param str
	 * @return
	 */
	public List<Object> getJson(String str){
		List<Object> list =new ArrayList<Object>();
		JSONObject ob=JSONObject.fromObject(str);
		list.add(ob.get("msgCode"));//返回码（0/1）
		list.add(ob.get("key"));    //权值
		list.add(ob.get("msg"));    //返回信息
		list.add(ob.get("customer"));//结果集
		return list;
	}
	/**
	 * 
	 * 
	 * @param obj 用户JSON格式基本信息
	 * @throws UnsupportedEncodingException 
	 */
	public List<String> getJsonUser(Object obj){
		List<String> list =new ArrayList<String>();
		JSONObject jsonNode = JSONObject.fromObject(obj);
			list.add(jsonNode.getString("idCard")); //身份证
			list.add(jsonNode.getString("image"));  //头像
			list.add(jsonNode.getString("name"));   //姓名
			list.add(jsonNode.getString("type"));   //类别
			list.add(jsonNode.getString("uid"));    //用户ID
		return list;
	}
	
	
}