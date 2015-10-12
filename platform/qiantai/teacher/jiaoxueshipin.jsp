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
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教学视频</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/common/jwplayer7/jwplayer.js"></script>
<script type="text/javascript">jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";</script>
<script type="text/javascript">
	function message_show_success(message){
			alert(message);
		}
	</script>
<style type="text/css">
.text {
	height: 30px;
	width: 500px;
}
.btn {
	background: #2d91d0 none repeat scroll 0 0;
    border: 1px solid #0072c3;
    border-radius: 4px;
    color: #fff;
    float: left;
    margin: 5px;
    padding: 1px 6px;
    text-align: center;
}
</style>
</head>
<body>
<html:dialog id="GNDH_JiaoXueSP" state="DHZT_ChaXun"/>
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
	// 课程信息
	RecordSet kcRS = executeResult.getRecordSet("SWDY_KeChengCX");
	kcRS.next();
%>
	<html:form id="selectForm">
    <div class="wrap clearfix">
        <div class="fl mt-10 w-710">
            <div class="td-zt">
                您所在的位置：<%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %>/<%=kcRS.getString("di_KeShiMC") %>
            </div>
            
           <%
           	// 教学视频列表
           	RecordSet jxspRS = executeResult.getRecordSet("SWDY_JiaoXueSPCX");
           	int i = 0;
           	while (jxspRS.next()) {
           %>
            <div id="img_Video" class="jxsp-sp mt-10" style="max-width:800px;">
            	<div class="z_edit_text" style="margin: 0 auto;width: 700px;">
		            <div style="position: relative; display: block; width: 700px; height: 365px;" id="J_player_wrapper">
		            	<div id="container<%=i%>">Loadingthe player...</div>
						<script type="text/javascript">
						    jwplayer("container<%=i%>").setup({
						        flashplayer:"<%=request.getContextPath() %>/common/jwplayer7/jwplayer.flash.swf",
						        file: '<%=request.getContextPath() + "/" + jxspRS.getString("di_ShiPinLJ") %>',
						        image: '<%=style%>/images/logo.png',
						        height:365,
						        width:700
						    });
							</script>
		            </div>
				</div>
		</div>
         <div class="mt-20">
             <label class="jxsp-kc">课程名：</label><label class="jxsp-mc"><%=jxspRS.getString("di_ShiPinMC") %></label>
         </div>
         <div class="mt-10">
             <label class="jxsp-kc">学校：</label><label class="jxsp-mc"><%=jxspRS.getString("di_XueXiao") %></label>
         </div>
         <div class="mt-10">
             <label class="jxsp-kc">主讲人：</label><label class="jxsp-mc"><%=jxspRS.getString("di_ZhuJiangR") %></label>
         </div>
         <div class="mt-10">
             <label class="jxsp-kc">课程简介：</label><label class="jxsp-mc"><%=jxspRS.getString("di_ShiPinJJ") %></label>
	         <div style="float: right;">
	         	<a class="btn" onclick="getInfo('<%=jxspRS.getString("di_BianHao") %>')">修改</a>&nbsp;
	         	<a class="btn " onclick="delVideo('<%=jxspRS.getString("di_BianHao") %>')">删除</a>
	         </div>
         </div>
         
		<%
				i++;
           	}
        %>
        <!-- 增加视频 -->
        <div class="zjyq mt-20">
            <div class="zj mt-5 xxzy-jxkj">
            </div>
            <label class="xxzy-jxkj">增加视频</label>
        </div>
            
        </div>
        
        <!-- 右侧导航 -->
        <div class="fr w-230">
	        <div class="mt-10 xxzy-bk">
	            <a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=kcRS.getString("di_KeChengBH") %>" class="xxzy-bk-a">返回到备课界面》</a>
	        </div>
	            <!-- 课程内容 -->
	            <div class="cour-mykc mykc mt-10">
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
	            <div class="cour-kc mt-1 mykc">
	                <div class="title">
	                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>">学习目标</a>
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
	            <div class="cour-mykc mt-1 mykc">
	                <div class="title">
	                    	教学视频
	                </div>
	            </div>
        </div>
    </div>
	</html:form>
	
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

