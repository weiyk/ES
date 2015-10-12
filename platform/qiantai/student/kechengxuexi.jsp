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
	<title>课程学习</title>
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
		<!-- 与我相关 -->
		<div class="aboutme-msg">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">与我相关</h2>
			</div>
			<div class="the-list mt-10">
				<ul class="clearfix">
					<li>
						<p><a href="#" class="glk">汪洋</a> 在 <a href="#" class="glk">语文作文其实没有那么难</a> 回复：拓展资源很丰富，非常不错，值得我们学习。</p>
					</li>
					<li>
						<p><a href="#" class="glk">杨洋</a> 在 <a href="#" class="glk">数学第1课《统计》拓展知识</a> 回复：讲解清晰。</p>
					</li>
					<li>
						<p><a href="#" class="glk">李琛</a> 在 <a href="#" class="glk">语文第1课《秋天的图画》教学视频</a> 回复：讲解详细，非常不错。</p>
					</li>
					<li>
						<p><a href="#" class="glk">刘鑫</a> 在 <a href="#" class="glk">语文第2课《看图写话》拓展知识</a> 回复：资源丰富，受益颇多。</p>
					</li>
					<li>
						<p><a href="#" class="glk">汪洋</a> 在 <a href="#" class="glk">语文第1课《秋天的图画》拓展知识</a> 回复：资源全面，适合课后学习。</p>
					</li>
					<li>
						<p><a href="#" class="glk">刘倩</a> 在 <a href="#" class="glk">语文第2课《看图写话》拓展知识</a> 回复：拓展资源很丰富，值得我们学习。</p>
					</li>
					<li>
						<p><a href="#" class="glk">张海</a> 在 <a href="#" class="glk">英语第2课《Colours》教学视频</a> 回复：视频清晰，讲解到位。</p>
					</li>
					<li>
						<p><a href="#" class="glk">江尚</a> 在 <a href="#" class="glk">语文第2课《看图写话》拓展知识</a> 回复：拓展资源很丰富，非常好。</p>
					</li>
				</ul>
			</div>
		</div>
		<!-- 学习动态 -->
		<div class="xx-dt mt-20">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">课程学习动态</h2>
				<a href="#" class="fr blk">更多》</a>
			</div>
			<div class="km-tab-bar clearfix mt-15">
				<ul class="fl">
					<li class="cur"><a href="#">全部</a></li>
					<li><a href="#">语文</a></li>
					<li><a href="#">数学</a></li>
					<li><a href="#">英语</a></li>
					<li><a href="#">物理</a></li>
					<li><a href="#">化学</a></li>
				</ul>
			</div>
			<div class="dt-list">
				<ul class="clearfix">
					<li class="th-li">
						<span class="cell-1">
							<a href="#" class="more">更多</a>
						</span>
						<span class="cell-2">作者</span>
						<span class="cell-3">回复/查看</span>
						<span class="cell-4">最后发表</span>
					</li>
					<li>
						<div class="cell-1">
							<a href="#">语文《秋天的图画》的课后拓展资源</a>
							<span class="dz-txt blk">置顶</span>
							<span class="dz-icon"></span>
						</div>
						<span class="cell-2">李阳</span>
						<span class="cell-3">26/365</span>
						<span class="cell-4">2015/04/28 19:24</span>
					</li>
					<li>
						<div class="cell-1">
							<a href="#">数学第1课《统计》课后题答案</a>
							<span class="dz-txt blk">置顶</span>
							<span class="dz-icon"></span>
						</div>
						<span class="cell-2">李琛</span>
						<span class="cell-3">20/324</span>
						<span class="cell-4">2015/04/25 18:29</span>
					</li>
					<li>
						<div class="cell-1">
							<a href="#">英语口语必备200句</a>
							<span class="dz-txt blk">置顶</span>
							<span class="dz-icon"></span>
						</div>
						<span class="cell-2">刘海</span>
						<span class="cell-3">25/256</span>
						<span class="cell-4">2015/04/18 15:40</span>
					</li>
					<li>
						<div class="cell-1">
							<a href="#">语文课后作文</a>
						</div>
						<span class="cell-2">王洋</span>
						<span class="cell-3">22/225</span>
						<span class="cell-4">2015/04/17 10:20</span>
					</li>
				</ul>
			</div>
			<div class="page-list green-pl clearfix">
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

			<div class="fb-msg mt-20">
				<div class="clearfix">
					<div class="select-box select-b-dy fl">
						<input type="hidden" value=""  class="the-val" />
						<div class="select-cover">
							<span class="df-val">请选择学习小组</span>
							<em class="icon"></em>
						</div>
						<ul class="clearfix hidden">
							<li><a href="javascript:;" rel="dy-1">第一单元</a></li>
							<li><a href="javascript:;" rel="dy-2">第二单元</a></li>
							<li><a href="javascript:;" rel="dy-3">第三单元</a></li>
						</ul>
					</div>
					<input type="text" class="txt-ip fr" value="可输入80个字" id="" />
				</div>
				<div class="fb-area mt-10">
					<div class=""><img src="images/fb-act.gif" alt="" /></div>
					<textarea id="" rows="" cols="">写下您想说的话...</textarea>
				</div>
				<div class="act mt-20">
                    <input type="button" value="发表" class="wlkc-98" />
				</div>
			</div>
		</div>
	</div>


	<div class="fr w-230 std-side">

		<!-- 我的帖子 -->
		<div class="my-tz mt-20">
			<div class="side-title clearfix">
				<h3>我的帖子</h3>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#" class="glk">从语文《秋天的图画》中，我学到一些写作技巧，希望大家批评指正...</a>
						<p>2015/04/28</p>	
					</li>
					<li>
						<a href="#" class="glk">数学《统计》课后练习题的多种解答方法，供大家一起学习...</a>
						<p>2015/04/23</p>	
					</li>
					<li>
						<a href="#" class="glk">语文《看图写话》课前预习，每首诗作者用了什么表现手法展现...</a>
						<p>2015/04/20</p>	
					</li>
					<li>
						<a href="#" class="glk">英语《colours》课后练习题有一些不懂之处，请大家帮忙解答...</a>
						<p>2015/04/16</p>	
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
