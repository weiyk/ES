<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/teacher";
//获取路径
String path=request.getContextPath()+"/servlet";
String yonghuxm =(String)session.getAttribute("YONGHUXM");
String yongHuBH = (String)session.getAttribute("XiTongHYBH");
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");
%>
<html>
<head>
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<%@include file="/common/ckeditor.jspf"%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>开始备课</title>
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
<html:dialog id="GNDH_KaiShiBK" state="DHZT_ChaKanKC"/>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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

<div class="wrap clearfix">
	<%
	RecordSet rs = executeResult.getRecordSet("SWDY_ChaXun");
	rs.next();
	// 课程状态
	String keChengZT = rs.getString("di_ZhuangTai");
	if (keChengZT == null || "".equals(keChengZT)) {
		keChengZT = "1";
	}
	%>
	<!--上半部分-->
	<div  class="top-banner-enjsx">
				<div class="title-bar clearfix mt-10">
			  		<h2><%=rs.getString("di_NianJi") + rs.getString("di_KeMu")%></h2>
				</div>
				<div class="title-mybanners-enjsx clearfix mt-10">
					<div class="mybanners-left-enjsx">
						<a href="#"><img src="<%=style %>/images/title-iconfont-shuss.png" alt="" /></a>
						
					</div>
					<div class="myclassroom-right-enjsx">
						<div class="myclass-right-top">
							<span class="img-enjsx">
								<a href="#"><img src="<%=style %>/images/iconfont-talk.png" alt="" /></a>
								<a href="#"><img src="<%=style %>/images/iconfont-note.png" alt="" /></a>
								<a href="#"><img src="<%=style %>/images/Shape.png" alt="" /></a>
							</span>
							<a href="#"><span class="jxz-enjsx"><%=rs.getString("di_ZhuangTaiMC") %></span></a>
						</div>
						<div class="myclass-right-main">
							<div class="title-dynamic">
								<div class="title-dy">
									<span class="title-jj mt-20">课程特色:</span>
								</div>
								<ul class="clearfix">
									<li>
										<%=rs.getString("di_KeChengTS") %>
									</li>
								
								</ul>
							</div>
						</div>
					</div>
				</div>
	</div>

	<!--左半部分-->
	<div class="fl mt-30 w-710">
		<!-- 标题列表 -->
		<div class="rmtj-box">
		<div class="title-bar clearfix mt-10">
		<a href="#" id="edit">
			<span style="float: right;margin-right: 97px;cursor: pointer;">编辑</span></a>
			  <h2>基本信息</h2>
		  </div>
			<!-- 章节 -->
			<html:form>
			<!-- 隐藏课程编号 -->
			<input type="hidden" name="di_BianHao" value="<%=rs.getString("di_BianHao") %>"/>
			<div class="myksbk-chapter mt-10">
				<div class="form-box">
					<div class="mation-fillin">
						<div class="mation-fillin-bs">
							标题：
						</div>
						<div class="mation-fillin-in">
							<div id="lbl_BiaoTi" style="padding-top: 6px; width: 450px; height: 10px; margin-left: 0px;" class="xxzy-zd" title="点击进行编辑">
								<%=rs.getString("di_BiaoTi") %>
							</div>
							<div>
								<input type="text" style="display: none" value="<%=rs.getString("di_BiaoTi") %>" id="di_BiaoTi" name="di_BiaoTi"/>
							</div>
						</div>
					</div><br />
					<div class="mation-fillin mt-20">
						<div class="mation-fillin-bs">
							标签：
						</div>
						<div class="mation-fillin-in">
							<div id="lbl_BiaoQian" style="padding-top: 6px;width: 450px; height: 10px; margin-left: 0px;" class="xxzy-zd">
								<%=rs.getString("di_BiaoQian") %>
							</div>
							<input style="display: none" type="text" value="<%=rs.getString("di_BiaoQian") %>" id="di_BiaoQian"  name="di_BiaoQian"/>							
						</div>
						<div id="lbl_desc" class="lblksbk hidden">
							将会应用于按标签搜索课程、相关课程的提取等
						</div>
					</div>
					<div class="mation-fillin-kc" style="height:150px">
						<div class="mation-fillin-kcts">
							课程特色：
						</div>
						<div class="mation-fillin-text">
							<div id="lbl_KeChengTS" style="padding-left: 0px;padding-top: 20px;width: 470px; min-height: 120px; margin-left: 0px;" class="xxzy-zd">
								<%=rs.getString("di_KeChengTS") %>
							</div>
							<div class="mation-texat hidden">
								<textarea id="di_KeChengTS" name="di_KeChengTS"><%=rs.getString("di_KeChengTS") %></textarea>
							</div>
						</div>
					</div>
					<div class="mation-fillin-zt">
						<div class="mation-fillin-kczt">
								课程状态：
					  	</div>
						<div class="ksbk-leri">
							<div style="margin-left: 14px;">
								<div id="lbl_ZhuangTai" class="xxzy-zd" style="padding-top: 6px;width: 450px; height: 10px; margin-left: 0px;">
									<%if("1".equals(keChengZT)){ out.println("教学中");} else {out.println("已停课");}%>
								</div>
							</div>
							<div class="one-cell clearfix">
								<div class="radio-boxs hidden" >
									<input type="hidden" name="di_ZhuangTai" id="di_ZhuangTai" value="<%=keChengZT %>"/>
									<span  class="one-rd <%if("1".equals(keChengZT)){ %>rd-checked<%} %>" onclick="changeState(1)">教学中</span>
									<span  class="one-rd <%if("2".equals(keChengZT)){ %>rd-checked<%} %>" onclick="changeState(2)">已停课</span>
								</div>
							</div>
						</div>
					</div>	
					<div class="mation-fillin-btn" align="center">
						<div>
							<input id="btnSave" style="display: none;" type="button" value="保存" class="wlkc-150" onclick="save()"/>
						</div>
						
						<%-- <a href="#" class="hidden" onclick="save()"><img src="<%=style %>/images/zmt-savebtn.png" alt=""/></a> --%>
					</div>	
				</div>
			</div>
			</html:form>
		</div>
	</div>

	<!--右半部分-->

	<div class="fr w-230">
		
		<!-- 我的全部课程 All my classes-->
		<div class="all-curriculum mt-30">
			<div class="one-dynamic">
				<div class="curriculum-mation-title">
						<h3>课程信息</h3>
				</div>
				<div class="curriculum-mation mt-10">
					<span class="ksbk-mation">基本信息</span>
				</div>
				<ul class="clearfix">
					<li>
						<a class="list-name" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=<%=rs.getString("di_BianHao")%>">课时内容</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

