<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<%@ page import="com.qam.framework.util.CommonUtils" %>
<% 
	/**
	*@author:masheng(邮箱名)
	*@createdate:2006-6-10(精确到日)
	*@description:用户查询
	*@version: 
	**/
%>
<html>
<head>
<title>设置排序&过滤条件</title>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%--ztree --%>
<%@include file="/common/ztree.jspf" %>
<base target="_self">
</head>
<body onload="init();">
<html:dialog id="GNDH_ShuJuXCXGLSZ"/> 
	<html:form>
		<table  width="100%">
			<tr>
				<td width="40%">&nbsp;</td>
				<td width="60%">
					<html:button id="clear_filter" value="清除过滤条件" onclick="clearFilter()"/>&nbsp;
					<html:button id="clear_sort" value="清除排序设置" onclick="clearSort()"/>&nbsp;
					<html:button id="queding" value="确定" onclick="doQueDing()"/>&nbsp;
					<html:button id="guanbi" value="取消" onclick="window.close()"/>&nbsp;
				</td>			
			</tr>
		</table>
		<%
			String sql = "select distinct sx.BieMing,sx.BieMing from QAM_ShuXing SX  where SX.shitibm='"+request.getParameter("cs_ShuJuB")+"' order by SX.BieMing  ";
		%>
		<html:tabcontrol height="100%" width="100%">
		
			<html:tabtitle tabNames="过滤条件,排序设置"/>
			<html:tabpage index="2">
				<table class="table" align="left" border=0>
					<tr>
						<td width="45%" class="content_L">
							<html:select ondblclick="moveRight('ASC')" id="di_ZiDuanM" enumSQL="<%=sql %>"  style="width:98%" multiple="true" size="15"/>
						</td>
						<td width="10%" class="content_L">
							<html:button id="to_left" onclick="moveLeft()" value=" ← "/><br><br>
							<html:button id="to_right_ASC" onclick="moveRight('ASC')" value="ASC →"/><br>
							<html:button id="to_right_DESC" onclick="moveRight('DESC')" value="DESC →"/><br><br>
							<html:button id="to_up" onclick="moveUp()" value=" ↑ "/><br><br>
							<html:button id="to_down" onclick="moveDown()" value=" ↓ "/>
						</td>
						<td width="45%" class="content_L">
							<html:select id="di_PaiXuTJ" style="width:98%" multiple="true" size="15"/>
							
						</td>
					</tr>
				</table>
			</html:tabpage>
			<html:tabpage index="1">
				<table class="table" align="left" border=0>
					<tr>
						<td class="content_L" width="30%">
							<html:select id="di_ZiDuanM2" initText="" enumSQL="<%=sql %>"   style="width:98%" />
						</td>
						<td class="content_L" width="10%">
							<html:combobox id="di_BiJiaoF" other=" onpropertychange='onBiJiaoFChange(this)'" style="width:98%" />
						</td>
						<td class="content_L" width="50%">
							<html:text id="di_BiJiaoZ1" style="width:98%" />
						</td>
						<td class="content_L" width="10%">
							<html:button id="add_zkh" onclick="addKuoHao('(')" value="增加("/>
						</td>
					</tr>
					<tr>
						<td class="content_L" width="30%">
							<html:button id="zengjiatj1" onclick="addFilter('AND')" value="增加为条件"/>&nbsp;
							<html:button id="zengjiatj2" onclick="addFilter('AND')" value="增加为AND条件"/>
						</td>
						<td class="content_L" width="10%">
							<html:button id="zengjiatj3" onclick="addFilter('OR')" value="增加为OR条件"/>
						</td>
						<td class="content_L" width="50%">
							<html:text id="di_BiJiaoZ2" style="width:98%" disabled="true" />
						</td>
						<td class="content_L" width="10%">
							<html:button id="add_ykh" onclick="addKuoHao(')')" value="增加)"/>
						</td>
					</tr>

					<tr>
						<td colspan="4" class="content_L">
							<html:textarea id="di_GuoLvTJ" rows="15" style="width:99%"/> 
						</td>
					</tr>
				</table>
			</html:tabpage>
		</html:tabcontrol>
		<html:paraSave/>		
	</html:form>
	<script language="javascript">
		function clearSort(){
			var length = ExtFunctionCM.getObject("di_PaiXuTJ").length;
			for(var i=0;i<length;i+=1){
				ExtFunctionCM.getObject("di_PaiXuTJ").options[i].selected=true;
			}
			moveLeft();
		}
		function clearFilter(){
			ExtFunctionCM.getObject("di_GuoLvTJ").value="";
		}
		function init(){
			var guoLvTJ = "<%=CommonUtils.null2Blank(request.getParameter("cs_GuoLvTJ")).replaceAll("\"","\\\\\"")%>";
			var paiXuTJ="<%=CommonUtils.null2Blank(request.getParameter("cs_PaiXuTJ"))%>";
			if(guoLvTJ){
				ExtFunctionCM.getObject("di_GuoLvTJ").value=guoLvTJ;
			}
			if(paiXuTJ){
				var str=paiXuTJ.split(",");
				var obj=ExtFunctionCM.getObject("di_ZiDuanM");
				for(var j=0;j<str.length;j++){
					var value1=str[j].substring(0,str[j].lastIndexOf(" "));
					var paixufs = str[j].substring(str[j].lastIndexOf(" ")+1);
					for(var i=0;i<obj.length;i+=1){
						if(obj.options[i].value==value1){
							obj.options[i].selected=true;
							moveRight(paixufs);
							break;
						}
					}
				}
				
				
			}
		}
		function moveLeft(){
			var sourceSelect=ExtFunctionCM.getObject("di_PaiXuTJ");
			var targetSelect=ExtFunctionCM.getObject("di_ZiDuanM");
			if(sourceSelect!=null &&sourceSelect.length>0&& targetSelect!=null ){
				for(var i=0;i<sourceSelect.length;i++){
					if(sourceSelect.options[i].selected){	
						targetSelect.length++;
						var ziduanm = sourceSelect.options[i].value.substring(0,sourceSelect.options[i].value.lastIndexOf(" "));
						targetSelect.options[targetSelect.length-1].value=ziduanm;
						targetSelect.options[targetSelect.length-1].text=ziduanm;
					}				
				}				
				for(var i=sourceSelect.length-1;i>=0;i--){
					if(sourceSelect.options[i].selected){
						sourceSelect.remove(i);
					}
				}				
			}
		}
		function moveRight(paixufs){
			var sourceSelect=ExtFunctionCM.getObject("di_ZiDuanM");
			var targetSelect=ExtFunctionCM.getObject("di_PaiXuTJ");
			if(sourceSelect!=null &&sourceSelect.length>0&& targetSelect!=null ){
				for(var i=0;i<sourceSelect.length;i++){
					if(sourceSelect.options[i].selected){	
						targetSelect.length++;
						targetSelect.options[targetSelect.length-1].value=sourceSelect.options[i].value+" "+paixufs;
						targetSelect.options[targetSelect.length-1].text=sourceSelect.options[i].text+" "+paixufs;
					}				
				}				
				for(var i=sourceSelect.length-1;i>=0;i--){
					if(sourceSelect.options[i].selected){
						sourceSelect.remove(i);
					}
				}				
			}
		}
		function moveUp(){
			var selectObj=ExtFunctionCM.getObject("di_PaiXuTJ");
			if(selectObj!=null){
				for(var i=1;i<selectObj.length;i++){
					if(selectObj.options[i].selected){							
						if(selectObj.options[i-1].selected){
							continue;
						}
						var value = selectObj.options[i-1].value;
						var text = selectObj.options[i-1].text;
						selectObj.options[i-1].value=selectObj.options[i].value;
						selectObj.options[i-1].text=selectObj.options[i].text;
						selectObj.options[i-1].selected=true;
						selectObj.options[i].value=value;
						selectObj.options[i].text=text;
						selectObj.options[i].selected=false;
					}
				
				}
				
			}
		}
		
		function moveDown(){
			var selectObj=ExtFunctionCM.getObject("di_PaiXuTJ");
			if(selectObj!=null){
				for(var i=selectObj.length-2;i>=0;i--){
					if(selectObj.options[i].selected){				
						if(selectObj.options[i+1].selected){					
							continue;
						}
						var value = selectObj.options[i+1].value;
						var text = selectObj.options[i+1].text;
						selectObj.options[i+1].value=selectObj.options[i].value;
						selectObj.options[i+1].text=selectObj.options[i].text;
						selectObj.options[i+1].selected=true;
						selectObj.options[i].value=value;
						selectObj.options[i].text=text;
						selectObj.options[i].selected=false;
					}
				
				}
				
			}
		}
		
		function onBiJiaoFChange(obj){
			if("BETWEEN"==obj.value.toUpperCase()){			
				ExtFunctionCM.getObject("di_BiJiaoZ2").disabled=false;
			}
			else{
				ExtFunctionCM.getObject("di_BiJiaoZ2").disabled=true;
				ExtFunctionCM.getObject("di_BiJiaoZ2").value="";
			}
		}
		
		function addKuoHao(kuohao){
			if("("==kuohao){
				if(ExtFunctionCM.getObject("di_GuoLvTJ").value!=""){
					ExtFunctionCM.getObject("di_GuoLvTJ").value=ExtFunctionCM.getObject("di_GuoLvTJ").value+"\n"+kuohao;
				}
				else{
					ExtFunctionCM.getObject("di_GuoLvTJ").value="(";
				}
			}
			else{
				ExtFunctionCM.getObject("di_GuoLvTJ").value=" )";
			}
		}
		
		function addFilter(lianjief){
			var tiaojian = "";
			if("BETWEEN"==ExtFunctionCM.getObject("di_BiJiaoF").value.toUpperCase()){	
				if(ExtFunctionCM.getObject("di_BiJiaoZ1").value=""){
					alert("BETWEEN 时起始值不能为空！");
					return;
				}
				else if(ExtFunctionCM.getObject("di_BiJiaoZ2").value=""){
					alert("BETWEEN 时结束值不能为空！");
					return;
				}
				tiaojian =ExtFunctionCM.getObject("di_ZiDuanM2").value+" BETWEEN '"+ExtFunctionCM.getObject("di_BiJiaoZ1").value+"' AND '"+ExtFunctionCM.getObject("di_BiJiaoZ2").value+"'";
			}
			else{
				tiaojian =ExtFunctionCM.getObject("di_ZiDuanM2").value+" "+ExtFunctionCM.getObject("di_BiJiaoF").value+" '"+ExtFunctionCM.getObject("di_BiJiaoZ1").value+"' ";
			}
			if(ExtFunctionCM.getObject("di_GuoLvTJ").value==""){
				ExtFunctionCM.getObject("di_GuoLvTJ").value=tiaojian;
			}
			else{
				ExtFunctionCM.getObject("di_GuoLvTJ").value+='\n'+lianjief+" "+tiaojian;
			}
			
			//alert(ExtFunctionCM.getObject("di_GuoLvTJ").value.replace(/\s/g,' '));
		}
		
		function doQueDing(){
			var paiXuTJ = "";
			var obj =ExtFunctionCM.getObject("di_PaiXuTJ");
			for(var i=0;i<obj.length;i++){
				if(paiXuTJ.length>0){
					paiXuTJ+=",";
				}
				paiXuTJ+=obj.options[i].value;
			}			
			
			var guoLvTJ=ExtFunctionCM.getObject("di_GuoLvTJ").value.replace(/\s/g,' ');
			if(guoLvTJ.length>0){
				if(!testSQL(guoLvTJ)){
					alert("设置的查询条件不正确，请检查！");
					return ;
				}
				
			}
			var returnValues =[['cs_PaiXuTJ',paiXuTJ],['cs_GuoLvTJ',guoLvTJ],['cs_SheZhiTJBZ','1']];
			//setTimeout();
			
			doRefresh=true;			
			ExtFunctionCM.buildReturnValue(returnValues,'<%=request.getParameter("select_target")%>');
			
		}
		function testSQL(guoLvTJ){			
			var sql ="SELECT COUNT(*) shuliang FROM <%=request.getParameter("cs_ShuJuB")%> WHERE 1=1 AND "+guoLvTJ;
			var ajax = new Ajax();
			ajax.setService("com.qam.web.facade.ajax.impl.SqlTest");
			ajax.addParameter("test_sql",sql);
			return "true"==ajax.request();
		}
		
	</script>
</doby>
</html>