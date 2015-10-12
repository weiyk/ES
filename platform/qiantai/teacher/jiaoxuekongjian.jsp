<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@page import="com.rc.tools.jsonexplain.*"%>
<%@page import="com.rc.tools.safty.ToDate" %>
<%@page import="java.util.*"%>
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>
<%
String style=request.getContextPath()+"/platform/qiantai/teacher";//获取样式
String path=request.getContextPath();//获取路径
String schoolName=(String) session.getAttribute("schoolName");//学校名字

String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");//获取用户姓名
String uid=(String)request.getSession().getAttribute("XiTongHYBH");//获取UID,系统用户编号
String key=(String)request.getSession().getAttribute("QuanZhi");//获取鉴值
String schoolId=(String)request.getSession().getAttribute("schoolId");//获取学校编号
//通知公告列表
TongZhiGG TZGG=new TongZhiGG();
List<Object> obj=TZGG.getJSONGongGaoBS(schoolId,key,uid,"2","1","4");
List<Map<String,Object>> TZGGlist=null;
String msgCode=(String)obj.get(0);//获取标示符
if(msgCode.equals("1")){
	TZGGlist=TZGG.getJSONGongGaoLB(obj.get(2));
}
request.setAttribute("msgCode",msgCode);


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
	<title>教学空间</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<script type="text/javascript">
	function message_show_success(message){
			alert(message);
		}
	</script>
</head>
<html:dialog id="GNDH_JiaoXueKJ" state="DHZT_ChaXun"/>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM %></a><%=schoolName %><a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>

	</div>
