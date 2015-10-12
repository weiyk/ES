<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课前导学</title>
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<%@include file="/common/ckeditor.jspf"%>
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
<html:dialog id="GNDH_KeQianDX" state="DHZT_ChaXun"/>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
		RecordSet kcRS = executeResult.getRecordSet("SWDY_KeChengCX");
		kcRS.next();
		
		// 课前导学查询
		RecordSet kqdxRS = executeResult.getRecordSet("SWDY_KeQianDXCX");
		kqdxRS.next();
	%>
    <div class="wrap clearfix">
		<html:form>
		<!-- 课前导学编号编号 -->
		<input type="hidden" name="di_BianHao" value="<%=kqdxRS.getString("di_BianHao") %>"/>
        <div class="fl mt-10 w-710">
            <div class="td-zt">
                您所在的位置：<%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %>/<%=kcRS.getString("di_KeShiMC") %>
            </div>
            <!-- 资源使用指导 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                	<a id="edit" href="#">
						<span style="float: right;margin-right: 37px;cursor: pointer; color: #2db5f3;">编辑</span>
					</a>
                    <h2>
                    	课前寄语
                    </h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_KeQianJY">
		            <%=kqdxRS.getString("di_KeQianJY") %>
            	</div>
	            <textarea class="hidden" id="di_KeQianJY" name="di_KeQianJY" rows="3" cols="100"><%=kqdxRS.getString("di_KeQianJY") %></textarea>
            </div>

            <!-- 知识回顾 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>
                        知识回顾</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
           		<div id="lbl_ZhiShiHG">
            		<%=kqdxRS.getString("di_ZhiShiHG") %>
           		</div>
            	<div id="di_ZhiShiHG_Div" class="hidden">
	           		<textarea id="di_ZhiShiHG" name="di_ZhiShiHG" rows="3" cols="100"><%=kqdxRS.getString("di_ZhiShiHG") %></textarea>
            	</div>
            </div>

            <!-- 教学重点 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>
                        教学重点</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_JiaoXueZD">
           			<%=kqdxRS.getString("di_JiaoXueZD") %>
            	</div>
            	<textarea class="hidden" id="di_JiaoXueZD" name="di_JiaoXueZD" rows="3" cols="100"><%=kqdxRS.getString("di_JiaoXueZD") %></textarea>
            </div>

            <!-- 教学难点 -->
            <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2>
                        教学难点</h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd">
            	<div id="lbl_JiaoXueND">
            		<%=kqdxRS.getString("di_JiaoXueND") %>
            	</div>
            	<textarea class="hidden" id="di_JiaoXueND" name="di_JiaoXueND" rows="3" cols="100"><%=kqdxRS.getString("di_JiaoXueND") %></textarea>
            </div>
            
            <!-- 保存按钮 -->
            <div class="xxzy-bc mt-50">
            	<!-- 进入页面时隐藏保存按钮，如果点击修改后显示保存按钮 -->
                <input style="display: none;" id="btnSave" type="button" value="保存" class="wlkc-150" onclick="save()"/>
            </div>
        </div>
	</html:form>

        <div class="fr w-230">
        <div class="mt-10 xxzy-bk">
            <a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=kcRS.getString("di_BianHao") %>" class="xxzy-bk-a">返回到备课界面》</a>
        </div>
            <!-- 课程内容 -->
            <div class="cour-kc mykc mt-20">
                <div class="title">
                    <h2>
                        课程内容</h2>
                </div>
            </div>
            <div class="cour-mykc mykc mt-10">
                <div class="title">
                    	课前导学
                </div>
            </div>
            <div class="cour-kc mt-1 mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>">学习目标</a>
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
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">教学视频</a>
                </div>
            </div>
        </div>
    </div>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$(function(){
	zshgEditor = CKEDITOR.replace( 'di_ZhiShiHG',
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
             ],height:80,width:636
          }
	 );

	// 点击编辑按钮时，数据项变为可编辑状态
	$("#edit").click(function() {
		$(this).hide();
		
		// 课前寄语， 隐藏lbl，显示输入框
		$("#lbl_KeQianJY").addClass("hidden");
		$("#di_KeQianJY").removeClass("hidden");
		$("#di_KeQianJY").parent().removeClass("xxzy-zd");
		
		// 知识回顾，隐藏lbl，显示输入框
		$("#lbl_ZhiShiHG").addClass("hidden");
		$("#di_ZhiShiHG_Div").removeClass("hidden");
		$("#di_ZhiShiHG_Div").parent().removeClass("xxzy-zd");

		// 教学重点，隐藏lbl，显示输入框
		$("#lbl_JiaoXueZD").addClass("hidden");
		$("#di_JiaoXueZD").removeClass("hidden");
		$("#di_JiaoXueZD").parent().removeClass("xxzy-zd");
		
		// 教学难点，隐藏lbl，显示输入框
		$("#lbl_JiaoXueND").addClass("hidden");
		$("#di_JiaoXueND").removeClass("hidden");
		$("#di_JiaoXueND").parent().removeClass("xxzy-zd");
		
		// 显示保存按钮
		$("#btnSave").css("display", "");
	});
});
// 保存课前导学
function save() {
	// 课前寄语
	var di_KeQianJY = $("#di_KeQianJY").val();
	if (isEmpty(di_KeQianJY)) {
		alert("课前寄语不能为空！");
		return false;
	}
	if (beyondTheLength(di_KeQianJY, 500)) {
		alert("课前寄语不能超过500字符！");
		return false;
	}
	
	// 知识回顾
	var zshgVal = zshgEditor.document.getBody().getText();
	if (isEmpty(zshgVal)) {
		alert("知识回顾不能为空！");
		return false;
	}
	if (beyondTheLength(zshgVal, 1000)) {
		alert("知识回顾不能超过1000字符！");
		return false;
	}
	
	// 教学重点
	var di_JiaoXueZD = $("#di_JiaoXueZD").val();
	if (isEmpty(di_JiaoXueZD)) {
		alert("教学重点不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueZD, 500)) {
		alert("教学重点不能超过500字符！");
		return false;
	}
	
	// 教学难点
	var di_JiaoXueND = $("#di_JiaoXueND").val();
	if (isEmpty(di_JiaoXueND)) {
		alert("教学难点不能为空！");
		return false;
	}
	if (beyondTheLength(di_JiaoXueND, 500)) {
		alert("教学难点不能超过500字符！");
		return false;
	}
	
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGai&_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcRS.getString("di_KeShiBH") %>');
}
</script>
</body>
</html>