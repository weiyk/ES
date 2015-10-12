<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
//获取样式
String style=request.getContextPath()+"/style";
//获取路径
String path=request.getContextPath();
String yonghuxm =(String)session.getAttribute("YONGHUXM");
String schoolName=(String) session.getAttribute("schoolName");
	String className=(String) session.getAttribute("className");
	String yonghubh=(String) session.getAttribute("XiTongHYBH");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	String image=(String)request.getSession().getAttribute("Image");
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>进课堂</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ"  class="user-name blk"><%=yonghuxm %></a> <%=schoolName %><a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
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
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue" class="cur">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<!-- 科目切换 -->
		<div class="km-tab-bar clearfix">
			<ul class="fl">
				<li class="cur"><a href="#">语文</a></li>
				<li><a href="#">数学</a></li>
				<li><a href="#">英语</a></li>
				<li><a href="#">物理</a></li>
				<li><a href="#">化学</a></li>
			</ul>
		</div>

		<!-- 正在直播 -->
		<div class="at-live mt-20">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">正在直播</h2>
			</div>
			<div class="box-c mt-10">
				<div class="pic">
					<a href="<%=path %>/platform/qiantai/student/jinruketang.jsp?KeChengBH=KC20150804006&pagesize=1">
						<span class="cover"></span>
						<img   src="<%=style%>/images/student/jinketang-kc1.jpg" alt="" />
					</a>
				</div>
				<div class="info mt-20">
					<a href="<%=path %>/platform/qiantai/student/jinruketang.jsp?KeChengBH=KC20150804006&pagesize=1" class="enter-kt btn-org">进入课堂</a>
					<strong>课程名：</strong> 《小马过河》 <br />
					<strong>学校：</strong> 咸安区外国语实验小学<br />
					<strong>主讲人：</strong> 宋保华<br />
					<strong>课程简介：</strong> 课文借助小马过河这件事，说明遇事不能光听别人说，而要开动脑，具体分析，还要勇于实践，才能找到解决问题的办法。<br />
				</div>
			</div>
		</div>
		<!-- 我的课堂 -->
		<div class="my-kt mt-280">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">我的课堂</h2>
				<a href="#" class="fr blk">更多>></a>
			</div>
			<div class="the-list mt-15">
				<ul class="clearfix">
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-Chinese-qunian1.jpg" alt="" />
							<span>二年级语文《去年的树》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-math-two1.jpg" alt="" />
							<span>二年级数学《两个常见的数学关系》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-xinli-my1.jpg" alt="" />
							<span>二年级心理健康教育《我的好朋友》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-music.jpg" alt="" />
							<span>二年级音乐《“六一”的课》</span>
						</a>
					</li>
				</ul> 
			</div>

		</div>

		<!-- 我的课堂 -->
		<div class="my-kt mt-30">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">热门课堂</h2>
				<a href="#" class="fr blk">更多>></a>
			</div>
			<div class="the-list mt-15">
				<ul class="clearfix">
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-xinli-classmate2.jpg" alt="" />
							<span>二年级心理健康教育《同学眼中的我》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-English.jpg" alt="" />
							<span>二年级英语《Unit1 This is our teacher》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-math-paint2.jpg" alt="" />
							<span>二年级数学《画垂线》</span>
						</a>
					</li>
					<li>
						<a href="#">
							<img src="<%=style%>/images/student/kt-Chinese-my2.jpg" alt="" />
							<span>二年级语文《我喜欢的动物》</span>
						</a>
					</li>
				</ul> 
			</div>

		</div>

	</div>


	<div class="fr w-230 std-side">
		<!-- 学生个人 -->
		<div class="std-user mt-20">
			<div class="pic"><a href="<%=path %>/platform/qiantai/student/gerenzhongxin-xuesheng.jsp"><img src="<%=imgUrl+image %>" alt="" height="60px;"/></a></div>
			<div class="user-info clearfix">
				<div class="name"><%=yonghuxm %></div>
				<div class="sc-info">  <%=className %> <br />	<%=schoolName %></div>			
			</div>
			<ul class="user-act clearfix">
				<li><a href="#">学习小组</a></li>
				<li><a href="<%=path %>/platform/qiantai/student/wodehaoyoulb.jsp">我的好友</a></li>
				<li><a href="#">我的班级</a></li>
				<li><a href="#">通知消息（<strong>2</strong>）</a></li>
			</ul>
		</div>
		
		<div class="kcb-side mt-20">
			<div class="side-title clearfix">
				<h3>课程表</h3>
				<a href="#" class="more-link">完整课程表>></a>
			</div>
			<div class="sub-title">
				<h4><font color="#FF0000">今日直播</font></h4>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#">语文《小马过河》</a>
						<span class="time">08:00 - 08:40</span>
					</li>
					<li>
						<a href="#">美术《我的老师》</a>
						<span class="time">09:00 - 09:40</span>
					</li>
					<li>
						<a href="#">品德与生活《我的家乡》</a>
						<span class="time">10:00 - 10:40</span>
					</li>
					<li>
						<a href="#">数学《平均分》</a>
						<span class="time">14:00 - 14:40</span>
					</li>
					<li>
						<a href="#">音乐《有趣的声音世界》</a>
						<span class="time">15:00 - 15:40</span>
					</li>
				</ul>
			</div>
			<div class="sub-title">
				<h4><font color="#FF0000">明日预告</font></h4>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#">语文《植物妈妈有办法》</a>
						<span class="time">08:00 - 08:40</span>
					</li>
					<li>
						<a href="#">美术《流动的颜色》</a>
						<span class="time">09:00 - 09:40</span>
					</li>
					<li>
						<a href="#">品德与生活《美化家园》</a>
						<span class="time">10:00 - 10:40</span>
					</li>
					<li>
						<a href="#">数学《除法》</a>
						<span class="time">14:00 - 14:40</span>
					</li>
					<li>
						<a href="#">音乐《音乐中的动物》</a>
						<span class="time">15:00 - 15:40</span>
					</li>
				</ul>
			</div>
		</div>

	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>
