<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@page import="com.qam.framework.util.CommonUtils"%>
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-10-3
	*@description:行权限设置列表

	*@version: 	
	**/
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@include file="/common/jquery.validate.jspf" %>
<%@include file="/common/ui.jspf" %>
<%@include file="/common/jqgrid.jspf" %>
<title>行权限设置列表</title>
<script language="javascript">
	var validateInfo = {di_LNO:"{required:true,maxlength:2,max:'100',min:'1',number:true}",di_ShuJuXM:"{required:true,maxlength:50}",di_CompareSign:"{required:true,maxlength:20}",di_ShuJuZ:"{required:true,maxlength:2000}",di_ShuJuLX:"{required:true,maxlength:20}",di_RightCondition:"{maxlength:50}",di_LeftCondition:"{maxlength:50}"};
	$(function(){
		$("[validate]").each(function(){
			$(this).removeAttr("validate");
		});
	});
	function validate(){
		if(ExtFunctionCM.getObject("cs_ShuJuFLBH").value=="" ||ExtFunctionCM.getObject("cs_ShuJuFLBH").value=="null" ){
			alert("请选择一个数据分类进行行权限设置");
			return false;
		}
		var count = ExtFunctionCM.getGroupRowCount("HangQuanXSZ");
		var minLno =count;
		var lno ;
		var left;
		var right;
		var leftCount=0;
		var rightCount=0;
		var flag = true;
		for(var i = 0; i < count; i++){
			if("i"==ExtFunctionCM.getObject("_qam_row_state_HangQuanXSZ_"+i).value){	
				for(var key in validateInfo){
					$("#"+key+"_"+i).attr('validate',validateInfo[key]);
				}
				if(!doValidate()){
					flag = false;
					break;
				}
			}
		}
		if(!flag){
			return false;
		}
		for(var i=0;i<count;i++){
			lno = ExtFunctionCM.getObject("di_LNO_"+i).value;
			if(lno==""){
				continue;
			}
			else{
				for(var j=0;j<count;j++){
					if(i==j){
						continue;
					}
					var lno2 = ExtFunctionCM.getObject("di_LNO_"+j).value;
					if(lno==lno2){
						alert("序号不能重复");
						ExtFunctionCM.getObject("di_LNO_"+j).focus();
						return false;
					}
				}
				if(parseInt(lno)<minLno && "i"==ExtFunctionCM.getObject("_qam_row_state_HangQuanXSZ_"+i).value){
					minLno=parseInt(lno);
				}
			}
		}
		
		for(var i=0;i<count;i++){
			lno = ExtFunctionCM.getObject("di_LNO_"+i).value;
			if(lno==""){
				continue;
			}			
			if("i"!=ExtFunctionCM.getObject("_qam_row_state_HangQuanXSZ_"+i).value){	
				continue;
			}
			left = ExtFunctionCM.Trim(ExtFunctionCM.getObject("di_LeftCondition_"+i).value.toLowerCase());
			right = ExtFunctionCM.Trim(ExtFunctionCM.getObject("di_RightCondition_"+i).value);
			if(left!=""){
				if(left.indexOf("and")==0){
					if(parseInt(lno)==minLno){
						alert("字符串出错，第一项不能有连接符\"or\"和\"and\"");
						ExtFunctionCM.getObject("di_LeftCondition_"+i).focus();
						return false;
					}
					left = left.substr(3);
				}
				else if(left.indexOf("or")==0){
					if(parseInt(lno)==minLno){
						alert("字符串出错，第一项不能有连接符\"or\"和\"and\"");
						ExtFunctionCM.getObject("di_LeftCondition_"+i).focus();
						return false;
					}
					left = left.substr(2);
				}
				
				for(var j=0;j<left.length;j++){
					if("("!=left.charAt(j)){
						alert("前置连接符只能是由\"or\"、\"and\"或\"(\"组成，并且\"or\"或\"and\"只能位于连接符起始位置");
						return false;
					}
				}
				leftCount +=left.length;
			}
			if(right!=""){
				for(var j=0;j<right.length;j++){
					if(")"!=right.charAt(j)){
						alert("后置连接符只能是由\")\"组成");
						return false;
					}
				}
				rightCount +=right.length;
			}
		}
		if(leftCount!=rightCount){
			alert("左括号数量不等于右括号数量，请检查！");
			return false;
		}
		return true;
	}
	function selectDataValue(rowIndex,selectObj,url,dialogId,width,height){	
		url = url.replace(/&cs_ShuJuXZ=/g,"");
		var shujux  = ExtFunctionCM.getObject('di_ShuJuXM_'+rowIndex).value;
		if(shujux==""){
			alert("请选择数据项");
			return false;
		}
		
		url +="&cs_ShuJuXBM="+shujux;
		
		url +="&cs_ShuJuXZ="+$("#di_ShuJuZ_"+rowIndex).val();
		
		openWin(selectObj,url,dialogId,width,height,'选择数据项');
		//ExtFunctionCM.SelectValue('di_ShuJuZ_'+rowIndex,selectObj,url,width,height);
	}
	function selectSessionValue(rowIndex,selectObj,url,dialogId,width,height){
		var sessionValue = ExtFunctionCM.getObject("di_ShuJuZ_"+rowIndex).value;
		if(sessionValue.length>0){
			url += "&cs_BieMing="+sessionValue.replace(/session./g,"");
		}
		openWin(selectObj,url,dialogId,width,height,'选择全局变量');
		//url +="&cs_ShuJuXBM="+shujux;	
		//ExtFunctionCM.SelectValue(dialogId,selectObj,url,width,height);
	}
	<%--打开窗口--%>
	function openWin(para,url,targetDialogId,dialogWidth,dialogHeight,title){
		if(!dialogWidth){
			dialogWidth=700;
		}
		if(!dialogHeight){
			dialogHeight=500;
		}
		top.newWin.dialog("option",{
			title:title,
			closeOnEscape:false,
			width:dialogWidth,
			height:dialogHeight,
			modal:true,
			open: function(event, ui) {
				event.target.innerHTML = '<iframe id="'+targetDialogId+'" src="'+url+'" width="100%" height="100%" scrolling="auto" border="0" frameborder="0"></iframe>';
			},
			close:function(event,ui){//\u70b9\u9009\u8d4b\u503c
				for(var i = 0; i < para.length; i++){
					var val = para[i];
					var value = $("#"+targetDialogId,this).contents().find("#"+val[0]).val();
					var kong = $("#"+targetDialogId,this).contents().find("#cs_Clear").val();
					if(!value && !kong) continue;
					if($("#"+val[1]).attr('id')){
						$("#"+val[1]).val(value);
					}else{
						var rowNumber = val[2];
						if($("#"+val[1]+"_"+rowNumber).attr("id")){
							$($("#"+val[1]+"_"+rowNumber)).val(value);
						}else{
							var rowData = jQuery("#"+val[3]).jqGrid('getRowData', (rowNumber+1)); 
							rowData[val[1]]=value;
						}
					}
				}
				$("#"+targetDialogId,this).attr('src',"");
				event.target.innerHTML="";
			}
		});
		top.newWin.dialog("open");
	}
	$(function(){
		$("td[id^='td_DelRow']").each(function(){
			$(this).attr('width','6%');
		});
	});
