<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	String schoolName=(String) session.getAttribute("schoolName");
	
	String KCBianhao=request.getParameter("cs_KeChengBH");
	
	request.setAttribute("cs_KeChengBH", request.getParameter("cs_KeChengBH"));
	
%>
<html>
<head>
<%@ taglib uri="qamer-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课时列表</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
</head>
<body>
<html:dialog id="GNDH_KeShiLB" state="DHZT_ChaXun"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>	</div>
	</div>
<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian" class="cur">练一练</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe" >测一测</a></li>
		</ul>
	</div>
</div>
<div class="wrap clearfix">
	<!--上半部分-->
	<div  class="top-banner-enjsx">
	
		<%
		// 课程信息
		RecordSet kcRS = executeResult.getRecordSet("SWDY_KeChengXX");
		kcRS.next();
		// 年级
		String grade = kcRS.getString("di_NianJi");
		%>
		<div class="title-bar clearfix mt-10">
			<h3>
				<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeChengZX">课程中心 </a>> <%=kcRS.getString("di_NianJiMC") + kcRS.getString("di_KeMu") %>
			</h3>
		</div>
		<div class="title-mybanners-enjsx clearfix mt-10">
			<div class="mybanners-left-enjsx">
				<a href="#"><img src="<%=style%>/images/title-iconfont-shuss.png" alt="" /></a>
			</div>
			<div class="myclassroom-right-enjsx">
				<div class="myclass-right-main">
					<div class="title-dynamic">
						<div class="title-dy">
							<span class="title-jj mt-20"><%=kcRS.getString("di_NianJiMC") + kcRS.getString("di_KeMu") %></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div style="border:1px solid #eeeeee; margin-top: 10px; padding: 5px 20px;">
			<div style="min-height: 40px;">
				<b>授课教师：</b>
			</div>
			<div style="min-height: 40px;">
				<b>课程特色：</b><%=kcRS.getString("di_KeChengTS") %>
			</div>
		</div>
	</div>

	<!--左半部分-->
	<div class="fl mt-30 w-710">
		
		<!-- 标题列表 -->
		<div class="rmtj-box">
		
			<div class="kc-tab-bar zyq-fb-ywq-tlq-s clearfix">
				<ul class="fl">
					<li class="cur"><a href="<%= path %>/jspdispatchservlet?_qam_dialog=GNDH_KeShiLB&cs_KeChengBH=<%=KCBianhao%>">课程列表</a></li>
					<li><a href="#">课程评论</a></li>
					<!--<li><a href="#">作业区</a></li>
					<li><a href="#">答疑区</a></li>
					-->
				</ul>
			</div>
		
			<!--内容-->
			<div class="tab-content clearfix">
				<html:form>
				<div class="one-tabc mt-10">
					<!-- 章节 -->
					<div class="myjrkc-chapter mt-10">
						<ul class="clearfix">
						<%
							// 课时列表
							RecordSet ksRS = executeResult.getRecordSet("SWDY_KeShiLB");
							// 总条数
							long total = ksRS.getRecordCount();
							// 每页显示条数
							int limit = 10;
							// 总页数
							int pageCount = 0;
							if (total%limit == 0) {
								pageCount = (int)total/limit;
								if (pageCount == 0)
									pageCount = 1;
							} else {
								pageCount = (int)total/limit + 1;
							}
							request.setAttribute("pageCount", pageCount);
							
							while (ksRS.next()) {
						%>
							<li>
								<span class="list-name"><%=ksRS.getString("di_KeShiMC") %></span>
								<span class="yl-fb-xg">
									<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_YuLanKC&cs_KeShiBH=<%=ksRS.getString("di_KeShiBH") %>"><img src="<%=style%>/images/app-jrkty.gif" />学习</a>
								</span>
							</li>
						<%
							}
						%>
					</ul>
				</div>
				<!-- 分页标签 -->
				<div class="page-list clearfix">
					<div class="hidden">
						<html:self id="GNDH_KeShiLB"/>
					</div>
					<input type="hidden" id="_qam_pagenumber_DHSJZ_KeShiXX" name="_qam_pagenumber_DHSJZ_KeShiXX"/>
					<input type="hidden" id="sum" name="sum" value="<%= pageCount %>"/>
									<a id="shang" href="javascript:SX(-1)">上一页</a>
				<%
				String currentPage = request.getParameter("_qam_pagenumber_DHSJZ_KeShiXX");
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
				<span class="p-num">共<%=pageCount%>页</span> 到 <input id="pageNumber" type="text" class="jp-ip" /> 页	
				<button type="button" onclick="TiaoZhuan()" class="to-sub">确定</button>
				<%-- 
					<a id="shang" href="javascript:SX(-1)">上一页</a>
					<%
					//需要显示的页码数量
					int length = 0;
					//如果如果页码大于等于7，页码就等于7，否则有几页就等于几页
					if (pageCount >= 7) {
						length = 7;
					} else {
						length = pageCount;
					}
					//循环六次
					for (int i = 1; i< length; i++) {%>
						<a id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
					<%}%>
					<c:if test="${pageCount > 7}">
						<span>...</span>
					</c:if>
					<a id="page${pageCount }" href="javascript:click(${pageCount })">${pageCount }</a>
					<a id="xia" href="javascript:SX(1)">下一页</a>
					<span class="p-num">共${pageCount }页</span> 到 <input id="pageNumber" type="text" class="jp-ip" /> 页	
					<button type="submit" onclick="TiaoZhuan()"  class="to-sub">确定</button>
				--%>
				</div>
			</div>
			</html:form>
