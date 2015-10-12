<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.qam.framework.context.ApplicationConfig"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.tools.jsonexplain.*"%>
<%@page import="java.util.List"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.util.Map"%>
<%@page import="com.rc.tools.safty.ToDate" %>
<%@page import="com.rc.web.extension.component.bangzhuzx.HelpCenter" %>
<% %>
<html>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
%>
<head>
	<title>问题详情</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	 <html:dialog id="GNDH_WenTiMXCK"/>
	 <style type="text/css">
    		.footers{background:#333;margin:50px 0px 0px 0px;padding:20px 0;}
			.footers .ft-txt{width:480px;}
			.footers .ft-txt .link a{color:#eee;font-size:12px;margin-right:12px;font-weight:bold;}
			.footers .ft-txt .copyright{color:#666}
			.footers .ft-txt .sp-txt{color:#888}
			.footers .contact-txt{width:290px;}
			.footers .contact-txt h2{font-size:16px;color:#eee;margin-bottom:5px;}
			.footers .contact-txt h2 span{font-size:14px;color:#666;font-weight:normal;}
			.footers .contact-txt p{line-height:16px;color:#666}
    </style>
</head>
<%
HelpCenter helpCenter=new HelpCenter();
String BianHao=request.getParameter("cs_BianHao");//编号

Map<String,String> map=null;
String afterId="";        //下一条ID
String afterTitle="";  //下一条标题
String beforId="";        //上一条ID
String beforTitle="";  //上一条标题
String content="";        //内容
String createTime="";  //创建时间
String id="";                  //ID
String title="";          //标题
if(!BianHao.equals("")){
	map=helpCenter.getQuestionDetail(BianHao);//根据标识对象获得详情
	if(map.size()>0){
		afterId=map.get("afterId");        
		afterTitle=map.get("afterTitle"); 
		beforId=map.get("beforId");        
		beforTitle=map.get("beforTitle");  
		content=map.get("content");  
		createTime=map.get("createTime"); 
		id=map.get("id");                 
		title=map.get("title");     
	}    
}
request.setAttribute("afterId",afterId);
request.setAttribute("beforId",beforId);


//热点推荐列表
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
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
		</ul>
	</div>
</div>

<div class="wrap clearfix">
    <!-- 重点推荐 -->
	<div class="fl mt-20 w-710">
         <!-- 所在位置 -->
         <div class="td-zt">
             您所在的位置：<a href="<%=path%>/desktop.html">首页</a>&gt;
             	  <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WeiTiLBCX" class="cur">帮助中心</a>&gt;
             	  问题详情
         </div>
	<div class="my-jx mt-4">

    <div class="clearfix">
      <div class="wm-c">
	        <div class="artdeti-c">
	            <h2 class="titletxt">
	             <p><%=title%></p>
	             <p class="time"><%=createTime%></p>
	            </h2>
	            <div class="c-txt">
	            <!--通知 公告内容-->
	            　		<%=content%>
	            </div>
	         </div>
     </div>
   </div>
   </div>
    <div class="next-more">
	    	<ul> 
		    	<li>&gt;上一条：
		    	  	<c:if test="${beforId != null}">
		    			<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WenTiMXCK&_qam_dialog_state=DHZT_ChaXun&cs_BianHao=<%=beforId%>">
		    				<%=beforTitle%>
		    			</a>
		    	   	</c:if>
		    	   	<c:if test="${beforId == null}">
		    	   		无
		    		</c:if>
		    	</li>
		    	<li>&gt;下一条：
		    		<c:if test="${afterId != null}">
		    			<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_WenTiMXCK&_qam_dialog_state=DHZT_ChaXun&cs_BianHao=<%=afterId%>" >
		    				<%=afterTitle%>
		    			</a>
		    		</c:if>
		    		<c:if test="${afterId ==null}">
		    			无
		    		</c:if>
		    	</li>
        </ul>
    </div>
    </div>
	<div class="fr w-230">
    	
		<!-- 问题列表 -->
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
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<%-- <script type="text/javascript">
$("img").one("error", function() {
	$(this).attr("src", "<%=request.getContextPath()%>/upload/teacher/jiaoxueshipin/WJ201509110001.png");
});
</script> --%>
</body>
</html>

