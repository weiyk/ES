<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-11
	*@description:已授权列权限列表
	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>已授权列权限列表</title>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0>

<html:dialog  />

<html:form>
<html:command id="ShanChu" style="display:none"/>
<html:sjqgrid id="ChaXunJG" doDelRow="false"  doSelfCustom="true"/>
<html:paraSave/>
<script language="javascript">
	var rowCount = ExtFunctionCM.getObject("_qam_rowcount_ChaXunJG").value;
	if(rowCount>0){		
		for(var i=0;i<rowCount;i++){
			var appointedCheck = ExtFunctionCM.getObject("di_ShanChu_"+i);
			var shifoujc = $("#ChaXunJG").getCell(i*1+1*1,"di_ShiFouJC_t")
			if(appointedCheck.disabled){
				continue;
			}			
			if("是"==shifoujc ){				
				appointedCheck.disabled=true;
			}
			else{
				appointedCheck.disabled=false;
			}		
		}
	}
	function doDel(){
		
		if(ExtFunctionCM.getSelectCount('ChaXunJG','di_ShanChu')>0){
			if(confirm("确定要删除选中列权限设置吗？")){
				return ExtFunctionCM.selAppointedCheck('di_ShanChu','ChaXunJG','d','n');				
			}
		}
		else{
			alert("请选择要删除的列权限设置");
		}
		return false;
	}
</script>
</html:form>
</body>
</html>