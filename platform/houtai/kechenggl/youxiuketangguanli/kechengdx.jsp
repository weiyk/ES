<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
		<html:dialog id="GNDH_DianXuan" async="false"/>
		<script type="text/javascript">
		$(function(){
			//查询
			$("#MLKZ_ChaXun").bind('click',function(){
				var con = ['dc_BiaoTiKC','dc_KeShiMC','dc_ZhuJiangR'];
				$(this)._search('DHSJZ_DianXuan','MLKZ_ChaXun',con);
			});
		});
		</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="dc_BiaoTiKC"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="dc_BiaoTiKC" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="dc_KeShiMC"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="dc_KeShiMC" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="dc_ZhuJiangR"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="dc_ZhuJiangR" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td align="right">
					<html:command id="MLKZ_ChaXun" />
					<html:command id="MLKZ_QuXiaoXZ" />
					<html:command id="MLKZ_GuanBi" />
					
				</td>
			</tr>
		</table>		
		<html:jqgrid id="DHSJZ_DianXuan"  doResize="" processUnitId="SWDY_ChaXun"  rownumbers="true" pager="pager"   height="400"/></div>
		<html:paraSave/>
	</html:form>
</body>
</html>