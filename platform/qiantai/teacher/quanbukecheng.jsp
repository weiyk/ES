<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/teacher";
//获取路径
String path=request.getContextPath()+"/servlet";
String yonghuxm =(String)session.getAttribute("YONGHUXM");
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");
//获取对话状态
String dialog_state=request.getParameter("_qam_dialog_state");
// 获得课程项目
IDataBaseAccess dbm = null;
// 课程项目集合
List<String> courseItemList = new ArrayList<String>();
// 编目列表
Map<String, String> xgbmMap = new HashMap<String, String>();
try {
	dbm = ContextService.lookupDefaultDataBaseAccess();
	dbm.openConnection();
	ResultSet rs = null;
	// 查询集合列表
	String sql = "select JiHeYLX, BianMa, Zhi from qam_jiheyz where ZhuangTai=1";
	rs = dbm.executeQuery(sql);
	while (rs.next()) {
		// 集合类型
		courseItemList.add(rs.getString("JiHeYLX"));
		// 集合编码
		courseItemList.add(rs.getString("BianMa"));
		// 集合值
		courseItemList.add(rs.getString("Zhi"));
	}
	
	// 相关编目
	sql = "SELECT bm.BianHao, bm.BianMuBM, bm.BianMuMC from jskj_kechengbm bm where bm.ShangJiBH = 'root'";
	rs = dbm.executeQuery(sql);
	while (rs.next()) {
		xgbmMap.put(rs.getString("BianHao"), rs.getString("BianMuMC"));
	}
	request.setAttribute("bmMap", xgbmMap);
} catch (Exception e) {
	e.printStackTrace();	
} finally {
	if (dbm != null)
		dbm.closeConnection();
}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>全部课程</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<link href="<%=style %>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style %>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
<script type="text/javascript">
<%if(!"DHZT_ChaXun".equalsIgnoreCase(dialog_state)){%>
	function message_show_success(message){
			alert(message);
	}
<%}%>
</script>
</head>
<html:dialog id="GNDH_QuanBuKC" state="DHZT_ChaXun"/>
<body>
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

<div class="wrap clearfix">

	<div class="fl mt-20 w-710" style="min-height: 350px;">
		<div class="my-kc mt-20">
			<a class="creat-mykc hover-a toup-zy-1"><img src="<%=style %>/images/icon-creat.gif" alt="" />创建我的课程</a>
			<div class="title-bar clearfix" style="width: 200px;">
				<h2>我的教学</h2>
			</div>
			<div class="the-list mt-20">
				<ul class="clearfix">
					<li class="the-td">
						<span class="cell-1">课程名</span>
						<span class="cell-2">状态</span>
						<span class="cell-3">操作</span>
					</li>
					<%
					// 循环生成课程列表
					RecordSet rs = executeResult.getRecordSet("SWDY_ChaXun");
					while (rs.next()) {
						// 编号
						//rs.getString("di_BianHao")
						out.println("<li>");
						// 年级 + 科目
						out.println("<span class=\"cell-1\"><a href=\"" + path + "/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&cs_KeChengBH=" + rs.getString("di_BianHao") +"\">" + rs.getString("di_NianJi") + rs.getString("di_KeMu") + "</a></span>");
						// 状态
						out.println("<span class=\"cell-2\">" + rs.getString("di_ZhuangTai") + "</span>");
						out.println("<span class=\"cell-3\"><a href=\"" + path + "/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&cs_KeChengBH=" + rs.getString("di_BianHao") + "\">查看</a>");
						out.println("<a href=\"" + path + "/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=" + rs.getString("di_BianHao") + "\">修改</a></span>");
						out.println("</li>");
					}
					%>
				</ul>
			</div>
		</div>
	</div>

	<div class="fr w-230">
		
		<div class="side-kc mt-20">
			<h2>我的课程</h2>
			<div class="the-nav mt-10">
				<ul class="clearfix">
					<li class="cur"><a href="<%=path %>/jspdispatchservlet?_qam_dialog=GNDH_QuanBuKC">全部</a></li>
					<%
					for(int i = 0; i < courseItemList.size(); i+=3) {
						if ("JH_KeMu".equals(courseItemList.get(i))) {
					%>
						<li class="cur"><a href="#" onclick="queryCourseByKeMu('<%=courseItemList.get(i+1)%>')"><%=courseItemList.get(i+2) %></a></li>
					<%	}
					}%>
					<!--<li class="cur"><a href="#">音乐</a></li>
					 <li><a href="#">语文</a></li> -->
				</ul>
			</div>
		</div>

	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<!--弹出层-->
