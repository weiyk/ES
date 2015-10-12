<%@page import="com.qam.framework.util.CommonUtils"%>
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
	<title>教学计划</title>
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.title {
		    background: rgba(0, 0, 0, 0) url("<%=style%>/images/doc.png") no-repeat scroll left center;
		    height: 40px;
		    line-height: 40px;
		    margin-bottom: 16px;
		}
	</style>
	<script type="text/javascript" src="<%=style %>/js/base.js"></script>
</head>
<body>
<html:dialog id="GNDH_JiaoXueJHCX" state="DHZT_JiaoXueJHLBCX"/>
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
//总页数
int pageCount = 0;
String type = request.getParameter("cs_JiHuaLX");
if (type == null || "".equals(type))
	type = "1";

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
	kcRS.next();
	// 课程编号
	request.setAttribute("di_KeChengBH", kcRS.getString("di_KeChengBH"));
	// 科目
	request.setAttribute("di_KeMu", kcRS.getString("di_KeMu"));
	// 年级
	request.setAttribute("di_NianJi", kcRS.getString("di_NianJi"));
	
} catch (Exception e) {
	e.printStackTrace();	
} finally {
	if (dbm != null)
		dbm.closeConnection();
}
%>
<div class="wrap clearfix" style="min-height: 400px;">
	<div class="zy-box">
	<div class="clearfix title_bar">
		<div class="left_title fl">
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengNR&cs_KeChengBH=${di_KeChengBH}"><span class="big_t">${di_NianJi }${di_KeMu }</span></a>
			<span class="small_t">教学计划</span>
			<span class="small_t">
			</span>
		</div>
		<div class="left_title" style="float: right; display: inline;">
			<a class="small_t wlkc-150" style="margin-top: 17px;" href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHTJ&cs_KeChengBH=${di_KeChengBH}">
				撰写教学计划
			</a>
		</div>
	</div>
