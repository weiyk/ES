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
	<html:dialog id="GNDH_XiTongRZSC" async="false"/>
<script type="text/javascript">
	function check(){
		var flag;
		if(!$("#dc_CaoZuoSJ").val() && !$("#dc_CaoZuoSJZ").val()){
			$(this)._confirm('提示','未输入条件将删除全部日志?',450,240,function(param){
				if(param == 1){
					flag = true;
					shanchu();
				}else if(param == 0){
					flag = false;
				}
			});
			return;
		}
		shanchu();
	}
	function shanchu(){
		var postData = {"_qam_dialog":"GNDH_XiTongRZSC","_qam_command":"MLKZ_QueDing","rc_datatype":"json","_dialog_submit_":"GNDH_XiTongRZSC","_rc_dialog_groupid":"DHSJZ_SCTJ","_rc_sortname":"{}","_rc_istreegrid":false,"_qam_dialog_state":"DHZT_XiuGai"};
		if($("#dc_CaoZuoSJ").val() && $("#dc_CaoZuoSJZ").val() &&  $("#dc_CaoZuoSJ").val() > $("#dc_CaoZuoSJZ").val()){
			$(this)._alert('提示','操作开始时间不能大于结束时间');
			return false;
		}
		postData['dc_CaoZuoSJ'] = $("#dc_CaoZuoSJ").val();
		postData['dc_CaoZuoSJZ'] = $("#dc_CaoZuoSJZ").val();
		$(this)._post(postData,function(){
			$(this)._close(1);
		});
	}
</script>
</head>
<body >
	<html:form >
	<div class="ui-layout-center ui-jqdialog-content ui-widget-content">
		<table border="0" cellpadding="0" width="100%" cellspacing="0" style="table-layout: fixed;" >
			<tr>
				<td   class="CaptionTD"  align="right" width="10%"><html:title id="dc_CaoZuoSJ"/></td>
				<td class="DataTD" width="30%"><html:datepick  modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_CaoZuoSJ"  style="WIDTH:80%" /></td>
				<td   class="CaptionTD"  align="center" width="10%"><html:title id="dc_CaoZuoSJZ"/></td>
				<td class="DataTD" width="30%"><html:datepick modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_CaoZuoSJZ" style="WIDTH:80%" /></td>
			</tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
		</table>
	</div>	
		<html:splitline modeStyle="ui-widget-content" width="100%"/>
		 <table width="94%" border="0" cellspacing="0" cellpadding="0" align="center" class="dj_bg">
			<tr>
				<td align="right">
					<html:command id="MLKZ_QueDing"/>
					<html:command id="MLKZ_GuanBi"/>
				</td>
			</tr>
		</table>
	</html:form>
	<html:paraSave />
</body>
</html>