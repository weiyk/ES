<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-10-10
	*@description:行权限设置调看

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
<title>行权限设置调看</title>

</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog/>

<html:form>

<table>
	<tr>
		<td width="100%">&nbsp;</td>
		<td width="0"><%-- <html:command id="GuanBi" /> --%>
		<html:button id="GuanBi" value="关闭" onclick="if(confirm('确定要离开本页面吗？')){parent.window.close();}"/></td>
	</tr>
</table>
<html:splitline width="99%"/>
<html:grid id="ChaXunJG"  doDelRow="false"  doSelfCustom="false"/>
		
<html:paraSave/>
</html:form>
</body>
</html>