<script type="text/javascript">
var kctsEditor;
$(function(){
	kctsEditor = CKEDITOR.replace( 'di_KeChengTS',
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
             ],height:80,width:500
          }
	 );
	$("#edit").bind('click',function(){
		$(this).hide();
		$("#btnSave").show();
		$("#di_BiaoTi").css("display", "");
		$("#lbl_BiaoTi").addClass("hidden");
		$("#lbl_BiaoQian").addClass("hidden");
		$("#di_BiaoQian").css("display", "");
		$("#lbl_desc").removeClass("hidden");
		$("#lbl_KeChengTS").addClass("hidden");
		$("#di_KeChengTS").parent().removeClass("hidden");
		$("#lbl_ZhuangTai").addClass("hidden");
		$("#di_ZhuangTai").parent().removeClass("hidden");
	});
});
// 教学中点选
function changeState(s) {
	$("#di_ZhuangTai").val(s);
}


// 保存课程信息
function save() {
	// 标题
	$("#edit").show();
	$("#btnSave").hide();
	$("#di_BiaoTi").css("display", "none");
	$("#lbl_BiaoTi").html($("#di_BiaoTi").val());
	$("#lbl_BiaoTi").removeClass("hidden");
	$("#di_BiaoQian").css("display", "none");
	$("#lbl_BiaoQian").html($("#di_BiaoQian").val());
	$("#lbl_BiaoQian").removeClass("hidden");
	$("#lbl_desc").addClass("hidden");
	$("#di_KeChengTS").parent().addClass("hidden");
	$("#lbl_KeChengTS").html(kctsEditor.document.getBody().getText());
	$("#lbl_KeChengTS").removeClass("hidden");
	
	var di_BiaoTi = $("#di_BiaoTi").val();
	if (isEmpty(di_BiaoTi)) {
		alert('请输入标题!');
		return false;
	}
	if (beyondTheLength(di_BiaoTi, 50)) {
		alert("标题不能超过50字符");
		return false;
	}
	
	// 标签
	var di_BiaoQian = $("#di_BiaoQian").val();
	if (isEmpty(di_BiaoQian)) {
		alert("请输入标签！");
		return false;
	}
	if (beyondTheLength(di_BiaoQian, 50)) {
		alert("标签不能超过50字符！");
		return false;
	}
	
	// 课程特色
	var di_KeChengTS = kctsEditor.document.getBody().getText();
	if (isEmpty(di_KeChengTS)) {
		alert("请输入课程特色！");
		return false;
	}
	if (beyondTheLength(di_KeChengTS, 200)) {
		alert("课程特色不能超过200字符！");
		return false;
	}
	
	// 课程状态
	var di_ZhuangTai = $("#di_ZhuangTai").val();
	if ($.trim(di_ZhuangTai) == "") {
		alert("请选择课程状态！");
		return false;
	}
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGaiKC&_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=rs.getString("di_BianHao")%>');
}




</script>
</body>
</html>