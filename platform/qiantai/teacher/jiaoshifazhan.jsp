<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String pathU=request.getContextPath();
	//获取用户姓名
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	//获取学校名字
	String schoolName=(String) session.getAttribute("schoolName");
%>
<html>
<head>
	<title>教师发展</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM%></a><%=schoolName %> 
 <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ" class="cur">教师发展</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<!-- 我学习的课程 -->
		<div class="mystd-kc">
			<div class="title-bar clearfix">
				<h2 class="fl">我学习的课程</h2>
				<a href="#" class=" blk fr">更多>></a>
			</div>
			<div class="the-list mt-20">
				<ul class="clearfix">
				 <li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like liked"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							班级管理
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-1.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							发展心理学
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-2.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							家庭教育学
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-3.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							教学论
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-4.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like liked"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							教学系统设计
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-5.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like  liked"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							教育评价
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-6.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like  liked"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							教育心理学
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
					<li>
						<div class="pic">
							<img src="<%=style%>/images/pic-7-7.jpg" alt="" />
							<div class="cover">
								<span class="jd">88%</span>
								<a href="#" class="to-like liked"></a>
								<div class="bg"></div>
							</div>
						</div>
						<div class="info">
							教育研究方法
						</div>
						<div class="act">
							<a href="#" class="btn-cs">继续学习</a>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<!-- 热门课程推荐 -->
		<div class="hotkc-tj mt-10">
			<div class="title-bar clearfix">
				<h2 class="fl">热门课程推荐</h2>
				<a href="#" class=" blk fr">更多>></a>
			</div>
		
			<div class="the-list">
				<ul class="clearfix">
				<li>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-3.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#">普通心理学</a></h4>
							<p>专业必修课，理论课</p>
							<div class="user">
								<a href="#" class="blk"><img src="<%=style%>/images/df-user-w.gif" alt="" /> 刘思耘</a>
							</div>
							<div class="act">
								<a href="#" class="btn-cs">开始学习</a>
							</div>
						</div>
					</li>
					
					<li>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-2.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#">认知心理学</a></h4>
							<p>专业必修课，理论基础课</p>
							<div class="user">
								<a href="#" class="blk"><img src="<%=style%>/images/df-user-w.gif" alt="" /> 刘思耘</a>
							</div>
							<div class="act">
								<a href="#" class="btn-cs">开始学习</a>
							</div>
						</div>
					</li>
					<li>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-1.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#">教育哲学</a></h4>
							<p>专业必修课</p>
							<div class="user">
								<a href="#" class="blk"><img src="<%=style%>/images/df-user-w.gif" alt="" /> 王坤庆</a>
							</div>
							<div class="act">
								<a href="#" class="btn-cs">开始学习</a>
							</div>
						</div>
					</li>
					<li>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-4.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#">现代教育技术</a></h4>
							<p>专业基础课，理论课</p>
							<div class="user">
								<a href="#" class="blk"><img src="<%=style%>/images/df-user-w.gif" alt="" /> 李文浩</a>
							</div>
							<div class="act">
								<a href="#" class="btn-cs">开始学习</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<!-- 研修社区 -->
		<div class="yxsq-box mt-30">
			<div class="title-bar clearfix">
				<h2 class="fl">研修社区</h2>
			</div>
			<div class="clearfix">
				<div class="fl yx-live">
					<div class="sub-title clearfix  mt-10">
						<h3 class="fl">研修现场</h3>
						<a href="#" class="fr blk">查看更多>></a>
					</div>
					<div class="the-list mt-10">
						<ul class="clearfix">
							<li>
								<a href="#">
									<img src="<%=style%>/images/pic-8-1.jpg" alt="" />
									学习心理学
								</a>
							</li>
							<li>
								<a href="#">
									<img src="<%=style%>/images/pic-8-2.jpg" alt="" />
									心理统计学
								</a>
							</li>
							<li>
								<a href="#">
									<img src="<%=style%>/images/pic-8-3.jpg" alt="" />
									信息管理学
								</a>
							</li>
							<li>
								<a href="#">
									<img src="<%=style%>/images/pic-8-4.jpg" alt="" />
									信息技术与课程整合
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="fr yx-sc">
					<div class="sub-title clearfix  mt-10">
						<h3 class="fl">研修资源</h3>
						<a href="#" class="fr blk">更多>></a>
					</div>
					<div class="sub-tab">
						<ul class="clearfix">
							<li class="cur"><a href="javascript:;">全部</a></li>
							<li><a href="javascript:;">语文</a></li>
							<li><a href="javascript:;">数学</a></li>
							<li><a href="javascript:;">英语</a></li>
							<li><a href="javascript:;">音乐</a></li>
							<li><a href="javascript:;">美术</a></li>
							<li><a href="javascript:;">生命安全</a></li>
							<li><a href="javascript:;">心理健康</a></li>
						</ul>
					</div>
					<div class="tab-content clearfix">
						<div class="sc-list one-tabc clearfix mt-10">
							<ul class="clearfix">
								<li>
									<span class="num num-hot">1</span>
									<a href="#">2014年省优质课分享2014年2014年省优质课...</a>
								</li>
								<li>
									<span class="num num-hot">2</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num num-hot">3</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">4</span>
									<a href="#">2014年省优质课分享2014年分享2014年...</a>
								</li>
								<li>
									<span class="num">5</span>
									<a href="#">2014年省优质课分享2014年分享204年...</a>
								</li>
								<li>
									<span class="num">6</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">7</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">8</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">9</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
							</ul>
						</div>
						<div class="sc-list one-tabc clearfix mt-10 hidden">
							<ul class="clearfix">
								<li>
									<span class="num num-hot">1</span>
									<a href="#">2015年省优质课分享2015年...</a>
								</li>
								<li>
									<span class="num num-hot">2</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num num-hot">3</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">4</span>
									<a href="#">2014年省优质课分享2014年分享2014年...</a>
								</li>
								<li>
									<span class="num">5</span>
									<a href="#">2014年省优质课分享2014年分享204年...</a>
								</li>
								<li>
									<span class="num">6</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">7</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">8</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
								<li>
									<span class="num">9</span>
									<a href="#">2014年省优质课分享2014年...</a>
								</li>
							</ul>
						</div>
					</div>

				</div>
			</div>

			
		</div>


	</div>


	<div class="fr w-230">
		
		<!-- 教师个人 -->
		<div class="tech-user mt-20">
			<div class="pic"><a href="<%=pathU %>/platform/qiantai/teacher/gerenzhongxin-jiaoshi.jsp"><img src="<%=style%>/images/user-pic-t007.gif" alt="" /></a></div>
			<div class="name mt-10">廖玖玖</div>
			<div class="sc-info">温泉二号桥小学</div>
			<div class="user-num clearfix">
				<!-- <div class="fd-num fl">
					<a href="#" class="blk">31</a> <br />
					我的好友
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">3</a> <br />
					我的工作室
				</div> -->
			</div>
            <div class="user-num-jsgzs clearfix">
            <div class="std-woyx" style="float:left;">
					<a href="<%=pathU %>/platform/qiantai/teacher/jiaoshigongzuoshi.jsp">我的工作室</a>
				</div>
				<div class="std-woyx" style="float:left;">
					<a href="#">我的研修</a>
				</div>
			</div>
		</div>
		
		<!-- 热门工作室 -->
		<div class="hot-std mt-20">
			<div class="side-title clearfix">
				<h3>热门工作室</h3>
			</div>
			<ul class="the-list clearfix">
				<li>
					<a href="#">朱海燕工作室</a>
					<span>1011</span>
				</li>
				<li>
					<a href="#">黄新亮工作室</a>
					<span>961</span>
				</li>
				<li>
					<a href="#">刘明珠工作室</a>
					<span>861</span>
				</li>
				<li>
					<a href="#">陈勇工作室</a>
					<span>781</span>
				</li>
				<li>
					<a href="#">余淼工作室</a>
					<span>750</span>
				</li>
				<li>
					<a href="#">章琴工作室</a>
					<span>700</span>
				</li>
				<li>
					<a href="#">高海鑫工作室</a>
					<span>491</span>
				</li>
			</ul>
		</div>

		<!-- 教师工作室 -->
		<div class="tech-std mt-20">
			<div class="side-title clearfix">
				<h3>教师工作室</h3>
               <a href="#" class="more-link blk">更多>></a>
			</div>
			<div class="sub-tab">
				<ul class="clearfix">
					<li class="cur"><a href="javascript:;">语文</a></li>
					<li><a href="javascript:;">数学</a></li>
					<li><a href="javascript:;">英语</a></li>
					<li><a href="javascript:;">音乐</a></li>
					<li><a href="javascript:;">美术</a></li>
					<li><a href="javascript:;">生命安全</a></li>
					<li><a href="javascript:;">心理健康</a></li>
				</ul>
			</div>
			<div class="tab-content clearfix">
				<div class="tech-list one-tabc clearfix mt-10">
					<ul class="clearfix">
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t01.gif" alt="" />
								朱海燕 <br />工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t02.gif" alt="" />
								黄新亮<br />工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t03.gif" alt="" />
								刘明珠<br />工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t04.gif" alt="" />
								陈勇<br />工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t05.gif" alt="" />
							余淼<br />工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t6.gif" alt="" />
								章琴<br />工作室
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>
