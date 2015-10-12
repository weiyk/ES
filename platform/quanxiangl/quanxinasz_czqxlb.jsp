<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-8-7
	*@description:已授权功能活动列表
	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>已授权功能活动列表</title>
<script type="text/JavaScript">
function message_show_success(message){
	$(this)._alert('提示',message);	
}
</script>
</head>
<body bottomMargin=0 leftMargin=1 topMargin=2 rightMargin=0>

<html:dialog />
<html:form>
<html:command id="ChaXun" style="display:none"/><html:command id="ChaXunHMD" style="display:none"/><html:command id="ShanChuCZQX" style="display:none"/><html:command id="ShanChuHMD" style="display:none"/>
<table id="ChaXunJG"  align="center"  border="1"  width="100%"  cellspacing="0"  cellpadding="0" >
	<tr id="" >
		<th id="td_di_SuoShuGN_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "26%">所属功能</th>
		<th id="td_di_MingCheng_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "26%">操作名称</th>
		<th id="td_di_BieMing_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "26%">操作别名</th>
		<th id="td_di_ShifouJC_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "13%">是否继承</th>
		<th id="td_di_ShouQuan_t"   class="td_bg"  align="center"  border="0"  nowrap="yes"  width = "14%" >删除
			<input type="checkbox" id="di_ShouQuan_all" name="di_ShouQuan_all" class="f_checkbox" onclick="ExtFunctionCM.selAllCheck(this,'di_ShouQuan','ChaXunJG','n')"/>
		</th>
	</tr>
<html:sjqgrid id="ChaXunJG"  doCreateTable="false" doCreateTitle="false" doSelfCustom="true"/>
</table>
<input type="hidden"  id="_qam_rowcount_ChaXunJG" name="_qam_rowcount_ChaXunJG"/>
<%-- 
<html:jqgrid id="ChaXunJG" doResize="doResize" multiSelect="true" otherPostData="{cs_SuoShuGN:\"${param.cs_SuoShuGN }\",cs_ChaXunFW:\"${param.cs_ChaXunFW }\",cs_ShouQuanLX:\"${param.cs_ShouQuanLX }\",cs_QuanXianDXBH:\"${param.cs_QuanXianDXBH }\",cs_QuanXianDXLX:\"${param.cs_QuanXianDXLX }\",cs_HuoDongBM:\"${param.cs_HuoDongBM }\",cs_HuoDongMC:\"${param.cs_HuoDongMC }\"}"  pager="pager" autoWidth="true" height="241"/>
--%>
<html:paraSave/>
<script language="javascript">
	var rowCount = ExtFunctionCM.getObject("_qam_rowcount_ChaXunJG").value;
	$(function(){
	$("#jqgh_ChaXunJG_td_di_ShouQuan_t").removeClass();	
	$("#_qam_rowcount_ChaXunJG").val(rowCount);
		if(rowCount>0){		
			for(var i=0;i<rowCount;i++){
				var appointedCheck = ExtFunctionCM.getObject("di_ShouQuan_"+i);		
				var quanxiandxbh = 	ExtFunctionCM.getObject("di_QuanXianDXBH_"+i);	
				var shifoujc = ExtFunctionCM.getObject("di_ShifouJC_"+i).value;	
				if(appointedCheck.disabled){
					continue;
				}
				quanxiandxbh.value="<%=request.getParameter("cs_QuanXianDXBH") %>";
				if("是"==shifoujc && "CaoZuoQXCX"=="<%=dialogState %>"){				
					appointedCheck.disabled=false;
				}
				else{
					appointedCheck.disabled=false;
				}		
			}
		}
	});
	
	function doDel(){
		var  mingcheng = "操作权限";
		<%
			if(dialogState.equals("HeiMingDCX")){
		%>
			mingcheng = "黑名单";
		<%
			}
		%>
		$("#_qam_rowcount_ChaXunJG").val(rowCount);
		if(ExtFunctionCM.getSelectCount('ChaXunJG','di_ShouQuan')>0){
			if(confirm("确定要删除选中"+mingcheng+"设置吗？")){
				return ExtFunctionCM.selAppointedCheck('di_ShouQuan','ChaXunJG','d','n');
			}
		}
		else{
			alert("请选择要删除的"+mingcheng+"设置");
		}
		return false;
	}
</script>
</html:form>
</body>
</html>