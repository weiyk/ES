<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String schoolName=(String) session.getAttribute("schoolName");
String yonghuxm =(String)session.getAttribute("YONGHUXM");
String style=request.getContextPath()+"/style";
String path=request.getContextPath();
String className=(String) session.getAttribute("className");
String yonghubh=(String) session.getAttribute("XiTongHYBH");
String imgUrl=(String)request.getSession().getAttribute("imgUrl");
String image=(String)request.getSession().getAttribute("Image");
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>一起学</title>
	<meta name="Keywords" content=""/>
	<meta name="Description" content=""/>
	<link href="<%=style %>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style %>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style %>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style %>/js/base.js"></script>
</head>

<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ&" class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
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

		<div class="title-bar green-title cyc-title clearfix">
			<h2 class="fl">课程学习动态</h2>
            <a href="#" class="more-link">更多>></a>
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


                <div class="message-list">
                    <ul class="clearfix">
                        <li>
                        <span class="word-black">你的同学李丽在第一课《秋天的图画》的课后讨论中回复了你</span>
                        <a class="word-green" href="<%=path %>/platform/qiantai/student/jinruketang.jsp">现在去看</a>
                        </li>
                        <li>
                         <span class="word-black">宋老师提出了第一课《秋天的图画》的课后题讨论</span>
                        <a class="word-green" href="<%=path %>/platform/qiantai/student/jinruketang.jsp">参加讨论</a>
                        <li>
                         <span class="word-black">你的同学张明在第一课《秋天的图画》提出了问题</span>
                        <a class="word-green" href="<%=path %>/platform/qiantai/student/jinruketang.jsp">去帮忙</a>
                        </li>
                        </li>
                        <li>
                        <span class="word-black">你的同学王磊在第一课《秋天的图画》提出了问题</span>
                        <a class="word-green" href="<%=path %>/platform/qiantai/student/jinruketang.jsp">去帮忙</a>
                        </li>
                        <li>
                        <span class="word-black">宋老师在第一课《秋天的图画》的课后拓展资源中发起了讨论</span>
                        <a class="word-green"  href="<%=path %>/platform/qiantai/student/jinruketang.jsp">参加讨论</a>
                        </li>
                        <li>
                        <span class="word-black">你的同学王扬在第一课《秋天的图画》的课后讨论中回复了你</span>
                        <a class="word-green"  href="<%=path %>/platform/qiantai/student/jinruketang.jsp">现在去看</a>
                        </li>
                        <li>
                        <span class="word-black">你的同学张明在第一课《秋天的图画》提出了问题</span>
                        <a class="word-green"  href="<%=path %>/platform/qiantai/student/jinruketang.jsp">去帮忙</a>
                        </li>
                        <li>
                        <span class="word-black">宋老师在第一课《秋天的图画》上传了课后拓展资源</span>
                        <a class="word-green"  href="<%=path %>/platform/qiantai/student/jinruketang.jsp">现在去看</a>
                        </li>
                        <li>
                        <span class="word-black">你的同学杨洋在第一课《秋天的图画》的课后讨论中回复了你</span>
                        <a class="word-green"  href="<%=path %>/platform/qiantai/student/jinruketang.jsp">现在去看</a>
                        </li>
                    </ul>
               </div>


	<!-- 学习小组动态 -->
		<div class="cur-test mt-20">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">学习小组动态</h2>
				<a href="<%=path %>/platform/qiantai/student/xuexixiaozu.jsp" class=" blk fr">更多>></a>
	
		   </div>

            <div class="my-studygroup mt-20">

                <div class="the-list mt-20">
	            <ul class="clearfix">
		            <li class="the-td">
			            <span class="cell-1">内容</span>
			            <span class="cell-2">小组名称</span>
			            <span class="cell-3">作者/时间</span>
                        <span class="cell-3">回复/查看</span>
                        <span class="cell-4">最后发表</span>
		            </li>
		            <li>
			            <span class="cell-1"><a href="#">美文阅读</a></span>
			            <span class="cell-2">语文阅读学习小组</span>
                        <span class="cell-3"><div>王丽丽</div><div>2015/04/25</div></span>
                        <span class="cell-4">510/792</span>
			            <span class="cell-5">2015/04/29</span>
		            </li>
		            <li>
			            <span class="cell-1"><a href="#">这样走向成功之路</a></span>
			            <span class="cell-2">语文阅读学习小组</span>
                        <span class="cell-3"><div>李阳</div><div>2015/04/20</div></span>
                        <span class="cell-4">254/392</span>
			            <span class="cell-5">2015/04/29</span>
		            </li>
		            <li>
			            <span class="cell-1"><a href="#">音标音频</a></span>
			            <span class="cell-2">英语发音学习小组</span>
                        <span class="cell-3"><div>李翔</div><div>2015/04/23</div></span>
                        <span class="cell-4">86/126</span>
			            <span class="cell-5">2015/04/28</span>
		            </li>
		            <li>
			            <span class="cell-1"><a href="#">巩固练习题</a></span>
			            <span class="cell-2">数学函数学习小组</span>
                        <span class="cell-3"><div>刘海</div><div>2015/04/26</div></span>
                        <span class="cell-4">56/105</span>
			            <span class="cell-5">2015/04/27</span>
		            </li>
		            <li>
			            <span class="cell-1"><a href="#">快速选择</a></span>
			            <span class="cell-2">数学选择题学习小组</span>
                        <span class="cell-3"><div>张明</div><div>2015/04/24</div></span>
                        <span class="cell-4">40/92</span>
			            <span class="cell-5">2015/04/26</span>
		            </li>
	            </ul>
            </div>
