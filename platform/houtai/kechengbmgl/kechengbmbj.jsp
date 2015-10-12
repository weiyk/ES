<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="net.sf.json.JSONArray"%>
<%@page language="java" isELIgnored="false"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.qam.framework.extension.function.impl.AbstractFunction"%>
<%@page import="com.qam.web.extension.function.GetNowFunction"%>
<%@page import="com.qam.framework.beans.FunctionParameter"%>
<%@page import="com.qam.framework.beans.enumeration.DataType"%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf"%>
<!-- jquery -->
<%@include file="/common/jquery.jspf"%>
<%-- 验证 --%>
<%@include file="/common/jquery.validate.jspf"%>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>

<html:dialog id="GNDH_KeChengBMBJ" />
<title><%=executeResult.getDialog().getName()%></title>

<%
	boolean readonly = false;
	String shangjiMC=request.getParameter("cs_ShangJiMC");
	String shifouDC = request.getParameter("cs_ShiFouDC");
	System.out.println(shifouDC);
	if("DHZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
		readonly = true;
	}
%>		
<c:set value="<%=readonly %>" var="readonly"></c:set>
<script type="text/javascript">
	function save() {
		if (doValidate()) {
			return true;
		}
	}
	
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
		<html:hidden id="di_ShiFouDC_Value" value="<%=shifouDC %>"/>
		<div class="ui-layout-center">
			<div id="content" class="ui-jqdialog-content ui-widget-content">
				<table border="0" cellpadding="0" cellspacing="0"
					style="width: 100%" class="EditTable" id="TblGrid_list">
					<html:hidden id="di_KouLingYC" value ="123456"/>
					<tbody>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BianMuBM"/></td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_BianMuBM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>	
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BianMuMC"/></td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_BianMuMC"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_ShangJiBM"/></td>
							<td class="DataTD" width="30%"><html:text readonly="true" value="<%=shangjiMC%>" id="di_ShangJiBM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_BeiZhuSM"/></td>
							<td class="DataTD" width="30%"><html:textarea readonly="${readonly }" id="di_BeiZhuSM"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>				
					</tbody>
				</table>
				<html:splitline modeStyle="ui-widget-content" width="100%"/>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center" class="dj_bg">
					<tr>
						<td align="right"> 
								<html:command id="MLKZ_BaoCun" />
								<html:command id="MLKZ_BaoCunXG" />
								<html:command id="MLKZ_GuanBi" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<html:paraSave />
	</html:form>
</body>
</html>