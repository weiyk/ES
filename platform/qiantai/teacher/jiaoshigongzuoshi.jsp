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
	<title>教师工作室</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM%></a><%=schoolName %> <a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS" class="cur">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<!-- 工作室介绍 -->
		<div class="myteals-gzs">
			<div class="title-bar clearfix">
				<h2 class="fl">工作室介绍</h2>
			</div>
			<div class="the-list mt-10">
				<span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;读书、思考、交流；听道、思考、交流；实践、思考、交流。有计划的读书刊；有计划的做研究；有计划的作交流。这就是你的廖玖玖工作室！</span>
			</div>
		</div>

		<!-- 风采展示 -->
		<div class="fczs-show mt-10">
			<div class="title-bar clearfix">
				<h2 class="fl">热门课程推荐</h2>
				
			</div>
			
		
			<div class="the-list">
				<ul class="clearfix">
					
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>教学设计</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-2-fc03.jpg" alt="" /></a>
						<div class="info fr">
						<span class="">【教学设计】&nbsp;每个人都把握好人生的度</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/03</span>
							<p><span class="">【教学设计】&nbsp;教师的自我修炼</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/17</span></p>
							
							<div class="user">
								<span class="">【教学设计】&nbsp;继续教育  教师心得</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/25</span>
							</div>
							<div class="act">
								<span class="">【教学设计】&nbsp;与那片森林的再次相逢</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/05/03</span>
							</div>
						</div>
					</li>
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>教育科研</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-2-fc04.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【教育科研】&nbsp;“用了多少钱”的教学过程</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/13</span>
							<p><span class="">【教育科研】&nbsp;你是怎样写分数的？</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/23</span></p>
							<div class="user">
								<span class="">【教育科研】&nbsp;小图大为---英语教学论文</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/05/23</span>
							</div>
							<div class="act">
								<span class="">【教育科研】&nbsp;张露科研课题成果报告</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/03</span>
							</div>
						</div>
					</li>
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>重点推荐</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-2-fc02.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【重点推荐】<a href="#">&nbsp;与青年教师谈师德</a></span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/03</span>
							<p><span class="">【重点推荐】&nbsp;心静</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/03/03</span></p>
							<div class="user">
								<span class="">【重点推荐】&nbsp;关于练习设计的思考</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/03</span>
							</div>
							<div class="act">
								<span class="">【重点推荐】&nbsp;小学数学要加强“三基”教学</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/01</span>
							</div>
						</div>
					</li>
					<li>
					    <div class="title-bar-tjzd mt-20">
							<span>研修集萃</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style%>/images/pic-4-2-fc01.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【研修集萃】&nbsp;学习 收获 提升 成长</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/03/03</span>
							<p><span class="">【研修集萃】&nbsp;西博会上城英语名师专场</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/03</span></p>
							<div class="user">
								<span class="">【研修集萃】&nbsp;英语教育研究论文写作</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/11</span>
							</div>
							<div class="act">
								<span class="">【研修集萃】&nbsp;外语课堂教学的功能与评估</span><span class="xjy"></span><span class="sjtimesg">廖玖玖&nbsp;&nbsp;&nbsp;2015/04/15</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>

		


	</div>


	<div class="fr w-230">
		
		<!-- 教师个人 -->
		<div class="tech-user mt-20">
			<div class="pic"><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ"><img src="<%=style%>/images/user-pic-t007.gif" alt="" /></a></div>
			<div class="name mt-10">廖玖玖</div>
			<div class="sc-info">温泉二号桥小学</div>
			<div class="user-num-jsgzs clearfix">
				<div class="fd-num fl">
					<a href="#" class="blk">120人</a> <br />
					成员人数
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">818个</a> <br />
					资源数
				</div>
			</div>
			<div class="user-num-jsgzs clearfix">
				<div class="fd-fbwz fl">
					<a href="#">发表文章</a>
				</div>
				<div class="std-woyx fl">
					<a href="#">我的研修</a>
				</div>
			</div>
		</div>
		
		<!-- 热门工作室 -->
		<div class="hot-std mt-20">
			<div class="side-title clearfix">
				<h3>最新动态</h3>
			</div>
			<ul class="the-list clearfix">
				<li>
					<a href="#">柯桂球：2015/04/16  14:18评论了教学设计：《每个人都把握好人生的度》</a>
				</li>
				<li>
					<a href="#">chenguoxiang：2015/04/12  09:18评论了教学设计：《每个人都把握好人生的度》</a>
				</li>
				<li>
					<a href="#">吴微娟：2015/04/10  13:48评论了教学设计：《每个人都把握好人生的度》</a>
				</li>
				<li>
					<a href="#">吴臻文：2015/04/06  09:18评论了教学设计：《每个人都把握好人生的度》</a>
				</li>
			</ul>
		</div>

		<!-- 工作室成员 -->
		<div class="tech-std mt-20">
			<div class="side-title clearfix">
				<h3>工作室成员</h3>
			</div>
			
			<div class="tab-content clearfix">
				<div class="tech-list-gzs one-tabc clearfix mt-10">
					<ul class="clearfix">
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t01.gif" alt="" />
								
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t02.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t03.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t04.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t05.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t6.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t7.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t8.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t9.gif" alt="" />
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="tech-std mt-20">
			<div class="side-title clearfix">
				<h3>热门工作室</h3>
			</div>
			
			<div class="tab-content clearfix">
				<div class="tech-list one-tabc clearfix mt-10">
					<ul class="clearfix">
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t01.gif" alt="" />
								朱海燕 <br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t02.gif" alt="" />
								黄新亮<br />教师工作室 
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t03.gif" alt="" />
								刘明珠<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t04.gif" alt="" />
								陈勇<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t05.gif" alt="" />
								余淼<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style%>/images/user-pic-t6.gif" alt="" />
								章琴<br />教师工作室
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
