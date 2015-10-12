<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java"  isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		<html:dialog id="GNDH_XueXiaoXX" async="false"/>
<script type="text/javascript">
	$().ready(function(){
		 var pageLayout = $('body').layout({ 
				applyDefaultStyles: false,  
				south: {
					size: '50%'
				}   
			 });
		//查询
		$("#MLKZ_ChaXun").bind('click',function(){
			var con = ['dc_XueXiaoBM','dc_XueXiaoMC','dc_LianXiR'];//查询条件
			$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
		});
	});		
</script>
</head>
<body >
	
	<html:form >
	<div class="ui-layout-center" style="overflow: hidden;">
   		<table width="99%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td   class="CaptionTD" align="left" width="1%"><html:title id="dc_XueXiaoBM"/></td>
				<td class="DataTD"   width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_XueXiaoBM" style="width:80%"/></td>
				<td   class="CaptionTD" align="left" width="1%"><html:title id="dc_XueXiaoMC"/></td>
				<td class="DataTD"   width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_XueXiaoMC" style="width:80%"/></td>
				<td   class="CaptionTD" align="left" width="1%"><html:title id="dc_LianXiR"/></td>
				<td class="DataTD"   width="18%"><html:text modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_LianXiR" style="width:80%"/></td>
				<td align="right">
             		<html:command id="MLKZ_ChaXun"/>
				</td>
				<td width="20px"></td>
			</tr>
		</table>  	
		<%-- --%>
		<html:jqgrid id="DHSJZ_ChaXunJG" processId="GNSW_XueXiaoXXCX" processUnitId="SWDY_ChaXun" rownumbers="true"   pager="pager" autoWidth="true" height="300" />
		</div>
		<html:paraSave/>
	<script type="text/javascript">
		$(function(){
			$(window).wresize(function(){
				content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.3);
			});
			content_resize($('#DHSJZ_ChaXunJG'),window,5,$(window).height()*0.3);
		});
	</script>
	</html:form>
</body>
</html>