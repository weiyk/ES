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
    <title>学习联合体（咸宁市）</title>
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
    <div class="wrap clearfix h-800">
        <div class="fl mt-10 w-600">
            
            <!-- 咸宁市地图 -->
            <div class="my-jx">
                <div class="title-bar clearfix">
                    <h2>
                        咸宁市地图</h2>
                </div>
            </div>
            
            <!-- 地图 -->
            <div class="mt-20">
                <img src="<%=style%>/images/lh_map_xn.png" alt="" border="0" usemap="#Map" />
<map name="Map" id="Map">
  <area shape="poly" coords="254,158,277,207,271,233,273,263,302,276,302,292,316,299,347,287,365,292,393,269,431,252,453,230,481,212,451,184,402,157,347,135,287,144" href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-xiananquxiaoxue.jsp" />
</map>
          </div>

            

        </div>
        <div class="fr w-r-230">
            <!-- 介绍 -->
            <div class="mt-50">
                <span class="td-js"><strong style="font:normal 22px '微软雅黑', Tahoma, Helvetica, sans-serif;">咸安教育信息化行动</strong></span>
            </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
            <div class="td-bk mt-10">
               <span><strong><span style="font-size:16px;color:#f00;">"一体"</span>—咸安数字学校</br>
<span style="font-size:16px;color:red;">"双核"</span>—以“协同”为核心实现多方共同推进；以“创新”为导向实现教学应用变革。</br>
<span style="font-size:16px;color:red;">"四驱"</span>—多层次教师全员培训，骨干学科建设，数字教师打造，学生行为观测。</strong></span>
                    
            </div>
            <div class="dt-al">
		<p style="text-indent:2em;">咸安数字学校是一所主要由中心学校和教学点组成的“独立建制、分层管理”的数字化学校，其目的是聚合优秀的教师资源和数字化信息资源，通过网络同步课堂、点播课堂等方式为农村教学点和薄弱学校提供实用、有效的教学支持。</p>
                
                <ul>
                    <li><a href="#" class="toup-zy-45">【视频】“协同”与“创新”</a></li>
					<li><a href="#" class="toup-zy-42">【视频】多层次教师全员培训</a></li>
                    <li><a href="#" class="toup-zy-43">【视频】骨干学科建设</a></li>
                    <li><a href="#" class="toup-zy-44">【视频】数字教师打造</a></li>
                    
                    <li><a href="#" class="toup-zy-46">【视频】学生行为观测</a></li>
                   <!--  <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
                </ul>
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
    <div class="pop-box-4 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="<%=style%>/images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div>




<div class="pop-box-42 hidden">
    <div class="cover"></div>
    <div class="pop-content">
        <div class="title clearfix">
            <span class="to-close"></span>
            <div><!-- <img src="<%=style%>/images/kc-pic.jpg" width="945" /> -->
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



<div class="pop-box-43 hidden">
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



<div class="pop-box-44 hidden">
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




<div class="pop-box-45 hidden">
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



<div class="pop-box-46 hidden">
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