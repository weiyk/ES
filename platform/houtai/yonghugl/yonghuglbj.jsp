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

<html:dialog id="GNDH_YongHuGLBJ" />
<title><%=executeResult.getDialog().getName()%></title>

<%
	boolean readonly = false;
	if("DHZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
		readonly = true;
	}
%>		
<c:set value="<%=readonly %>" var="readonly"></c:set>
<script type="text/javascript">
	function save() {
		if (doValidate()) {
			//判断登录名是否重复
			var XM = $("#di_ZhangHu").val();//登录名
			var count = 0;
			var state = '${param._qam_dialog_state}';
			if(state == "DHZT_XiuGai"){
				count = ExtFunctionCM.CheckRecordCount("XT_YONGHU"," WHERE  DENGLUM='" + XM + "' AND BIANHAO <> '" + $("#cs_BianHao").val() + "'");
			}else if(state == "DHZT_XinZeng"){
				count = ExtFunctionCM.CheckRecordCount("XT_YONGHU"," WHERE  DENGLUM='" + XM + "'");
			}
			if (count > 0) {
				$(this)._alert('提示', '该账户已存在,请重新填写');
				return;
			}
			return true;
		}
	}
	function changgeProvince(){
		var result="";
		var condition =" where parent_id='"+$('#J_province').val()+"'";
		$.ajax({
			url:'${path}/servlet/AjaxServlet',
			type:"post",
			traditional:true,
			async:false,
			data:{service:"com.rc.web.extension.ajax.GetOptionsService",
				parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
				value:["pt_region","region_name","region_id",condition,"请选择","",""]},
			complete:function(XHR, TS){
				result = XHR.responseText;
				if('_qam_ajax_error'==result){
					$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
					throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
				}
				XHR = null;
			}
		});
		$('#J_city').html(result);
		$('#J_town').html('<option value="">请选择</option>');
	}
	function changgeCity(){
		var result="";
		var condition =" where parent_id='"+$('#J_city').val()+"'";
		$.ajax({
			url:'${path}/servlet/AjaxServlet',
			type:"post",
			traditional:true,
			async:false,
			data:{service:"com.rc.web.extension.ajax.GetOptionsService",
				parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
				value:["pt_region","region_name","region_id",condition,"请选择","",""]},
			complete:function(XHR, TS){
				result = XHR.responseText;
				if('_qam_ajax_error'==result){
					$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
					throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
				}
				XHR = null;
			}
		});
		$('#J_town').html(result);
	}
     $().ready(function(){
     	var pro=$('#J_province_YC').val();
     	var J_town=$('#J_town_YC').val();
     	var J_city=$('#J_city_YC').val();
     	if(pro){
     		$('#J_province').val(pro);
     		var result="";
				var condition =" where parent_id='"+$('#J_province').val()+"'";
				$.ajax({
					url:'${path}/servlet/AjaxServlet',
					type:"post",
					traditional:true,
					async:false,
					data:{service:"com.rc.web.extension.ajax.GetOptionsService",
						parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
						value:["pt_region","region_name","region_id",condition,"请选择","",""]},
					complete:function(XHR, TS){
						result = XHR.responseText;
						if('_qam_ajax_error'==result){
							$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
							throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
						}
						XHR = null;
					}
				});
				$('#J_city').html(result);
				$('#J_city').val(J_city);
				result="";
				condition =" where parent_id='"+$('#J_city').val()+"'";
				$.ajax({
					url:'${path}/servlet/AjaxServlet',
					type:"post",
					traditional:true,
					async:false,
					data:{service:"com.rc.web.extension.ajax.GetOptionsService",
						parameter:["tableName","textField","valueField","condition","initText","dataSource","seletcedValue"],
						value:["pt_region","region_name","region_id",condition,"请选择","",""]},
					complete:function(XHR, TS){
						result = XHR.responseText;
						if('_qam_ajax_error'==result){
							$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
							throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
						}
						XHR = null;
					}
				});
				$('#J_town').html(result);
				$('#J_town').val(J_town);
     	}
     })
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
		<div class="ui-layout-center">
			<div id="content" class="ui-jqdialog-content ui-widget-content">
				<table border="0" cellpadding="0" cellspacing="0"
					style="width: 100%" class="EditTable" id="TblGrid_list">
					<html:hidden id="di_KouLingYC" value ="123456"/>
					<tbody>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_ZhangHu"/></td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_ZhangHu"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>	
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_XingMing" /></td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_XingMing"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_ChangYongYX"/></td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_ChangYongYX"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%">手机号</td>
							<td class="DataTD" width="30%"><html:text readonly="${readonly }" id="di_ShouJi"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_Sex"/></td>
							<td class="DataTD" width="10%"><html:radiobox readonly="${readonly }" id="di_Sex"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:10%" /></td>
						</tr>	
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_ChuShengRQ"/></td>
							<td class="DataTD" width="30%"><html:datepick readonly="${readonly }" id="di_ChuShengRQ"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>	
						<tr>
							<td   class="CaptionTD"  align="right" width="10%">所在地区</td>
							<td class="DataTD" width="30%">
							<html:hidden id="J_province_YC" />
							<html:hidden id="J_city_YC" />
							<html:hidden id="J_town_YC" />
							<html:select disabled="${readonly }" id="J_province" onchange="changgeProvince()" initText="请选择" enumSQL="select region_name,region_id from pt_region where region_type='1'"  modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:25%" />
							<html:select disabled="${readonly }" id="J_city"  onchange="changgeCity()" initText="请选择"  modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:25%" />
							<html:select disabled="${readonly }" id="J_town" initText="请选择"  modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:25%" />
							
							
							</td>
						</tr>	
						<tr>
							<td   class="CaptionTD"  align="right" width="10%"><html:title id="di_GeRenJJ"/></td>
							<td class="DataTD" width="30%"><html:textarea readonly="${readonly }" id="di_GeRenJJ"   modeStyle="FormElement ui-widget-content ui-corner-all"  style="WIDTH:80%" /></td>
						</tr>				
					</tbody>
				</table>
				
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