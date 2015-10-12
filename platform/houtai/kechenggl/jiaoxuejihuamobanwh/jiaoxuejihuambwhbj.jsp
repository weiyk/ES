<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="javax.wsdl.Import"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="com.qam.framework.context.ContextService" %>
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<%-- 验证 --%>
<%@include file="/common/jquery.validate.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%@include file="/common/ckeditor.jspf"%>
<html:dialog id="GNDH_MoBanBJ" async="true"/>
<%
String uid=(String)request.getSession().getAttribute("XiTongHYBH");//获取UID,系统用户编号
String path=request.getContextPath();
boolean disabled = false;
if("DHZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
	disabled = true;
}
%>
<script type="text/javascript">
$(function(){
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'MoBanNR',
   		{
            toolbar : 
             [
				 //加粗     斜体，     下划线      穿过线      下标字        上标字
                 ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
				 // 数字列表          实体列表            减小缩进    增大缩进
                 ['NumberedList','BulletedList','-','Outdent','Indent'],
				 //左对齐             居中对齐          右对齐          两端对齐
                 ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
				 // 样式       格式      字体    字体大小
                 ['Styles','Format','Font','FontSize'],
				 //文本颜色     背景颜色
                 ['TextColor','BGColor'],
				 //全屏           显示区块
                 ['Maximize', 'ShowBlocks','-']
             ],height:200,width:600
          }
	 );
});
//判断长度
function len(s) {
	 var l = 0;
	 var a = s.split("");
	 for (var i=0;i<a.length;i++) {
	  if (a[i].charCodeAt(0)<299) {
	   l++;
	  } else {
	   l+=2;
	  }
	 }
	 return l;
	}
function save(){
	var MoBanMC=$("#di_MoBanMC").val();
	if(!MoBanMC){
		$(this)._showTip('di_MoBanMC','必填字段');
		return false;
	}
	var count = 0;
	var state = '${param._qam_dialog_state}';
	if(state == "DHZT_XinZeng"){
		count = ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueJHMB"," WHERE  MoBanMC='" + MoBanMC + "'");
	}else if(state == "DHZT_DiaoKan"){
		count = ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueJHMB"," WHERE  MoBanMC='" + MoBanMC + "' AND BIANHAO <> '" + $("#cs_BianHao").val() + "'");
	}
	if (count > 0) {
		$(this)._alert('提示', '模板名称已存在,请重新填写');
		return;
	}else{
		if(len(MoBanMC)>50){
			$(this)._showTip('di_MoBanMC','长度不能大于50字符(一个中文等于2个字符)');
			return false;
		}
		var MoBanNR=jhnrEditor.document.getBody().getText();
		if(!MoBanNR){
			$(this)._alert('提示','模板内容不能为空！');
			return false;
		}
		if(len(MoBanNR)>2000){
			$(this)._alert('提示','长度不能大于2000字符(一个中文等于2个字符)');
			return false;
		}
		$("#di_MoBanNR").val(jhnrEditor.document.getBody().getHtml());
		return true;
	}
}
</script>
<c:set value="<%=disabled %>" var="disabled"></c:set>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<html:hidden id="di_JianLiR"  value="<%=uid%>"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_MoBanMC"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text id="di_MoBanMC" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:99%"/>
				</td>
			</tr>
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_MoBanLX"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<%if(disabled){%>
						<html:radiobox id="di_MoBanLX" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
					<%}else{%>
						<html:radiobox value="1"  id="di_MoBanLX" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
					<%}%>
				</td>
			</tr>
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_MoBanNR"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:hidden id="di_MoBanNR" />
					<textarea  id="MoBanNR" name="MoBanNR"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
						<html:command id="MLKZ_BaoCun" />
						<html:command id="MLKZ_XiuGai" />
						<html:command id="MLKZ_GuanBi" />
				</td>
			</tr>
		</table>		
	</div>
<html:paraSave/>
</html:form>
<script type="text/javascript">
	$(function(){
		jhnrEditor.setData($("#di_MoBanNR").val());
	});
</script>
</body>
</html>