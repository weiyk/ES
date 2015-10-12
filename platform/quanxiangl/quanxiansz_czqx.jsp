<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-8-4
	*@description:操作权限设置，功能活动列表

	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ui.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>操作权限设置</title>
</head>
<body  >

<html:dialog />

<html:form>
<div style="height:10px"></div>
<div  class="ui-jqdialog-content ui-widget-content">
<table border=0 width="99%" cellspacing="0"  cellpadding="2" align="center" class="table" >
	<tr>
		<td class="CaptionTD" width="10%" align="right" nowrap><html:title id="dc_MingCheng"/></td>
		<td class="DataTD" align="left"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_MingCheng" /></td>
		<td class="CaptionTD" width="10%" align="right" nowrap><html:title id="dc_BieMing"/></td>
		<td class="DataTD" align="left"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_BieMing" /></td>
		<td class="CaptionTD" width="10%" align="right" nowrap><html:title id="dc_GongNengBM"/></td>
		<td class="DataTD"  align="left"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_GongNengBM"   /></td>
	</tr>	
	<tr >
		<td class="CaptionTD" width="10%" align="right" nowrap><html:title id="dc_FanWei"/></td>
		<td class="DataTD"  align="left"><html:select style="width:100%" modeStyle="FormElement ui-widget-content ui-corner-all" initText="所有" id="dc_FanWei" /></td>
		<td colspan="4" align="right" class="content_L"><html:command id="ChaXunCZQX"/><html:command id="ChaXunHMD"/>&nbsp;<html:command id="BaoCunCZQX"/><html:command id="BaoCunHMD"/>&nbsp;<html:button id="GuanBi" value="关闭" onclick="if(confirm('确定要离开本页面吗？')){parent.window.close();}"/></td>
	</tr>
</table>
</div>
<html:splitline width="99%"/>

<html:sjqgrid id="ChaXunJG" resetRowState="a" options="{height:'365px'}"  doSelfCustom="true"/>

<html:paraSave/>
</html:form>
<script type="text/javascript">
	$(function(){
		$("#jqgh_ChaXunJG_td_di_ShouQuan_t").removeClass('.ui-th-div-ie ui-jqgrid-sortable');
	});
	$(function(){
		$(window).wresize(function(){
			content_resize($('#ChaXunJG'),window,5,$(window).height()*0.25);
		});
		content_resize($('#ChaXunJG'),window,5,$(window).height()*0.25);
	});
</script>
</body>
</html>