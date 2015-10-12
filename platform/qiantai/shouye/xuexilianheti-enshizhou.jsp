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
    <title>学习联合体（恩施州）</title>
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
            
            <!-- 恩施土家族苗族自治州地图 -->
            <div class="my-jx">
                <div class="title-bar clearfix">
                    <h2>
                        恩施土家族苗族自治州地图</h2>
                </div>
            </div>
            
            <!-- 地图 -->
            <div class="mt-20">
                <img src="<%=style%>/images/lh_map_esz.png" alt="" border="0" usemap="#Map" />
<map name="Map" id="Map">
  <area shape="poly" coords="247,362,286,318,321,284,341,279,364,301,390,299,412,287,409,250,399,210,355,211,330,180,302,192,280,209,273,187,237,205,228,218,270,252,234,285,240,320" href="<%=request.getContextPath() %>/platform/qiantai/shouye/xuexilianheti-enshishixiaoxue.jsp" />
</map>
          </div>

            

        </div>
        <div class="fr w-r-230">
            <!-- 介绍 -->
            <div class="mt-50">
                <span class="td-js"><strong>恩施“三式”破“三难”</strong></span>
            </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
            <div class="td-bk mt-10">
               
                    <p>为破解恩施土家族苗族自治州农村教育难题，恩施把在线互动教学同步课堂分为同体式、支教式和协作式三类同步课堂...<a>更多</a></p>
            </div>
            <div class="dt-al">
                <span><strong>行动实录</strong></span>
                <ul>
                    <li><a href="#" class="toup-zy-4">【视频】恩施“三式”破“三难”</a></li>
                   <!--  <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
                    <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
                    <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
                    <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
                    <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
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
            <div><!-- <img src="images/kc-pic.jpg" width="945" /></div> -->
			<script type="text/javascript">

var swf_width=958//改视频宽度
var swf_height=545//改视频高度
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

</body>
</html>