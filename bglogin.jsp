<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.qam.framework.beans.License"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.web.utils.SystemConfig"%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.qam.framework.util.CommonUtils" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%@ taglib uri="qamer-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String _contextPath = request.getContextPath();
%>
<link rel="icon" href="<%=_contextPath%>/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="<%=_contextPath%>/favicon.ico" type="image/x-icon" />
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	//服务端禁用浏览器缓存
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma","no-cache"); 
	session.invalidate();
	String _qam_img_path = request.getContextPath() +"/common/skins/default";	
	String path = request.getContextPath();
	String jqueryHome = request.getContextPath()+"/common/jquery";
	String jqueryScriptHome=jqueryHome+"/script";
	String jqueryCssHome = jqueryHome+"/themes/default";
	String jqueryCssIconHome=jqueryHome+"/themes";
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	License license = ContextService.lookupLicenseService().getLicense();
	String msg = "";
   	if(!ContextService.lookupLicenseService().validateAuthorize(license)){
   		msg = "授权文件无效!";
   	}else if(!ContextService.lookupLicenseService().validateExpiration(request)){
   		msg = "授权已经过期!";
   	}else{
   		cal.setTime(sdf.parse(sdf.format(cal.getTime())));
   		cal.add(Calendar.DAY_OF_YEAR,7);
   		Calendar c = Calendar.getInstance();
   		if(!license.getExpiration().equals("never")){
	   		c.setTime(sdf.parse(license.getExpiration()));   
	   		if(cal.compareTo(c) == 0){
	   			msg = "授权即将于"+c.get(Calendar.YEAR)+"年"+(c.get(Calendar.MONTH)+1)+"月"+c.get(Calendar.DAY_OF_MONTH)+"日到期";
	   		}
   		}
   	}
%>
<head>
<%@ include file="/main.jspf" %>
<script language="javascript" src="<%=path%>/common/script/project.js"></script>

<title><%=SystemConfig.getTitle() %></title>
 <META http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<META HTTP-EQUIV="Cache-Control" CONTENT="max-age=0" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache" />
