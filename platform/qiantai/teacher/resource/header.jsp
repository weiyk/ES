<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper" %>
<%@page import="java.util.*"%>
<%
	//获取样式
	String style = request.getContextPath()
			+ "/platform/qiantai/teacher";
	//获取资源样式
	String resource_style = request.getContextPath()
			+ "/platform/qiantai/teacher/style/resource";
	//获取路径
	String path = request.getContextPath() + "/servlet";
	//获取用户姓名
	String YONGHUXM = (String) request.getSession().getAttribute(
			"YONGHUXM");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>资源中心</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet"
	type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
</head>
<body>
<div class="header">
		<div class="in-box wrap clearfix">
			<div class="logo fl">
				<a href="#">双轨数字学校</a>
			</div>
			<ul class="nav fr">
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ">首页</a>
				</li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a>
				</li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a>
				</li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a>
				</li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a>
				</li>
				<li><a
					href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX" class="cur">资源中心</a>
				</li>
			</ul>
		</div>
	</div>
	</body>
	</html>
	