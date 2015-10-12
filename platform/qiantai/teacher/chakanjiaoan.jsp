<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
%>
<html>
<head>
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>查看教案</title>
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style %>/js/base.js"></script>
</head>
<body>
<html:dialog id="GNDH_ChaKanJA" state="DHZT_ChaXun"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a> 
 <%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB" class="cur">教学准备</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>
<%
	// 课程信息
	RecordSet kcRS = executeResult.getRecordSet("SWDY_ChaXunKCXX");
	kcRS.next();
%>
<div class="wrap clearfix">
	<div class="zy-box">
	<div class="clearfix title_bar">
	<div class="left_title fl">
		<span class="big_t"><%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %></span>
		<span class="small_t"><%=kcRS.getString("di_KeShiMC") %></span>
	</div>
	<div class="left_title" style="float: right; display: inline;">
		<a class="small_t" style="margin-top: 17px;" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=<%=kcRS.getString("di_KeChengBH") %>">
			&lt;&lt; 返回
		</a>
	</div>
	</div>
<hr/>
	<%
		// 教案信息
		RecordSet jaRS = executeResult.getRecordSet("SWDY_ChaXunJAXX");
		if (jaRS.next()) {
			// 教学目标分析
			request.setAttribute("di_JiaoXueMBFX", jaRS.getString("di_JiaoXueMBFX"));
			// 教学内容分析
			request.setAttribute("di_JiaoXueNRFX", jaRS.getString("di_JiaoXueNRFX"));
			// 学习者特征分析
			request.setAttribute("di_XueXiZTZFX", jaRS.getString("di_XueXiZTZFX"));
			// 学习策略和方法选择
			request.setAttribute("di_XueXiCLHFF", jaRS.getString("di_XueXiCLHFF"));
			// 教学媒体的选择和应用 
			request.setAttribute("di_JiaoXueMT", jaRS.getString("di_JiaoXueMT"));
			// 教学过程设计
			request.setAttribute("di_JiaoXueGC", jaRS.getString("di_JiaoXueGC"));
		}
	%>
	<html:form>
		<!-- 教案编号 -->
		<input type="hidden" name="di_BianHao" id="di_BianHao" <%if(jaRS.getString("di_BianHao") != null) { out.print("value='" + jaRS.getString("di_BianHao") + "'"); }%>/>
		<!-- 课时编号 -->
		<input type="hidden" name="di_KeShiBH" id="di_KeShiBH" value="<%=kcRS.getString("di_KeShiBH") %>"/>
		<div class="learn_tar">
		<div class="learn_title">
			<p>教学目标分析</p>
		</div>
		<textarea rows="5" cols="150" name="di_JiaoXueMBFX" id="di_JiaoXueMBFX">${di_JiaoXueMBFX }</textarea>
		</div>
	
		<div class="learn_tar">
		<div class="learn_title">
			<p>教学内容分析</p>
		</div>
		<textarea rows="5" cols="150" name="di_JiaoXueNRFX" id="di_JiaoXueNRFX">${di_JiaoXueNRFX }</textarea>
		</div>
	
		<div class="learn_tar">
		<div class="learn_title">
			<p>学习者特征分析</p>
		</div>
		<textarea rows="5" cols="150" name="di_XueXiZTZFX" id="di_XueXiZTZFX">${di_XueXiZTZFX }</textarea>
		</div>
	
		<div class="learn_tar">
		<div class="learn_title">
			<p>学习策略和方法选择</p>
		</div>
		<textarea rows="5" cols="150" name="di_XueXiCLHFF" id="di_XueXiCLHFF">${di_XueXiCLHFF }</textarea>
		</div>
	
		<div class="learn_tar">
		<div class="learn_title">
			<p>教学媒体的选择与应用</p>
		</div>
		<textarea rows="5" cols="150" name="di_JiaoXueMT" id="di_JiaoXueMT">${di_JiaoXueMT }</textarea>
		</div>
	
		<div class="learn_tar">
		<div class="learn_title">
			<p>教学过程设计</p>
		</div>
		<textarea rows="5" cols="150" name="di_JiaoXueGC" id="di_JiaoXueGC">${di_JiaoXueGC }</textarea>
		</div>
		
	</html:form>
		 <!-- 保存按钮 -->
         <div class="xxzy-bc mt-20">
         	<input type="button" value="保存" class="wlkc-150" onclick="save()"/>
         </div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
function save() {
	// 教学目标分析
	var di_JiaoXueMBFX = $("#di_JiaoXueMBFX").val();
	if (isEmpty(di_JiaoXueMBFX)) {
		alert("教学目标分析不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueMBFX, 500)) {
		alert("教学目标分析不能超过500字符！");
		return false;
	}
	
	// 教学内容分析
	var di_JiaoXueNRFX = $("#di_JiaoXueNRFX").val();
	if (isEmpty(di_JiaoXueNRFX)) {
		alert("教学内容分析不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueNRFX, 500)) {
		alert("教学内容分析不能超过500字符！");
		return false;
	}
	
	// 学习者特征分析
	var di_XueXiZTZFX = $("#di_XueXiZTZFX").val();
	if (isEmpty(di_XueXiZTZFX)) {
		alert("学习者特征分析不能为空！");
		return false;
	}
	if (beyondTheLength(di_XueXiZTZFX, 500)) {
		alert("学习者特征分析不能超过500字符！");
		return false;
	}
	
	// 学习策略
	var di_XueXiCLHFF = $("#di_XueXiCLHFF").val();
	if (isEmpty(di_XueXiCLHFF)) {
		alert("学习策略和方法选择不能为空！");
		return false;
	}
	if (beyondTheLength(di_XueXiCLHFF, 500)) {
		alert("学习策略和方法选择不能超过500字符！");
		return false;
	}
	
	// 教学媒体的选择与应用
	var di_JiaoXueMT = $("#di_JiaoXueMT").val();
	if (isEmpty(di_JiaoXueMT)) {
		alert("教学媒体的选择与应用不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueMT, 500)) {
		alert("教学媒体的选择与应用不能超过500字符！")
		return false;
	}
	
	// 教学过程设计
	var di_JiaoXueGC = $("#di_JiaoXueGC").val();
	if (isEmpty(di_JiaoXueGC)) {
		alert("教学过程设计不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueGC, 1000)) {
		alert("教学过程设计不能超过1000字符！");
		return false;
	}
	
	// 教案编号
	var di_BianHao = $("#di_BianHao").val();
	if (di_BianHao.length == 0) {
		// 添加
		$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_TianJia&_qam_dialog=GNDH_ChaKanJA&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH")%>');
	} else {
		// 更新
		$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGai&_qam_dialog=GNDH_ChaKanJA&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH")%>');
	}
}
</script>
</body>
</html>