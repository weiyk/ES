<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-10-10
	*@description:行权限设置列表
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
<title>行权限设置列表</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog  />

<html:form>
<table border=0 width="99%" cellspacing="0" cellpadding="2" align="center" class="table" >
	<tr>
		<td class="title_cx" nowrap><html:title id="dc_SuoShuGN"/></td>
		<td class="content_L"><html:controls id="dc_SuoShuGN" /></td>
		<td class="title_cx" nowrap><html:title id="dc_SuoShuSW"/></td>
		<td class="content_L"><html:controls id="dc_SuoShuSW" /></td>		
	</tr>	
	<tr >
		<td class="title_cx" nowrap><html:title id="dc_ShuJuFL"/></td>
		<td class="content_L"><html:controls id="dc_ShuJuFL"   /></td>
		<td colspan="2" align="right" class="content_L"><html:command  id="ChaXun"/>&nbsp;<html:command  id="ShaChu"/></td>
	</tr>
</table>

<html:splitline width="99%"/>

<html:cgrid id="ChaXunJG" doDelRow="true"   doSelfCustom="true">
<html:cgrid id="ChaXunZMX" doDelRow="false" doSelfCustom="false" titleTdAttribute=" class=\"title_cx\"" parentGroup="ChaXunJG" relations="di_ShuJuFLBH=di_ShuJuFLBH_MX,di_QuanXianDXBH=di_QuanXianDXBH_MX,di_QuanXianDXLX=di_QuanXianDXLX_MX" />
</html:cgrid>
<html:paraSave/>
</html:form>
</body>
</html>