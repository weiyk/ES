<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//获取样式
	String style = request.getContextPath()
			+ "/platform/qiantai/teacher";
	//获取资源样式
	String resource_style = request.getContextPath()
			+ "/platform/qiantai/teacher/style/resource";
	//获取路径
	String path = request.getContextPath() + "/servlet";
	//获取用户姓名
	String YONGHUXM = (String) request.getSession().getAttribute(
			"YONGHUXM");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	//资源类型
	String keyword = request.getParameter("keyword");
	
	//总页数
	int pageCount = 0;
	String currentPage = request.getParameter("_qam_pagenumber_DHSJZ_KeChengLBCXJG");
	if(CommonUtils.null2Blank(currentPage).length() == 0){
		currentPage = "1";
	}
	
	request.setAttribute("cs_ChuBanS", request.getParameter("cs_ChuBanS"));
	request.setAttribute("cs_KeMu", request.getParameter("cs_KeMu"));
	request.setAttribute("cs_Keyword", request.getParameter("cs_Keyword"));
	request.setAttribute("cs_NianJi", request.getParameter("cs_NianJi"));
	request.setAttribute("cs_XueDuan", request.getParameter("cs_XueDuan"));
	
	// 学段信息
	Map<String, String> stageMap = new LinkedHashMap<String, String>();
	// 年级信息
	Map<String, String> gradeMap = new LinkedHashMap<String, String>();
	// 出版社信息
	Map<String, String> publishMap = new LinkedHashMap<String, String>();
	// 课程科目信息
	Map<String, String> subjectMap = new LinkedHashMap<String, String>();
	
	// 查询集合域
	IDataBaseAccess dbm = null;
	ResultSet rs = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		// 查询集合列表
		String sql = "select JiHeYLX, BianMa, Zhi from qam_jiheyz where ZhuangTai=1 and " 
			+ "JiHeYLX in ('JH_XueDuan', 'JH_NianJi', 'JH_KeBenLX', 'JH_KeMu') order by JiHeYLX";
		rs = dbm.executeQuery(sql);
		
		String type = null;
		while (rs.next()) {
			// 集合域类型
			type = rs.getString("JiHeYLX");
			if (type != null) {
				if ("JH_XueDuan".equals(type)) {
					// 学段
					stageMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_NianJi".equals(type)) {
					// 年级					
					gradeMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_KeBenLX".equals(type)) {
					// 出版社					
					publishMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				} else if ("JH_KeMu".equals(type)) {
					// 科目
					subjectMap.put(rs.getString("BianMa"), rs.getString("Zhi"));
				}
			}
		}
		
		request.setAttribute("stageMap", stageMap);
		request.setAttribute("gradeMap", gradeMap);
		request.setAttribute("publishMap", publishMap);
		request.setAttribute("subjectMap", subjectMap);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			rs.close();
		if (dbm != null)
			dbm.closeConnection();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课程中心</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
