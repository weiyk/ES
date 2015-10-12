<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-8-4
	*@description:列权限设置，对话数据项列表
	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>列权限设置</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog />

<html:form>
<div  class="ui-jqdialog-content ui-widget-content">
<table border=0 width="99%" cellspacing="0" cellpadding="2" align="center" class="table" >
	<tr>
		<td class="CaptionTD" width="10%" nowrap><html:title id="dc_MingCheng"/></td>
		<td class="DataTD" width="20%"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_MingCheng" /></td>		
		<td class="CaptionTD" width="10%" nowrap><html:title id="dc_GongNengBM"/></td>
		<td class="DataTD" width="20%"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all"  id="dc_GongNengBM"   /></td>
	</tr>	
	<tr >
		<td class="CaptionTD" width="10%" nowrap><html:title id="dc_FanWei"/></td>
		<td class="DataTD" width="20%"><html:select style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" initText="所有" id="dc_FanWei" /></td>
		<td  align="right" colspan=2 class="content_L"><html:command id="ChaXun"/>&nbsp;<html:command id="QueDing"/>&nbsp;<html:button id="GuanBi" value="关闭" onclick="if(confirm('确定要离开本页面吗？')){parent.window.close();}"/></td>
	</tr>
</table>
</div>
<html:splitline width="99%"/>

<html:sjqgrid id="ChaXunJG" options="{height:'375px'}" resetRowState="a"  doSelfCustom="true"/>
<html:paraSave/>
</html:form>
</body>
</html>