<!--添加教学视频弹出层-->
<div class="pop-box hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<form action="<%=path %>/uploadVideo" id="uploadForm" method="post" enctype="multipart/form-data">
		<!-- 课时编号 -->
		<input type="hidden" id="di_KeShiBH" name="di_KeShiBH" value="<%=kcRS.getString("di_KeShiBH") %>"/>
		<!-- 视频编号 -->
		<input type="hidden" id="di_ShiPinBH" name="di_ShiPinBH"/>
		<div class="title clearfix">
			<h2>教学视频</h2>
			<span class="to-close"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
				<div class="one-cell clearfix">
					<label>视频名称</label>
					<div class="mation-fillin-in">
						<input type="text" class="text" name="di_ShiPinMC" id="di_ShiPinMC"/>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>学校</label>
					<div class="mation-fillin-in">
						<input type="text" class="text" name="di_XueXiao" id="di_XueXiao"/>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>视频路径</label>
					<div class="multiselect-box">
						<input type="file" class="text" id="di_ShiPinLJ" name="di_ShiPinLJ"/>
						<div id="fuJianDIV"></div>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>视频简介</label>
					<div class=mation-texat>
						<textarea rows="3" cols="100" name="di_ShiPinJJ" id="di_ShiPinJJ"></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="box-actadd">
			<button type="button" id="save" onclick="formValidate()">保存</button>
			<button type="button" class="hidden" id="update" onclick="updateShiPin()">修改</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$(".xxzy-jxkj").click(function () {
		$("#save").removeClass("hidden");
		$("#update").addClass("hidden");
		
		$("#di_ShiPinMC").val("");
		$("#di_XueXiao").val("");
		$("#di_ShiPinJJ").val("");
		$("#fuJianDIV").text("");
	})
});

// 表单提交验证
function formValidate() {
	// 视频名称非空验证
	var di_ShiPinMC = $("#di_ShiPinMC").val();
	if (isEmpty(di_ShiPinMC)) {
		alert("视频名称不能为空！");
		return false;
	}
	// 长度验证
	if (beyondTheLength(di_ShiPinMC, 50)) {
		alert("视频名称长度不能超过50字符！");
		return false;
	}
	// 重名验证
	var keShiBH = $("#di_KeShiBH").val();
	if (ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueSP "," WHERE KeShiBH = '" + keShiBH + "' and ShiPinMC='" + di_ShiPinMC + "'") > 0) {
		alert("视频名称已经被使用！");
		return false;
	}
	
	// 学校
	var di_XueXiao = $("#di_XueXiao").val();
	if (isEmpty(di_XueXiao)) {
		alert("学校名称不能为空！");
		return false;
	}
	// 长度验证
	if (beyondTheLength(di_XueXiao, 50)) {
		alert("学校名称长度不能超过50字符！");
		return false;
	}
	
	// 视频路径
	var ShiPinLJ = $("#di_ShiPinLJ").val();
	if ($.trim(ShiPinLJ) == "") {
		alert("请选择视频路径！");
		return false;
	}
	
	var prefix = ShiPinLJ.substring(ShiPinLJ.lastIndexOf(".") + 1).toUpperCase();
	if (prefix != "FLV" && prefix != "MP4") {
		alert("请上传flv,mp4格式视频文件！");
		return false;
	}
	
	// 视频简介
	var di_ShiPinJJ = $("#di_ShiPinJJ").val();
	if (isEmpty(di_ShiPinJJ)) {
		alert("视频简介不能为空！");
		return false;
	}
	if (beyondTheLength(di_ShiPinJJ, 500)) {
		alert("视频简介不能超过500字符！");
		return false;
	}
	
	// 提交表单
	$("#uploadForm").submit();
}

//删除教学视频
function delVideo(shiPinBH) {
	var del = confirm("确认删除？");
	if (!del)
		return;
	
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.DelVideo",
		parameter:["shiPinBH"],
		value:[shiPinBH]},
		success:function(data,textStatus,jqXHR) {
			// 刷新页面
			$("#selectForm").attr("action", "<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH")%>");
			$("#selectForm").submit();
		},
		complete:function(XHR, TS){
			result = XHR.responseText;
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
		}
	});
}

