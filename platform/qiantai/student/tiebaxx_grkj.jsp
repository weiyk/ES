<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.ParseException" %>
<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue" %>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.web.extension.component.tongxinlu.insertTongXinL"%>
<%@page import="java.util.Map,java.net.*"%>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>
<%
	String schoolName=(String) session.getAttribute("schoolName");
	String className=(String) session.getAttribute("className");
 %>
<%!
private static String getTime(String createDate) throws ParseException{
	createDate=Long.parseLong(createDate)+(long)8*60*60*1000+"";
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");//小写的mm表示的是分钟  
	Date date =new Date();
	String value="";
	long day=(date.getTime()-Long.parseLong(createDate))/(60*1000);//分钟
	//Date datezss= new Date(Long.parseLong(createDate));
	//System.out.println(createDate);
	int hh=(int)day/60;  //共计小时数
	int dd=(int)hh/24;   //共计天数
	if(day>=60){
		if(hh>=24){
			if(dd>2){
				SimpleDateFormat sdfD=new SimpleDateFormat("yyyy-MM-dd");
				Date datez= new Date(Long.parseLong(createDate));
				value=sdfD.format(datez);
			}else{
				value=dd+"天前";
			}
		}else{
			value=hh+"小时前";
		}
	}else if(day<=0){
		value="1分钟前";
	}else{
		value=day+"分钟前";
	}
	return value;
}
%>

<%!
	public String getValue(String json,int page,String imaUrl) throws ParseException{
		StringBuffer html=new StringBuffer();
		JSONArray array = JSONArray.fromObject(json);
		if(page>array.size()){
			page=array.size();
		}
		for(int j = 0; j < page; j++) {
			JSONObject jsonObject_post = array.getJSONObject(j);
			String createDate =jsonObject_post.get("created_at").toString();
			//String updateDate=jsonObject_post.get("updated_at").toString();
			//String id=jsonObject_post.get("id").toString();
			String uid=jsonObject_post.get("userId").toString();
			//String uid="1441793";
			GetInterfacesValue inter=new GetInterfacesValue();
			Map<String,String> map=inter.getUser(uid);
			html.append("<li>");
			html.append("<div class=\"pic fl\"><img src=\""+imaUrl+map.get("image")+"\" /></div>");
			html.append("<div class=\"fr info\"><div class=\"title clearfix\">");
			html.append("<a href=\"#\" class=\"fl cla-1\">"+map.get("xingming")+"["+map.get("schoolName")+"-"+map.get("className")+"]"+"</span></a> ");
			html.append("<span class=\"fr\">"+getTime(createDate)+"</span>");
			html.append("</div><div class=\"txt-star clearfix\"><div  class=\"txt fl\">");
			html.append(jsonObject_post.get("content").toString());
			html.append("</div></div>");
			html.append("<div class=\"act clearfix\"><div class=\"alink fr\">");
			//html.append("<a id=\"tj"+id+"\" href=\"javascript:add('"+id+"','"+likeCount+"')\" class=\"cur\" ><s class=\"al-tj\"></s>推荐("+likeCount+")</a>");
			//html.append("<a href=\"#\" class=\"cur\"><s class=\"al-pl\"></s>评论("+jsonObject_post.get("commentCount").toString()+")</a>");
			//html.append("<a href=\"#\"><s class=\"al-yl\"></s>预览(16)</a>");
			html.append("</div></div></div>");
			html.append("</li>");
		}
	return html.toString();
}
%>
<%
String style=request.getContextPath()+"/style";
//获取路径
String path=request.getContextPath();
%>
<html>
<head>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<style type="">
	.zjx-areatext .the-list li .txt{font-size:14px;color:#000;margin-left:160px;width: 75%}
	.zjx-areatext .the-list li .title .cla-1{font-size:12px;color:#000;line-height:10px;padding-left:160px;}
	</style>
</head>

<%
String kechengbh=(String)request.getParameter("KeChengBH");
String zhi=(String)request.getParameter("zhi");
	String yonghubh=(String) session.getAttribute("XiTongHYBH");

	String key=(String) session.getAttribute("QuanZhi");
	String pagesize=(String)request.getParameter("pagesize");
	if("".equals(pagesize)||pagesize==null){
		pagesize="1";
	}
	GetInterfacesValue	getInterfacesValue=new GetInterfacesValue();
	String json=getInterfacesValue.getJson(pagesize,yonghubh,key,kechengbh);
	int count=getInterfacesValue.getPageCount(yonghubh,key,kechengbh);
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	int sum=count/3;
	if(count<3){
		sum=1;
	}else{
		if(count%3>0){
			sum+=1;
		}
	}
	String imgUrl="http://118.26.134.24";
%>
<body>
<script type="text/javascript">
var sumpage=<%=sum%>;
$().ready(function(){
	var pageSize='<%=pagesize%>';
	if(!pageSize){
		pageSize=1;
	}
     $("#page"+pageSize).addClass("cur");
});
	function SX(e,sum){
		window.parent.SX(e,sum);
	}
	function click(i){
		window.parent.click(i);
	}
	function TiaoZhuan(){
		window.parent.TiaoZhuan();
	}
</script>
                   <!--列表-->
<div class="zjx-areatext">
    	<div class="the-list" id="pageAdd">
			<ul class="clearfix">
				<%=getValue(json,3,imgUrl) %>				
			</ul>
		</div>
	<div class="page-list clearfix" align="center">
		<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
		<%
		int pages=Integer.parseInt(pagesize);
		int length=0;
		if(sum<=3){
			//循环六次
			for(int i=1;i<=sum;i++){%>
				<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
			<%}
		}else{
			if(pages<=1){
				for(int j=1;j<=3;j++){
				%>
					<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
				<% }
			}else{
				if(sum>pages){
					for(int k=pages-1;k<=pages+1;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
				if(sum==pages){
					for(int k=pages-2;k<=sum;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
			}%>
		<%} %>
		<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
		<span class="p-num">共<%=sum%>页</span> 到 <input id="wenben" onkeyup="ExtFunctionCM.inputRegExp(this,'(^0$)|(^(-)?0\\.\\d{0,2}$)|(^(-)?[1-9]?[0-9]{0,12}?$)')" type="text" class="jp-ip" /> 页	
		<button type="submit" onclick="TiaoZhuan()" class="to-sub">确定</button>
	</div>
	</div>
</body>
</html>