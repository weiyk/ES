<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
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
	<%@include file="/common/framework.jspf" %>
	<%@include file="/common/jquery.jspf" %>
	<%@include file="/common/ckeditor.jspf"%>
	<title>撰写教学计划</title>
	<meta name="Keywords" content="">
	<meta name="Description" content="">
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
<html:dialog id="GNDH_JiaoXueJHTJ" state="DHZT_JiaoXueJHMB"/>
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
//获得课程项目
IDataBaseAccess dbm = null;
try {
	ResultSet kcRS = null;
	dbm = ContextService.lookupDefaultDataBaseAccess();
	dbm.openConnection();
	// 查询集合列表
	StringBuffer sqlBuf = new StringBuffer();
	sqlBuf.append("SELECT JSKJ_KeCheng.BianHao AS di_KeChengBH");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_KeMu' AND BianMa = KeMu ) AS di_KeMu");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_NianJi' AND BianMa = NianJi ) AS di_NianJi");
	sqlBuf.append(" FROM JSKJ_KeCheng JSKJ_KeCheng WHERE 1 = 1 AND JSKJ_KeCheng.BianHao = '" + request.getParameter("cs_KeChengBH") + "'");
	kcRS = dbm.executeQuery(sqlBuf.toString());
	if (kcRS.next()) {
		// 课程编号
		request.setAttribute("di_KeChengBH", kcRS.getString("di_KeChengBH"));
		// 科目
		request.setAttribute("di_KeMu", kcRS.getString("di_KeMu"));
		// 年级
		request.setAttribute("di_NianJi", kcRS.getString("di_NianJi"));
	}
	
	
	// 教学计划编号
	String cs_BianHao = request.getParameter("cs_BianHao");
	String JiHuaLX = "1";
	if (cs_BianHao != null && !"".equals(cs_BianHao)) {
		sqlBuf.delete(0, sqlBuf.length());
		sqlBuf.append("Select BianHao ,JiHuaBT ,JiHuaLX ,JiHuaNR");
		sqlBuf.append(" FROM JSKJ_JiaoXueJH ");
		sqlBuf.append(" WHERE BianHao = '" + cs_BianHao + "'");
		ResultSet jxjhRS = dbm.executeQuery(sqlBuf.toString());
		if (jxjhRS.next()) {
			// 编号
			request.setAttribute("BianHao", jxjhRS.getString("BianHao"));
			// 标题
			request.setAttribute("JiHuaBT", jxjhRS.getString("JiHuaBT"));
			// 内容
			request.setAttribute("JiHuaNR", jxjhRS.getString("JiHuaNR"));
			// 类型
			JiHuaLX = jxjhRS.getString("JiHuaLX");
		}
	}
	request.setAttribute("JiHuaLX", JiHuaLX);
} catch (Exception e) {
	e.printStackTrace();	
} finally {
	if (dbm != null)
		dbm.closeConnection();
}
%>
<div class="wrap clearfix">
	<div class="zy-box">
	<div class="clearfix title_bar">
		<div class="left_title fl">
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=${di_KeChengBH}"><span class="big_t">${di_NianJi }${di_KeMu }</span></a>
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=1"><span class="small_t" >教学计划</span></a>
		</div>
		<div class="left_title" style="float: right; display: inline;">
			<a class="small_t" style="margin-top: 17px;" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=1">
				&lt;&lt; 返回
			</a>
		</div>
	</div>
<hr/>

	<!--左半部分-->
	<div class="fl mt-30 w-710">
		<div class="rmtj-box">
			<html:form>
			<input type="hidden" id="di_BianHao" name="di_BianHao" value="${BianHao }"/>
			<!-- 隐藏课程编号 -->
			<input type="hidden" name="di_KeChengBH" value="${di_KeChengBH }"/>
			<div class="myksbk-chapter mt-10">
				<div class="form-box">
					<div class="mation-fillin-zt">
						<div class="mation-fillin-kczt">
								计划类型
					  	</div>
						<div class="ksbk-leri">
							<div class="one-cell clearfix">
								<div class="radio-boxs">
									<input type="hidden" name="di_JiHuaLX" id="di_JiHuaLX" value="${JiHuaLX != null ? JiHuaLX : 1 }"/>
									<!-- 编辑时读取已经选中的 -->	
									<span class="one-rd ${JiHuaLX == 1 ? 'rd-checked' : ''}" onclick="changeState(1)">学期计划</span>
									<span class="one-rd ${JiHuaLX == 2 ? 'rd-checked' : ''}" onclick="changeState(2)">月计划</span>
									<span class="one-rd ${JiHuaLX == 3 ? 'rd-checked' : ''}" onclick="changeState(3)">周计划</span>
									<span class="one-rd ${JiHuaLX == 4 ? 'rd-checked' : ''}" onclick="changeState(4)">学年计划</span>
								</div>
							</div>
						</div>
					</div>	
					<div class="mation-fillin">
						<div class="mation-fillin-bs">
							标题
						</div>
						<div class="mation-fillin-in">
							<input type="text" id="di_JiHuaBT" name="di_JiHuaBT" value="${JiHuaBT }"/>
						</div>
					</div><br />
					<div class="mation-fillin-kc" style="height:280px">
						<div class="mation-fillin-kcts">
							计划内容
						</div>
						<div class="mation-fillin-text">
							<div class="mation-texat">
								<textarea id="di_JiHuaNR" name="di_JiHuaNR">${JiHuaNR }</textarea>
							</div>
						</div>
					</div>
					<div>
						<div style="display: inline; float: left; margin-left: 70px;">
							<a class="small_t wlkc-150" href="#" onclick="saveJXJH()" style="margin-top: 17px; width: 70px; height: 30px;">
								保存
							</a>
						</div>
						<div style="display: inline; float: right;">
							<a class="small_t wlkc-150" href="#" onclick="saveTemplate()" style="margin-top: 17px; width: 70px; height: 30px;">
								另存为模板
							</a>
						</div>
					</div>	
				</div>
			</div>
			</html:form>
		</div>
	</div>
	
	
	<!--右半部分-->
	<div class="fr w-230">
		<div class="all-curriculum mt-30" style="height: 500px; overflow-x: hidden; overflow-y: auto; border: 1px solid grey;">
			<%
				// 教学计划模板
				RecordSet templateRS = executeResult.getRecordSet("SWDY_JiaoXueJHMBLB");
				int i = 0;
				while (templateRS.next()) {
			%>
				<div style="margin-bottom: 10px;">
					<div style="width: 100%; text-align: center;"><%=templateRS.getString("di_MoBanMC") %></div>
					<div id="temp<%=i %>" style="font-size: xx-small;" onclick="copyTemplate('temp<%=i %>')">
						<%=templateRS.getString("di_MoBanNR") %>
					</div>
				</div>
			<%
					i++;
				}
			%>
		</div>
	</div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$(function(){
	// 教学计划内容
	jhnrEditor = CKEDITOR.replace( 'di_JiHuaNR',
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
             ],height:200,width:600
          }
	 );
});

