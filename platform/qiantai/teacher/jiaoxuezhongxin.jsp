<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/teacher";
//获取路径
String path=request.getContextPath()+"/servlet";
//获取用户姓名
String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
//获取学校名字
String schoolName=(String) session.getAttribute("schoolName");

//获得课程项目
IDataBaseAccess dbm = null;
//课程项目集合
List<String> courseItemList = new ArrayList<String>();
//编目列表
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
<html>
<head>
	<title>教学中心</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>
<html:dialog id="GNDH_JiaoXueZB" state="DHZT_ChaXunKC"/>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM%></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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

	<div class="fl mt-20 w-710">

		<!-- 直播课程 -->
		<div class="live-kc">
			<div class="title-bar clearfix">
				<h2>直播课程</h2>
			</div>
			<div class="kc-table mt-10">
				<div class="tb-title clearfix">
					<span class="blk they fl"><a href="#" class="blk">2015年</a></span>
					<span class="blk seemore fr"><a  class="blk" href="#">点击查看完整课表</a></span>
					<span class="blk them"><a href="#" class="blk">5月</a></span>
				</div>
				<table cellspacing="0" cellpadding="0" class="mt-10 the-table">
					<tr>
						<th>周一</th>
						<th>周二</th>
						<th>周三</th>
						<th>周四</th>
						<th>周五</th>
						<th>周六</th>
						<th>周天</th>
					</tr>
					<tr class="date">
						<td>18日</td>
						<td>19日</td>
						<td>20日</td>
						<td>21日</td>
						<td>22日</td>
						<td>23日</td>
						<td>24日</td>
					</tr>
					<tr>
						<td><a href="#" class="one-kc hover-a"><span class="time">08:40</span>英语</a></td>
						<td><a href="#" class="one-kc hover-a"><span class="time">09:50</span>音乐</a></td>
						<td><a href="#" class="one-kc hover-a"><span class="time">08:40</span>英语</a></td>
						<td><a href="#" class="one-kc hover-a"><span class="time">09:50</span>音乐</a></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>					
				</table>
			</div>
		</div>

		<!-- 我的课程 -->
		<div class="my-jx mt-30">
			<div class="title-bar clearfix">
				<h2>我的教学</h2>
                <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_QuanBuKC" class=" blk fr">我的全部课程</a>
			</div>
			<div class="jx-list clearfix mt-15">
				<%
				// 循环生成课程列表
				RecordSet rs = executeResult.getRecordSet("SWDY_WoDeJX");
				int i = 0;
				while (rs.next()) {
					i++;
				%>
				<div class="<%if(i%3 == 0 ) {%>one-jx last<% } else {%>one-jx<%}%>">
					<div class="title">
						<h3><%=rs.getString("di_NianJi") + rs.getString("di_KeMu") %></h3>
						<p><%=rs.getString("di_JiaoXueMS") %></p>
						<span class="state-tip<%if("2".equals(rs.getString("di_ZhuangTai"))) {%> hd-fb<%} %>"><%=rs.getString("di_ZhuangTaiMC") %></span>
					</div>
					<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=rs.getString("di_BianHao")%>">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&cs_KeChengBH=<%=rs.getString("di_BianHao")%>">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="#">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批12}</span><a href="#">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答16}</span><a href="#">进入答疑</a></li>
						</ul>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>


	<div class="fr w-230">
		
		<div class="test-side-act clearfix mt-20">
			<!-- <a href="#" class="btn-zb hover-a ">直播公开课</a> -->
			<a href="#" class="toup-zy-1 btn-creatkc btn-cs hover-a mt-10">创建我的教学课程</a>
			<a href="http://www.zhiliaoshu.com.cn/download.html" target="_blank" class="btn-dl hover-a mt-10">知了树教师端下载</a>
		</div>

		<div class="ewm-box mt-20">
			<h3>知了树二维码：</h3>
			<img src="<%=style %>/images/zhiliaoshu.png" width="190px" height="190px" alt="" />
			<span>扫描下载知了树教师端下载
			</span>
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
		<html:form>
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
						for(int j = 0; j < courseItemList.size(); j+=3) {
							if ("JH_XueDuan".equals(courseItemList.get(j))) {
								code = courseItemList.get(j+1);
								text = courseItemList.get(j+2);
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
						for(int j = 0; j < courseItemList.size(); j+=3) {
							if ("JH_NianJi".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
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
						for(int j = 0; j < courseItemList.size(); j+=3) {
							if ("JH_KeMu".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
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
						for(int j = 0; j < courseItemList.size(); j+=3) {
							if ("JH_KeBenLX".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
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
						for(int j = 0; j < courseItemList.size(); j+=3){
							if ("JH_JiaoXueMS".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
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
						for(int j = 0; j < courseItemList.size(); j+=3){
							if ("JH_BeiKeMS".equals(courseItemList.get(j))) {
								// 编码
								code = courseItemList.get(j+1);
								// 值
								text = courseItemList.get(j+2);
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
		</div>
	</html:form>
	</div>
</div>
<script type="text/javascript">
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

//将页面选中的项，放入表单中，准备提交
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

//新增课程
function save() {
	setFormData();
	
	if (!ajaxValidateCourse()) {
		// 提交表单
		$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XinZengKC&_qam_dialog=GNDH_JiaoXueZB&_dialog_submit_=GNDH_JiaoXueZB');
	}
}

//验证课程是否重复
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
