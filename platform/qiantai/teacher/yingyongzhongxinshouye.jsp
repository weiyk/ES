<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	//获取用户姓名
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	//获取学校名字
	String schoolName=(String) session.getAttribute("schoolName");
%>
<html>
<head>
	<title>应用中心首页</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM%></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX" class="cur">应用中心</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="bj-bn">
		<img src="<%=style%>/images/yingyongzx-pic.png" alt="" />
	</div>


	<div class="clearfix mt-20 ">
    <div class="search-boxzx">
    <div class="yyzx-label">搜索全部：</div>
	<div class="yyzx-seach-ip fl">
		<input type="text" value="请输入软件名称" id="" onclick="this.select()"/></div><button type="submit">搜索</button>
    </div>
		<div class="fl w-710">

			<div class="about-bj mt-30">
				<div class="title-bar  clearfix">
					<h2 class="fl">推荐应用</h2>
				</div>
			</div>

            <div class="zy-list">
            	<div class="the-list">
						<ul class="clearfix">
							
							<li>
								<div class="pic-tjyy fl"><a href="#"><img src="<%=style%>/images/yingyongtj-pic02.png" alt="" /></a></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">高效课堂</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：以云平台资源为依托，以手持移动终端和电化教室为载体，为小学至高校的教师和学生提供基于国家教学大纲和知识点为核心内容的教，学，师生互动的全流程教学应用平台。
										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="fl">12人收藏</a>
										<div class="alinks fr">
											<a href="#" class="blk ">备课授课</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic01.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">直播课堂</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：利用网络桥梁实现区域名师，一个教学点与多所中心校和多所师范学院组建同步课堂，以中心校优秀师资和湖北师范联盟为依托，帮助教学点开齐课开好课。
										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="fl">7人收藏</a>
										<div class="alinks fr">
											<a href="#" class="blk">备课授课</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic03.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">亲子桥</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：利用移动互联技术构建留守儿童与父母的亲子交流渠道建设内容：基于移动互联，云平台空间的家校沟通桥梁，实现亲子实时沟通，学习信息共享，安全信息推送。
										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="fl">10人收藏</a>
										<div class="alinks fr">
											<a href="#" class="blk ">即时通讯</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic04.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">iMovie</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：一款非常棒的短片制作软件，完全可以让一位小朋友自己去尝试做大片的感受，通过选择不同的片头模版，简单编辑之后，孩子们完全可以在短时间内创作出一出让人惊叹的影片。
										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="fl">12人收藏</a>
										<div class="alinks fr">
											<a href="#" class="blk ">学习应用</a>
										</div>
									</div>
								</div>
							</li>
			
						</ul>
					</div>
            </div>

			<div class="about-bj mt-30">
				<div class="title-bar  clearfix">
					<h2 class="fl">分类列表</h2>
                    <a href="#" class="fllb-gd-blue fl">最受欢迎</a><a href="#" class="fllb-gd fl">|&nbsp;用户评分</a><a href="#" class="fllb-gd fl">|&nbsp;更新时间</a>
				</div>
			</div>

            <div class="zy-list">
            	<div class="the-list">
						<ul class="clearfix">
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic05.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">Paper 53
</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介："一款经典的画画软件，可以让孩子们自由的涂鸦，绘出一片完全不同的世界。
"

										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="blk fl">35人收藏</a>
										<div class="alinks fr">
											<a href="#">学习应用</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic06.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">solar walk
</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：模拟整个太阳系以及部分系外星系，让孩子们可以在模拟中感知太阳系的结构。

										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="blk fl">22人收藏</a>
										<div class="alinks fr">
											<a href="#">备课授课</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic07.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">百度传课
</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：百度传课引入全国知名重点学校的一线教学名师，采取网络互动直播和点播的授课模式，突破地域和时间的限制，为广大的学生群体提供高效便捷的网络学习渠道，推出高质量的线上精品课程。

										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="blk fl">12人收藏</a>
										<div class="alinks fr">
											<a href="#">备课授课</a>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="pic-tjyy fl"><img src="<%=style%>/images/yingyongtj-pic08.png" alt="" /></div>
								<div class="fr info-tjyy">
									<div class="title-tjyy clearfix">
										<a href="#" class="fl">宝贝听听
</a>
									</div>
									<div class="txt-star clearfix">
										<div class="txt fl">
											简介：海量故事，精心挑选！陪伴孩子快乐成长！优质音源，专业播音员录制，倾心打造，只为出精品！丰富的电台信息，让孩子享受听故事的乐趣。


										</div>
										<div class="star-box fr" rel="3">
										<div class="yyzx"><a href="#">下载</a></div>
                                            <span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star star-on"></span>
											<span class="one-star"></span>
											<span class="one-star"></span>
										</div>
									</div>
									<div class="act clearfix">
										<a href="#" class="blk fl">10人收藏</a>
										<div class="alinks fr">
											<a href="#">学习应用</a>
										</div>
									</div>
								</div>
							</li>
			
						</ul>
					</div>
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

						到 <input type="text" id="Text1" class="jp-ip" /> 页	
						<button type="submit" class="to-sub">确定</button>
						
					</div>

        
        </div>

		<div class="fr w-230">

		<!-- 应用分类导航-->
		<div class="all-myclass mt-30">
			<div class="one-dynamic">
				<div class="all-curriculum">
					<h2>应用分类导航</h2>
				</div>
				<ul class="clearfix">
					<li>
						<span class="list-name culum-yyzx">备课授课</span>
					</li>
					<li>
						<span class="list-name culum-yyzx">互动课堂</span>
					</li>
					<li>
						<span class="list-name culum-yyzx">即时通讯</span>
					</li>
				</ul>
			</div>
		</div>

        <!-- 人气排行榜-->
			<div class="bj-member-rq ">
				<div class="side-title clearfix">
					<h3>人气排行榜</h3>
				</div>
				<div class="bj-m-list">
					<ul class="clearfix">
						<li>
							<div class="sort fl"><input type="button" value="1" class="wlkc-sort"/></div>
							<div class="sign fl">
                            <img src="<%=style%>/images/sign-pic.png"/>
							</div>
                            <div class="name-yy fl">
                            <p>书香中国</p>
                            <div class="fl mt-5"><span><img src="<%=style%>/images/smallstar-pic.png"/></span><div class="fr c-blue">3.2分</div></div>
                            </div>
						</li>
						<li>
							<div class="sort fl"><input type="button" value="2" class="wlkc-sort"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            易题库
                            </div>
						</li>
						<li>
							<div class="sort fl"><input type="button" value="3" class="wlkc-sort"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic1.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            翼点通
                            </div>
						</li>
						<li>
							<div class="sort fl"><a href="#"><input type="button" value="4" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic2.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            悟空识字
                            </div>
						</li>
						<li>
							<div class="sort fl"><a href="#"><input type="button" value="5" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic3.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            问他作业
                            </div>
						</li>
                        						<li>
							<div class="sort fl"><a href="#"><input type="button" value="6" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic4.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            人体探秘
                            </div>
						</li>
						<li>
							<div class="sort fl"><a href="#"><input type="button" value="7" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic5.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            看图猜成语
                            </div>
						</li>
                        						<li>
							<div class="sort fl"><input type="button" value="8" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic6.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            宝贝听听
                            </div>
						</li>
						<li>
							<div class="sort fl"><input type="button" value="9" class="wlkc-sort-g"/></div>
							<div class="sign-small fl">
                              <img src="<%=style%>/images/sign-s-pic7.png" alt="" />
							</div>
                            <div class="name-yy-small fl">
                            百度传课
                            </div>
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