// 教学计划类型改变
function changeState(v) {
	$("#di_JiHuaLX").val(v);
}

// 表单验证
function formValidate() {
	// 标题
	var di_JiHuaBT = $("#di_JiHuaBT").val();
	if (isEmpty(di_JiHuaBT)) {
		alert("请输入标题！");
		return false;
	}
	if (beyondTheLength(di_JiHuaBT, 50)) {
		alert("标题不能超过50字符！");
		return false;
	}
	// 教学计划编号
	var di_BianHao = $("#di_BianHao").val();
	// 如果教学计划编号!=空则表示，为修改操作
	if (!isEmpty(di_BianHao)) {
		if (ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueJH "," WHERE KeChengBH = '${di_KeChengBH}' and JiHuaBT='" + di_JiHuaBT + "' and BianHao<>'" + di_BianHao + "'") > 0) {
			alert("教学计划标题已被使用！");
			return false;
		}
	} else {
		// 添加操作
		if (ExtFunctionCM.CheckRecordCount("JSKJ_JiaoXueJH "," WHERE KeChengBH = '${di_KeChengBH}' and JiHuaBT='" + di_JiHuaBT + "'") > 0) {
			alert("教学计划标题已被使用！")
			return false;
		}
	}
	
	// 教学内容
	var content = jhnrEditor.document.getBody().getText();
	if (isEmpty(content)) {
		alert("请输入计划内容！");
		return false;
	}
	if (beyondTheLength(content, 2000)) {
		alert("计划内容不能超过2000字符！");
		return false;
	}
	return true;
}

// 添加教学计划
function saveJXJH() {
	if (formValidate()) {
		// 教学计划编号
		var di_BianHao = $("#di_BianHao").val();
		if ($.trim(di_BianHao) != "") {
			// 修改
			$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_XiuGaiJXJH&_qam_dialog=GNDH_JiaoXueJHTJ&cs_KeChengBH=${di_KeChengBH}&cs_BianHao=${BianHao}');
		} else {
			// 添加
			$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_TianJiaJXJH&_qam_dialog=GNDH_JiaoXueJHTJ&cs_KeChengBH=${di_KeChengBH}');
		}
	}
}

// 赋值模板信息
function copyTemplate(tempID) {
	var tempData = $("#" + tempID).html();
	jhnrEditor.setData(tempData);
}

// 保存为模板
function saveTemplate() {
	// 标题
	var di_JiHuaBT = $("#di_JiHuaBT").val();
	if (isEmpty(di_JiHuaBT)) {
		alert("请输入标题！");
		return false;
	}
	if (beyondTheLength(di_JiHuaBT, 50)) {
		alert("标题不能超过50字符！");
		return false;
	}
	// 添加操作
	if (ExtFunctionCM.CheckRecordCount("jskj_jiaoxuejhmb "," WHERE MoBanMC = '" + di_JiHuaBT + "'") > 0) {
		alert("标题已被使用！")
		return false;
	}
	
	// 教学内容
	var content = jhnrEditor.document.getBody().getText();
	if (isEmpty(content)) {
		alert("请输入计划内容！");
		return false;
	}
	if (beyondTheLength(content, 2000)) {
		alert("计划内容不能超过2000字符！");
		return false;
	}
	
	$(this)._submit('<%=path%>/jspcontrolservlet?_qam_command=MLKZ_TianJiaJXJHMB&_qam_dialog=GNDH_JiaoXueJHTJ&cs_KeChengBH=${di_KeChengBH}');
}
</script>
</body>
</html>