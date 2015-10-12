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
	<html:dialog id="GNDH_XueXiaoXXDK" state="DHZT_JinRu" />
<script type="text/javascript">
	
</script>
</head>
<body >
	<html:form >
	<div class="ui-layout-center ui-jqdialog-content ui-widget-content">
		<table border="0" cellpadding="0" width="100%" cellspacing="0" style="table-layout: fixed;" >
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XueXiaoBM"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_XueXiaoBM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XueXiaoMC"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_XueXiaoMC"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XueXiaoJC"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_XueXiaoJC"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_LianXiR"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_LianXiR"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_LianXiDH"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_LianXiDH"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XueXiaoWZ"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_XueXiaoWZ"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_QiangID"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_QiangID"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
			</tr>
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XueXiaoDZ"/></td>
				<td class="DataTD" width="30%"><html:text readonly="true" id="di_XueXiaoDZ"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
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