</div>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">       
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ" class="cur">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<!-- 信息提示 -->
		<div class="msg-tip clearfix">
			您有  <a href="#" class="msg-num blk">7</a> 条未读信息
			<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="more-link blk">去看看</a>
		</div>

		<!-- 我的教学 -->
		<div class="my-jx mt-20">
			<a href="#" class="creat-mykc hover-a toup-zy-1">创建我的课程</a>
			<div class="title-bar clearfix">
				<h2>我的教学</h2>
			</div>
			<div class="sub-tab">
				<ul class="clearfix">
					<%
					boolean selected = false;
					//System.out.println(request.getParameter("cs_KeMu"));
					for(int i = 0; i < courseItemList.size(); i+=3) {
						if ("JH_KeMu".equals(courseItemList.get(i))) {
					%>
						<li><a <%if(request.getParameter("cs_KeMu") != null && request.getParameter("cs_KeMu").equals(courseItemList.get(i+1))) { selected = true;%>class="cur"<%} %> onclick="queryCourseByKeMu('<%=courseItemList.get(i+1)%>')"><%=courseItemList.get(i+2) %></a></li>
					<%	}
					}%>
					<li><a <%if(!selected){ out.println("class='cur'");}%> href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ">全部</a></li>
					<!-- <li><a href="javascript:;">语文</a></li>	 -->							
				</ul>
			</div>
			<div class="tab-content clearfix">
				<div class="jx-list one-tabc clearfix mt-10">
				<%
				// 循环生成课程列表
				RecordSet rs = executeResult.getRecordSet("SWDY_ChaXunJG");
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
							<li ><strong>教学准备</strong><a href="<%=path%>/servlet/jspcontrolservlet?_qam_dialog=GNDH_KaiShiBK&cs_BianHao=<%=rs.getString("di_BianHao")%>">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="<%=path%>/servlet/jspcontrolservlet?_qam_dialog=GNDH_KeChengLB&cs_KeChengBH=<%=rs.getString("di_BianHao")%>">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="#">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批12}</span><a href="#">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答16}</span><a href="#">进入答疑</a></li>
						</ul>
				</div>
				<%
				}
				%>
			</div>
			<%--
			<div class="jx-list one-tabc clearfix mt-10">
					<div class="one-jx">
						<div class="title">
							<h3>一年级音乐</h3>
							<p>传统多媒体课堂</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批12}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答16}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx">
						<div class="title">
							<h3>二年级音乐</h3>
							<p>传统多媒体课堂</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批15}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答13}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx last">
						<div class="title">
							<h3>三年级音乐</h3>
							<p>传统多媒体课堂</p>
							<span class="state-tip hd-fb">已结课</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批21}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答15}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
				</div>

				<div class="jx-list one-tabc clearfix hidden mt-10">
					<div class="one-jx">
						<div class="title">
							<h3>二年级语文</h3>
							<p>异步课程+一键式备课</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx">
						<div class="title">
							<h3>一年级语文</h3>
							<p>异步课程+一键式备课</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx last">
						<div class="title">
							<h3>一年级语文</h3>
							<p>直播课程+一键式备课</p>
							<span class="state-tip hd-fb">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
				</div>

				<div class="jx-list one-tabc clearfix hidden mt-10">
					<div class="one-jx">
						<div class="title">
							<h3>三年级语文</h3>
							<p>异步课程+一键式备课</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx">
						<div class="title">
							<h3>一年级语文</h3>
							<p>异步课程+一键式备课</p>
							<span class="state-tip">教学中</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
					<div class="one-jx last">
						<div class="title">
							<h3>一年级语文</h3>
							<p>直播课程+一键式备课</p>
							<span class="state-tip hd-fb">已结课</span>
						</div>
						<ul class="clearfix">
							<li ><strong>教学准备</strong><a href="xiugaikecheng-kaishibeike.html">开始准备</a></li>
							<li><strong>课堂教学</strong><a href="kechengliebiao.html">进入课堂</a></li>
							<li><strong>课堂教学</strong><a href="taolunqu.html">查看讨论</a></li>
							<li><strong>作业批阅</strong><span class="tip">{未批50}</span><a href="zuoyequ.html">开始批阅</a></li>
							<li><strong>学生答疑</strong><span class="tip">{未答50}</span><a href="dayiqu.html">进入答疑</a></li>
						</ul>
					</div>
				</div>
				--%>
			</div>
		</div>

		<!-- 我的学习 -->
		<div class="my-xxi mt-10">
			<div class="title-bar clearfix">
				<h2>我的学习</h2>
			</div>
			<div class="sub-tab">
				<ul class="clearfix">
					<li class="cur"><a href="javascript:;">我的课程</a></li>
					<li><a href="javascript:;">我的笔记</a></li>
					<li><a href="javascript:;">我的问答</a></li>
				</ul>
			</div>
			<div class="tab-content clearfix">
				<div class="xxi-list one-tabc clearfix mt-10">					
					<div class="one-xxi">
						<div class="pic"><img src="<%=style%>/images/jypj.jpg" alt="" /></div>
						<h3><center>教育评价</center></h3>
						<div class="progress-bar">
							<div class="cur-bar" style="width:90%"></div>
						</div>
						<div class="btn">
							<a href="#"><input type="button" value="继续学习" class="wlkc-98" /></a>
						</div>						
					</div>
					<div class="one-xxi">
						<div class="pic"><img src="<%=style%>/images/fzxlx.jpg" alt="" /></div>
						<h3><center>发展心理学</center></h3>
						<div class="progress-bar">
							<div class="cur-bar" style="width:20%"></div>
						</div>
						<div class="btn">
							<a href="#"><input type="button" value="继续学习" class="wlkc-98" /></a>
						</div>						
					</div>
					<div class="one-xxi last">
						<div class="pic"><img src="<%=style%>/images/jtjyx.jpg" alt="" /></div>
						<h3><center>家庭教育学</center></h3>
						<div class="progress-bar">
							<div class="cur-bar" style="width:50%"></div>
						</div>
						<div class="btn">
							<a href="#"><input type="button" value="继续学习" class="wlkc-98" /></a>
						</div>						
					</div>					
				</div>
				<div class="bj-list one-tabc clearfix hidden mt-10">
					<div class="one-bj clearfix">
						<div class="pic"><img src="<%=style%>/images/jyxlx.jpg" alt="" /></div>
						<div class="info">
							<h3>教育心理学的发展历程</h3>
							<p>发表于 <a href="#" class="blk">《教育心理学》</a>最后更新 2015/04/23 12:30</p>
							<a href="#" class="seemore blk">查看笔记</a>
						</div>
					</div>
					<div class="one-bj clearfix">
						<div class="pic"><img src="<%=style%>/images/jyxlx.jpg" alt="" /></div>
						<div class="info">
							<h3>在教学过程中集中学生的注意力</h3>
							<p>发表于 <a href="#" class="blk">《教育心理学》</a> 最后更新 2015/04/23 12:30</p>
							<a href="#" class="seemore blk">查看笔记</a>
						</div>
					</div>
					<div class="one-bj clearfix">
						<div class="pic"><img src="<%=style%>/images/xdjyjs.jpg" alt="" /></div>
						<div class="info">
							<h3>教师要主动适应现代教育的要求</h3>
							<p>发表于 <a href="#" class="blk">《信息技术与课程整合》</a>最后更新 2015/03/23 12:30</p>
							<a href="#" class="seemore blk">查看笔记</a>
						</div>
					</div>
					<div class="one-bj clearfix">
						<div class="pic"><img src="<%=style%>/images/xdjyjs.jpg" alt="" /></div>
						<div class="info">
							<h3>进一步提高教师对课堂的掌控能力</h3>
							<p>发表于 <a href="#" class="blk">《信息技术与课程整合》</a>最后更新 2015/03/23 12:30</p>
							<a href="#" class="seemore blk">查看笔记</a>
						</div>
					</div>
				</div>
				<div class="wd-list one-tabc clearfix hidden mt-10">
					<div class="one-wd clearfix">
						<h3><a href="#">教育心理学的发展历程是什么？</a></h3>
						<p>发表于 <a href="#" class="blk">《教育心理学》</a>  最后回复 <a href="#" class="blk">陈哲老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">6</a>
					</div>
					<div class="one-wd clearfix">
						<h3><a href="#">怎样在教学过程中集中学生的注意力?</a></h3>
						<p>发表于 <a href="#" class="blk">《教育心理学》</a>  最后回复 <a href="#" class="blk">张平老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">4</a>
					</div>
					<div class="one-wd clearfix">
						<h3><a href="#">教师不能主动适应现代教育的要求怎么办？</a></h3>
						<p>发表于 <a href="#" class="blk">《信息技术与课程整合》</a>  最后回复 <a href="#" class="blk">陈哲老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">4</a>
					</div>
					<div class="one-wd clearfix">
						<h3><a href="#">如何进一步提高教师对课堂的掌控能力？</a></h3>
						<p>发表于 <a href="#" class="blk">《信息技术与课程整合》</a>  最后回复 <a href="#" class="blk">张平老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">3</a>
					</div>
					<div class="one-wd clearfix">
						<h3><a href="#">信息化教育与教育信息化的区别与联系。</a></h3>
						<p>发表于 <a href="#" class="blk">《现代教育技术》</a>  最后回复 <a href="#" class="blk">张平老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">2</a>
					</div>
					<div class="one-wd clearfix">
						<h3><a href="#">信息化教育的理论基础是什么？</a></h3>
						<p>发表于 <a href="#" class="blk">《现代教育技术》</a>  最后回复 <a href="#" class="blk">陈哲老师</a> 2015-4-12 11:41</p>
						<a href="wodeyanxiu.html" class="hf-num blk">4</a>
					</div>
				</div>

			</div>
		</div>

		<!-- 热门推荐 -->
		<div class="rmtj-box mt-30">

			<div class="title-bar clearfix">
				<h2>热门推荐</h2>
			</div>
			<div class="sub-tab">
				<ul class="clearfix">
					<li class="cur"><a href="javascript:;">课程推荐</a></li>
					<li><a href="javascript:;">资源推荐</a></li>
					<li><a href="javascript:;">热门订阅</a></li>
				</ul>
			</div>	
			<div class="tab-content clearfix">
				<div class="the-list one-tabc mt-10">
					<ul class="clearfix">
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/jxl.jpg" alt="" /></a></div>
							<span class="tip"></span>
							<p><center>教学论</center></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/jxxtl.jpg" alt="" /></a></div>
							<p><center>教学系统设计</cen></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/jypj.jpg" alt="" /></a></div>
							<p><center>教学评价</cen></p>
							
						</li>
						<li class="last">
							<div class="pic"><a href="#"><img src="<%= style %>/images/jyxlx_1.jpg" alt="" /></a></div>
							<p><center>教育心理学</cen></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style%>/images/jyyjff.jpg" alt="" /></a></div>
							<p><center>教育研究方法</cen></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/jyzx.jpg" alt="" /></a></div>
							<p><center>教育哲学</cen></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/ptxlx.jpg" alt="" /></a></div>
							<p><center>普通心理学</center></p>
							
						</li>
						<li class="last">
							<div class="pic"><a href="#"><img src="<%= style %>/images/rzxlx.jpg" alt="" /></a></div>
							<p><center>认知心理学</center></p>							
						</li>
					</ul>
				</div>
				<div class="the-list one-tabc hidden mt-10">
					<ul class="zy-list clearfix">
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/type-zy-1.gif" alt="" /></a></div>
							<p><a href="#"><center>如何上好一门课</center></a></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%= style %>/images/type-zy-2.gif" alt="" /></a></div>
							<p><center>三角形的知识资源包</center></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-3.gif" alt="" /></a></div>
							<p><center>二年级语文优秀作文</center></p>
							
						</li>
						<li class="last">
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-4.gif" alt="" /></a></div>
							<p><center>认识古筝</center></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-1.gif" alt="" /></a></div>
							<p><center>小学教师应该注意的问题</center></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-2.gif" alt="" /></a></div>
							<p><center>小班教学的注意事项</center></p>
							
						</li>
						<li>
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-3.gif" alt="" /></a></div>
							<p><center>如何和学生沟通</center></p>
							
						</li>
						<li class="last">
							<div class="pic"><a href="#"><img src="<%=style%>/images/type-zy-4.gif" alt="" /></a></div>
							<p><center>教学设计怎么做</center></p>
							
						</li>
					</ul>
				</div>
				<div class="dy-list one-tabc hidden mt-10">
					<ul class="clearfix">
						<li>
							<a href="#" class="to-dy"><img src="<%=style%>/images/btn-dy.gif" alt="" /></a>
							<div class="title clearfix">
								<a href="#" class="fl pic"><img src="<%=style%>/images/use-df-pic-1.gif" alt="" /></a>
								<div class="fr info">
									<h3>二年级人教版音乐</h3>
									<p><a href="#" class="blk">3421</a> 人订阅</p>
								</div>
							</div>
							<div class="txt">
								包含二年级人教版音乐的教学资源和学习资源，是老师备课、提升自己教学水平很好的选择。
							</div>
						</li>
						<li>
							<a href="#" class="to-dy"><img src="<%=style%>/images/btn-dy.gif" alt="" /></a>
							<div class="title clearfix">
								<a href="#" class="fl pic"><img src="<%=style%>/images/use-df-pic-2.gif" alt="" /></a>
								<div class="fr info">
									<h3>三年级人教版音乐</h3>
									<p><a href="#" class="blk">4351</a> 人订阅</p>
								</div>
							</div>
							<div class="txt">
								包含三年级人教版音乐的思维严谨的教学设计，生动形象的教学资源，是老师备课、提升自己教学水平很好的选择。
							</div>
						</li>
						<li>
							<a href="#" class="to-dy"><img src="<%=style%>/images/btn-dy.gif" alt="" /></a>
							<div class="title clearfix">
								<a href="#" class="fl pic"><img src="<%=style%>/images/use-df-pic-3.gif" alt="" /></a>
								<div class="fr info">
									<h3>一年级人教版英语</h3>
									<p><a href="#" class="blk">2345</a> 人订阅</p>
								</div>
							</div>
							<div class="txt">
								包含一年级人教版英语的教学设计、类型丰富的教学资源，以及提升学生学习英语的兴趣，为以后的英语学习打下良好的基础。
							</div>
						</li>
						<li>
							<a href="#" class="to-dy"><img src="<%=style%>/images/btn-dy.gif" alt="" /></a>
							<div class="title clearfix">
								<a href="#" class="fl pic"><img src="<%=style%>/images/use-df-pic-4.gif" alt="" /></a>
								<div class="fr info">
									<h3>二年级人教版数学</h3>
									<p><a href="#" class="blk">1235</a> 人订阅</p>
								</div>
							</div>
							<div class="txt">
								包含三年级人教版数学的思维严谨的教学设计，生动形象的教学资源，是老师备课、提升自己教学水平很好的选择。
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<div class="fr w-230">
		
		<!-- 教师个人 -->
		<div class="tech-user mt-20">
			<div class="pic"><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ"><img src="http://118.26.134.24${TouXiang}" alt="" /></a></div>
			<div class="name mt-10"><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ">${YONGHUXM}</a></div>
			<div class="sc-info">${schoolName}</div>
			<div class="user-num clearfix">
				<div class="fd-num fl">
				<%
				GetHaoYouLB haoyou=new GetHaoYouLB();
				List<List> list=new ArrayList<List>();
				list=haoyou.getHaoYou(uid,key);
				%>
					<a href="<%=path %>/platform/qiantai/teacher/wodehaoyou.jsp" class="blk"><%=list.size() %></a> <br />
					我的好友
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">6</a> <br />
					我的工作室
				</div>
			</div>
		</div>
		
		<!-- 平台动态 -->
		<div class="pt-gg mt-20">
			<div class="side-title clearfix">
				<h3>教师动态</h3>
				<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_GongGaoLB" class="more-link blk">更多》</a>
			</div>
			<ul class="">
				<c:if test="${msgCode==1}">
					 <% for(int k=0;k<TZGGlist.size();k++){
				      	 Map<String,Object> maps=TZGGlist.get(k);
			      		  %>
						<li>
							<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LSGongGaoXQ&cs_BianHao=<%=maps.get("id")%>">【<b><%=maps.get("type")%></b>】<%=maps.get("title")%></a>
						</li>
					 <%} %>
				</c:if>
					
			</ul>
		</div>

		<!-- 我的应用 -->
		<div class="my-app mt-20">
			<div class="side-title clearfix">
				<h3>我的应用</h3>
				<a href="<%=path %>/platform/qiantai/teacher/yingyongzhongxinshouye.jsp" class="more-link blk">更多》</a>
			</div>
			<ul class="the-list clearfix">
				<li>
					<a href="http://www.zhiliaoshu.com.cn/download.html" target="_blank" class="pic"><img src="<%=style%>/images/app-pic2.png" alt="" /></a>
					<div class="info">
						<a href="http://www.zhiliaoshu.com.cn/download.html" target="_blank">知了树</a>
						<p title="普泰移动知了树是新一代信息化教育解决方案，为家长、学生、老师等提供集学习、资源、安全、通信于一体的教育信息化服务产品。普泰移动知了树包括网络空间构建平台、多套核心应用平台（资源管理、教学管理、校园安全、学习园地等）、基础支撑平台、公用服务组件（APP）、职能终端产品。">普泰移动知了树是新一代信息化教育解决方案...</p>
					</div>
				</li>
			</ul>
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
//按科目查询
function queryCourseByKeMu(km) {
	$(this)._submit('<%=path%>/servlet/jspcontrolservlet?_qam_command=DHZT_ChaXun&_qam_dialog=GNDH_JiaoXueKJ&cs_KeMu=' + km);
}

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
		$(this)._submit('<%=path%>/servlet/jspcontrolservlet?_qam_command=MLKZ_TianJiaKC&_qam_dialog=GNDH_JiaoXueKJ&_dialog_submit_=GNDH_JiaoXueKJ');
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
		url:'<%=path%>/servlet/AjaxServlet',
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
