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
<title>学习活动设计</title>
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
<html:dialog id="GNDH_XueXiHD" state="DHZT_ChaXun"/>
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
	RecordSet kcRS = executeResult.getRecordSet("SWDY_KeChengXXCX");
	kcRS.next();
%>
    <div class="wrap clearfix" style="min-height: 400px;">
        <div class="fl mt-10 w-710">
            <div class="td-zt">
                您所在的位置：<%=kcRS.getString("di_NianJi") + kcRS.getString("di_KeMu") %>/<%=kcRS.getString("di_KeShiMC") %>
            </div>
            
            <!-- 学习活动列表显示 -->
            <%
            // 学习活动
            RecordSet xxhdRS = executeResult.getRecordSet("SWDY_XueXiHDCX");
            while (xxhdRS.next()) {
            %>
              <div class="my-jx mt-20">
                <div class="title-bar clearfix">
                    <h2><%=xxhdRS.getString("di_HuoDongMC") %></h2>
                </div>
            </div>
            <div class="mt-20 xxzy-zd" style="word-wrap:break-word;">
            	<%=xxhdRS.getString("di_HuoDongNR") %>
            </div>
            <%
            }
            %>
          
            <!-- 新增活动 -->
            <div class="zjyq mt-20">
                <div class="zj mt-5 xxzy-jxkj">
           		</div>
                <label class="xxzy-jxkj">新增活动</label>
            </div>
        </div>
        
        <div class="fr w-230">
        <div class="mt-10 xxzy-bk">
            <a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=kcRS.getString("di_KeChengBH") %>" class="xxzy-bk-a">返回到备课界面》</a>
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
            <div class="cour-mykc mt-1 mykc">
                <div class="title">
                   	学习活动设计
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


<!--弹出层-->
<div class="pop-box hidden">
	<div class="cover"></div>
	<html:form>
	<div class="pop-content">
		<!-- 课时编号 -->
		<input type="hidden" name="di_KeShiBH" value="<%=kcRS.getString("di_KeShiBH") %>"/>
		<div class="title clearfix">
			<h2>学习活动</h2>
			<span class="to-close"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
				<div class="one-cell clearfix">
					<label>活动名称</label>
					<div class="mation-fillin-in">
						<input class="text" type="text" name="di_HuoDongMC" id="di_HuoDongMC" style="height: 30px; width: 500px;"/>
					</div>
				</div>
				
				<div class="one-cell clearfix">
					<label>活动内容</label>
					<div class="multiselect-box">
						<textarea rows="3" cols="100" name="di_HuoDongNR" id="di_HuoDongNR"></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="box-actadd">
			<button type="button" onclick="save()">增加活动</button>
		</div>
	</div>
	</html:form>
</div>
<script type="text/javascript">
// 学习活动保存
function save() {
	// 活动名称
	var huoDongMC = $("#di_HuoDongMC").val();
	if (isEmpty(huoDongMC)) {
		alert("活动名称不能为空！");
		return false;
	}
	if (beyondTheLength(huoDongMC, 50)) {
		alert("活动名称不能超过50字符！");
		return false;
	}
	// 非法字符校验
	if (forbiddenChar(huoDongMC)) {
		alert("活动名称只能输入字母、数字或中文！");
		return false;
	}
	
	// 验证活动名称是否重复
	var keShiBH = "<%=kcRS.getString("di_KeShiBH") %>";
	if (ExtFunctionCM.CheckRecordCount("jskj_xuexihd "," WHERE keshibh = '" + keShiBH + "' and huodongmc='" + huoDongMC + "'") > 0) {
		alert("活动名称已被使用！");
		return false;
	}
	
	// 活动内容
	var huoDongNR = $("#di_HuoDongNR").val();
	if (isEmpty(huoDongNR)) {
		alert("活动内容不能为空！");		
		return false;
	}
	if (beyondTheLength(huoDongNR, 1000)) {
		alert("活动内容不能超过1000字符！");
		return false;
	}
	
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XueXiHDTJ&_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=kcRS.getString("di_KeShiBH") %>');
}
</script>
</body>
</html>