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
    <title>学习联合体（恩施市小学）</title>
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
    <div class="wrap clearfix">
        <div class="fl mt-10 w-600">
            <!-- 恩施市地图 -->
            <div class="my-jx">
                <div class="title-bar clearfix">
                    <h2>
                        恩施市地图</h2>
                </div>
            </div>
            
            <!-- 地图 -->
            <div class="mt-20 h-600">
                <img src="images/lh_map_es.jpg" alt=""/>
				<!--
                <a href="#"><div id="map_es" class="div_es"></div></a>
                <a href="#"><div id="map_es_mm1" class="div_es_mm1"></div></a>
                <a href="#"><div id="map_es_mm2" class="div_es_mm2"></div></a>
                <a href="#"><div id="map_es_mm3" class="div_es_mm3"></div></a>
                <a href="#"><div id="map_es_mm4" class="div_es_mm4"></div></a>-->
				
                <a href="#"><div id="map_es_mm5" class="div_es_mm5" style="position:relative;top:-410px;left:210px;height:80px;width:70px; text-align:center;"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />春堡教学点</div>
                </a>
                <a href="#"><div id="map_es_mm6" class="div_es_mm6" style="position:relative;top:-440px;left:290px;height:80px;width:70px; text-align:center;"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />龙马民族小学</div>
                </a>
                <a href="#"><div id="map_es_mm7" class="div_es_mm7" style="position:relative;top:-450px;left:270px;height:80px;width:70px; text-align:center;"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />武商小学</div>
                </a>
				 <a href="#"><div id="map_es_mm8" class="div_es_mm8"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />店子教学点</div>
                </a>
                <a href="#"><div id="map_es_mm9" class="div_es_mm9"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />芭蕉侗族乡中心小学</div>
                </a>
				 <a href="#"><div id="map_es_mm10" class="div_es_mm10"><img src="<%=style%>/images/flag-icon-512 copy.png" /><br />南河教学点</div>
                </a>
				
            </div>

            

        </div>
        <div class="fr w-r-230">
            <!-- 介绍 -->
            <div id="es">
                <div class="mt-50">
                    <span class="td-js"><strong>春堡教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
               	
					<div class="td-bk mt-10">
						<p>龙凤镇青堡教学点位于湖北省恩施市与重庆市奉节县交界处的青堡村。学校现有学前班、一年级和二年级，共47名学生，教职工4人。
						</p>
					</div>
				 <div class="dt-al">
					<span><strong>行动实录</strong></span>
					
					<ul>
						<li><a href="#" class="toup-zy-6">【课堂实录】同步音乐课堂</a></li>
						<!-- <li><a href="#" class="toup-zy-5">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
            <div id="mm" class="hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>龙马民族小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>龙马民族小学始建于1927年，位于咸安区龙凤镇，现已成为较大规模的农村半寄宿制完小，下属青堡、碾盘、佐家三个教学点，共有教职工34人，小学高级教师14人，三点一校学生数546人。
					</p>
                </div>
				 <div class="dt-al">
					<span><strong>行动实录</strong></span>
					<ul>
						<li><a href="#" class="toup-zy-7">【课堂实录】温馨音乐课《数蛤蟆》</a></li>
						<li><a href="#" class="toup-zy-8">【课堂实录】同步音乐课堂</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
            <div id="mm1" class="hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>武商小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>恩施市龙凤镇武商小学座落于桃树湾，是一所由恩施市政府规划、“武商量贩集团”援建的完全小学。2014年秋学校有教职工41人，有14个教学班，在校学生764人。
					</p>
                </div>
				 <div class="dt-al">
					<span><strong>行动实录</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="#" class="toup-zy-9">【师生心声】周阳艳老师谈资源平台</a></li>
						<li><a href="#" class="toup-zy-10">【师生心声】学生访谈--邓莘</a></li>
						<li><a href="#" class="toup-zy-11">【师生心声】学生访谈--杨临风</a></li>
						<li><a href="#" class="toup-zy-12">【课堂实录】同步语文课堂</a></li>
						<li><a href="#" class="toup-zy-13">【课堂实录】同步音乐课堂</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
            <div id="mm2" class="hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>店子教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>店子教学点坐落于龙凤镇西北部的店子槽村凉风垭。学校占地2688平方米，建筑面积915平方米，现有教学班6个，学生58人，在职教职工8人，其中专科学历2人，中师及高中学历6人。
					</p>
                </div>
				 <div class="dt-al">
					<!-- <span>典型案例</span> -->
					<span class="fr"><a href="#">直播课程表</a></span>
					<!-- <ul>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本4标签2</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
					</ul> -->
				</div>
            </div>
            <div id="mm3" class="hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>芭蕉侗族乡中心小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>芭蕉侗族乡中心小学创建于1906年，后搬迁至现址——龙神台。学校占地面积17094平方米，校舍建筑面积5470平方米。学校规划班级21个，在籍学生846人，在编教职工36人。
					</p>
                </div>
				 <div class="dt-al">
					<span><strong>行动实录</strong></span>
					<ul>
						<li><a href="#" class="toup-zy-14">【师生心声】芭蕉小学学生访谈</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
            <div id="mm4" class="hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>南河小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>南河教学点位于芭蕉侗族乡南河村坟前坝组，现有在职教师3人，开设有二、四、六年级三个教学班，学生有 43 人，另有一个学前班，有7人。
					</p>
                </div>
				 <div class="dt-al">
					<span><strong>行动实录</strong></span>
					<ul>
						<li><a href="#" class="toup-zy-15">【课堂实录】南河小学语文课堂</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
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


  

    <!-- 弹出层 -->
  	
	<div class="pop-box-6 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>






	<div class="pop-box-7 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>





	<div class="pop-box-8 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>





	<div class="pop-box-9 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>






	<div class="pop-box-10 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>





	<div class="pop-box-11 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>






	<div class="pop-box-12 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->

<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>






	<div class="pop-box-13 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>



	<div class="pop-box-14 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>




	<div class="pop-box-15 hidden">
		<div class="cover"></div>
		<div class="pop-content">
			<div class="title clearfix">
				<span class="to-close"></span>
				<div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='<%=style %>/images/waixiao-yuwen.flv' //视频路径地址
var config='0:自动播放|1:连续播放|100:默认音量|0:控制栏位置|2:控制栏显示|0x000033:主体颜色|60:主体透明度|0x66ff00:光晕颜色|0xffffff:图标颜色|0xffffff:文字颜色|:logo文字|:logo地址|:结束swf地址'


document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="<%=request.getContextPath()%>/common/video/vcastr2.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
document.write('<param name="FlashVars" value="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'">');
document.write('<embed src="<%=request.getContextPath()%>/common/video/vcastr2.swf" wmode="opaque" FlashVars="vcastr_file='+files+'&vcastr_title='+texts+'&vcastr_config='+config+'" menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>'); 


</script>
				</div>
			</div>
		</div>
	</div>

</body>
</html>