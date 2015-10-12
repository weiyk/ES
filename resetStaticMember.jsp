<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.qam.framework.manager.StaticMemberManager" %>
<%
	StaticMemberManager.getInstance().initStaticMember();
	out.println("静态变量初始化完毕");
	com.qam.framework.timer.TimerManager.getInstance();
%>