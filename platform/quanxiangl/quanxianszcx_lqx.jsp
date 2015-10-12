<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-10
	*@description:列权限设置列表
	*@version: 	
	**/
%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%--ztree --%>
<%@include file="/common/ztree.jspf" %>
<title>列权限设置列表</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog  />

<html:form>
<table border=0 width="99%" cellspacing="0" cellpadding="2" align="center" class="table" >
	<tr>
		<td class="title_cx" nowrap><html:title id="dc_MingCheng"/></td>
		<td class="content_L"><html:controls id="dc_MingCheng" /></td>
		<td class="title_cx" nowrap><html:title id="dc_ShuJuXMC"/></td>
		<td class="content_L"><html:controls id="dc_ShuJuXMC" /></td>		
	</tr>	
	<tr >
		<td class="title_cx" nowrap><html:title id="dc_GongNengBM"/></td>
		<td class="content_L"><html:controls id="dc_GongNengBM"   /></td>
		<td colspan="2" align="right" class="content_L"><html:command  id="ChaXun"/>&nbsp;<html:command  id="ShaChu"/></td>
	</tr>
</table>

<html:splitline width="99%"/>

<html:grid id="ChaXunJG" doDelRow="true"  doSelfCustom="true"/>
<html:paraSave/>
</html:form>
</body>
</html>