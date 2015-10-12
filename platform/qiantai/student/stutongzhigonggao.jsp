<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@page import="com.rc.tools.jsonexplain.*"%>
<%@page import="com.rc.tools.safty.ToDate" %>
<%@page import="java.util.*"%>
<%
String style=request.getContextPath()+"/platform/qiantai/teacher";//获取样式
String path=request.getContextPath();//获取路径
String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");//获取用户姓名
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");

%>
<html>
<head>
	<title>通知公告</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	 <html:dialog id="GNDH_TongZhiSTUGG"/>
</head>
<%//得到总条数
TongZhiGG TZGGS=new TongZhiGG();
String uid=(String)request.getSession().getAttribute("XiTongHYBH");//获取UID,系统用户编号
String key=(String)request.getSession().getAttribute("QuanZhi");//获取鉴值
String schoolId=(String)request.getSession().getAttribute("schoolId");//获取学校编号
List<Object> objSUM=TZGGS.getJSONGongGaoBS(schoolId,key,uid,"3","all","10");
List<Map<String,Object>> listSUM=null;
int sum=0;//总页数变量
int count=1;//总页数
String msgCode=(String)objSUM.get(0);
if(msgCode.equals("1")){
	listSUM=TZGGS.getJSONGongGaoLB(objSUM.get(2));
	count=listSUM.size();//获取总条数
}
if(count%10==0){
	sum=(int)count/10;
}else{
	sum=((int)count/10)+1;
}
request.setAttribute("sum",sum);//保存至内置对象

ToDate td=new ToDate();
//通知公告列表
TongZhiGG TZGG=new TongZhiGG();
String currentPage = request.getParameter("currentPage");
if(CommonUtils.null2Blank(currentPage).length() == 0){
	currentPage = "1";
}
List<Object> obj=TZGG.getJSONGongGaoBS(schoolId,key,uid,"3",currentPage,"10");
//System.out.println(obj);
List<Map<String,Object>> list=null;
String msgCode1=(String)obj.get(0);
boolean bool=false;
if(msgCode1.equals("1")){
	list=TZGG.getJSONGongGaoLB(obj.get(2));
	bool=true;
}
request.setAttribute("bool",bool);
%>

<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ&" class="user-name blk"><%=YONGHUXM %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>
<html:form>
<input type="hidden" name="currentPage" value="<%=currentPage %>" id="currentPage"/>
<input type="hidden" name="sum" value="<%=sum%>" id="sum"/>
<div class="wrap clearfix">
	<div  class="fl mt-20 w-710">
          <!-- 所在位置 -->
         <div class="td-zt">您所在的位置：<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a>&gt;学生动态 </div>
        <div class="my-jx mt-4">
        <div class="notice-gogao">
        <ul>
        	<c:if test="${bool}">
      		 <%
      		for(int i=0;i<list.size();i++){
      			Map<String,Object> maps=list.get(i);
      		  %>
      		 	<li>
			        <span class="span-fl">【<b><%=maps.get("type")%></b>】<a href ="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_GongGaoSTUXQ&cs_BianHao=<%=maps.get("id")%>"><%=maps.get("title")%></a></span>
			        <span class="span-fr"><%= td.TimeConvert((String)maps.get("createTime")) %></span>
		        </li>
      		 <%}%>
      		 </c:if>
        </ul>
        </div>
          <!-- 翻页 --> 
			<div class="page-list clearfix">
				<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
				<%
				int pages=Integer.parseInt(currentPage);
				int length=0;
				if(sum<=7){
					//循环六次
					for(int i=1;i<=sum;i++){%>
						<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
					<%}
				}else{
					if(pages<=3){
						for(int j=1;j<=7;j++){
						%>
							<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
						<% }
					}else{
						if(sum<pages+3){
							for(int k=sum-6;k<pages-3;k++){
								%>
									<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
								<% 
							}
						}
						if(sum>pages+3){
							for(int k=pages-3;k<pages+4;k++){
								%>
									<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
								<% 
							}
						}else{
							for(int k=pages-3;k<sum+1;k++){
								%>
									<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
								<% 
							}
						}
					}%>
				<%} %>
				<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
				<span class="p-num">共<%=sum%>页</span> 到 <input id="wenben" type="text" class="jp-ip" /> 页	
				<button type="button" onclick="TiaoZhuan()" class="to-sub">确定</button>
			</div>
       </div>
    </div>
</div>
</html:form>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});

//提交分页
function pageSubmit(){
	document.forms[0].action="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_TongZhiSTUGG&_qam_dialog_state=null&_dialog_submit_=GNDH_TongZhiSTUGG";
	document.forms[0].submit();
}
//点击确定
function TiaoZhuan(){
  	var num=$("#wenben").val();
  	var sum='<%=sum%>';
  	if(Number(num)>Number(sum)){
  		$("#wenben").val("1");
  	}
  	var reg = new RegExp("^[0-9]*$");  
  	if(!reg.test(num)){
  		$("#wenben").val("1");
  	}
  	if(num<1){
  		$("#wenben").val("1");
  	}
	$("#currentPage").val($("#wenben").val());
	//控制当前页码
	pageSubmit();
}
//点击页码
function click(i){
	$("#currentPage").val(i);
	pageSubmit();
}
//点击上一页和下一页
function SX(e,sum){
var s=$("#currentPage").val();
if(e==1){//上一页
	if(s>1){
		s=s-1;
		$("#currentPage").val(s);
		pageSubmit();
	}
}else if(e==2){//下一页 
	if(s<sum){
		s=parseFloat(s)+1;
		$("#currentPage").val(s);
		pageSubmit();
	}
}
}
</script>
</body>
</html>