<script type="text/javascript">
	//提交分页
	function pageSubmit() {
		$("#_qam_turnpageflag").val("true");
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeShiLB&cs_KeChengBH=${cs_KeChengBH}";
		document.forms[0].submit();
	}
  
  	//点击确定
   	function TiaoZhuan() {
   		var num=$("#pageNumber").val();
	  	var reg = new RegExp("^[0-9]*$");  
	  	if(!reg.test(num)){
	  		// 非法数字跳转到第一页
	  		num = "1";
	  	}
	  	if($("#sum").val()==1){
	  		//alert("当前只有一页");
	  		//$("#pageNumber").val("");
	  		//return false;
	  		// 跳转到第一页
	  		num = "1";
	  	}
   		$("#_qam_pagenumber_DHSJZ_KeShiXX").val(num);
   		//控制当前页码
   		pageSubmit();
   	}
  	
	//点击页码
	function click(i) {
		$("#_qam_pagenumber_DHSJZ_KeShiXX").val(i);
		pageSubmit();
  	}
	
	//点击上一页和下一页
	function SX(e) {
		// 总页数
		var pageCount = "${pageCount}";
		// 当前页
		var currentPage = $("#_qam_pagenumber_DHSJZ_KeShiXX").val();
		// 目标页
		var targetPage = parseInt(currentPage) + (e);
		if (targetPage >= 1 && targetPage <= parseInt(pageCount)) {
			$("#_qam_pagenumber_DHSJZ_KeShiXX").val(targetPage);
			pageSubmit();
		}
	}

	$(function(){
		var currentPage = $("#_qam_pagenumber_DHSJZ_KeShiXX").val();
		if (currentPage == "0") {
			currentPage = "1";
		}
		//样式
		$("#page"+$("#_qam_pagenumber_DHSJZ_KeShiXX").val()).addClass("cur");
		//给文本框赋值
		$("#pageNumber").val(currentPage);
	});
