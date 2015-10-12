 <%@page import="java.util.Calendar"%>
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<% 
	/**
	*@author:masheng
	*@createdate:2006-8-7
	*@description:授权列表查询条件
	*@version:
	**/
%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<title>授权列表查询</title>
</head>
<body bottomMargin=0 leftMargin=1 topMargin=5 rightMargin=0>

<html:dialog  />

<html:form>
<html:hidden id="dc_FanWei" value="3"/>
<div  class="ui-jqdialog-content ui-widget-content">
<html:splitline width="100%"/>
<table border=0 width="95%" cellspacing="0" cellpadding="2" align="center" class="" >
	<tr>
		<td class="CaptionTD" width="10%" id="td_dcMingCheng" nowrap><html:title id="dc_MingCheng"/></td>
		<td class="DataTD" width="20%"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_MingCheng" /></td>
		<td class="CaptionTD" width="10%" id="td_dcBieMing" nowrap><html:title id="dc_BieMing"/></td>
		<td class="DataTD" width="20%"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_BieMing" /></td>
		<td class="CaptionTD" width="10%" nowrap><html:title id="dc_GongNengBM"/></td>
		<td class="DataTD" width="20%"><html:text style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" id="dc_GongNengBM"   /></td>
	</tr>	
	<tr>
		<td class="CaptionTD" nowrap><html:title id="dc_ShouQuanLX"/></td>
		<td  class="DataTD"><html:select style="width:98%" modeStyle="FormElement ui-widget-content ui-corner-all" optionValues="操作权限,0;" id="dc_ShouQuanLX" onchange="selChange()"/></td>	
		<td colspan=2 class="CaptionTD" id="td_ShouQuanDX" nowrap>授权对象：</td>		
		<td colspan=2 align="right" class="DataTD"><html:command id="ChaXun" modeStyle="f_btn01"/>&nbsp;<html:command id="ShanChu" modeStyle="f_btn01"/>&nbsp;<html:command id="SheZhiQX" enabled="false"  modeStyle="f_btn01"/></td>
	</tr>	
