<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
%>
<html>
<head>
    <title>重置密码</title>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function(){
    	if(!placeholderSupport()){   // 判断浏览器是否支持 placeholder
    	    $('[placeholder]').focus(function() {
    	        var input = $(this);
    	        if (input.val() == input.attr('placeholder')) {
    	            input.val('');
    	            input.removeClass('placeholder');
    	        }
    	    }).blur(function() {
    	        var input = $(this);
    	        if (input.val() == '' || input.val() == input.attr('placeholder')) {
    	            input.addClass('placeholder');
    	            input.val(input.attr('placeholder'));
    	        }
    	    }).blur();
    	};
    	})
    	function placeholderSupport() {
    	    return 'placeholder' in document.createElement('input');
    	}
    
    	function sMobile(){
    		var userName=$("#userName").val();//获取用户名
    		if(userName=='' || userName =='请输入用户名'){
    			alert("用户名不能为空");
	    		return false;
    		}
    		var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&—|{}【】‘；：”“'。，、？]"); 
    		if(pattern.test(userName)==true){
    			alert("用户名不允许包含特殊字符");
    			$("#userName").val("");
    			return false;
    		}
    		
    	    var phone = $("#phone").val(); //获取手机号
	    	if(phone=='' || phone == '请输入接收密码手机号'){
	    		alert("手机号码不能为空");
	    		return false;
	    	}
	   		if(!(/^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57]|17[0678])[0-9]{8}$/.test(phone))){ 
	   		   alert("手机号码格式不正确"); 
	   		   return false;
	   		}
	   		var reset = $("#reset").val(); //获取重置原因
	   		if(reset=='' || reset == '请输入重置原因........'){
	   			alert("重置原因不能为空");
	    		return false;
	   		}
	   		$.ajax({
				url:path+'/servlet/AjaxServlet',
				type:"post",
				traditional:true,
				async:false,
				data:{service:"com.rc.web.extension.ajax.ResetPassword",
				parameter:["phone","reset","userName"],
				value:[phone,reset,userName]},
				success:function(str){},
				complete:function(XHR, TS){
						result = XHR.responseText;
						//var data =(new Function("",result))();//解析字符串
						alert(result);
						if('_qam_ajax_error'==result){
							$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
							throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
						}
						XHR = null;
					} 
			});
    	}
    </script>
</head>
<body style="background:#FAFAD2">
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/desktop.html">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT">学习联合体</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT" >优秀课堂</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
		</ul>
	</div>
</div>
<html:form onsubmit="return sMobile()">
		<div class="wrap clearfix">
			<div>
				<table border="0">
					<tr>
						<td colspan="2" align="left" height="40px"><h2><b>重置密码</b></h2></td>
					</tr>
					<tr>
						<td align="left" width="60px" height="40px">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</td>
						<td align="left" height="40px"><input type="text" name="userName" id="userName" placeholder="请输入用户名" style="width:200px;height: 20px;"/></td>
					</tr>
					<tr>
						<td align="left" width="60px" height="40px">手机号码：</td>
						<td align="left" height="40px"><input type="text" name="phone" id="phone" placeholder="请输入接收密码手机号" style="width:200px;height: 20px;"/></td>
					</tr>
					<tr>
						<td align="left" width="60px" height="40px" valign="top">重置原因：</td>
						<td align="left" height="40px"><textarea id="reset" placeholder="请输入重置原因........"  name="reset" rows="0" cols="5" style="width: 500px; height: 186px; resize: none;"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="right" style="padding-right: 380px" height="44px">
							<button type="submit" id="chongzhi" name="chongzhi" style="width:70px;">重置</button>&nbsp;&nbsp;&nbsp;
							<button type="button" id="fanhui" onclick="window.location.href='<%=path%>/desktop.html'" name="fanhui" style="width:70px;">返回</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
</html:form>
<jsp:include page="/bottomPage.jsp" />
</body>
</html>
