<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/teacher";
//获取路径
String path=request.getContextPath()+"/servlet";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>教师工作室</title>
	<meta name="Keywords" content="">
	<meta name="Description" content="">
	<link href="style/base.css" rel="stylesheet" type="text/css" />
	<link href="style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="js/base.js"></script>
</head>
<body>

<!-- <div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="gerenzhongxin-jiaoshi.htm" class="user-name blk">余淼</a> 咸宁实验外国语小学
 <a href="index.html" class="to-quit">退出</a></p>
	</div>
</div>
 -->
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/desktop.html">首页</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_XueXiLHT"  class="cur">学习联合体</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YouXiuKT" >优秀课堂</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_MingShiGZS">名师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_TongZhiGG">通知公告</a></li>
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
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;教英语的、有名字的老师学习、工作的场所。这个场所在一个叫余淼的地方。这个含义如果不太好理解的话，就是因为“余淼”这个地方名人们不熟悉。其实这样的含义与什么叫“上城区教师进修学校”的解释是类似的。学习、工作：明其道不计其功！道天地之间也，其大无外，其小无内。天者，高之极也；地者，下之极也；日月者，明之极也；无穷者，广大之极也；圣人者，道之极也。数学是要不断问“为什么”的科学！这也是明其道。我们说话的基本句式是：“因为……，所以……。”“如果……，那么……。”“之所以……，是因为……。”正因为是要明其道，所以这里没有权威，谁都不代表真理！而且大家相信真理越辩越明！</span>
			</div>
		</div>

		<!-- 风采展示 -->
		<div class="fczs-show mt-10">
			<div class="title-bar clearfix">
				<h2 class="fl">风采展示</h2>
				
			</div>
			
		
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>重点推荐</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style %>/images/pic-4-2.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【重点推荐】<a href="#">&nbsp;与青年教师谈师德</a></span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/03</span>
							<p><span class="">【重点推荐】&nbsp;心静</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/03/03</span></p>
							<div class="user">
								<span class="">【重点推荐】&nbsp;关于练习设计的思考</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/03</span>
							</div>
							<div class="act">
								<span class="">【重点推荐】&nbsp;小学数学要加强“三基”教学</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/01</span>
							</div>
						</div>
					</li>
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>教学设计</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style %>/images/pic-4-4.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【教学设计】&nbsp;“用了多少钱”的教学过程</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/13</span>
							<p><span class="">【教学设计】&nbsp;你是怎样写分数的？</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/23</span></p>
							<div class="user">
								<span class="">【教学设计】&nbsp;每个人都把握好人生的度</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/25</span>
							</div>
							<div class="act">
								<span class="">【教学设计】&nbsp;与那片森林的再次相逢</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/05/03</span>
							</div>
						</div>
					</li>
					<li>
						<div class="title-bar-tjzd mt-20">
							<span>教育科研</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style %>/images/pic-7-6.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【教育科研】&nbsp;继续教育  教师心得</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/03</span>
							<p><span class="">【教育科研】&nbsp;教师的自我修炼</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/17</span></p>
							<div class="user">
								<span class="">【教育科研】&nbsp;小图大为---英语教学论文</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/05/23</span>
							</div>
							<div class="act">
								<span class="">【教育科研】&nbsp;张露科研课题成果报告</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/03</span>
							</div>
						</div>
					</li>
					<li>
					    <div class="title-bar-tjzd mt-20">
							<span>研修集萃</span>
							<a href="#" class=" blk fr">更多>></a>
						</div>
						<a href="#" class="pic fl"><img src="<%=style %>/images/pic-4.jpg" alt="" /></a>
						<div class="info fr">
							<span class="">【研修集萃】&nbsp;学习 收获 提升 成长</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/03/03</span>
							<p><span class="">【研修集萃】&nbsp;西博会上城英语名师专场</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/03</span></p>
							<div class="user">
								<span class="">【研修集萃】&nbsp;英语教育研究论文写作</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/11</span>
							</div>
							<div class="act">
								<span class="">【研修集萃】&nbsp;外语课堂教学的功能与评估</span><span class="xjy"></span><span class="sjtimesg">余淼&nbsp;&nbsp;&nbsp;2015/04/15</span>
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
			<div class="pic"><a href="#"><img src="<%=style %>/images/user-pic_t0001.gif" alt="" /></a></div>
			<div class="name mt-10">余淼</div>
			<div class="sc-info">咸安区外国语实验小学</div>
			<div class="user-num-jsgzs clearfix">
				<div class="fd-num fl">
					<a href="#" class="blk">100人</a> <br />
					成员人数
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">180个</a> <br />
					资源数
				</div>
			</div>
			<div class="user-num-jsgzs clearfix">
				<div class="fd-fbwz fl">
					<a href="#">申请加入</a>
				</div>
				<div class="std-woyx fl">
					<a href="#">加入收藏</a>
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
					<a href="#">柯桂球：2015/04/16  14:18评论了重点推荐：《与青年教师谈师德——简述我走过的路》</a>
				</li>
				<li>
					<a href="#">汤金涛：2015/04/12  09:18评论了重点推荐：《与青年教师谈师德——简述我走过的路》</a>
				</li>
				<li>
					<a href="#">吴微娟：2015/04/10  13:48评论了重点推荐：《与青年教师谈师德——简述我走过的路》</a>
				</li>
				<li>
					<a href="#">吴臻文：2015/04/06  09:18评论了重点推荐：《与青年教师谈师德——简述我走过的路》</a>
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
								<img src="<%=style %>/images/user-pic-t01.gif" alt="" />
								
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t02.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t03.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t04.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t05.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t6.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t7.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t8.gif" alt="" />
							</a>
						</li>
						<li>
							<a href="#">
								<img src="<%=style %>/images/user-pic-t9.gif" alt="" />
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="tech-std mt-20">
			<div class="side-title clearfix">
				<!-- <h3>热门工作室</h3> -->
			</div>
			
			<div class="tab-content clearfix">
				<div class="tech-list one-tabc clearfix mt-10">
					<!-- <ul class="clearfix">
						<li>
							<a href="#">
								<img src="images/user-pic-t01.gif" alt="" />
								朱海燕 <br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="images/user-pic-t02.gif" alt="" />
								黄新亮<br />教师工作室 
							</a>
						</li>
						<li>
							<a href="#">
								<img src="images/user-pic-t03.gif" alt="" />
								刘明珠<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="images/user-pic-t04.gif" alt="" />
								陈勇<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="images/user-pic-t05.gif" alt="" />
								余淼<br />教师工作室
							</a>
						</li>
						<li>
							<a href="#">
								<img src="images/user-pic-t6.gif" alt="" />
								章琴<br />教师工作室
							</a>
						</li>
					</ul> -->
				</div>
			</div>
		</div>

	</div>
	

</div>

<!-- 页尾 -->
<div class="footer">
	<div class="wrap clearfix">
		<div class="ft-txt fl">
			<p class="link"><a href="#">关于我们</a><a href="#">联系我们</a><a href="#">法律条款</a><a href="#">帮助中心</a><a href="#">意见反馈</a></p>
            <p class="copyright mt-10">版权所有：湖北省信息化与基础教育均衡发展协同创新中心</p>
            <p class="copyright mt-10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中邮世纪（北京）通信技术有限公司</p>
			<p class="sp-txt mt-10">技术支持：中邮世纪（北京）通信技术有限公司</p>
		</div>
		<div class="contact-txt fr">
			<h2>联系我们 <span>Contact Us</span></h2>
			<p>
				地址：湖北省武汉市洪山区珞喻路152号 <br />
				邮编：430070<br />
				电话：400-0910-601  <br />
				E-mail:shuzixuexiao@126.com	
			</p>
		</div>
	</div>
</div>
</body>
</html>