<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	//获取样式
	String style=request.getContextPath()+"/style";
	//获取路径
	String path=request.getContextPath();
	String schoolName=(String) session.getAttribute("schoolName");
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>测一测</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ"  class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>

<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian" class="cur">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe" >测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">

		<div class="title-bar green-title cyc-title clearfix">
			<h2 class="fl">练一练</h2>
			<a href="<%=path%>/platform/qiantai/student/yiqixue.jsp" class="btn-org fr">我要提问</a>
		</div>

		<!-- 科目切换 -->
		<div class="km-tab-bar mt-10 clearfix">
			<ul class="fl">
				<li class="cur"><a href="#">语文</a></li>
				<li><a href="#">数学</a></li>
				<li><a href="#">英语</a></li>
				<li><a href="#">物理</a></li>
				<li><a href="#">化学</a></li>
			</ul>
		</div>

		<!-- 测一测选择 -->
		<div class="test-choose mt-30">
			<p class="txt">每天坚持学30分钟，考试成绩可以挑战100分。</p>
			<div class="the-form mt-15 clearfix">
				<form method="post" action="">
					<label class="fl">教材选择</label>
					<div class="select-box select-b-nj fl">
						<input type="hidden" value="" class="the-val" />
						<div class="select-cover">
							<span class="df-val">一年级</span>
							<em class="icon"></em>
						</div>
						<ul class="clearfix hidden">
							<li><a href="javascript:;" rel="nj-1">一年级</a></li>
							<li><a href="javascript:;" rel="nj-2">二年级</a></li>
							<li><a href="javascript:;" rel="nj-3">三年级</a></li>
							<li><a href="javascript:;" rel="nj-4">四年级</a></li>
							<li><a href="javascript:;" rel="nj-5">五年级</a></li>
							<li><a href="javascript:;" rel="nj-6">六年级</a></li>
						</ul>
					</div>
					<div class="select-box select-b-sxc fl">
						<input type="hidden" value=""  class="the-val"/>
						<div class="select-cover">
							<span class="df-val">上册</span>
							<em class="icon"></em>
						</div>
						<ul class="clearfix hidden">
							<li><a href="javascript:;" rel="sxc-1">上册</a></li>
							<li><a href="javascript:;" rel="sxc-2">下册</a></li>
						</ul>
					</div>
					<div class="select-box select-b-dy fl">
						<input type="hidden" value=""  class="the-val" />
						<div class="select-cover">
							<span class="df-val">第一单元</span>
							<em class="icon"></em>
						</div>
						<ul class="clearfix hidden">
							<li><a href="javascript:;" rel="dy-1">第一单元</a></li>
							<li><a href="javascript:;" rel="dy-2">第二单元</a></li>
							<li><a href="javascript:;" rel="dy-3">第三单元</a></li>
						</ul>
					</div>
					<button type="submit" class="btn-sub btn-org fl">提交</button>
					
				</form>
			</div>
		</div>



		<!-- 当前测试 -->
		<div class="cur-test mt-20">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">当前测试</h2>
			</div>
			<div class="test-info clearfix mt-20">
				<div class="test-enter fl">
					<div class="pic fl"><img src="<%=path %>/style/images/pic-5-1.jpg" alt="" /></div>
					<div class="info fr">
						<p>
							<strong>第一单元：</strong>单元测试 <br />
							<strong>题　　数：</strong>25题<br />
							<strong>难　　度：</strong>低难度 <br />
							<strong>时　　间：</strong>30分钟 <br />
							<strong>总　　分：</strong>100分 
						</p>
						<div class="act-btn mt-15">
							<a href="#" class="btn-org">进入测试</a>
							<a href="#" class="btn-green mt-15">答案详情</a>
						</div>
					</div>
				</div>

				<div class="result-list fr">
					<div class="title clearfix">
						<h4 class="fl">成绩排行榜</h4>
						<p class="fr">测试<strong class="b1">5803</strong>人 最高<strong class="b2">100</strong>分</p>
					</div>
					<ul class="the-list clearfix mt-15">
						<li>
							<a class="pic" href="#"><img src="<%=path %>/style/images/user-pic-s1.gif" alt="" /></a>
							<span class="pm-tip num-1">冠军</span>
							<p>
								<a href="#">刘小军</a> <br />
								得分： <strong>100分</strong>
								<span class="time">03/29 04:35</span>
							</p>
						</li>
						<li>
							<a class="pic" href="#"><img src="<%=path %>/style/images/王诗婷.gif" alt="" /></a>
							<span class="pm-tip num-2">亚军</span>
							<p>
								<a href="#">王诗婷</a> <br />
								得分： <strong>100分</strong>
								<span class="time">04/12 06:26</span>
							</p>
						</li>
						<li>
							<a class="pic" href="#"><img src="<%=path %>/style/images/王文静.gif" alt="" /></a>
							<span class="pm-tip num-3">季军</span>
							<p>
								<a href="#">王文静</a> <br />
								得分： <strong>100分</strong>
								<span class="time">05/09 09:26</span>
							</p>
						</li>
					</ul>

				</div>
			
			</div>



		</div>
	</div>
	<div class="fr w-230 std-side">
		<!-- 测一测侧边栏 -->
		<div class="test-side-act clearfix mt-20">
			<a href="<%=path %>/platform/qiantai/student/ceyice.jsp" class="btn-oltest btn-org hover-a">在线练习</a>
			<a href="<%=path %>/platform/qiantai/student/canjiakaoshi.jsp" class="btn-exam btn-green hover-a mt-10">参加考试</a>
			<a href="<%=path %>/platform/qiantai/student/xueshengkongjian.jsp" class="btn-back hover-a mt-10">返回空间首页</a>
		</div>


	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />

</body>
</html>
