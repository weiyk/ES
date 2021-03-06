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
		<html:dialog id="GNDH_KeChengCX" async="false"/>
		<script type="text/javascript">
			$(function(){
				$("#MLKZ_ChaXun").bind('click',function(){
					var con = ['dc_BiaoTi','dc_BiaoQian'];
					$(this)._search('DHSJZ_ChaXunJG','MLKZ_ChaXun',con);
				});
				//删除
				$("#MLKZ_ShanChu").bind('click',function(){
		 			var grid = $("#DHSJZ_ChaXunJG");
					var selIds = grid.getGridParam('selarrrow');
					
		            $(this)._delRecord('DHSJZ_ChaXunJG','MLKZ_ShanChu','di_BianHao',null,function(){
		            	$("#MLKZ_ChaXun").click();
		            });
		         });
		         //查看教学计划
		         $("#MLKZ_ChaKanJXJH").bind('click',function(){
		 			var grid = $("#DHSJZ_ChaXunJG");
					var ids = grid.getGridParam('selarrrow');
					var bianhao = $("#DHSJZ_ChaXunJG").getCell(ids[0],'di_BianHao')||$("#di_BianHao_"+(ids[0]-1)).val();
					if(ids.length==1&&bianhao){
						$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueJHCX_HT&_qam_dialog_state=DHZT_ChaXun&cs_KeChengBH='+bianhao,'GNDH_JiaoXueJHCX_HT',650,450,'教学计划查询');
					}else{
						$(this)._alert("提示","请选择一条数据查看计划！");
						return false;
					}	
		         });
			  });
			
		</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td nowrap width="5%" class="CaptionTD" align="left">
					<html:title id="dc_BiaoTi"/>
				</td>
				<td  width="22%" class="DataTD">
					<html:text id="dc_BiaoTi" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td nowrap width="7%" class="CaptionTD" align="left">
					<html:title id="dc_BiaoQian"/>
				</td>
				<td  width="22%" class="DataTD">
					<html:text id="dc_BiaoQian" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td align="right">
					<html:command id="MLKZ_ChaXun"/>
					<html:command id="MLKZ_ChaKanJXJH"/>
					<html:command id="MLKZ_ShanChu"/>
				</td>
			</tr>
		</table>		
		<html:jqgrid id="DHSJZ_ChaXunJG"  doResize="" processUnitId="SWDY_KeChengCX" sortable="true" sortName="di_BiaoTi:BiaoTi,di_BiaoQian:BiaoQian,di_XueDuan:XueDuan,di_NianJi:NianJi,di_KeMu:KeMu,di_KeBenLX:KeBenLX,di_JiaoXueMS:JiaoXueMS,di_BeiKeMS:BeiKeMS,di_ZhuangTai:ZhuangTai,di_JianLiKCR:JianLiR" rownumbers="true" pager="pager"  autoWidth="true" multiboxonly="true" height="400" multiSelect="true"/>
	</div>
		<html:paraSave/>
	</html:form>
</body>
</html>