</script>
</head>
<body bottomMargin=0 leftMargin=0 topMargin=3 rightMargin=0 >

<html:dialog/>

<html:form>

<table>
	<tr>
		<td width="85%">&nbsp;</td>
		<td width="10%"><nobr>显示<html:controls id="di_ZuiXiaoHS"/>条</nobr></td>
		<td width="5"><nobr><html:command id="BaoCun"/>
		<%if(CommonUtils.null2Blank(request.getParameter("cs_ShuJuFLBH")).length() == 0 || "null".equals(CommonUtils.null2Blank(request.getParameter("cs_ShuJuFLBH")))){ %>
			<html:button id="GuanBi" value="关闭" onclick="if(confirm('确定要离开本页面吗？')){parent.window.close();}"/>
		<%}else{ %>
			<html:button id="GuanBi" value="关闭" onclick="$(this)._close()"/>
		<%} %>
		</nobr></td>
	</tr>
</table>
<%
	int minRows =11;
	if(request.getParameter("di_ZuiXiaoHS")!=null && request.getParameter("di_ZuiXiaoHS").length()>0){
		try{
			minRows = Integer.parseInt(request.getParameter("di_ZuiXiaoHS"));
		}
		catch(Exception e){
			minRows =11;
		}
	}
	executeResult.getDialog().findDialogGroup("HangQuanXSZ").setMinRows(minRows);
%>
<html:splitline width="99%"/>
<html:tabcontrol style="font-size:90%; height: 93%;">
		<html:tabtitle tabNames="行权限设置,已继承行权限"/>
		<html:tabpage index="1">
			<div style="width:95%">	
				<html:sjqgrid id="HangQuanXSZ" resetRowState="i"   doDelRow="true"  doSelfCustom="false"/>
			</div>
		</html:tabpage>
		<html:tabpage index="2">	
			<div style="width:95%">
				<html:sjqgrid id="JiChengHQX" resetRowState="i" doDelRow="false"  doSelfCustom="false"/>
			</div>	
		</html:tabpage>	
</html:tabcontrol>
<div style="display:none"><html:command id="ML_ChuShiHua"/></div>
<html:paraSave/>
</html:form>
<div id="newWin">
	
</div>
</body>
</html>