</head>
<html:dialog id="GNDH_KeChengZX" state="DHZT_ChaXun"/>
<body>

	<div class="top-u-bar">
		<div class="wrap">
			<p>
				欢迎你！ <a href="gerenzhongxin.htm" class="user-name blk"><%=YONGHUXM%></a><%=schoolName%><a
					href="<%=path%>/desktop.html" class="to-quit">退出</a>
			</p>
		</div>
	</div>
	<!-- 头部 开始-->
	<jsp:include page="/platform/qiantai/teacher/resource/header.jsp" />
	<!-- 头部结束 -->
	<div class="wrap clearfix">
		<div class="wrap clearfix" style="height:auto;">
			<div class="res-content">
				<div class="layout">
					<div class="sea-right fl">
						<div class="res-search fl">
							<div class="search-left fl">
								<form id="searchForm" method="post"> 
									<!-- 出版社 -->
									<input type="hidden" name="cs_ChuBanS" id="cs_ChuBanS" value="${cs_ChuBanS }"/>
									<!-- 科目 -->
									<input type="hidden" name="cs_KeMu" id="cs_KeMu" value="${cs_KeMu }"/>
									<!-- 年级 -->
									<input type="hidden" name="cs_NianJi" id="cs_NianJi" value="${cs_NianJi }"/>
									<!-- 学段 -->
									<input type="hidden" name="cs_XueDuan" id="cs_XueDuan" value="${cs_XueDuan }"/>
									<!-- 关键字 -->
									<input name="cs_Keyword" value="${cs_Keyword }" class="search-text" type="text"/> 
									<input class="search-button" value="搜索" type="submit"/> 
								</form>
							</div>
						</div>
					
						<div class="search-content fl">
							<!-- 学段 -->
							<ul>
								<li class="list-class">学段：</li>
								<li><a <c:if test="${empty cs_XueDuan }">class="reslist-click"</c:if> href="javascript:stageClick('')">全部</a></li>
								<c:forEach items="${stageMap }" var="stage">
									<li><a <c:if test="${cs_XueDuan == stage.key}">class="reslist-click"</c:if> href="javascript:stageClick('${stage.key }')">${stage.value }</a></li>
								</c:forEach>
							</ul>
							
							<!-- 年级 -->
							<ul>
								<li class="list-class">年级：</li>
								<li><a <c:if test="${empty cs_NianJi }">class="reslist-click"</c:if> href="javascript:gradeClick('')">全部</a></li>
								<c:forEach items="${gradeMap }" var="grade">
									<li><a <c:if test="${cs_NianJi == grade.key}">class="reslist-click"</c:if> href="javascript:gradeClick('${grade.key }')">${grade.value }</a></li>
								</c:forEach>
							</ul>
							
							<!-- 出版社 -->
							<ul>
								<li class="list-class">出版社：</li>
								<li><a <c:if test="${empty cs_ChuBanS }">class="reslist-click"</c:if>
									href="javascript:publishClick('')">全部</a>
								</li>
								
								<c:forEach items="${publishMap }" var="publish">
									<li>
										<a <c:if test="${cs_ChuBanS == publish.key}">class="reslist-click"</c:if> href="javascript:publishClick('${publish.key }')">${publish.value }</a>
									</li>
								</c:forEach>
							</ul>
							
							<!-- 科目 -->
							<ul>
								<li class="list-class">课程科目：</li>
								<li><a <c:if test="${empty cs_KeMu }">class="reslist-click"</c:if>
									href="javascript:subjectClick('')">全部</a>
								</li>
								
								<c:forEach items="${subjectMap }" var="subject">
									<li><a <c:if test="${cs_KeMu == subject.key}">class="reslist-click"</c:if>
										href="javascript:subjectClick('${subject.key }')">${subject.value }</a>
									</li>
								</c:forEach>
							</ul>
						</div>

						<html:form id="keChengForm">
						<div class="lei_count">
							<!--列表内容切换开始-->
							<div class="list-content">
								<div class="sea-switchbox">
									<ul class="search-nav">
									</ul>
								</div>
								<div class="aui-switch-list">
									<div class="list-wrap">
										<!-- grid 展示-->
										<div class="aui-switch-grid" id="grid">
                            				<div class="grid-content">
                            				<%
                            				// 课程列表
                            				RecordSet keChengRS = executeResult.getRecordSet("SWDY_KeChengCX");
                            				// 总条数
                            				long total = keChengRS.getRecordCount();
                            				// 每页显示条数
                            				int limit = 10;
                            				if (total%limit == 0) {
                            					pageCount = (int)total/limit;
                            					if (pageCount == 0)
                            						pageCount = 1;
                            				} else {
                            					pageCount = (int)total/limit + 1;
                            				}
                            				request.setAttribute("pageCount", pageCount);
                            				
                            				while (keChengRS.next()) {
                            				%>
                                            	<div class="grid-content-box">
                                   					 <div class="resource-name">
														<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeShiLB&cs_KeChengBH=<%=keChengRS.getString("di_BianHao") %>">
                                                 		 <img src="<%=style%>/images/title-iconfont-shuss.png" width="177" height="200" class="tu_lei"/>
                                                 		</a>
                                                   	 	<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeShiLB&cs_KeChengBH=<%=keChengRS.getString("di_BianHao") %>">
                                                   	 	 	<%=keChengRS.getString("di_XueDuan") + keChengRS.getString("di_NianJi") %>&nbsp;&nbsp;
                                                   	 	 	<%=keChengRS.getString("di_KeMu") %>&nbsp;&nbsp;
                                                   	 	 	<%=keChengRS.getString("di_JianLiR") %>
                                                   	 	</a>
                                                    	<br/>
                                   					 </div>
                               					 </div>
                            				<%	
                            				}
                            				%>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--tab结束-->

							<!--翻页插件-->
							<div class="hidden">
								<html:self id="SWDY_KeChengCX"/>
							</div>
							<div class="clear"></div>
							<input type="hidden" name="_qam_pagenumber_DHSJZ_ChaXunJG" value="<%=currentPage %>" id="_qam_pagenumber_DHSJZ_ChaXunJG"/>
							<input type="hidden" id="sum" name="sum" value="<%= pageCount %>"/>
							
							<div class="page-list clearfix" align="center">
							<a id="shang" href="javascript:SX(-1)">上一页</a>
							<%
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
							<button type="button" onclick="TiaoZhuan()" style="height: 38px; background: #2cb4f3 none repeat scroll 0 0;">确定</button>
						</div>

							<!--翻页插件-->

						</div>
					</html:form>

						<!--内容1结束-->

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="clear"></div>
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
$("img").one("error", function() {
	$(this).attr("src", "<%=style%>/images/default.png");
});
	
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});

//提交分页
function pageSubmit(){
	$("#keChengForm").attr("action", "<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeChengZX").submit();
}

//提交分页
function pageSubmit() {
	$("#_qam_turnpageflag").val("true");
	$("#keChengForm").attr("action", "<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeChengZX").submit();
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
		$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(num);
		//控制当前页码
		pageSubmit();
	}
	
//点击页码
function click(i) {
	$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(i);
	pageSubmit();
	}

//点击上一页和下一页
function SX(e) {
	// 总页数
	var pageCount = "${pageCount}";
	// 当前页
	var currentPage = $("#_qam_pagenumber_DHSJZ_ChaXunJG").val();
	// 目标页
	var targetPage = parseInt(currentPage) + (e);
	if (targetPage >= 1 && targetPage <= parseInt(pageCount)) {
		$("#_qam_pagenumber_DHSJZ_ChaXunJG").val(targetPage);
		pageSubmit();
	}
}

$(function(){
	var currentPage = $("#_qam_pagenumber_DHSJZ_ChaXunJG").val();
	if (currentPage == "0") {
		currentPage = "1";
	}
	//样式
	$("#page"+$("#_qam_pagenumber_DHSJZ_ChaXunJG").val()).addClass("cur");
	//给文本框赋值
	$("#pageNumber").val(currentPage);
});

// 学段查询条件
function stageClick(v) {
	$("#cs_XueDuan").val(v);
	search();
}

// 年级查询条件
function gradeClick(v) {
	$("#cs_NianJi").val(v);
	search();
}

// 出版社查询条件
function publishClick(v) {
	$("#cs_ChuBanS").val(v);
	search();
}

// 科目查询条件
function subjectClick(v) {
	$("#cs_KeMu").val(v);
	search();
}

// 条件查询
function search() {
	$("#searchForm").attr("action", "<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeChengZX").submit();
}
</script>
</body>
</html>