<meta http-equiv="expires" content="-11" />
<META HTTP-EQUIV="Expires" CONTENT="Tue, 01 Jan 1980 1:00:00 GMT" />
<META HTTP-EQUIV="Pragma" CONTENT="no-cache" /> 
<c:set var="year" value="<%=year %>"></c:set>
<style type="text/css">
	body{font: 12px/1.5 Microsoft YaHei, Arial, sans-serif; background: #FFF; margin: 0 ;padding: 0; color: #404b53;width: 100%;height: 100%;vertical-align: middle;}
</style>
<script type="text/javascript">
	$(function(){
		$("#pz").bind('click',function(){
			if($(this).attr('checked')){
				$("#adminWin").val(2);
				$("#tr_dw").hide();
			}else{
				$("#adminWin").val(1);
				$("#tr_dw").show();
			}
		});
		$("#about").bind("click",function(){
			about();
		});
	});
	function about(){
		$("<div></div>").dialog({ 
			title:"产品信息", 
			modal:true, 
			height:320,
			width:500,
			resizable:false, 
			closeOnEscape :false,//esc \u4e0d\u5173\u95ed
			modal:true,
			open: function(event, ui) {
				event.target.innerHTML = '<iframe src="<%=path%>/mainframe/about.jsp" width="100%" height="100%" scrolling="auto" border="0" frameborder="0"></iframe>';
			},
			close:function(event,ui){
				event.target.innerHTML = '';
			},
			
		}); 
	}
	function winResize(){ 
		try{
			window.moveTo(0,0);
			var screenHeight=screen.availHeight;
			var screenWidth=screen.availWidth;
			window.resizeTo(screenWidth,screenHeight);	
		}catch(e){
		}				
	} 
	function submited(){	
		var ua = window.navigator.userAgent;
		if(!$("#loginName").val()){
			$(this)._alert('提示','请输入用户名!');
			return;
		}
		if(!$("#loginPwd").val()){
			$(this)._alert('提示','请输入密码!');
			return;
		}
		//验证码是否为无
		if(!$("#yanZhenM").val()){
			$(this)._alert('提示','请输入验证码!');
			return;
		}
		if($("#yanZhenM").val().length < 4){
			$(this)._alert('提示','请输入4位验证码!');
			return;
		}
		if(!$.browser.msie && !$.browser.mozilla && !$.browser.safari){
			$(this)._alert('提示','请用IE、mozilla、safari浏览器登陆本系统!');
			return;
		}
		if($.browser.msie && $.browser.version < 8.0){
			$(this)._alert('提示','请选8.0版本以上的IE登陆本系统!');
			//return;
		}
		if($.browser.mozilla && $.browser.version < 12.0){
			if(!/rv\:(\d+)/.test(ua)){
				$(this)._alert('提示','请选12.0版本以上的mozilla登陆本系统!');
				return;
			}
		}
		var userName = document.getElementById("loginName").value;
		setCookie("loginName",userName);
		//if('admin' == userName){<%--如果是管理员--%>
			//$("#checkWin").dialog('open');
			//return;
		//}
		<%if(!ContextService.lookupLicenseService().validateExpiration(request)){%>
		$(this)._alert('提示','<%=ContextService.lookupLicenseService().getErrorMsg()%>');
		<%}else{%>
		document.form1.submit();
		<%}%>
	}	
	function windowsInit(){
		//try{winResize();}catch(e){}
		document.getElementById("loginName").focus();
		var username=getCookie("loginName");
		document.getElementById('loginName').value = username;
		if(username ==""){
			document.getElementById('loginName').value="";
			document.getElementById('loginName').focus();
		}else{
			document.getElementById('loginName').value=username;
			document.getElementById('loginPwd').focus();
		}
	}
	<%--按回车登陆--%>
	$(document).keydown(function(event) {
		if (event.keyCode == 13) {
		 	if($('.ui-dialog-buttonset').attr('class') && $('.ui-dialog-buttonset').attr('class').length > 0)
		 		return;
			submited();
		}
	}); 
	<%--切换验证码--%>
	function changeImg(){
		document.form1.yzm.src = "<%=request.getContextPath() %>/common/page/image.jsp?"+ Math.random();
	}
</script>
</head>
<body onload="windowsInit()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- 
<div id="checkWin">
	<table align="center" width="100%" style="height: 100%;">
		<tr>
			<td align="center"><button id="ywxt">业务系统</button> </td>
			<td align="center"><button id="pzxt">配置系统</button></td>
		</tr>
	</table>
</div>
-->

<form name="form1" method="post" action="<%=request.getContextPath() %>/servlet/desktop_bg.html">
 <html:hidden id="adminWin" value="1"/>
 <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" style="height:100%;padding-top: 10px">
  <tr>
    <td>
      <table width="778" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="62%"><img src="<%=_qam_img_path %>/rc/logo.png" width="300" height="90px" alt="logo"/></td>
          <td width="38%"><div class="top_text"><a id="about" href="#">关于产品</a><span class="gray"> |  </span><a href="mailto:support@ifory.cn">联系我们</a>
          	<br/><font color="red"><%=msg %></font>
          </div>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td class=""><table width="1080" border="0"  align="center" style="background: url(<%=_qam_img_path %>/rc/login_mid_name.jpg); " cellpadding="0" cellspacing="0">
      <tr>
        <td width="725" height="452"></td>
        <td>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="330" height="36"></td>
          </tr>
          <tr>
            <td class="login-wbg" >
            <table width="94%" border="0" align="center" cellpadding="7" cellspacing="0" class="login01">
              <tr>
                <td width="27%" align="right" class="f-s-16" gray01>用户名</td>
                <td width="73%" class="f_input"><input type="text" name="loginName" maxlength="20" id="loginName" size="24" /></td>
              </tr>
              <tr>
                <td align="right" class="f-s-16" gray01>密&nbsp;&nbsp;码</td>
                <td class="f_input"><input type="password" id="loginPwd"  maxlength="20" name="loginPwd" class="f_input" size="24" /></td>
              </tr>
              <tr>
                <td align="right" class="f-s-16" gray01>验证码</td>
                <td class="f_input01"><input type="text" id="yanZhenM" name="yanZhenM" class="FormElement ui-widget-content ui-corner-all" maxlength="4"  style="width:50%"/>
				<a href="#" onclick="javascript:changeImg()"><span class="img-mt10"><img id="yzm" src="<%=request.getContextPath() %>/common/page/image.jsp" width="40%" height="25"/></span></a>
				</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><span  class="f_btn"><input name="按钮" onclick="submited()" type="button" value="登 录 " /></span>
                 <span  class="f_btn"><input name="按钮" onclick="reset()" type="button" value="重置 " /></span>
                 </td>
              </tr>
              </table>
              </td>
          </tr>
          <tr>
            <td width="330" height="36"></td>
          </tr>
        </table>
        </td>
        <td width="23" height="452"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="778" border="0" align="center" cellpadding="0" cellspacing="0" class="footer">
      <tr>
        <td>CopyRight © <%=SystemConfig.getRange() %>  <%=SystemConfig.getCorprationName() %>  版权所有  All rights reserved.<br />
          请使用浏览器IE8.0（正式）及以上版本或Firefox 12.0及以上版本<br /></td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
	<script language="javascript">
	<%if(request.getParameter("errInfo")!=null && request.getParameter("errInfo").length()>0 && !request.getParameter("errInfo").equals("null")){%>
	$(this)._alert('提示','<%=request.getParameter("errInfo")%>',null,null,function(){
		if(<%="验证码输入错误！".equals(request.getParameter("errInfo"))%>){
			document.form1.yzm.src = "<%=request.getContextPath() %>/common/page/image.jsp?"+ Math.random();
		}
	});
	<%}%>
	</script>
</body>
</html>