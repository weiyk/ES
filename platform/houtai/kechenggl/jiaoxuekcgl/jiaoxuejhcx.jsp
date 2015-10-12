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
<html:dialog id="GNDH_JiaoXueJHCX_HT" async="false"/>
<script type="text/javascript">
function afterCloseDialog(){
	$("#MLKZ_ChaXun").click();
}
$(function(){
	$("#MLKZ_ChaXun").bind('click',function(){
		var con = ['dc_JiHuaBT'];
		$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
	});
	//删除
  	$("#MLKZ_ShanChu").bind('click',function(){
  		$(this)._delRecord('DHSJZ_ChaXunJG','MLKZ_ShanChu','di_BianHao','',function(){
  			$("#MLKZ_ChaXun").click();
		});	
	});
});
//调看
function dk(index){
	var bh =  $("#di_BianHao_"+index).val() || $('#DHSJZ_ChaXunJG').getCell((index+1),'di_BianHao');//编号
	var KeChengBH =  $("#di_KeChengBH_"+index).val() || $('#DHSJZ_ChaXunJG').getCell((index+1),'di_KeChengBH');//课程编号
	$(this)._fifthDialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueJHBJ_HT&_qam_dialog_state=DHZT_ChaXun&cs_JiHuaBH='+bh+'&cs_KeChengBH='+KeChengBH,'GNDH_JiaoXueJHBJ_HT',650,400,'教学计划编辑');

}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td nowrap width="5%" class="CaptionTD" align="left">
					<html:title id="dc_JiHuaBT"/>
				</td>
				<td  width="22%" class="DataTD">
					<html:text id="dc_JiHuaBT" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td align="right">
					<html:command id="MLKZ_ChaXun"/>
					<html:command id="MLKZ_ShanChu"/>
				</td>
			</tr>
		</table>		
		<html:jqgrid id="DHSJZ_ChaXunJG"  doResize="" processUnitId="SWDY_JiaoXueJHCX" sortable="true"  sortName="di_JiHuaBT:JiHuaBT,di_JiHuaLX:JiHuaLX,di_ChuangJianSJ:ChangJianSJ" rownumbers="true" pager="pager"  autoWidth="true" multiboxonly="true" height="300" multiSelect="true"/>
	</div>
	</html:form>
</body>
</html>