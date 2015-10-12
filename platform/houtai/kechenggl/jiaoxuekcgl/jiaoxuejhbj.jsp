<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.rc.web.utils.SystemConfig"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>

<%@include file="/common/jquery.validate.jspf" %>
<html:dialog id="GNDH_JiaoXueJHBJ_HT" />
<%@include file="/common/ckeditor.jspf"%>
<title><%=executeResult.getDialog().getName()%></title>
<%
	String foldPath = SystemConfig.getUploadPath();
	boolean disabled = false;
	String dw =(String)session.getAttribute("DanWeiBH");
	if("DHJRZT_DiaoKan".equalsIgnoreCase(request.getParameter("_qam_dialog_state"))){
		disabled = true;
	}
%>
<c:set value="<%=disabled %>" var="disabled"></c:set>
<script type="text/javascript">
$(function(){
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'JiHuaNR',
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
             ],height:150,width:560
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

//保存
function save(){
	if(doValidate()){
		var JiHuaNR=jhnrEditor.document.getBody().getText();
		if(!JiHuaNR){
			$(this)._alert('提示','计划内容不能为空！');
			return false;
		}
		if(len(JiHuaNR)>2000){
			$(this)._alert('提示','长度不能大于2000字符(一个中文等于2个字符)');
			return false;
		}
		$("#di_JiHuaNR").val(jhnrEditor.document.getBody().getHtml());
		return true;
	}
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<html:form>
  <div class="ui-layout-center ui-jqdialog-content" >
         <span>
		<table class="dengjibox" width="100%" border="0" height="70%" cellspacing="0" cellpadding="0">
      		<tbody>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_JiHuaBT"/></td>
	          <td class="DataTD">
	          	<html:text id="di_JiHuaBT" modeStyle="FormElement ui-widget-content ui-corner-all" style="width:98%"/>
	          </td>
	        </tr>
	        <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_JiHuaLX" /></td>
	          <td class="DataTD">
	          	<html:radiobox id="di_JiHuaLX"  modeStyle="FormElement ui-widget-content ui-corner-all" style="width:5%"/>
	          </td>
	        </tr>
	         <tr>
	          <td  width="14%" class="CaptionTD" align="right"><html:title id="di_JiHuaNR" /></td>
	          <td class="DataTD">
	           	  <html:hidden id="di_JiHuaNR" />
		          <textarea  id="JiHuaNR" name="JiHuaNR"></textarea>
	          </td>
	        </tr>
     	 </tbody>
     </table>
    </span>
   </div>  
		<html:paraSave/>
		<html:hidden id="di_BianHao" />
		<html:hidden id="di_KeChengBH" />
		<html:splitline modeStyle="ui-widget-content" width="100%"/>
		<html:splitline/>
		<html:splitline/>
		<html:splitline/>
		<table width="100%" border="0"  cellspacing="0" cellpadding="0" align="center" class="dj_bg">
			<tr>
				 <td align="right">
						<div class="title_right">
							<html:command id="MKLZ_BaoCun"/>
							<html:command id="MLKZ_FanHui"/>						
						</div>
				</td>
			</tr>
		</table>
  </html:form>
<script type="text/javascript">
 	$(function(){
		jhnrEditor.setData($("#di_JiHuaNR").val());
	});
 </script>
</body>
</html>
