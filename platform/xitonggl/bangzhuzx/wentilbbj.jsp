<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%@page import="com.rc.web.utils.SystemConfig"%>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<%-- validate --%>
<%@include file="/common/jquery.validate.jspf" %>
<%@include file="/common/ckeditor.jspf"%>
<head>
<script type="text/javascript">
function message_show_success(message){
	$("#loadWindow").dialog({
		autoOpen: false,
		resizable:false,
		titlebar:false,
		position:["center","center"]
	});
	message = message || "\u64cd\u4f5c\u4e2d\u5904\u7406\u4e2d......";
	var ua = window.navigator.userAgent;
	$("#loadWindow").dialog("option",{
		title:"",
		closeOnEscape:false,
		width:"200px",
		height:40,
		open: function(event, ui) {
			event.target.innerHTML = message;
		},
		modal:true
	});
	$("#loadWindow").dialog("open");
	var message_timeout_t=1000;
	function change_message_timeout(){				
		message_timeout_t-=1000;
		if(message_timeout_t<=0){
			if(timer){
				window.clearInterval(timer);
			}
		}
	}
	var timer=window.setInterval(change_message_timeout,1000);	
	setTimeout(message_hide,message_timeout_t+1000);
}
//隐藏
function message_hide(){
	$("#loadWindow").dialog("close");
	try{
		afterMessageBoxHide();
	}
	catch(e){
		
	}
}
</script>
<html:dialog id="GNDH_WenTiLBBJ"/>
<script type="text/javascript">
	var old_bt;
	$(function(){
	old_bt= $("#di_BiaoTi").val(); 
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'NeiRong',
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
             ],height:150,width:570
          }
	 );
});
//保存验证
function save(){
	if(doValidate()){
		var bt= $("#di_BiaoTi").val(); 
		if(old_bt!=bt){
			if(ExtFunctionCM.CheckRecordCount("jcsj_wentiliebiao "," WHERE biaoti = '"+bt+"'") > 0){
			    $(this)._alert('提示','当前标题的问题已存在,请重新填写标题内容！');
			    return false;
			}
		}
		$("#di_NeiRong").val(jhnrEditor.document.getBody().getHtml());
		return true;
	}
}

</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<html:form>
	<div class="ui-layout-center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="ui-jqdialog-content ui-widget-content">
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_BiaoTi"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:text  id="di_BiaoTi" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td nowrap width="3%" class="CaptionTD" align="right">
					<html:title id="di_NeiRong"/>
				</td>
				<td  width="15%" class="DataTD" align="left">
					<html:hidden id="di_NeiRong" />
					<html:textarea id="NeiRong"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:70%"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" >
						<html:command id="MLKZ_XinZengBC" />
						<html:command id="MLKZ_XiuGaiBC" />
						<html:command id="MLKZ_GuanBi" />
				</td>
			</tr>
		</table>		
	</div>
		<html:paraSave/>
	</html:form>
	<script type="text/javascript">
$(function(){
	jhnrEditor.setData($("#di_NeiRong").val());
});
 </script>
</body>
</html>