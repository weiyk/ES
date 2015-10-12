<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	//获取样式
	String style=request.getContextPath()+"/style";
	//获取路径
	String path=request.getContextPath();
	String schoolName=(String) session.getAttribute("schoolName");
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>学习小组</title>
	<meta name="Keywords" content=""/>
	<meta name="Description" content=""/>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>

<body>

<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ&"  class="user-name blk"><%=yonghuxm %></a> <%=schoolName %><a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
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
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian" >练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe" >测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
        

        <!-- 与我相关 -->
		<div class="title-bar green-title cyc-title clearfix">
			<h2 class="fl">与我相关</h2>
		</div>





                <div class="forme-list">
                    <ul class="clearfix">
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">语文阅读学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">汪洋</span>
                        <span class="word-black">在</span>
                        <span class="word-green">大家推荐一些好看的语文阅读课外书吧</span>
                        <span class="word-black">中回复了我： 老师...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">数学应用题学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">张明</span>
                        <span class="word-black">在</span>
                        <span class="word-green">大家推荐一些解题技巧</span>
                        <span class="word-black">中回复了我： 多做练习，多思考...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">数学函数学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">刘海</span>
                        <span class="word-black">在</span>
                        <span class="word-green">大家推荐一些练习题</span>
                        <span class="word-black">中回复了我： 我这有一些典型的练习题...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">语文阅读学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">李清清</span>
                        <span class="word-black">在</span>
                        <span class="word-green">给大家推荐一些优秀作文</span>
                        <span class="word-black">中回复了我： 我这有一些优秀作文...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">英语发音学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">李琛</span>
                        <span class="word-black">在</span>
                        <span class="word-green">给大家推荐一些音标练习</span>
                        <span class="word-black">中回复了我： 我这有标准音标的音频...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">语文阅读学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">李琛</span>
                        <span class="word-black">在</span>
                        <span class="word-green">关于课文课后作文练习</span>
                        <span class="word-black">中回复了我： 我有一些优秀作文案例...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">数学选择题学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">李好</span>
                        <span class="word-black">在</span>
                        <span class="word-green">一些函数的选择题解题技巧</span>
                        <span class="word-black">中回复了我： 我有一些典型的案例...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">语文朗读学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">王莎</span>
                        <span class="word-black">在</span>
                        <span class="word-green">一些经典诗篇朗读文章</span>
                        <span class="word-black">中回复了我： 我觉得朗读文章的时候...</span>
                        </div>
                        </li>
                        <li>
                        <div class="messagebox-pic"><img src="<%=style %>/images/messagebox.png" /></div>
                        <div class="word-text">
                        <span class="word-green">英语完形题学习小组</span>
						<span class="word-black">的</span>
						<span class="word-green">罗珊</span>
                        <span class="word-black">在</span>
                        <span class="word-green">完形填空的解题方法</span>
                        <span class="word-black">中回复了我： 我认为完形填空应该...</span>
                        </div>
                        </li>
                    </ul>
               </div>


	<!-- 讨论区  小组详情-->
		<div class="cur-test mt-20">
           <div class="discussion-area mt-10">
			    <div class="side-title clearfix">
				    <ul class="clearfix">
                     <li class="cur" ><a href="javascript:;">讨论区</a></li>
                     <!--<li><a href="javascript:;">小组详情</a></li>-->
                    </ul>

			    </div>
                 
                <div class="select-group clearfix">
                	   <label class="fl">话题</label>
					    <div class="select-box select-b-nj fl">
						<input type="hidden" value="" class="the-val" />
						<div class="select-cover">
							<span class="df-val">请选择学习小组</span>
							<em class="icon"></em>
						</div>
						<ul class="clearfix hidden">
							<li><a href="javascript:;" rel="nj-1">语文阅读小组</a></li>
							<li><a href="javascript:;" rel="nj-2">语文写作小组</a></li>
							<li><a href="javascript:;" rel="nj-3">英语小组</a></li>
							<li><a href="javascript:;" rel="nj-4">数学小组</a></li>
							<li><a href="javascript:;" rel="nj-5">化学小组</a></li>
							<li><a href="javascript:;" rel="nj-6">历史小组</a></li>
						</ul>
					</div>
                </div>
           
           </div>


	   </div>

     <!-- 小组详情-->
        <!--<div class="group-detail">
        <ul>
           <li class="out-line">
             <div class="groupdetail-f">
               <div class="list-left">
                  <div class="big-head"><img src="images/user-pic.gif" /></div>
                  <div class="hunpai-text">
                   <p class="p-title">语文阅读学习小组</p>
                   <div class="inner-div-xq">
                      <div class="small-head"><img src="images/smallheader.png" /></div>
                      <div class="p-text">
                          <p>李雨儿</p>
                          <p>小组管理员</p>
                      </div>
                   </div>
                  </div>
               
               </div>
               <div class="list-right">
                   <p>简介:</p><br/>
                   <span class="">语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组。</span>
               </div>
             
             </div>
             <div class="groupdetail-s">
             <ul>
                 <li class="li-text">成员</li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
             </ul>
             </div>
           </li>
           <li class="out-line">
             <div class="groupdetail-f">
               <div class="list-left">
                  <div class="big-head"><img src="images/user-pic.gif" /></div>
                  <div class="hunpai-text">
                   <p class="p-title">语文阅读学习小组</p>
                   <div class="inner-div-xq">
                      <div class="small-head"><img src="images/smallheader.png" /></div>
                      <div class="p-text">
                          <p>李雨儿</p>
                          <p>小组管理员</p>
                      </div>
                   </div>
                  </div>
               
               </div>
               <div class="list-right">
                   <p>简介:</p><br/>
                   <span class="">语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组。</span>
               </div>
             
             </div>
             <div class="groupdetail-s">
             <ul>
                 <li class="li-text">成员</li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
             </ul>
             </div>
           </li>

          <li class="out-line">
             <div class="groupdetail-f">
               <div class="list-left">
                  <div class="big-head"><img src="images/user-pic.gif" /></div>
                  <div class="hunpai-text">
                   <p class="p-title">语文阅读学习小组</p>
                   <div class="inner-div-xq">
                      <div class="small-head"><img src="images/smallheader.png" /></div>
                      <div class="p-text">
                          <p>李雨儿</p>
                          <p>小组管理员</p>
                      </div>
                   </div>
                  </div>
               
               </div>
               <div class="list-right">
                   <p>简介:</p><br/>
                   <span class="">语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组，语文阅读学习小组是以提高同学们阅读水平为目的小组。</span>
               </div>
             
             </div>
             <div class="groupdetail-s">
             <ul>
                 <li class="li-text">成员</li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
                 <li class="li-pic">
                 <p><img src="images/smallheader.png" /></p>
                 <p class="p-c">李依依</p>
                 </li>
             </ul>
             </div>
           </li>
        </ul>
        
        </div>-->
        
     <!-- 讨论区-->
        <div class="tlq-group">
        <div class="my-studygroup mt-20">

                <div class="the-list mt-20">
	            <ul class="">
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

       <div class="add-postion">
        
        </div>
        <!-- 翻页-->
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
				到 <input type="text" id="Text2" class="jp-ip" /> 页	
				<button type="submit" class="to-sub">确定</button>
			</div>

        <!-- 选择学习小组，写下想说的话-->
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
					<div class=""><img src="<%=style %>/images/fb-act.gif" alt="" /></div>
					<textarea id="" rows="" cols="">写下您想说的话...</textarea>
				</div>
				<div class="act mt-20">
					<button class="btn-cs">发表</button>
				</div>
			</div>

        </div>
	</div>

	
	
    
    <div class="fr w-230 std-side">
		
     <!--学习小组 -->   
        <div class="all-study-group mt-20">
			<div class="side-title clearfix">
				<h3>学习小组</h3>
                <a href="#" class="more-link blk">更多》</a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
                        <span class="fl mm">1</span>
						<a><img src="<%=style %>/images/student/team-Chinese-reading.png" alt="" /></a>
                        <span class="rr">语文阅读学习小组</span>
						
					</li>
					<li>
                        <span class="fl mm">2</span>
						<a><img src="<%=style %>/images/student/team-math-apply.png" alt="" /></a>
                        <span class="rr">数学应用题学习小组</span>
						
					</li>
					<li>
                        <span class="fl mm">3</span>
						<a><img src="<%=style %>/images/student/team-Chinese-composition.png" alt="" /></a>
                        <span class="rr">语文作文学习小组</span>
						
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
