<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学习目标</title>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<meta name="Keywords" content="">
<meta name="Description" content="">
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
<script type="text/javascript">
	function message_show_success(message){
			alert(message);
		}
	</script>
</head>
<body>
<html:dialog id="GNDH_XueXiMB" state="DHZT_ChaXun"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
		// 课程信息查询
		RecordSet kcRS = executeResult.getRecordSet("SWDY_ChaXunKCXX");
		kcRS.next();
		
		// 查询学习目标
		RecordSet xxmbRS = executeResult.getRecordSet("SWDY_ChaXunXXMB");
		xxmbRS.next();
	%>
    <div class="wrap clearfix">
    	<html:form>
    	<!-- 学习目标编号 -->
    	<input type="hidden" name="di_KeShiBH" value="<%=xxmbRS.getString("di_BianHao") %>"/>
        <div class="fl mt-10 w-710">
            <div class="td-zt">
                您所在的位置：<%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %>/<%=kcRS.getString("di_KeShiMC") %>
            </div>
            <!-- 知识与能力目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                	<a id="edit" href="#">
						<span style="float: right;margin-right: 37px;cursor: pointer; color: #2db5f3;">编辑</span>
					</a>
                    <h2>知识与能力目标</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_ZhiShiYNLMB">
            		<%=xxmbRS.getString("di_ZhiShiYNLMB") %>
            	</div>
            	<textarea style="display:none" rows="3" cols="100" name="di_ZhiShiYNLMB" id="di_ZhiShiYNLMB"><%=xxmbRS.getString("di_ZhiShiYNLMB") %></textarea>
            </div>
            
            <!-- 过程与方法目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>过程与方法目标</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_GuoChengYFFMB">
            		<%=xxmbRS.getString("di_GuoChengYFFMB") %>
            	</div>
            	<textarea style="display:none" rows="3" cols="100" name="di_GuoChengYFFMB" id="di_GuoChengYFFMB"><%=xxmbRS.getString("di_GuoChengYFFMB") %></textarea>
            </div>

            <!-- 情感与态度价值观目标 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>情感与态度价值观目标</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_QingGanTDJZ">
            		<%=xxmbRS.getString("di_QingGanTDJZ") %>
            	</div>
            	<textarea style="display:none" rows="3" cols="100" name="di_QingGanTDJZ" id="di_QingGanTDJZ"><%=xxmbRS.getString("di_QingGanTDJZ") %></textarea>
            </div>
            
            <!-- 保存按钮 -->
            <div class="xxzy-bc mt-20">
            	<input style="display: none;" id="btnSave" type="button" value="保存" class="wlkc-150" onclick="save()"/>
            </div>
        </div>
        </html:form>
        
        <div class="fr w-230">
        <div class="mt-10 xxzy-bk">
        	<a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=kcRS.getString("di_KC_BianHao") %>" class="xxzy-bk-a">返回到备课界面》</a>
        </div>
            <!-- 课程内容 -->
            <div class="cour-mykc mykc mt-20">
                <div class="title">
                    <h2>
                        课程内容</h2>
                </div>
            </div>
            <div class="cour-kc mykc mt-10">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>">课前导学</a>
                </div>
            </div>
            <div class="cour-mykc mt-1 mykc">
                <div class="title">
                    	学习目标
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">相关学习资源</a>
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">学习活动设计</a>
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>">教学视频</a>
                </div>
            </div>
        </div>
    </div>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$(function() {
	
	$("#edit").click(function() {
		// 隐藏编辑按钮
		$(this).hide();
		
		// 知识与能力目标，隐藏lbl，显示输入框
		$("#lbl_ZhiShiYNLMB").addClass("hidden");
		$("#lbl_ZhiShiYNLMB").parent().removeClass("xxzy-zd");
		$("#di_ZhiShiYNLMB").css("display", "");
		
		// 过程与方法目标，隐藏lbl，显示输入框
		$("#lbl_GuoChengYFFMB").addClass("hidden");
		$("#lbl_GuoChengYFFMB").parent().removeClass("xxzy-zd");
		$("#di_GuoChengYFFMB").css("display", "");
		
		// 情感与态度价值观目标，隐藏lbl,显示输入框		
		$("#lbl_QingGanTDJZ").addClass("hidden");
		$("#lbl_QingGanTDJZ").parent().removeClass("xxzy-zd");
		$("#di_QingGanTDJZ").css("display", "");
		
		// 显示保存按钮
		$("#btnSave").css("display", "");
	});
});

// 保存学习目标
function save() {
	// 知识与能力目标
	var di_ZhiShiYNLMB = $("#di_ZhiShiYNLMB").val();
	if (isEmpty(di_ZhiShiYNLMB)) {
		alert("知识与能力目标不能为空！");
		return false;
	}
	if (beyondTheLength(di_ZhiShiYNLMB, 500)) {
		alert("知识与能力目标不能超过500字符！");
		return false;
	}
	
	// 过程与方法目标不能为空
	var di_GuoChengYFFMB = $("#di_GuoChengYFFMB").val();
	if (isEmpty(di_GuoChengYFFMB)) {
		alert("过程与方法目标不能为空！");
		return false;
	}
	if (beyondTheLength(di_GuoChengYFFMB, 500)) {
		alert("过程与方法目标不能超过500字符！");
		return false;
	}
	
	// 情感与态度价值观目标
	var di_QingGanTDJZ = $("#di_QingGanTDJZ").val();
	if (isEmpty(di_QingGanTDJZ)) {
		alert("情感与态度价值观目标不能为空！");
		return false;
	}
	if (beyondTheLength(di_QingGanTDJZ, 500)) {
		alert("情感与态度价值观目标不能超过500字符！");
		return false;
	}
	
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGai&_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>');
}
</script>
</body>
</html>