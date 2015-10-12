<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<% %>
<html>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");//获取用户姓名
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");

%>
<%-- 平台 --%>
<%@include file="/common/framework.jspf"%>
<head>
	<title>公告详情</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	 <html:dialog id="GNDH_LSGongGaoXQ" state=""/>
</head>
<%
GongGaoXQ GGXQ=new GongGaoXQ();
String BianHao=request.getParameter("cs_BianHao");//编号
String uid=(String)request.getSession().getAttribute("XiTongHYBH");//获取UID,系统用户编号
String key=(String)request.getSession().getAttribute("QuanZhi");//获取鉴值

List<Object> obj=GGXQ.getJSONGongGaoXQBS(key,uid,BianHao);//得到标示对象
Map<String,String> map=null;
String msgCode=(String)obj.get(0);
String afterId="";        //下一条ID
String afterTitle="";  //下一条标题
String beforId="";        //上一条ID
String beforTitle="";  //上一条标题
String content="";        //内容
String createTime="";  //创建时间
String id="";                  //ID
String title="";          //标题
if(msgCode.equals("1")){
	map=GGXQ.getJsonGGXQ(obj.get(2));//根据标识对象获得详情
	 afterId=map.get("afterId");        //下一条ID
	 afterTitle=map.get("afterTitle");  //下一条标题
	 beforId=map.get("beforId");        //上一条ID
	 beforTitle=map.get("beforTitle");  //上一条标题
	 content=map.get("content");        //内容
	 createTime=map.get("createTime");  //创建时间
	 id=map.get("id");                  //ID
	 title=map.get("title");          //标题
}
request.setAttribute("afterId",afterId);
request.setAttribute("beforId",beforId);

ToDate td=new ToDate();
if(!createTime.equals("")){
	createTime=td.TimeConvert(createTime);
}
%>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM %></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">       
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ" >首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>

<div class="wrap clearfix">
    <!-- 重点推荐 -->
	<div class="fl mt-20 w-710">
         <!-- 所在位置 -->
         <div class="td-zt">
             您所在的位置：<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ" >首页</a>&gt;
             	  <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_GongGaoLB">教师动态</a>&gt;
             资讯详情
         </div>
	<div class="my-jx mt-4">
    <div class="clearfix">
      <div class="wm-c">
	        <div class="artdeti-c">
	            <h2 class="titletxt">
	             <p><%=title%></p>
	             <p class="time"><%=createTime %></p>
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
		    	  	<c:if test="${beforId != ''}">
		    			<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LSGongGaoXQ&cs_BianHao=<%=beforId%>">
		    				<%=beforTitle%>
		    			</a>
		    	   	</c:if>
		    	   	<c:if test="${beforId == ''}">
		    	   		无
		    		</c:if>
		    	</li>
		    	<li>&gt;下一条：
		    		<c:if test="${afterId != ''}">
		    			<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LSGongGaoXQ&cs_BianHao=<%=afterId%>" >
		    				<%=afterTitle%>
		    			</a>
		    		</c:if>
		    		<c:if test="${afterId ==''}">
		    			无
		    		</c:if>
		    	</li>
        </ul>
    </div>
    </div>
</div>


<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>