</script>
				
				<div class="one-tabc hidden mt-10">
					<iframe width="100%" height="570px" align="top"  id="liebiao"
					src="<%=request.getContextPath() %>/platform/qiantai/student/tiebaxx.jsp?pagesize=1&&KeChengBH=<%=KCBianhao %>"
					style="border:none;" frameborder="0" scrolling="auto"></iframe>
				</div>
				
				<!-- 作业区域 -->
				<div class="one-tabc hidden mt-10">
					<div class="tlq-hdyw-zyq mt-10">
						<div class="tlq-hdyw-zyq-title-left">
							<div class="sub-tab">
								<ul class="clearfix">
									<li class="cur"><a href="javascript:;">未批</a></li>
									<li><a href="javascript:;">已批</a></li>
								</ul>
							</div>
						</div>
						<div class="tlq-hdyw-zyq-title-right">
							<a href="#"><div class="tlq-hdyw-zyq-title-right-cell1"></div></a>
							<a href="#"><div class="tlq-hdyw-zyq-title-right-cell2">上传作业</div></a>							
						</div>
					</div>
					<!--内容-->
					<div class="tlq-hdyw-zyq-contents mt-10">
						<span>暂无作业！</span>
					</div>
				</div>
				<div class="one-tabc hidden mt-10">
					<!--内容-->
					<div class="tlq-hdyw-zyq-contentseb mt-10">
						
						<div class="the-list">
							<ul class="clearfix">
								
								<li>
									<span class="cell-4"><a href="#"><img src="<%=style%>/images/taolun3.png" /></a></span>
									<span class="cell-1">
										<div class="lyl-wdyx">王晓阳</div><div class="tw-wdyx"></div><br />
										<div class="content-wdyx">老师，我对于古典音乐的深层韵味还是不是很理解呀！</div><br />
										
										<div class="wbk-hdyweb">
												<div class="form-box">
														<div class="mation-fillin-fbrz">
															
															<div class="mation-fillin-in">
																<input type="text" value="我来回复" id="" name="" />
															</div>
														</div>
												</div>
											</div>
									</span>
									<span class="cell-2">
										
										<br /><div class="time-hdyweb">2015/3/30</div><br />
										    <input type="button" value="回复" class="wlkc-80 mt-10"/>
									</span>
								</li>
								<li>
									<span class="cell-4"><a href="#"><img src="<%=style%>/images/taolun4.png" /></a></span>
									<span class="cell-1">
										<div class="lyl-wdyx">王懿龙</div><div class="tw-wdyx"></div><br />
										<div class="content-wdyx">我想更快的提升自己的成绩，希望老师能多多给我建议。</div><br />
										
										<div class="wbk-hdyweb">
												<div class="form-box">
														<div class="mation-fillin-fbrz">
															
															<div class="mation-fillin-in">
																<input type="text" value="我来回复" id="" name="" />
															</div>
														</div>
												</div>
											</div>
									</span>
									<span class="cell-2">
										
										<br /><div class="time-hdyweb">2015/3/30</div><br />
										    <input type="button" value="回复" class="wlkc-80 mt-10"/> 
									</span>
								</li>
								<li>
									<span class="cell-4"><a href="#"><img src="<%=style%>/images/taolun2.png" /></a></span>
									<span class="cell-1">
										<div class="lyl-wdyx">王文静</div><div class="tw-wdyx"></div><br />
										<div class="content-wdyx">我不知道怎样进行课后学习，希望老师能告诉我们方法！</div><br />
										
										<div class="wbk-hdyweb">
												<div class="form-box">
														<div class="mation-fillin-fbrz">
															
															<div class="mation-fillin-in">
																<input type="text" value="我来回复" id="" name="" />
															</div>
														</div>
												</div>
											</div>
									</span>
									<span class="cell-2">
										
										<br /><div class="time-hdyweb">2015/3/30</div><br />
										    <input type="button" value="回复" class="wlkc-80 mt-10"/>
									</span>
								</li>
								<li>
									<span class="cell-4"><a href="#"><img src="<%=style%>/images/taolun3.png" /></a></span>
									<span class="cell-1">
										<div class="lyl-wdyx">王晓阳</div><div class="tw-wdyx"></div><br />
										<div class="content-wdyx">老师，该怎样形容优美的美景呢？</div><br />
										
										<div class="wbk-hdyweb">
												<div class="form-box">
														<div class="mation-fillin-fbrz">
															
															<div class="mation-fillin-in">
																<input type="text" value="我来回复" id="" name="" />
															</div>
														</div>
												</div>
											</div>
									</span>
									<span class="cell-2">
										
										<br /><div class="time-hdyweb">2015/3/30</div><br />
										    <input type="button" value="回复" class="wlkc-80 mt-10"/>
									</span>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--右半部分-->

	<div class="fr w-230">
		
		<%
		/**
		 * 查询可能感兴趣的课程
		 */
		IDataBaseAccess dbm = null;
		ResultSet interestRS = null;
		try {
			dbm = ContextService.lookupDefaultDataBaseAccess();
			dbm.openConnection();
			// 查询集合列表
			StringBuffer sql = new StringBuffer();
			sql.append("Select BianHao , KeMu, NianJi ,XueDuan, ");
			sql.append("(select zhi from qam_jiheyz where JiHeYLX='JH_KeMu' and BianMa=KeMu) as KeMuMC,");
			sql.append("(select zhi from qam_jiheyz where JiHeYLX='JH_NianJi' and BianMa=NianJi) as NianJiMC");
			sql.append(" FROM JSKJ_KeCheng ");
			// 过滤自己
			sql.append(" WHERE NianJi ='" + grade + "' and BianHao<>'" + KCBianhao + "'");
			sql.append(" order by jianLiR desc ");
			sql.append(" limit 10");
			
			interestRS = dbm.executeQuery(sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<!-- 我的全部课程 All my classes-->
		<div class="all-myclass mt-30">
			<div class="one-dynamic">
				<div class="all-curriculum">
					<h2>可能感兴趣的课程</h2>
				</div>
				<ul class="clearfix">
					<%
					while (interestRS.next()) {
					%>
						<li>
							<span class="list-name">
								<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeShiLB&cs_KeChengBH=<%=interestRS.getString("BianHao")%>">
									<%=interestRS.getString("NianJiMC") + interestRS.getString("KeMuMC")%>
								</a>
							</span>
						</li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
</body>
</html>