</table>
</div>
<html:splitline width="100%"/>
<iframe width="100%" height="80%" src="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_CZQX&_qam_dialog_state=CaoZuoQXCX&cs_QuanXianDXBH=-1&cs_ChaXunFW=0&cs_ShouQuanLX=0"  style="border:none;"  id="RightTree" name="RightTree" frameBorder="0" scrolling="auto"></iframe>
<html:paraSave/>
<script language="javascript">
	var selObj  = ExtFunctionCM.getObject("dc_ShouQuanLX");
	var iframeOjb = ExtFunctionCM.getObject("RightTree");
	//ExtFunctionCM.getObject("SheZhiQX").disabled=true;
	function selChange(){		
		var huodongbm=ExtFunctionCM.getObject("dc_BieMing").value;
		var huodongmc=ExtFunctionCM.getObject("dc_MingCheng").value
		var suoshugn = ExtFunctionCM.getObject("dc_GongNengBM").value;
		var quanxiandxbh=ExtFunctionCM.getObject("cs_QuanXianDXBH").value;
		var quanxiandxlx=ExtFunctionCM.getObject("cs_QuanXianDXLX").value;	
		var chaxunfw=ExtFunctionCM.getObject("dc_FanWei").value;
		var shouquanlx = selObj.value;
		ExtFunctionCM.getObject("td_dcMingCheng").innerText="<html:title id="dc_MingCheng"/>";
		ExtFunctionCM.getObject("td_dcBieMing").innerText="<html:title id="dc_BieMing"/>";
		
		if(""==quanxiandxbh || "null"==quanxiandxbh){
			ExtFunctionCM.getObject("SheZhiQX").disabled=true;
			alert("请选择权限组或用户");
			return ;
		}
		ExtFunctionCM.getObject("SheZhiQX").disabled=false;
		var pageSize = $("#RightTree").contents().find("#_qam_pagesize_ChaXunJG").val();
		switch(selObj.value){
			case "0":	//操作权限
				var src1="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_CZQX&_qam_dialog_state=CaoZuoQXCX&cs_ShouQuanLX=0";
				src1+="&cs_QuanXianDXBH="+quanxiandxbh+"&cs_ChaXunFW="+chaxunfw+"&cs_SuoShuGN="+suoshugn;						
				src1+="&cs_HuoDongBM="+huodongbm+"&cs_HuoDongMC="+huodongmc+"&cs_QuanXianDXLX="+quanxiandxlx+"&_qam_pagesize_ChaXunJG="+pageSize;
				iframeOjb.src=src1;				
				break;
			case "1":	//黑名单		
				if("0"==quanxiandxlx){
					ExtFunctionCM.getObject("SheZhiQX").disabled=false;
				}
				else{
					ExtFunctionCM.getObject("SheZhiQX").disabled=true;
				}
				var src1="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_CZQX&_qam_dialog_state=HeiMingDCX&cs_ShouQuanLX=1";
				src1+="&cs_QuanXianDXBH="+quanxiandxbh+"&cs_ChaXunFW="+chaxunfw+"&cs_SuoShuGN="+suoshugn;						
				src1+="&cs_HuoDongBM="+huodongbm+"&cs_HuoDongMC="+huodongmc+"&cs_QuanXianDXLX="+quanxiandxlx+"&_qam_pagesize_ChaXunJG="+pageSize;;
				iframeOjb.src=src1;		
				break;
			case "2"://列权限
				ExtFunctionCM.getObject("td_dcMingCheng").innerText="对话名称";
				ExtFunctionCM.getObject("td_dcBieMing").innerText="数据项名称";
				var src1="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_LQX&_qam_dialog_state=ChaXun";
				src1+="&cs_QuanXianDXBH="+quanxiandxbh+"&cs_ChaXunFW="+chaxunfw+"&cs_SuoShuGN="+suoshugn;						
				src1+="&cs_HuoDongBM="+huodongbm+"&cs_HuoDongMC="+huodongmc+"&cs_QuanXianDXLX="+quanxiandxlx+"&_qam_pagesize_ChaXunJG="+pageSize;;
				iframeOjb.src=src1;	
				break;
			case "3"://行权限
				//ExtFunctionCM.getObject("td_dcMingCheng").innerText="名称"
				ExtFunctionCM.getObject("td_dcBieMing").innerText="数据分类"
				var src1="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_HQX&_qam_dialog_state=ChaXun";
				src1+="&cs_QuanXianDXBH="+quanxiandxbh+"&cs_SuoShuGN="+suoshugn;						
				src1+="&cs_ShuJuFLMC="+huodongbm+"&cs_SuoShuSW="+huodongmc+"&cs_QuanXianDXLX="+quanxiandxlx+"&_qam_pagesize_ChaXunJG="+pageSize;;
				iframeOjb.src=src1;	
				break;
			default:
				var src1="<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YSQ_CZQX&_qam_dialog_state=CaoZuoQXCX&cs_ShouQuanLX=0";
				src1+="&cs_QuanXianDXBH="+quanxiandxbh+"&cs_ChaXunFW="+chaxunfw+"&cs_SuoShuGN="+suoshugn;						
				src1+="&cs_HuoDongBM="+huodongbm+"&cs_HuoDongMC="+huodongmc+"&cs_QuanXianDXLX="+quanxiandxlx+"&_qam_pagesize_ChaXunJG="+pageSize;;
				iframeOjb.src=src1;	
				break;
		}
	}
	function doChaXun(){		
		selChange();
	}
	function doShanChu(){
		switch(selObj.value){
			case "0":	
				//if(confirm("确定要删除选中操作权限设置吗？")){
					//document.frames("RightTree").document.forms[0].ShanChuCZQX.click();
					if($.browser.msie){
						document.frames("RightTree").document.forms[0].ShanChuCZQX.click();
					}else{
						document.getElementById("RightTree").contentWindow.document.getElementById('ShanChuCZQX').click();
					}
				//}	
				break;
			case "1":
				//if(confirm("确定要删除选中黑名单设置吗？")){
					if($.browser.msie){
						document.frames("RightTree").document.forms[0].ShanChuHMD.click();
					}else{
						document.getElementById("RightTree").contentWindow.document.getElementById('ShanChuHMD').click();
					}
				//}
				break;
			case "2":
				//if(confirm("确定要删除选中列权限设置吗？")){
					if($.browser.msie){
						document.frames("RightTree").document.forms[0].ShanChu.click();
					}else{
						document.getElementById("RightTree").contentWindow.document.getElementById('ShanChu').click();
					}
				//}
				break;
			case "3":
				//if(confirm("确定要删除选中的行权限设置吗？")){
					if($.browser.msie){
						document.frames("RightTree").document.forms[0].ShanChu.click();
					}else{
						document.getElementById("RightTree").contentWindow.document.getElementById('ShanChu').click();
					}
				//}
				break;
			default:
			
				break;
		}
	}
	function doSetRight(){
		
		var quanxiandxbh=ExtFunctionCM.getObject("cs_QuanXianDXBH").value;
		
		var quanxiandxlx=ExtFunctionCM.getObject("cs_QuanXianDXLX").value;	
		if(quanxiandxbh==""){
			alert("请选择权限对象！");
			return;
		}
		
		switch(selObj.value){
			case "0":	
				ExtFunctionCM.openNewWin("<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=ChaXunCZQX&_qam_dialog=GNDH_ShouQuanGL&cs_ShouQuanLX=0&cs_QuanXianDXLX="+quanxiandxlx+"&cs_QuanXianDXBH="+quanxiandxbh,"GNDH_ShouQuanGL","850","420","scrollbars=1,resizable=1");					
				break;
			case "1":
				if("0"==quanxiandxlx){				
					ExtFunctionCM.openNewWin("<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=ChaXunHMD&_qam_dialog=GNDH_ShouQuanGL&cs_ShouQuanLX=1&cs_QuanXianDXLX="+quanxiandxlx+"&cs_QuanXianDXBH="+quanxiandxbh,"GNDH_ShouQuanGL","850","420","scrollbars=1,resizable=1");					
				}
				else{
					alert("只有用户才能设置黑名单");
				}
				break;
			case "2":
				ExtFunctionCM.openNewWin("<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=ChaXun&_qam_dialog=GNDH_ShouQuanGL&cs_ShouQuanLX=liequanxian&cs_QuanXianDXLX="+quanxiandxlx+"&cs_QuanXianDXBH="+quanxiandxbh,"GNDH_ShouQuanGL","850","420","scrollbars=1,resizable=1");					
				
				break;
			case "3":
				ExtFunctionCM.openNewWin("<%=request.getContextPath() %>/servlet/jspdispatchservlet?_qam_dialog_state=BianJi&_qam_dialog=GNDH_ShouQuanGL&cs_ShouQuanLX=hangquanxian&cs_QuanXianDXLX="+quanxiandxlx+"&cs_QuanXianDXBH="+quanxiandxbh,"GNDH_ShouQuanGL","-1","420","scrollbars=1,resizable=1");					
				break;
			default:
				break;
		}
	}
</script>
</html:form>

</body>
</html>
