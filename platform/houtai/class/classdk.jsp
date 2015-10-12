<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
	<html:dialog id="GNDH_BanJiXXDK"/>
<script type="text/javascript">
	
</script>
</head>
<body >
	<html:form >
	<div class="ui-layout-center ui-jqdialog-content ui-widget-content">
		<table border="0" cellpadding="0" width="100%" cellspacing="0" style="table-layout: fixed;" >
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BanJiMC"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_BanJiMC"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BanJiBM"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_BanJiBM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BanZhuRXM"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_BanZhuRXM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BenBanRS"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_BenBanRS"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BanJiLX"/></td>
				<td class="DataTD" width="30%"><html:select disabled="true" id="di_BanJiLX" initText=""  modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BanJiKH"/></td>
				<td class="DataTD" width="30%"><html:textarea readonly="true" id="di_BanJiKH"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
		</table>
	</div>	
		<html:splitline modeStyle="ui-widget-content" width="100%"/>
		 <table width="94%" border="0" cellspacing="0" cellpadding="0" align="center" class="dj_bg">
			<tr>
				<td align="right">
					<html:command id="MLKZ_GuanBi"/>
				</td>
			</tr>
		</table>
	</html:form>
	<html:paraSave />
</body>
</html>