<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-10-7
	*@description:已授权行权限列表
	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>已授权行权限列表</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog />

<html:form>
<html:command id="ShanChu" style="display:none"/>

<table id="ChaXunJG"  width="100%">

	<tr id="" >

		<th id="td_di_SuoShuGN_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "20%">所属功能</th>
		<th id="td_di_SuoShuSW_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "20%">所属事务</th>
		<th id="td_di_SuoShuSWDY_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "25%">所属事务单元</th>
		<th id="td_di_ShuJuFlMC_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "25%">数据分类</th>
		<th id="td_DelRow_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "10%" align = "center"><nobr>删除<input type="checkbox" id="_qam_del_check_ChaXunJG_all" name="_qam_del_check_ChaXunJG_all" class="f_checkbox" onclick="ExtFunctionCM.selAllDelCheck(this,'_qam_row_state_ChaXunJG','_qam_del_check_ChaXunJG_','ChaXunJG')" value="false"></nobr></th>
	</tr>
<html:sjqgrid id="ChaXunJG" doCreateTable="false" doDelRow="true" doCreateTitle="false" doSelfCustom="true"/>
</table>
<input type="hidden"  id="_qam_rowcount_ChaXunJG" name="_qam_rowcount_ChaXunJG">
<html:paraSave/>
</html:form>
<script type="text/javascript">
	var rowCount = ExtFunctionCM.getObject("_qam_rowcount_ChaXunJG").value;
	$(function(){
		$("#_qam_rowcount_ChaXunJG").val(rowCount);
	});
</script>
</body>
</html>