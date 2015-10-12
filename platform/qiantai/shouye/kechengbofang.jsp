<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//获取样式
String style=request.getContextPath()+"/platform/qiantai/shouye";
//获取路径
String path=request.getContextPath()+"/servlet";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>课程播放</title>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
</head>
<body>

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

<div class="wrap-kc clearfix">
    <div id="div_left" class="fl w-230">
        <div class="tech-user mt-10">
			<div class="kc-pic"><a href="#" class="kc-skls">授课老师</a><a href="#"><img class="kc-pic" src="<%=style%>/images/mhp/t1.gif" alt="" /></a></div>
			<div class="name mt-10">宋保华</div>
			<div class="sc-info">小学高级教师</div>
			<div class="user-num clearfix">
				1968年6月18日出生，大专学历，小学高级教师。所撰写的论文、优质课获区一等奖，多次组织学生参加省、市、区少儿书画比赛，均获得好的成绩。
			</div>
            <div class="kc-fb">
                <div class="fl txt-input">
                    <input type="text" onclick="this.select()" value=""/>
                </div>
                <input type="button" value="发表" class="wlkc-80 fb-btn" />
            </div>
            
		</div>

        <div class="my-coursedy-dy mt-120 ml-10">
			   
			<div class="one-coursedy">
                    <ul class="the-questiondy-list">
				        <li>
				          <div class="kc-pl">
                              <div class="dy-scan">
                                    <img src="<%=style%>/images/mhp/s1-wxy.png" alt="" />
                                    <div class="kc-pl-nc ml-10 mt-5">王晓阳</div>
                                </div>                          
                                <div class="dy-info">
						            <span class="kc-pl-title">课程内容丰富。</span>
						            <p class="kc-pl-nc">时间：1小时前</p>
					           </div>
                          </div>
				        </li>
			            <li>
				          <div class="kc-pl">
                              <div class="dy-scan">
                                     <img src="<%=style%>/images/mhp/s2-wst.png" alt="" />
                                     <div class="kc-pl-nc ml-10 mt-5">王诗婷</div>
                                </div>                          
                                <div class="dy-info">
						            <span class="kc-pl-title">老师讲课幽默生动。</span>
						            <p class="kc-pl-nc">时间：54分钟前</p>
					           </div>
                          </div>
				        </li> 
                        <li>
				          <div class="kc-pl">
                              <div class="dy-scan">
                                    <img src="<%=style%>/images/mhp/s3-wwj.png" alt="" />
                                    <div class="kc-pl-nc ml-10 mt-5">王文静</div>
                                </div>                          
                                <div class="dy-info">
						            <span class="kc-pl-title">讲课清晰，内容充实</span>
						            <p class="kc-pl-nc">时间：50分钟前</p>
					           </div>
                          </div>
				        </li>
			            <li>
				          <div class="kc-pl">
                              <div class="dy-scan">
                                     <img src="images/mhp/s4-wyl.png" alt="" />
                                     <div class="kc-pl-nc ml-10 mt-5">王懿龙</div>
                                </div>                          
                                <div class="dy-info">
						            <span class="kc-pl-title">课程编排有序。</span>
						            <p class="kc-pl-nc">时间：45分钟前</p>
					           </div>
                          </div>
				        </li>           
			        </ul>
		        </div>
            </div>
    </div>



        <div id="img_Video" class="fl mt-10 ml-20 w-7" style="max-width:1182px;">
            <!-- <img id="img_Video" src="images/mhp/kcbf.jpg"  /> -->
			 <script type="text/javascript">
			
			var swf_width='100%'//1164  //改视频宽度
			var swf_height='657'//改视频高度
			var texts=''
			var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
			var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'
			
			//width="'+ swf_width +'" height="'+ swf_height +'">
			document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
			document.write('<param name="movie" value="vcastr2.swf"><param name="quality" value="high">');
			document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
			document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
			document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 
			
			
			</script>			
        </div>



        <div id="div_right" class="fr w-230">
            <div class="mt-10">
                <div class="kc-kcjs">
                    <span class="title">
                        课程介绍</span><br /><br />
                    本课是由外国语实验小学宋保华老师给中心校外国语实验小学、桂花镇苏家坊教学点和刘祠教学点一起上的同步互动混合课堂。
					<p>本课的内容是人教版小学美术二年级下册第十六课的内容《我的老师》，其主要内容是
了解人物画在构图上头像、半身像、全身像与组像的不同。学生们通过学习，都能画出自己喜欢的老师，并添加适当的背景。</p>

                </div>
            </div>

        </div>
		
		
    </div>
    <script>
        window.onload = function () {
            var id_main = document.getElementById("img_Video");
            var w = document.body.clientWidth; // 
            id_main.style.width = (w - 500) + "px";
            var aa = id_main.height;
            var id_left = document.getElementById("div_left");
            id_left.style.height = aa + "px";
            var id_right = document.getElementById("div_right");
            id_right.style.height = aa + "px";
        }
        $(window).resize(function () {
            var id_main = document.getElementById("img_Video");
            var w = document.body.clientWidth; // 
            var ww = (w - 500) > 700 ? (w - 500) : 700;
			var ww = (w - 500) < 1200 ? (w - 500) : 1200;
            id_main.style.width = ww + "px";
            var aa = id_main.height;
            var id_left = document.getElementById("div_left");
            id_left.style.height = aa + "px";
            var id_right = document.getElementById("div_right");
            id_right.style.height = aa + "px";
        });
</script>
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