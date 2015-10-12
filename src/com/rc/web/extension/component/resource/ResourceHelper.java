package com.rc.web.extension.component.resource;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.rc.eschool.fundmanage.expend.GetUrl;
import com.rc.web.seriveces.Base64Util;
import com.rc.web.seriveces.HttpWebs;

public class ResourceHelper {
	private HttpWebs web;
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat format_cc = new SimpleDateFormat("yyyy年MM月dd日上传");
	/**
	 * 获取资源分类
	 * @return
	 */
	public List<List<String>> getType(){
		web= new HttpWebs();
		web.init();
		List<List<String>> type=new ArrayList<List<String>>();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("subjectsRes_url");
    	Map<String, String> parmMap = new HashMap<String, String>();
    	String sb=web.callByPost(url,parmMap);  
        JSONArray array = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	//获取一级类别
        	JSONArray array_1=JSONArray.fromObject(jsonObject.get("ret"));
        	List<String> list_2=null;
        	for(int i=0;i<array_1.size();i++){
        		list_2=new ArrayList<String>();
        		JSONObject Object = array_1.getJSONObject(i);
        		String id=Object.get("id").toString();
        		//String name=Object.get("name").toString();
        		//获取二级分类
        		String url_2=getUrl.getUrl("resBySubject_url");
            	Map<String, String> parmMap_2 = new HashMap<String, String>();
            	parmMap_2.put("subjectId", id);
            	parmMap_2.put("pagecount", "1");
            	String sb_2=web.callByPost(url_2,parmMap_2);  
                JSONArray array_2 = JSONArray.fromObject("["+Base64Util.decrypt(sb_2)+"]");
                JSONObject jsonObject_2 = array_2.getJSONObject(0);
                String msgCode_2=jsonObject_2.get("msgCode").toString();
                if("1".equals(msgCode_2)){
                	JSONArray array_=JSONArray.fromObject(jsonObject_2.get("ret"));
                	for(int j=0;j<array_.size();j++){
	                	JSONObject Object_2 = array_.getJSONObject(j);
	            		String id_2=Object_2.get("id").toString();
	            		String name_2=Object_2.get("name").toString();
	            		list_2.add(id_2+"&"+name_2);
                	}
                }
        		type.add(list_2);
        	}
        }
		return type;
	}
	/***
	 * 根据资源分类获取资源
	 * type 资源类别编号
	 * @return 资源List
	 * @throws ParseException 
	 */
	public List<String> getResourceByType(String type) throws ParseException{
		if(type==""||type==null){type="40992768";}
		List<String> list=new ArrayList<String>();
		web= new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("resSearch_url");
    	Map<String, String> parmMap = new HashMap<String, String>();
    	parmMap.put("subjectId", type);
    	String sb=web.callByPost(url,parmMap);  
        JSONArray array_back = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array_back.getJSONObject(0);
        String msgCode=jsonObject.get("msgCode").toString();
        if("1".equals(msgCode)){
        	//获取资源数组
        	JSONArray array=JSONArray.fromObject(jsonObject.get("Lres"));
        	for(int i=0;i<array.size();i++){
        		JSONObject object = array.getJSONObject(i);
        		String id =object.getString("id");
        		String name =object.getString("name");
        		String icon =object.getString("icon"); 
        		String companyName=object.getString("companyName");
        		String size=String.valueOf(Integer.parseInt(object.getString("size"))/1048576)+"M";
        		String creatTime=format_cc.format(new Timestamp(format.parse(object.getString("creatTime")).getTime()));
        		list.add(icon+"&"+id+"&"+name+"&"+companyName+"&"+size+"&"+creatTime);
        	}
        }
		return list;
	}
	
	/***
	 * 根据搜索词获取资源
	 * keyword 搜索词
	 * ziyuanlb 资源类别
	 * meitilx 媒体类型
	 * pagecount 页码数
	 * pagesize  每页显示条数
	 * @return 资源List
	 */
	public List<List<String>> getResourceBySearch(String keyword,String ziyuanlb,String meitilx,String pagecount,String pagesize,String uid,String collect,String like,String download) throws Exception{

		List<List<String>> list=new ArrayList<List<String>>();
		web= new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("resSearch_url");
    	Map<String, String> parmMap = new HashMap<String, String>(); 
    	if(keyword!=null&!"total".equals(keyword)&!"null".equals(keyword)){parmMap.put("keyword", keyword);}
    	if(ziyuanlb!=null&!"total".equals(ziyuanlb)&!"null".equals(ziyuanlb)){parmMap.put("subjectId", ziyuanlb);} 
    	if(meitilx!=null&!"total".equals(meitilx)&!"null".equals(meitilx)){parmMap.put("resTypes", meitilx);}
    	if(uid!=null&!"total".equals(uid)&!"null".equals(uid)){parmMap.put("uid", uid);}
    	if(collect!=null&!"total".equals(collect)&!"null".equals(collect)){parmMap.put("collect", "1");}
    	if(like!=null&!"total".equals(like)&!"null".equals(like)){parmMap.put("like", "1");}
    	if(download!=null&!"total".equals(download)&!"null".equals(download)){parmMap.put("download", "1");}
    	parmMap.put("pagecount", pagecount);   
    	parmMap.put("pagesize", pagesize);     
    	String sb=web.callByGet(url, parmMap);    
        JSONArray array_back = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array_back.getJSONObject(0); 
        String msgCode=jsonObject.get("msgCode").toString();  
        if("1".equals(msgCode)){
        	List<String> list_count=new ArrayList<String>();
        	List<String> list_res=new ArrayList<String>();
        	String count =jsonObject.get("count").toString();
        	list_count.add(count);
        	list.add(list_count);
        	//获取资源数组
        	JSONArray array=JSONArray.fromObject(jsonObject.get("Lres"));
        	for(int i=0;i<array.size();i++){
        		JSONObject object = array.getJSONObject(i);
        		String id =object.getString("id");
        		String name =object.getString("name");
        		String icon =object.getString("icon"); 
        		String introduction =object.getString("introduction").equals("")?"无":object.getString("introduction");
        		String createTime =object.getString("creatTime").equals("null")?"1900-01-01":format.format(new Timestamp(format.parse(object.getString("creatTime")).getTime()));
        		String downCount=object.getString("downCount"); 
        		String downUrl=object.getString("downUrl");  
        		list_res.add(icon+"&"+id+"&"+name+"&"+introduction+"&"+createTime+"&"+downCount+"&"+downUrl);
        	}
        	list.add(list_res);
        } 
		return list;
	}
	/***
	 * 获取排行数据
	 * ranktype 排行类型
	 * @param ranktype 
	 * @return 返回倒序数据
	 */
	public List<String> getRankRes(String ranktype){
		List<String> ranklist=new ArrayList<String>();
		web= new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("resSearch_url"); 
    	Map<String, String> parmMap = new HashMap<String, String>(); 
    	if("download".equals(ranktype)){
    		parmMap.put("download", "1");   
    	}
    	if("like".equals(ranktype)){
    		parmMap.put("like", "1");
    	}
    	String sb=web.callByPost(url,parmMap);    
        JSONArray array_back = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array_back.getJSONObject(0); 
        String msgCode=jsonObject.get("msgCode").toString();  
        if("1".equals(msgCode)){
        	//获取资源数组
        	JSONArray array=JSONArray.fromObject(jsonObject.get("Lres"));
        	for(int i=0;i<array.size();i++){
        		JSONObject object = array.getJSONObject(i);
        		String id =object.getString("id");
        		String name =object.getString("name");
        		ranklist.add(id+"&"+name);
        	}
        }
		return ranklist;
	}
	/**
	 * 获取资源明细
	 * @param Resid
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, String>> getResDetailByResid(String Resid) throws Exception{
		List<Map<String, String>> detaillist=new ArrayList<Map<String, String>>();
		web= new HttpWebs();
		web.init();
		GetUrl getUrl=new GetUrl();
		String url=getUrl.getUrl("resdetail_url"); 
    	Map<String, String> parmMap = new HashMap<String, String>(); 
    	parmMap.put("resId", Resid);
    	String sb=web.callByPost(url,parmMap);    
        JSONArray array_back = JSONArray.fromObject("["+Base64Util.decrypt(sb)+"]");
        JSONObject jsonObject = array_back.getJSONObject(0); 
        String msgCode=jsonObject.get("msgCode").toString();  
        if("1".equals(msgCode)){
        	//获取资源数组
        	JSONArray array=JSONArray.fromObject(jsonObject.get("lres"));
        	for(int i=0;i<array.size();i++){
        		JSONObject object = array.getJSONObject(i);
        		String id =object.getString("id");
        		String name =object.getString("name");
        		String modifyTime=object.getString("modifyDate");
        		String icon=object.getString("icon");
        		String downUrl=object.getString("downUrl");
        		String author=object.getString("author");
        		String publish=object.getString("publish");
        		String rightCount =object.getString("rightCount");
        		String size =String.valueOf((Double.parseDouble(object.getString("size"))/1048576));
        		String form=downUrl.substring(downUrl.lastIndexOf(".")+1);
        		Map<String, String> detail=new HashMap<String, String>();
        		detail.put("id", id);
        		detail.put("name", name);
        		detail.put("modifyTime", format.format(new Timestamp(format.parse(modifyTime).getTime())));
        		detail.put("icon", icon);
        		detail.put("downUrl", downUrl);
        		detail.put("author", author);
        		detail.put("publish", publish);
        		detail.put("rightCount", rightCount);
        		detail.put("size", size);
        		detail.put("form", form);
        		detaillist.add(detail);
        	}
        }
		return detaillist;
	}
	public static void main(String[] args) {
		ResourceHelper help=new ResourceHelper();//40992768
		try{ 
			help.getResourceBySearch("我是小学生",null,null,"1","10",null,null,null,null); 
		}catch(Exception e){ 
			e.printStackTrace(); 
		}
	}
}
