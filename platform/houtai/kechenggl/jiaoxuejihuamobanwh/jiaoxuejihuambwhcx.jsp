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
		<html:dialog id="GNDH_JiaoXueJH" async="false"/>
		<script type="text/javascript">
		//点击关闭调取查询
		function afterCloseDialog(){
			$("#MLKZ_ChaXun").click();
		}
		$(function(){
			//查询
			$("#MLKZ_ChaXun").bind('click',function(){
				var con = ['dc_MoBanMC','dc_MoBanLX','dc_JianLiR'];
				$(this)._search('DHSJZ_JiaoXueJiHuaMB','MLKZ_ChaXun',con);
			});
			//新增
			$("#MLKZ_XinZeng").bind('click',function(){
		  	  		$(this)._dialog('${path}/servlet/jspdispatchservlet?_qam_dialog=GNDH_MoBanBJ&_qam_dialog_state=DHZT_XinZeng','GNDH_MoBanBJ',700,480,'新增教学计划模板');
		  	});
			//删除
		  	$("#MLKZ_ShanChu").bind('click',function(){
			  		var ids = $("#DHSJZ_JiaoXueJiHuaMB").getGridParam('selarrrow');//多选
			  		var bianhao = jQuery('#DHSJZ_JiaoXueJiHuaMB').getCell(ids[0],'di_BianHao') || $("#di_BianHao_"+(ids[0]-1)).val();//编号
			  		if(!bianhao){
			  			$(this)._alert('提示','请选择要删除的记录！');
						return false;
			  		}
			  		$(this)._delRecord('DHSJZ_JiaoXueJiHuaMB','MLKZ_ShanChu','di_BianHao','',function(){
			  			$("#MLKZ_ChaXun").click();
					});	
						
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
					<html:title id="dc_MoBanMC"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="dc_MoBanMC" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="dc_MoBanLX"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:select id="dc_MoBanLX" initText="请选择"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"></html:select>
				</td>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="dc_JianLiR"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="dc_JianLiR" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:90%"/>
				</td>
				<td align="right">
					<html:command id="MLKZ_ChaXun" />
					<html:command id="MLKZ_XinZeng" />
					<html:command id="MLKZ_ShanChu" />
					
				</td>
			</tr>
		</table>		
		<html:jqgrid id="DHSJZ_JiaoXueJiHuaMB"  doResize="" processUnitId="SWDY_ChaXun" sortable="true"  rownumbers="true" pager="pager"  autoWidth="true" multiboxonly="true" height="400" multiSelect="true"/>
	</div>
		<html:paraSave/>
	</html:form>
</body>
</html>