//查看教学视频详情
function getInfo(shiPinBH) {
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.GetVideoInfo",
		parameter:["shiPinBH"],
		value:[shiPinBH]},
		success:function(data,textStatus,jqXHR) {
			// 显示详情弹出层
			$(".pop-box").removeClass("hidden");
			// div弹出框显示在屏幕中间
			var top = ($(window).height() - $(".pop-box .pop-content").height())/2;   
	        var scrollTop = $(document).scrollTop();   
	        $(".pop-box .pop-content").css('top', top + scrollTop);
	        
			$("#save").addClass("hidden");
			$("#update").removeClass("hidden");
			
			// 视频信息
			var videoInfo = data;
			// 视频编号
			$("#di_ShiPinBH").val(videoInfo.BianHao);
			// 视频名称
			$("#di_ShiPinMC").val(videoInfo.ShiPinMC);
			// 学校
			$("#di_XueXiao").val(videoInfo.XueXiao);
			// 视频简介
			$("#di_ShiPinJJ").val(videoInfo.ShiPinJJ);
			
			// 附件路径
			$("#fuJianDIV").text("");
			$("#fuJianDIV").append(videoInfo.ShiPinMC + "&nbsp;&nbsp;<a id='removeId' onclick='shanChuFJ()'>删除</a>");
		},
		complete:function(XHR, TS){
			result = XHR.responseText;
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
		}
	});
}

function shanChuFJ() {
	$("#fuJianDIV").text("");
}

// 修改教学视频
function updateShiPin() {
	// 视频名称非空验证
	var di_ShiPinMC = $("#di_ShiPinMC").val();
	if (isEmpty(di_ShiPinMC)) {
		alert("视频名称不能为空！");
		return false;
	}
	// 长度验证
	if (beyondTheLength(di_ShiPinMC, 50)) {
		alert("视频名称长度不能超过50字符！");
		return false;
	}
	// 重名验证
	var shiPinBH = $("#di_ShiPinBH").val();
	if (ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueSP "," WHERE ShiPinMC='" + di_ShiPinMC + "' and BianHao!='" + shiPinBH + "'") > 0) {
		alert("视频名称已经被使用！");
		return false;
	}
	
	// 学校
	var di_XueXiao = $("#di_XueXiao").val();
	if (isEmpty(di_XueXiao)) {
		alert("学校名称不能为空！");
		return false;
	}
	// 长度验证
	if (beyondTheLength(di_XueXiao, 50)) {
		alert("学校名称长度不能超过50字符！");
		return false;
	}
	
	// 原来的附件
	var old = $("#fuJianDIV").text();
	// 新视频路径
	var ShiPinLJ = $("#di_ShiPinLJ").val();
	if (!isEmpty(old)) {
		if (!isEmpty(ShiPinLJ)) {
			alert("只能上传一个视频！");
			return false;
		}
	} else {
		if (isEmpty(ShiPinLJ)) {
			alert("请选择视频路径！");
			return false;
		}
		
		// 获得删除文件后缀
		var prefix = ShiPinLJ.substring(ShiPinLJ.lastIndexOf(".") + 1).toUpperCase();
		if (prefix != "FLV" && prefix != "MP4") {
			alert("请上传flv,mp4格式视频文件！");
			return false;
		}
	}
	
	// 视频简介
	var di_ShiPinJJ = $("#di_ShiPinJJ").val();
	if (isEmpty(di_ShiPinJJ)) {
		alert("视频简介不能为空！");
		return false;
	}
	if (beyondTheLength(di_ShiPinJJ, 500)) {
		alert("视频简介不能超过500字符！");
		return false;
	}
	
	// 更新
	var op = "<input type='hidden' name='operation' value='1'/>";
	$("#uploadForm").append(op);
	$("#uploadForm").submit();
}
</script>
</body>
</html>