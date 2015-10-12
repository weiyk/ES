<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-6-10(精确到日)
	*@description:用户查询
	*@version: 
	**/
%>
<%@ page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/ui.jspf" %>
<%@include file="/common/jqgrid.jspf" %><%--包含定义文件 --%>
<html>
<head>

<html:dialog id="GNSW_XuanZeSJX" /><%--进行对话初始化(必须的且在其他任何标签之前)--%>
<title><%=executeResult.getDialog().getName() %></title>
<script type="text/javascript">
	function setShuJuBBM(){
		ExtFunctionCM.GetOneFieldValue("QAM_ShuJuFL T1,Qam_ShiTi T2","T2.ShiTiBM ","where T1.ShuJuB = T2.ShiTiBM and  T1.bianhao ='<%=request.getParameter("cs_ShuJuFLBH")%>'","",0,function callback(data){ExtFunctionCM.getObject("dc_ShuJuBBM").value=data;});
	}
	var rowData=[];
	$(function(){
		var bm = '${param.cs_ShuJuXZ}';
		var bms = bm.split(",");
		$.each(bms,function(i,bieMing){
			if(bieMing){
				rowData.push(bieMing);
			}
		});
		$("#tabs_GNSW_XuanZeSJX").bind('tabsselect', function(event, ui){
			if(ui.index == 1){
				var pData = $("#ChaXunJG_YXZ").getGridParam("postData");
				pData['cs_ShuJuXZ'] = rowData.join(",");
				pData['cs_ShuJuFLBH'] = $("#cs_ShuJuFLBH").val();
				pData['cs_ShuJuXBM'] = $("#cs_ShuJuXBM").val();
				pData['_qam_dialog_state'] = 'XuanZe';
				$("#ChaXunJG_YXZ").setGridParam({postData:pData}).trigger("reloadGrid");
			}
		});
	});
	function selectValue(){	
		var selIds = $("#ChaXunJG").getGridParam('selarrrow');
		if(selIds.length == 0){
			$(this)._alert('提示','请选择记录！');
			return;
		}
		var ids=[];
		$.each(selIds,function(i,id){
			ids.push(id);
		});
		$.each(ids,function(i,id){
			rowData.push($("#di_ShuJuXZ_"+(id-1),$("#ChaXunJG")).val());
			$("#ChaXunJG").delRowData(id);
		});
	}
	function queding(){
		var ids = $("#ChaXunJG_YXZ").getDataIDs();
		var selIds = $("#ChaXunJG_YXZ").getGridParam('selarrrow');
		var data=[];
		$.each(ids,function(i,id){
			if(jQuery.inArray(id,selIds) == -1){
				var shuJuXZ = $("#di_ShuJuXZ_YXZ_"+(id-1),$("#ChaXunJG_YXZ")).val() || $("#ChaXunJG_YXZ").getCell(id,'di_ShuJuXZ_YXZ');
				data.push(shuJuXZ);
			}
		});
		if(data.length == 0 && rowData.length == 0){
			$(this)._alert('提示','请选择记录!');
			return;
		}
		if(data.length > 0){
			$("#cs_ShuJuXZ").val(data.join(","));
		}else{
			$("#cs_ShuJuXZ").val(rowData.join(","));
		}
		top.newWin.dialog('close');
	}
	<%--清空值--%>
	function clearValues(){
		$("#cs_ShuJuXZ").val('');
		$("#cs_Clear").val('1');
		top.newWin.dialog('close');
	}
	function closeWin(constrainExp){
		if(!constrainExp){
			if(!confirm('\u786e\u5b9a\u79bb\u5f00\u672c\u9875\u9762\u5417\uff1f')) 
				return false;
		}
		top.newWin.dialog('close');
	}
</script>
</head>
<body onload="setShuJuBBM();ExtFunctionCM.getObject('dc_SheZhiTJ').value='0';">

<html:form  ><%--产生form标签(可选的) --%>
<html:group id = "{all}" tableAttribute=" class=\"table\" border =0 width=\"97%\" cellspacing=\"0\" cellpadding=\"2\" align=\"center\"" titleTdAttribute="class=\"title_cx\"" contentTdAttribute="class=\"content_L\""   rowCount="2" /><%--根据指定的单条数据组id，产生数据项 (可选的)--%>
<html:hidden id="cs_Clear"/>
<table align="center" STYLE="border-collapse:collapse;" width="95%">
	<tr >
		<Td align="left" WIDTH="60%" >
			
		</Td> 
		<%--
		<Td align="right" >
			<html:command id="MLKZ_TreeView"/>
		</Td> 
		<td align="right">
			
			<html:command id="ML_TiaoJianSZ"/>
		</td>
		 --%>
		<td align="right">
			<html:button id = "XuanZe" value="选择" onclick="selectValue()"/>
		</td>
		<td align="right">
			<html:button id = "XuanZe" value="确定" onclick="queding()"/>
		</td>		
		<td align="right">
			<html:button id="clear" value="清除" onclick="clearValues();"/>
		</td>
		<td align="right">
			<html:button id="GuanBi" value="关闭" onclick="closeWin()"/>
		</td>
	</tr>
</table>

<html:splitline width="100%"/><%--产生间隔线(可选的) --%>
<html:tabcontrol style="font-size:90%; height: 85%;">
	<html:tabtitle tabNames="未选数据项值,已选数据项值"/>
	<html:tabpage index="1">
		<div style="width:95%">
			<html:sjqgrid id="ChaXunJG" options="{rownumbers:true,multiselect:true}" doSelfCustom="true" doDelRow = "false"/><%--产生grid列表(可选的) --%>
		</div>	
	</html:tabpage>
	<html:tabpage index="2">
		<div style="width:95%">
			<html:jqgrid id="ChaXunJG_YXZ" dialogState="cx" height="280" multiSelect="true" rownumbers="true"/><%--产生grid列表(可选的) --%>
		</div>	
	</html:tabpage>
	
</html:tabcontrol>
<div style="display:none">
	<html:command id="ML_ChaXun"/>
</div>
<html:paraSave/>
</html:form><%--form标签结束(可选的,如果使用了form标签，则是必须的) --%>

</body>
</html>