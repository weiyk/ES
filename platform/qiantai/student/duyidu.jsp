<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
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
	<title>读一读</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<style>
	.index_btn2{
	width:224px;height:70px;background:#ff9000;display: block;color: #fff;line-height: 70px;text-decoration:none;text-align: center;margin-top: 35px;font-size: 20px;}
	.round2 {
    border-radius: 35px;
    -moz-border-radius: 35px;
    -webkit-border-radius: 35px;
}
.index_btn2 img{position: relative;top: 13px;width:34px;height:40px;}
	</style>
	<script type="text/javascript">
		function pop(){
			$('.pop-box-1').removeClass('hidden');
		}
	</script>
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
			<a href="http://www.zhiliaoshu.com.cn/download.html" target="_black">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu" class="cur">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">

		<!-- 读一读 -->
		<div class="reader-box">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">正在读</h2>
				<a href="http://www.zhiliaoshu.com.cn/download.html" target="_black" target="_black" class="glk fr">更多</a>
			</div>
			<div class="read-list mt-20 myread-list">
				<ul class="clearfix">
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-1.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="#" onclick="pop()" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="#" onclick="pop()">成语故事精选</a></h4>
						<p>
							中国少年儿童出版社  鲁迅
							<br />
							<span class="jd">已读95%</span>
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-2.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="#" onclick="pop()" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="#" onclick="pop()">鲁兵孙漂流记</a></h4>
						<p>
							汕头大学出版社  杨旭
							<br />
							<span class="jd">已读75%</span>
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-3.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="#" onclick="pop()" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="#" onclick="pop()">钢铁是怎样炼成的</a></h4>
						<p>
							北京日知图书  笛福
							<br />
							<span class="jd">已读45%</span>
						</p>
					</li>
					<li class="last">
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-4.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="#" onclick="pop()" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="#" onclick="pop()">小王子</a></h4>
						<p>
							少儿出版社  马振聘
							<br />
							<span class="jd">已读25%</span>
						</p>
					</li>
				</ul>
				<p class="all-read">
					<a href="#" onclick="pop()">共有10本书在读</a>
				</p>
			</div>
			<div class="title-bar green-title clearfix mt-30">
				<h2 class="fl">精品推荐</h2>
				<a href="#" onclick="pop()" class="glk fr">更多</a>
			</div>
			<div class="jpbook-list mt-20">
				<ul class="clearfix">
					<li>
						<a href="#" onclick="pop()" class="pic fl">
							<img src="<%=path %>/style/images/jp-book.jpg" alt="" />
						</a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()">《西游记》</a></h4>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;《西游记》是中国古典四大名著之一，是由明代小说家吴承恩所创作的中国古代第一部浪漫主义的长篇神魔小说。</p>
							<a href="#" onclick="pop()" class="btn-org">开始阅读</a>
						</div>
					</li>
					<li>
						<a href="#" onclick="pop()" class="pic fl">
							<img src="<%=path %>/style/images/jp-book-1.jpg" alt="" />
						</a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()">《三国演义》</a></h4>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;《三国演义》是中国第一部长篇章回体历史演义小说。描写了从东汉末年到西晋初年之间近100年的历史风云。</p>
							<a href="#" onclick="pop()" class="btn-org">开始阅读</a>
						</div>
					</li>
					<li>
						<a href="#" onclick="pop()" class="pic fl">
							<img src="<%=path %>/style/images/jp-book-2.jpg" alt="" />
						</a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()">《叶圣陶童话》</a></h4>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;世界上有一粒种子，像核桃那样大，绿色的外皮非常可爱。凡是看见它的人，没一个不喜欢它。</p>
							<a href="#" onclick="pop()" class="btn-org">开始阅读</a>
						</div>
					</li>
					<li>
						<a href="#" onclick="pop()" class="pic fl">
							<img src="<%=path %>/style/images/jp-book-3.jpg" alt="" />
						</a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()">《上下五千年》</a></h4>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;知识就像一块无敌大面包，让人肯之不尽，受用非凡。知识就像一块无敌大面包，让人肯之不尽，受用非凡。</p>
							<a href="#" onclick="pop()" class="btn-org">开始阅读</a>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>


	<div class="fr w-230 std-side">

		<!-- 名师选读 -->
		<div class="ms-book mt-20">
			<div class="side-title clearfix">
				<h3>名师选读</h3>
                <a href="#" onclick="pop()" class="more-link">更多>></a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#" onclick="pop()"><img src="<%=path %>/style/images/book-2-1.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()" class="glk">鲁宾孙漂流记</a></h4>
							<p>
								作者：杨旭 <br />
								出版社：汕头大学出版社
							</p>	
						</div>
					</li>
					<li>
						<a href="#" onclick="pop()" class="pic fl"><img src="<%=path %>/style/images/book-2.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()" class="glk">简爱</a></h4>
							<p>
								作者：夏洛蒂·勃朗特 <br />
								出版社：人民出版社
							</p>	
						</div>
					</li>
					<li>
						<a href="#" onclick="pop()" class="pic fl"><img src="<%=path %>/style/images/book-2-3.jpg" alt="" /></a>
						<div class="info fr">
							<h4><a href="#" onclick="pop()" class="glk">西游记</a></h4>
							<p>
								作者：吴承恩 <br />
								出版社：人民出版社
							</p>	
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- 大家都在看 -->
		<div class="allsee-book mt-20">
			<div class="side-title clearfix">
				<h3>我喜欢的</h3>
                <a href="http://www.zhiliaoshu.com.cn/download.html" target="_black" class="more-link">更多>></a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#" onclick="pop()" class="fl glk">《爱的教育》</a>
						<span class="fr">作者：卢坚 孟容</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《上下五千年》</a>
						<span class="fr">作者：曹余章</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《汤姆索娅历险记》</a>
						<span class="fr">作者：马克&#8226;吐温</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《三国演义》</a>
						<span class="fr">作者：罗贯中</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《小学科学知识故事》</a>
						<span class="fr">作者：曹文轩</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《钢铁是怎样炼成的》</a>
						<span class="fr">作者：笛福</span>
					</li>
				</ul>
			</div>
		</div>
        <div class="allsee-book mt-20">
			<div class="side-title clearfix">
				<h3>大家都在看</h3>
                <a href="http://www.zhiliaoshu.com.cn/download.html" target="_black" class="more-link">更多>></a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#" onclick="pop()" class="fl glk">《伊索寓言》</a>
						<span class="fr">作者：伊索</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《中国历史故事精选》</a>
						<span class="fr">作者：曹文轩</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《爱的教育》</a>
						<span class="fr">作者：卢坚 孟容</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《上下五千年》</a>
						<span class="fr">作者：曹余章</span>
					</li>
					<li>
						<a href="#" onclick="pop()" target="_black" class="fl glk">《汤姆索娅历险记》</a>
						<span class="fr">作者：马克&#8226;吐温</span>
					</li>
					<li>
						<a href="#" onclick="pop()" class="fl glk">《三国演义》</a>
						<span class="fr">作者：罗贯中</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	

</div>

<div class="pop-box-1 hidden">
	<div class="cover"></div>
	<div class="pop-content" style="width:340px;height:370px;left: 65%">
	<div class="title clearfix">
			<h2>知了树阅读移动端</h2>
			<span class="to-close"></span>
		</div>
	    	<div class="" align="center">
		         <div class="index_div2"> <a href="http://zhiliaoshu.com.cn/downloads/PTACJY_Ebook.apk" class="index_btn2 round2" style="background: #FF6E00;"> <img src="http://zhiliaoshu.com.cn/imagess/img2.png"> <span>Android下载</span> </a>
		           <p class="index_p1" style="color:#8F6D26">支持安卓4.0及以上系统</p>
		         </div>
		         <div class="img3"><img src="http://zhiliaoshu.com.cn/imagess/img3.png" style="max-width:44%;"></div>
		         <span style="font-size: 18px;">请扫描二维码下载APP</span>
		         <div style="height: 10px;"></div>
	       </div>
    </div>
</div>


<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>