<div class="pop-box-1 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<input type="hidden" id="bianHao"/>
		<html:form id="addForm">
		<div class="title clearfix">
			<h2>创建课程</h2>
			<span class="to-close"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
				<!--选择-->
				<div class="one-cell clearfix">
					<label>学段</label>
					<div class="sx-list fl">
						<input type="hidden" name="di_XueDuan" id="xueDuan"/>
						<%
						// 编码
						String code;
						// 值
						String text;
						// 设置默认值, 第一个值默认选中
						boolean setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3) {
							if ("JH_XueDuan".equals(courseItemList.get(i))) {
								code = courseItemList.get(i+1);
								text = courseItemList.get(i+2);
						%>
							<a id="<%="xueDuan" + code %>" <%if(setDefault){ %>class="cur"<%} %> onclick="confirm('<%="xueDuan" + code%>')"><span><%=text %></span></a>
						<%
							setDefault = false;
							}
						}
						%>
					</div>
				</div> 
				<div class="one-cell clearfix">
					<label>年级</label>
					<div class="sx-list fl">
						<input type="hidden" name="di_NianJi" id="nianJi"/>
						<%
						setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3) {
							if ("JH_NianJi".equals(courseItemList.get(i))) {
								// 编码
								code = courseItemList.get(i+1);
								// 值
								text = courseItemList.get(i+2);
						%>
							<a id="<%="nianJi" + code %>" <%if(setDefault){ %>class="cur"<%} %> onclick="confirm('<%="nianJi" + code%>')"><span><%=text %></span></a>
						<%
							setDefault = false;
							}
						}
						%>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>科目</label>
					<div class="sx-list fl">
						<input type="hidden" name="di_KeMu" id="keMu"/>
						<%
						setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3) {
							if ("JH_KeMu".equals(courseItemList.get(i))) {
								// 编码
								code = courseItemList.get(i+1);
								// 值
								text = courseItemList.get(i+2);
						%>
							<a id="<%="keMu" + code %>" <%if(setDefault){ %>class="cur"<%} %> onclick="confirm('<%="keMu" + code%>')"><span><%=text %></span></a>
						<%
							setDefault = false;
							}
						}
						%>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>课本</label>
					<div class="sx-list fl">
						<input type="hidden" name="di_KeBenLX" id="keBenLX"/>
						<%
						setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3) {
							if ("JH_KeBenLX".equals(courseItemList.get(i))) {
								// 编码
								code = courseItemList.get(i+1);
								// 值
								text = courseItemList.get(i+2);
						%>
							<a id="<%="keBenLX" + code %>" <%if(setDefault){ %>class="cur"<%} %> onclick="confirm('<%="keBenLX" + code%>')"><span><%=text %></span></a>
						<%
							setDefault = false;
							}
						}
						%>
					</div>
				</div>
				<!--下拉菜单-->
				<div class="one-cell clearfix">
					<label>相关编目</label>
					<div class="select-boxs select-boxs-bl fl">
						<select style="width: 100px; height: 30px;" name="di_BianMuBH" id="bianMuBH">
							<c:forEach items="${bmMap }" var="bm">
								<option value="${bm.key }">${bm.value }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<!--单选按钮-->
				<div class="one-cell clearfix">
					<label>教学模式</label>
					<div class="radio-box">
						<input type="hidden" name="di_JiaoXueMS" id="jiaoXueMS" />
						<%
						setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3){
							if ("JH_JiaoXueMS".equals(courseItemList.get(i))) {
								// 编码
								code = courseItemList.get(i+1);
								// 值
								text = courseItemList.get(i+2);
						%>
							<span id="<%="jiaoXueMS" + code %>" class="one-rd <%if(setDefault){ %>rd-checked<%} %>" onclick="confirmRadio('<%="jiaoXueMS" + code %>')"><%=text %></span>
						<%
							setDefault = false;
							}
						} 
						%>
					</div>
				</div>
				<div class="one-cell clearfix">
					<label>备课模式</label>
					<div class="radio-box">
						<input type="hidden" name="di_BeiKeMS" id="beiKeMS" />
						<%
						setDefault = true;
						for(int i = 0; i < courseItemList.size(); i+=3){
							if ("JH_BeiKeMS".equals(courseItemList.get(i))) {
								// 编码
								code = courseItemList.get(i+1);
								// 值
								text = courseItemList.get(i+2);
						%>
							<span id="<%="beiKeMS" + code %>" class="one-rd <%if(setDefault){ %>rd-checked<%} %>" onclick="confirmRadio('<%="beiKeMS" + code %>')"><%=text %></span>
						<%
							setDefault = false;
							}
						} 
						%>
					</div>
				</div>
			</div>
		</div>
		<div class="box-act">
			<a href="#" class="to-close">取消</a>
			<button id="saveBtn" type="button" onclick="save()">保存</button>
			<button id="updateBtn" type="button" onclick="update()">修改</button>
		</div>
	</html:form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	// 创建我的课程
	$(".creat-mykc").click(function () {
		$(".pop-box-1").removeClass("hidden");
		$("#saveBtn").removeClass("hidden");
		$("#updateBtn").addClass("hidden");
	})
	
});

