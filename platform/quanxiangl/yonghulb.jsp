<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-7
	*@description:权限设置用户
	*@version: 

	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ui.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<%@ page import="com.qam.framework.beans.submitreturn.RecordSet" %>
<%@ page import="com.qam.web.facade.taglib.support.JavaScript" %>
<title>用户查询</title>
</head>
<body  bottomMargin=0 leftMargin=1 topMargin=0 rightMargin=0 >

<html:dialog id="GNDH_YongHuLB"  async="false" />
<html:form>
<table width="100%" border=0 align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td nowrap align="left" ><html:text id="dc_YongHuM" style="width:125" title="按登录名或用户姓名搜索"/><html:command id="SouSuo"/></td>
		
	</tr>
</table>
<html:splitline width="100%"/>
<%-- --%>
<html:jqgrid id="YongHuLB" pager="pager" doResize="resizeGrid" height="200" viewRecords="false" width="230" dialogState="ChaXun"/>
</html:form>
</body>
</html>
