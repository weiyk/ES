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
	//imgUrl
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	//资源类型
	String type=request.getParameter("type"); 
	//获取资源分类
	ResourceHelper rshelp=new ResourceHelper();
	List<String> list=rshelp.getResourceByType(type);
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
	<div class="res-middle-content">
		<ul>
			<%for(int i=0;i<list.size();i++ ){String[] res=list.get(i).split("&"); %>
			<li>
				<img src="<%=imgUrl%><%=res[0] %>" class="tu_lei" width="20" height="20"/>
				<%
					String mc=res[2];
					if(mc.length()>=12){mc=mc.substring(0,12);}
				 %>
				<a target="_blank" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>"><%=mc %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=res[3] %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=res[4] %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=res[5] %> </a>
			</li>
			<%} %>
		</ul>
	</div>
</body>
</html>
