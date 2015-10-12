<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="com.qam.framework.beans.viewsubmit.CustomItem"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="com.rc.tools.jsonexplain.*"%>
<%@page import="com.rc.tools.safty.ToDate" %>
<%--调用接口--%>
<%@page import="java.util.*"%>
<%@page import="com.rc.web.extension.component.bangzhuzx.HelpCenter" %>
<%-- 平台 --%>
<%@page import="com.qam.web.QamWebDataConstants"%>

<%@ taglib uri="qamer-html" prefix="html"%>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
%>

<html>
<head>
	<title>帮助中心</title>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
</head>
<%//得到总条数
HelpCenter helpCenter=new HelpCenter();

int sum=0;//总页数
int count=1;//获取总条数
if(helpCenter.getTotalCount()>0){
	count=helpCenter.getTotalCount();
}
if(count%10==0){
	sum=(int)count/10;
}else{
	sum=((int)count/10)+1;
}
request.setAttribute("sum",sum);//保存至内置对象

//问题列表
String currentPage = request.getParameter("currentPage");
if(CommonUtils.null2Blank(currentPage).length() == 0){
	currentPage = "1";
}
List<String> quesList=helpCenter.getQuestionList(Integer.parseInt(currentPage), 10);
//最新问题10条
List<String> quesList_new=helpCenter.getQuestionList(1, 10);
%>

<body>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/desktop.html" class="cur">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT">学习联合体</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT" >优秀课堂</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG" >通知公告</a></li>
		</ul>
	</div>
</div>
 <html:form>
 <input type="hidden" name="currentPage" value="<%=currentPage %>" id="currentPage"/>
<div class="wrap clearfix">
    <!-- 通知公告列表-->
	<div  class="fl mt-20 w-710">
          <!-- 所在位置 -->
         <div class="td-zt">您所在的位置：<a href="<%=path%>/desktop.html">首页</a>&gt;帮助中心 </div>
        <div class="my-jx mt-4">
        <div class="notice-gogao">
        <ul style="padding-bottom: 0px;min-height: 200px;">
      		 <%
      		 if(quesList.size()>0){
      			for(int i=0;i<quesList.size();i++){
      			String ques=quesList.get(i);
      		  %>
      		 	<li>
			        <span class="span-fl"><a href ="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WenTiMXCK&_qam_dialog_state=DHZT_ChaXun&cs_BianHao=<%=ques.split("&")[0]%>"><%=ques.split("&")[1]%></a></span>
			        <span class="span-fr"><%= ques.split("&")[2] %></span>
		        </li>
      		 <%}}%>
        </ul>
        </div>
       <div class="page-list clearfix" align="center">
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
	<div class="fr w-230">
		<!-- 热点推荐 -->
		<div class="pt-gg mt-20">
			<div class="side-title clearfix">
				<h3>问题列表</h3>
			</div>
			<ul class="the-list">
				<%
				if(quesList_new.size()>0){
      			for(int i=0;i<quesList_new.size();i++){
      				String ques_new=quesList_new.get(i);
      		  	%>
				<li>
					<span class="span-red"><%=(i+1)%></span><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WenTiMXCK&_qam_dialog_state=DHZT_ChaXun&cs_BianHao=<%=ques_new.split("&")[0]%>"><%=ques_new.split("&")[1]%></a>
				</li>
			 <%}}%>
			</ul>
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
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WeiTiLBCX&_qam_dialog_state=null&_dialog_submit_=GNDH_WeiTiLBCX";
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