// 确认选择,并记录所选择的值
function confirm(id) {
	// 根据学段动态显示年级，暂时这样写
	if (id == "xueDuan1") {
		$("#nianJi4").css("display", "block");
		$("#nianJi5").css("display", "block");
		$("#nianJi6").css("display", "block");
	} else if (id == "xueDuan2" || id == "xueDuan3") {
		$("#nianJi4").css("display", "none");
		$("#nianJi5").css("display", "none");
		$("#nianJi6").css("display", "none");
	}
	// 根据ID获得元素，并设置为选中状态
	$("#" + id).addClass("cur");
	// 根据ID获得所有同胞元素，并将其设置为未选中状态
	$("#" + id).siblings().removeClass("cur");
	// 获得选中的标签值，并将其赋值给表单元素
	$("#" + id.replace(/[0-9]/g, "")).val(id.replace(/[^0-9]/g, ""));
}

// 确认选择，并记录所选择的值
function confirmRadio(id) {
	$("#" + id).addClass("rd-checked");
	$("#" + id).siblings().removeClass("rd-checked");
	
	$("#" + id.replace(/[0-9]/g, "")).val(id.replace(/[^0-9]/g, ""));
}

// 按科目查询
function queryCourseByKeMu(km) {
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_ChaXun&_qam_dialog=GNDH_QuanBuKC&_qam_dialog_state=DHZT_ChaXun&cs_KeMu=' + km);
}

// 新增课程
function save() {
	setFormData();
	// 根据科目+年级+学段验证课程是否重复
	if (!ajaxValidateCourse()) {
		// 提交表单
		$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XinZeng&_qam_dialog=GNDH_QuanBuKC&_dialog_submit_=GNDH_QuanBuKC');
	}
}

// 更新课程
function update() {
	// 组装表单数据
	setFormData();
	var courseID = $("#bianHao").val();
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGai&_qam_dialog=GNDH_QuanBuKC&_dialog_submit_=GNDH_QuanBuKC&di_BianHao=' + courseID);
}

// 将页面选中的项，放入表单中，准备提交
function setFormData() {
	var hiddenList = ["xueDuan", "nianJi", "keMu", "keBenLX", "jiaoXueMS", "beiKeMS"];
	// 获得被选中的标签
	var selectItem;
	$.each(hiddenList, function(i, v) {
		selectItem = $("#" + v).siblings(".cur");
		if (selectItem == undefined || selectItem.length == 0) {
			selectItem = $("#" + v).siblings(".rd-checked");
		}
		// 被选中的标签ID
		var eId = selectItem.attr("id");
		// 获得标签值赋值给表单hidden标签
		$("#" + eId.replace(/[0-9]/g, "")).val(eId.replace(/[^0-9]/g, ""));
	});
}

// 验证课程是否重复
function ajaxValidateCourse() {
	var exists = false;
	
	// 年级
	var nianJi = $("#nianJi").val();
	// 学段
	var xueDuan = $("#xueDuan").val();
	// 科目
	var keMu = $("#keMu").val();
	$.ajax({
		type:"post",
		url:'<%=path%>/AjaxServlet',
		traditional:true,
		async:false,
		dataType: "json",
		data:{service:"com.rc.web.ajax.ValidateCourse",
		parameter:["nianJi", "xueDuan", "keMu"],
		value:[nianJi, xueDuan, keMu]},
		success:function(data,textStatus,jqXHR){
			if (data.state == "1") {
				exists = true;
				alert(data.msg);
			}
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
	return exists;
}
</script>
</body>
</html>