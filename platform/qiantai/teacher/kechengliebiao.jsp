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
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程列表</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
</head>
<body>
<html:dialog id="GNDH_KeChengLB" state="DHZT_KeChengLBCX"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>	</div>
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
	sqlBuf.append("SELECT JSKJ_KeCheng.BianHao AS di_KeChengBH, JSKJ_KeCheng.KeChengTS AS di_KeChengTS");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_KeMu' AND BianMa = KeMu ) AS di_KeMu");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_NianJi' AND BianMa = NianJi ) AS di_NianJi");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_KeChengZT' AND BianMa = JSKJ_KeCheng.ZhuangTai ) AS di_ZhuangTai");
	sqlBuf.append(" FROM JSKJ_KeCheng JSKJ_KeCheng WHERE 1 = 1 AND JSKJ_KeCheng.BianHao = '" + request.getParameter("cs_KeChengBH") + "'");
	kcRS = dbm.executeQuery(sqlBuf.toString());
	kcRS.next();
	// 课程编号
	request.setAttribute("di_KeChengBH", kcRS.getString("di_KeChengBH"));
	// 课程特色
	request.setAttribute("di_KeChengTS", kcRS.getString("di_KeChengTS"));
	// 科目
	request.setAttribute("di_KeMu", kcRS.getString("di_KeMu"));
	// 年级
	request.setAttribute("di_NianJi", kcRS.getString("di_NianJi"));
	// 状态
	request.setAttribute("di_ZhuangTai", kcRS.getString("di_ZhuangTai"));

	// 清空
	sqlBuf.delete(0, sqlBuf.length());
	// 查询前三条课程
	sqlBuf.append("SELECT BianHao AS di_KeChengBH");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_KeMu' AND BianMa = KeMu ) AS di_KeMu");
	sqlBuf.append(", ( SELECT zhi FROM qam_jiheyz WHERE JiHeYLX = 'JH_NianJi' AND BianMa = NianJi ) AS di_NianJi");
	sqlBuf.append(" FROM JSKJ_KeCheng order by BianHao desc LIMIT 3");
	ResultSet courseRS = dbm.executeQuery(sqlBuf.toString());
	Map<String, String> courseMap = new HashMap<String, String>();
	while (courseRS.next()) {
		courseMap.put(courseRS.getString("di_KeChengBH"), courseRS.getString("di_NianJi") + courseRS.getString("di_KeMu"));
	}
	request.setAttribute("courseMap", courseMap);
} catch (Exception e) {
	e.printStackTrace();	
} finally {
	if (dbm != null)
		dbm.closeConnection();
}
%>
<div class="wrap clearfix">
	<!--上半部分-->
	<div  class="top-banner-enjsx">
				<div class="title-bar clearfix mt-10">
			  		<h2>${di_NianJi }${di_KeMu }</h2>
				</div>
				<div class="title-mybanners-enjsx clearfix mt-10">
					<div class="mybanners-left-enjsx">
						<a href="#"><img src="<%=style%>/images/title-iconfont-shuss.png" alt="" /></a>
					</div>
					<div class="myclassroom-right-enjsx">
						<div class="myclass-right-top">
							<span class="img-enjsx">
								<a href="#"><img src="<%=style%>/images/iconfont-talk.png" alt="查看评论" title="查看评论"/></a>
								<a href="<%=path %>/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=KCBianhao%>">
									<img src="<%=style%>/images/iconfont-note.png" alt="课程信息" title="课程信息"/>
								</a>
								<a href="#"><img src="<%=style%>/images/Shape.png" alt="分享" title="分享"/></a>
							</span>
							<span class="jxz-enjsx">${di_ZhuangTai }</span>
						</div>
						<div class="myclass-right-main">
							<div class="title-dynamic">
								<div class="title-dy">
									<span class="title-jj mt-20">课程特色:</span>
								</div>
								<ul class="clearfix">
									<li>
										${di_KeChengTS }
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
		
			<div class="kc-tab-bar zyq-fb-ywq-tlq-s clearfix">
				<ul class="fl">
					<li class="cur"><a href="<%= path %>/jspdispatchservlet?_qam_dialog=GNDH_KeChengLB&_qam_dialog_state=DHZT_KeChengLBCX&_dialog_submit_=GNDH_KeChengLB&cs_KeChengBH=<%=KCBianhao%>">课程列表</a></li>
					<!--
					<li><a href="#">讨论区</a></li>
					<li><a href="#">作业区</a></li>
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
							RecordSet ksRS = executeResult.getRecordSet("SWDY_KeShiLBCX");
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
									<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_YuLanKC&cs_KeShiBH=<%=ksRS.getString("di_KeShiBH") %>"><img src="<%=style%>/images/app-jrkty.gif" />预览</a>
									<%if ("1".equals(ksRS.getString("di_FaBuZT"))) { 
									%>
										<a><img src="<%=style%>/images/app-jrktfj.gif" /></a>已发布
									<%
									} else {
									%>
										<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&_qam_command=MLKZ_FaBuKS&cs_KeShiBH=<%=ksRS.getString("di_KeShiBH") %>&cs_KeChengBH=${di_KeChengBH}"><img src="<%=style%>/images/app-jrktfj.gif" />发布</a>
									<%
									}
									%>
									<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=ksRS.getString("di_KeShiBH") %>"><img src="<%=style%>/images/app-jrktxg.png" />修改</a>
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
						<html:self id="SWDY_KeShiLBCX"/>
					</div>
					<input type="hidden" id="_qam_pagenumber_DHSJZ_KeChengLBCXJG" name="_qam_pagenumber_DHSJZ_KeChengLBCXJG"/>
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
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_KeChengLB&_qam_dialog_state=DHZT_KeChengLBCX&_dialog_submit_=GNDH_KeChengLB&cs_KeChengBH=${di_KeChengBH}";
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
   		$("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val(num);
   		//控制当前页码
   		pageSubmit();
   	}
  	
	//点击页码
	function click(i) {
		$("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val(i);
		pageSubmit();
  	}
	
	//点击上一页和下一页
	function SX(e) {
		// 总页数
		var pageCount = "${pageCount}";
		// 当前页
		var currentPage = $("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val();
		// 目标页
		var targetPage = parseInt(currentPage) + (e);
		if (targetPage >= 1 && targetPage <= parseInt(pageCount)) {
			$("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val(targetPage);
			pageSubmit();
		}
	}

	$(function(){
		var currentPage = $("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val();
		if (currentPage == "0") {
			currentPage = "1";
		}
		//样式
		$("#page"+$("#_qam_pagenumber_DHSJZ_KeChengLBCXJG").val()).addClass("cur");
		//给文本框赋值
		$("#pageNumber").val(currentPage);
	});
</script>
				
				<div class="one-tabc hidden mt-10">
					<div class="tlq-hdyw-zyq mt-10">
					<div class="tlq-hdyw-zyq-title-left">
						<div class="sub-tab">
							<ul class="clearfix">
								<li class="cur"><a href="javascript:;">全部</a></li>
								<li><a href="javascript:;">精华</a></li>
							</ul>
						</div>
					</div>
					<div class="tlq-hdyw-zyq-title-right">
						<a href="#"><div class="tlq-hdyw-zyq-title-right-cell1">发话题</div></a>						
						<a href="#"><div class="tlq-hdyw-zyq-title-right-cell3">排序</div></a>
						<a href="#"><div class="tlq-hdyw-zyq-title-right-xlcd">
							<!-- 下拉菜单 begin-->
							<div class="test-tlq-hdyw-zyq">
					
								<div class="the-form clearfix">
										
										<div class="select-box  fl">
											<input type="hidden" value=""  class="the-val"/>
											
											<ul class="clearfix hidden">
												<li><a href="javascript:;" rel="nj-1">一年级</a></li>
												
											</ul>
											<div class="select-cover">
												<span class="df-val">最新发帖</span>
												<em class="icon-blue"></em>
											</div>
											<ul class="clearfix hidden">
												<li><a href="javascript:;" rel="sxc-1">最新发帖</a></li>
												<li><a href="javascript:;" rel="sxc-2">最后回复</a></li>
											</ul>
										</div>
								</div>
							</div>
							<!-- 下拉菜单 end-->
						</div></a>
					</div>
				</div>
				
				<!-- 章节 -->
				<div class="mytlq-chapter">
				
					<ul class="clearfix">
                      <li style="background:#f1f1f1;height:20px;">
                          <span class="list-name" style="padding-top:0;">标题</span>
                          <span class="jh myreview">最后回复人</span>
                          <span class="jh myreview">回复数</span>
                          <span class="jh myreview">发起人</span>
                      </li>
						<li>
							<span class="list-name">你们平时会经常听音乐吗？</span>
							<span class="jh myreview">晓雪<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">10<br /><span class="sj">60</span></span>
							<span class="jh myreview">何月<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">大家觉得向他人介绍人或物品有趣吗？</span>
							<span class="jh myreview">夏天<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">5<br /><span class="sj">60</span></span>
							<span class="jh myreview">胡晓<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">你们是怎么介绍自己的老师的呀？</span>
							<span class="jh myreview">何蓓蓓<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">3<br /><span class="sj">60</span></span>
							<span class="jh myreview">安阳<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">大家都是怎么样学习音乐的呢？</span>
							<span class="jh myreview">袁岳<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">9<br /><span class="sj">60</span></span>
							<span class="jh myreview">姜静<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">大家有没有觉得听音乐的时候心里有种很舒适的感觉</span>
							<span class="jh myreview">刘莎<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">23<br /><span class="sj">60</span></span>
							<span class="jh myreview">薇安<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">学习音乐音乐哪一块更难学呢？</span>
							<span class="jh myreview">天天<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">41<br /><span class="sj">60</span></span>
							<span class="jh myreview">田蕊<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">我们都来谈谈对音乐学习的想法吧！</span>
							<span class="jh myreview">胜利<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">33<br /><span class="sj">60</span></span>
							<span class="jh myreview">大成<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">我们的课后合唱练习应该怎么办呢？</span>
							<span class="jh myreview">何小红<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">10<br /><span class="sj">60</span></span>
							<span class="jh myreview">方林<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">大家都是怎样学习音乐的呢？</span>
							<span class="jh myreview">刘洋<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">14<br /><span class="sj">60</span></span>
							<span class="jh myreview">景甜<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">你们喜欢音乐课吗？</span>
							<span class="jh myreview">张张<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">10<br /><span class="sj">60</span></span>
							<span class="jh myreview">桃子<br /><span class="sj">2015/05/03</span></span>
						</li>
						<li>
							<span class="list-name">觉得自己会的乐器太少，大家都是怎样学习乐器的呢？</span>
							<span class="jh myreview">何小红<br /><span class="sj">2小时前</span></span>
							<span class="jh myreview">10<br /><span class="sj">60</span></span>
							<span class="jh myreview">天天<br /><span class="sj">2015/05/03</span></span>
						</li>
					</ul>
				</div>
				<div class="page-list clearfix">
							<a href="#">上一页</a>
							<a href="#" class="cur">1</a>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<a href="#">6</a>
							<span>...</span>
							<a href="#">12</a>
							<a href="#">下一页</a>
	
							<span class="p-num">共11页</span>
	
							到 <input type="text" id="" class="jp-ip" /> 页	
							<button type="submit" class="to-sub">确定</button>
					</div>
				</div>
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
		
		<!-- 我的全部课程 All my classes-->
		<div class="all-myclass mt-30">
			<div class="one-dynamic">
				<div class="all-curriculum">
					<h2>我的全部课程</h2>
				</div>
				<ul class="clearfix">
					<c:forEach items="${courseMap }" var="course">
						<li>
							<span class="list-name culum">
								<a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&cs_KeChengBH=${course.key }">${course.value }</a>
							</span>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="fix-curric">
				<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_QuanBuKC"><span>显示全部课程</span></a>
			</div>
		</div>
	</div>
</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
</body>
</html>