<hr/>
<br/>
	<div class="one-cell clearfix">
		<div class="radio-box">
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=1">
				<span class="one-rd <%if ("1".equals(type)) {%>rd-checked<%}%>">学期计划</span>
			</a>
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=2">
				<span class="one-rd <%if ("2".equals(type)) {%>rd-checked<%}%>">月计划</span>
			</a>
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=3">
				<span class="one-rd <%if ("3".equals(type)) {%>rd-checked<%}%>">周计划</span>
			</a>
			<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH}&cs_JiHuaLX=4">
				<span class="one-rd <%if ("4".equals(type)) {%>rd-checked<%}%>">学年计划</span>
			</a>
		</div>
	</div>
	<br/>
	
	<html:form>
	<%

		// 教学计划列表
		RecordSet jxjhRS = executeResult.getRecordSet("SWDY_JiaoXueJHLBCX");
		// 总条数
		long total = jxjhRS.getRecordCount();
		// 每页显示条数
		int limit = 5;
		if (total%limit == 0) {
			pageCount = (int)total/limit;
			if (pageCount == 0)
				pageCount = 1;
		} else {
			pageCount = (int)total/limit + 1;
		}
		request.setAttribute("pageCount", pageCount);
		
		while (jxjhRS.next()) {
	%>
		<div class="learn_tar">
			<div class="title">
				<span style="padding-left: 50px; font-size: 16px ;font-family: 'Arial Normal', 'Arial';"><%=jxjhRS.getString("di_JiHuaBT") %></span>
			</div>
			<div style="margin-left: 40px;">
				<%=jxjhRS.getString("di_JiHuaNR") %>
			</div>
			<div style="height: 30px; margin-top: 20px; margin-left: 40px;">
				<div style="display: inline; float: left;">
					<span style="color: red;"><%=jxjhRS.getString("di_ChuangJianSJ") %></span>
				</div>
				<div style="display: inline; float: right;">
					<a href="javascript:delJiHua('<%=jxjhRS.getString("di_BianHao") %>')">
						<img style="width: 20px; height: 20px;" src="<%=style %>/images/del.png" alt="删除"/>
						删除
					</a>
				</div>
				<div style="display: inline; float: right; margin-right: 10px;">
					<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHTJ&cs_KeChengBH=${di_KeChengBH }&cs_BianHao=<%=jxjhRS.getString("di_BianHao") %>&cs_JiHuaLX=<%=type %>">
						<img style="width: 20px; height: 20px;" src="<%=style %>/images/editor.png" alt="修改"/>
						修改
					</a>
				</div>
			</div>
			<hr style="border-bottom:1px dashed;"/>
		</div>
	<%
		}
	%>
	
	<!-- 分页标签 -->
	<div class="page-list clearfix">
		<div class="hidden">
			<html:self id="SWDY_JiaoXueJHLBCX"/>
		</div>
		<input type="hidden" id="_qam_pagenumber_DHSJZ_JiaoXueJH" name="_qam_pagenumber_DHSJZ_JiaoXueJH"/>
		<input type="hidden" id="sum" name="sum" value="<%= pageCount %>"/>
		<a id="shang" href="javascript:SX(-1)">上一页</a>
		<%
		String currentPage = request.getParameter("_qam_pagenumber_DHSJZ_KeChengLBCXJG");
		if(CommonUtils.null2Blank(currentPage).length() == 0){
			currentPage = "1";
		}
		int pages=Integer.parseInt(currentPage);
		int length=0;
		if(pageCount<=7){
			//循环六次
			for(int i=1;i<=pageCount;i++){%>
				<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
			<%}
		}else{
			if(pages<=3){
				for(int j=1;j<=7;j++){
				%>
					<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
				<% }
			}else{
				if(pageCount<pages+3){
					for(int k=pageCount-6;k<pages-3;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
				if(pageCount>pages+3){
					for(int k=pages-3;k<pages+4;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}else{
					for(int k=pages-3;k<pageCount+1;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
			}%>
		<%} %>
		<a id="xia" href="javascript:SX(1)">下一页</a>
		<span class="p-num">共${pageCount }页</span> 到 <input id="pageNumber" type="text" class="jp-ip" /> 页	
		<button type="button" onclick="TiaoZhuan()"  class="to-sub">确定</button>
	</div>
	</html:form>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp"/>
<script type="text/javascript">
	//提交分页
	function pageSubmit() {
		$("#_qam_turnpageflag").val("true");
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueJHCX&_qam_dialog_state=DHZT_JiaoXueJHLBCX&_dialog_submit_=GNDH_JiaoXueJHCX&cs_KeChengBH=${di_KeChengBH }&cs_JiHuaLX=<%=type %>";
		document.forms[0].submit();
	}
  
  	//点击确定
   	function TiaoZhuan() {
   		var num=$("#pageNumber").val();
	  	var reg = new RegExp("^[0-9]*$");  
	  	if(!reg.test(num)){
	  		// 输入的不是数字时跳转到第一页
	  		num = "1";
	  	}
	  	if($("#sum").val()==1){
	  		num = "1";
	  	}
	  	// 总页数
	  	var sum = $("#sum").val();
	  	if (parseInt(num) < 1 || parseInt(num) > sum) {
	  		num = "1";
	  	}
   		$("#_qam_pagenumber_DHSJZ_JiaoXueJH").val(num);
   		//控制当前页码
   		pageSubmit();
   	}
  	
	//点击页码
	function click(i) {
		$("#_qam_pagenumber_DHSJZ_JiaoXueJH").val(i);
		pageSubmit();
  	}
	
	//点击上一页和下一页
	function SX(e) {
		// 总页数
		var pageCount = "${pageCount}";
		// 当前页
		var currentPage = $("#_qam_pagenumber_DHSJZ_JiaoXueJH").val();
		// 目标页
		var targetPage = parseInt(currentPage) + (e);
		if (targetPage >= 1 && targetPage <= parseInt(pageCount)) {
			$("#_qam_pagenumber_DHSJZ_JiaoXueJH").val(targetPage);
			pageSubmit();
		}
	}

	$(function(){
		var currentPage = $("#_qam_pagenumber_DHSJZ_JiaoXueJH").val();
		if (currentPage == "0") {
			currentPage = "1";
		}
		//样式
		$("#page"+$("#_qam_pagenumber_DHSJZ_JiaoXueJH").val()).addClass("cur");
		//给文本框赋值
		$("#pageNumber").val(currentPage);
	});
	
	// 删除计划
	function delJiHua(cs_BianHao) {
		var del = confirm("确认删除？");
		if (del == true) {
			$(this)._submit("<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueJHCX&_qam_command=MLKZ_JiaoXueJHSC&cs_KeChengBH=${di_KeChengBH }&cs_BianHao=" + cs_BianHao + "&cs_JiHuaLX=<%=type %>");
		}
	}
</script>
</body>
</html>