</div>
	   </div>



		</div>




	
	
    
    <div class="fr w-230 std-side">
    <!--请输入关键字查找小组 -->
        <div class="studygroup-search clearfix mt-20">
		    <label class="fl">请输入关键字查找小组</label>
		    <div class="fl txt-input"><input type="text" id="" value="输入文字" onclick="this.select()" /></div>
		    <span><input type="button" value="搜索" class="wlkc-fb-64"/></span>
		</div >
        <div class="hot-word-sg">
        <label >热门关键词： 阅读  英语  语文</label>
        </div>
		
     <!--我的学习小组 -->   
        <div class="my-study-group mt-20">
			<div class="side-title clearfix">
				<h3>我的学习小组</h3>
                <a href="#" class="more-link blk">更多>></a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
                	<li class="th-group">
						<a href="#" class="fl">小组名称</a>
						<span class="fr">人数</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-Chinese-reading.png" alt="" /></a>
                        <span class="rr">语文阅读学习小组</span>
						<span class="fr mm">25</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-math-function.png" alt="" /></a>
                        <span class="rr">数学函数学习小组</span>
						<span class="fr mm">25</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-English-fayin.png" alt="" /></a>
                        <span class="rr">英语发音学习小组</span>
						<span class="fr mm">18</span>
					</li>
				</ul>
			</div>
		</div>
    

       <!--可能感兴趣的小组 -->   
        <div class="my-study-group mt-20">
			<div class="side-title clearfix">
				<h3>可能感兴趣的小组</h3>
			</div>
			<div class="the-list">
				<ul class="clearfix">
                	<li class="th-group">
						<a href="#" class="fl">小组名称</a>
						<span class="fr">人数</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-English-reading.png" alt="" /></a>
                        <span class="rr">英语阅读学习小组</span>
						<span class="fr mm">23</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-English-judge.png" alt="" /></a>
                        <span class="rr">英语判断题学习小组</span>
						<span class="fr mm">25</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-math-apply.png" alt="" /></a>
                        <span class="rr">数学应用题学习小组</span>
						<span class="fr mm">16</span>
					</li>
                    					<li>
						<a><img src="<%=style %>/images/student/team-math-choose.png" alt="" /></a>
                        <span class="rr">数学选择题学习小组</span>
						<span class="fr mm">20</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-math-count.png" alt="" /></a>
                        <span class="rr">数学算术学习小组</span>
						<span class="fr mm">30</span>
					</li>
					<li>
						<a><img src="<%=style %>/images/student/team-Chinese-composition.png" alt="" /></a>
                        <span class="rr">语文作文学习小组</span>
						<span class="fr mm">21</span>
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
