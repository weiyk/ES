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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学习联合体（咸安区小学）</title>
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
    <link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
    <script src="<%=style%>/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=style%>/js/base.js" type="text/javascript"></script>
	<style  type="text/css">
		#school_distribution_box{width:600px;height:600px;overflow:hidden;}
		.show_map{
			width: 100%;
			height: 100%;
			position: relative;
		}
		#allmap{width:600px;height:600px;}
	</style>
	<script type="text/javascript">
		//百度地图API功能
		var map;
		function loadJScript() {
			var script = document.createElement("script");
			script.type = "text/javascript";
			script.src = "http://api.map.baidu.com/api?v=2.0&ak=S3UdP2m4e3iEUuFLAhceqa2k&callback=init";
			document.body.appendChild(script);
		}
		function init() {
			map = new BMap.Map("allmap"); // 创建Map实例
			map.centerAndZoom(new BMap.Point(114.448565,29.742284),11); // 创建点坐标
			map.enableScrollWheelZoom(); //启用滚轮放大缩小
			addMapControl();
			addMapOverlay(); //向地图添加覆盖物
		}
		function addClickHandler(target,window){
			target.addEventListener("click",function(){
				target.openInfoWindow(window);
				changeSchoolByName(target,window);
				//var p = target.getPosition();
				//alert("marker的位置是" + p.lng + "," + p.lat);
				//alert(window.getContent());
				//alert(window.getTitle());	

			});
		}

		function addMapControl(){
			//左上角，添加默认缩放平移控件
			var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
			map.addControl(navControl);
		}

		function addMapOverlay(){

			var markers = [
							{content:"由咸安区外国语实验小学作为中心校，桂花镇刘祠小学和桂花镇苏家坊小学作为教学点所组成的一对二的学习联合体。",title:"外国语实验小学",image:"<%=style%>/images/waiguoyushiyan.jpg",imageOffset: {width:-46,height:-21},position:{lat:29.865323,lng:114.295169}},
							{content:"由咸安区外国语实验小学作为中心校，桂花镇刘祠小学和桂花镇苏家坊小学作为教学点所组成的一对二的学习联合体。",title:"桂花镇刘祠小学",image:"<%=style%>/images/liuci.jpg",imageOffset: {width:-46,height:-46},position:{lat:29.739501,lng:114.457376}},
							{content:"由咸安区外国语实验小学作为中心校，桂花镇刘祠小学和桂花镇苏家坊小学作为教学点所组成的一对二的学习联合体。",title:"桂花镇苏家坊小学",image:"<%=style%>/images/sujiafang.jpg",imageOffset: {width:-46,height:-46},position:{lat:29.694356,lng:114.331713}},
							{content:"由咸安区浮山中小学作为中心校，汀泗桥镇聂家教学点、汀泗桥镇大坪教学点和汀泗桥镇星星教学点作为教学点所组成的一对三的学习联合体。",title:"浮山中小学",image:"<%=style%>/images/fushanzhong.jpg",imageOffset: {width:-92,height:-21},position:{lat:29.870886,lng:114.317067}},
							{content:"由咸安区浮山中小学作为中心校，汀泗桥镇聂家教学点、汀泗桥镇大坪教学点和汀泗桥镇星星教学点作为教学点所组成的一对三的学习联合体。",title:"汀泗桥镇聂家教学点",image:"<%=style%>/images/niejia.jpg",imageOffset: {width:-92,height:-46},position:{lat:29.767791,lng:114.183907}},
							{content:"由咸安区浮山中小学作为中心校，汀泗桥镇聂家教学点、汀泗桥镇大坪教学点和汀泗桥镇星星教学点作为教学点所组成的一对三的学习联合体。",title:"汀泗桥镇大坪教学点",image:"<%=style%>/images/daping.jpg",imageOffset: {width:-92,height:-46},position:{lat:29.741218,lng:114.292551}},
							{content:"由咸安区浮山中小学作为中心校，汀泗桥镇聂家教学点、汀泗桥镇大坪教学点和汀泗桥镇星星教学点作为教学点所组成的一对三的学习联合体。",title:"汀泗桥镇星星教学点",image:"<%=style%>/images/xingxing.jpg",imageOffset: {width:-92,height:-46},position:{lat:29.718778,lng:114.251002}},
							{content:"由咸安区二号桥小学作为中心校，大幕乡蔡桥教学点和大幕乡桃花尖教学点作为教学点所组成的一对二的学习联合体。",title:"二号桥小学",image:"<%=style%>/images/erhaoqiao.jpg",imageOffset: {width:-23,height:-21},position:{lat:29.831664,lng:114.328068}},
							{content:"由咸安区二号桥小学作为中心校，大幕乡蔡桥教学点和大幕乡桃花尖教学点作为教学点所组成的一对二的学习联合体。",title:"大幕乡蔡桥教学点",image:"<%=style%>/images/caiqiao.jpg",imageOffset: {width:-23,height:-46},position:{lat:29.840389,lng:114.58231}},
							{content:"由咸安区二号桥小学作为中心校，大幕乡蔡桥教学点和大幕乡桃花尖教学点作为教学点所组成的一对二的学习联合体。",title:"大幕乡桃花尖教学点",image:"<%=style%>/images/taohuajian.jpg",imageOffset: {width:-23,height:-46},position:{lat:29.770582,lng:114.511961}}
							];
				for(var index = 0; index < markers.length; index++ ){
				var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
				var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap/images/icon.png",new BMap.Size(20,25),{
				  imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
				})});
				var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(25,5)});
				  label.setStyle({
					color : "red",
					fontSize : "12px",
					height : "20px",
					lineHeight : "20px",
					fontFamily:"微软雅黑"
				});
                                  var opts = {
				  width: 200,
				  title: markers[index].title,
				  enableMessage: false
				};

				var sContent = "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"+markers[index].title+"</h4>" + 
				"<img style='float:right;margin:4px' id='imgDemo' src='"+markers[index].image+"' width='139' height='104' title='"+markers[index].title+"'/>" + 
				"<p style='margin:0;line-height:1.5;font-size:13px;'>"+markers[index].content+"</p>" + 
				"</div>";

				var infoWindow = new BMap.InfoWindow(sContent);
				marker.setLabel(label);
				addClickHandler(marker,infoWindow);
				map.addOverlay(marker);
			};
		}
		
		window.onload = loadJScript;  //异步加载地图
		
		//切换右边导航
		function changeSchoolByName(marker,infoWindow){
			var p = marker.getPosition();
			
			//alert("marker的位置是" + p.lng + "," + p.lat);	
			//alert(infoWindow.getContent());
			//alert(infoWindow.getTitle());	
			var patt = new RegExp(/<h4.*?>(.*?)<\/h4>/i);
			var obj_title = infoWindow.getContent().match(patt)[1];	
			//obj_title = infoWindow.getTitle();
			//alert(now_title);

			$("#school_info_box").find("div.school_info_div").each(function() {
				$(this).hide();
			});
			$("#school_info_box").find("div.school_info_div").each(function() {
				var obj = $(this);
				var now_title = obj.find("span.td-js").text();
				if(obj_title != null && now_title != null && obj_title == now_title){
					obj.show();
				}
			});

		}

		/*
		// 百度地图API功能
		var map = new BMap.Map("allmap");    // 创建Map实例
		map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
		map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
		map.setCurrentCity("北京	");          // 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		*/

	</script>
	
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
            
            <!-- 咸安区地图 -->
            <div class="my-jx">
                <div class="title-bar clearfix">
                    <h2>
                        咸安区地图</h2>
                </div>
            </div>
            
            <!-- 地图 -->
            <div id="school_distribution_box" style="zoom:1;" class="mt-20 h-600">
				<div class="show_map" alog-alias="bainuo-map" alog-group="bainuo-map">
					<div id="allmap" class="map-container"></div>
					
				</div>


				
				<!--
                <img src="images/lh_map_xa.jpg" alt="" border="0" usemap="#Map" />
				
                <a href="#"><div id="map_xa" class="div_xa"></div></a>
                <a href="#"><div id="map_xa_mm1" class="div_xa_mm1"></div></a>
                <a href="#"><div id="map_xa_mm2" class="div_xa_mm2"></div></a>
                <a href="#"><div id="map_xa_mm3" class="div_xa_mm3"></div></a>
				
                <a href="#"><div id="map_xa_mm4" class="div_xa_mm4"><img src="images/flag-icon-512 copy.png" /><br />外国语实验小学</div>
                </a>
                <a href="#"><div id="map_xa_mm5" class="div_xa_mm5" color="red" ><img src="images/flag-icon-512 copy.png" /><br />浮山中小学</div>
                </a>
                <a href="#"><div id="map_xa_mm6" class="div_xa_mm6"><img src="images/flag-icon-512 copy.png" /><br />聂家教学点</div>
                </a>
                <a href="#"><div id="map_xa_mm7" class="div_xa_mm7"><img src="images/flag-icon-512 copy.png" /><br />二号桥小学</div>
                </a>
                <a href="#"><div id="map_xa_mm8" class="div_xa_mm8"><img src="images/flag-icon-512 copy.png" /><br />大坪教学点</div>
                </a>
                <a href="#"><div id="map_xa_mm9" class="div_xa_mm9"><img src="images/flag-icon-512 copy.png" /><br />星星教学点</div>
                </a>
                <a href="#"><div id="map_xa_mm10" class="div_xa_mm10"><img src="images/flag-icon-512 copy.png" /><br />苏家坊小学</div>
                </a>
                <a href="#"><div id="map_xa_mm11" class="div_xa_mm11"><img src="images/flag-icon-512 copy.png" /><br />刘祠小学</div>
                </a>
                <a href="#"><div id="map_xa_mm12" class="div_xa_mm12"><img src="images/flag-icon-512 copy.png" /><br />大幕乡落桥</div>
                </a>
                <a href="#"><div id="map_xa_mm13" class="div_xa_mm13"><img src="images/flag-icon-512 copy.png" /><br />大幕乡桃花尖</div>
                </a>
				-->
          </div>

            

        </div>
        <div id="school_info_box" class="fr w-r-230">
            <!-- 介绍 -->
            <div id="xn" class="school_info_div">
                <div class="mt-50">
                    <span class="td-js"><strong>外国语实验小学</strong></span>
                </div>
				<div class="tb-bk-left mt-10"><img src="<%=style%>/images/zmt-gb-imgleft.png" /></div>
                <div class="td-bk mt-10">
                    <p>咸安区外国语实验小学是一所全日制公办小学。学校开办于2012年9月，地处咸安区长安大道盘泗洲一号碧桂园小区内。目前，学校拥有16个教学班，在校学生884人，教职工38人。</p>
                </div>
				<div class="dt-al">
					<span><strong>行动实录</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="#" class="toup-zy-16">【师生心声】教师访谈--周琼</a></li>
						<li><a href="#" class="toup-zy-17">【课堂实录】同步音乐课堂</a></li>
						<li><a href="#" class="toup-zy-18">【课堂实录】同步美术课堂</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
            <div id="xnmm"  class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>浮山中小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style%>/images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                    
                    <p>浮山中小学是一所市、区共建的九年一贯制学校。学校位于咸安区青龙路中段南侧。学校现有教学班29个，在校学生1336人，全部采取小班教学。</p>
                </div>
				<div class="dt-al">
					<span><strong>行动实录</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="#" class="toup-zy-19">【师生心声】专递课堂访谈--陈勇</a></li>
						<li><a href="#" class="toup-zy-20">【课堂实录】音乐专递课堂</a></li>
						<li><a href="word/fushan-chenyong.docx" class="toup-zy-21">【文档】学校优秀教师陈勇的简介</a></li>
						<li><a href="word/fushan-yujie.doc" class="toup-zy-22">【文档】学校优秀教师于洁的简介</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
             <div id="xn4" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>汀泗桥镇聂家教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-10"><img src="<%=style%>/images/zmt-gb-imgleft.png" /></div>
                <div class="td-bk mt-10">
                    
                    <p>聂家教学点位于汀泗桥镇聂家村中心，距汀泗桥镇约6千米。学校建筑面积4600平方米，现配有教学班3个，学生9人，其中学前班3人，一年级5人，二年级1人，授课教师1人。</p>
                </div>
				<div class="dt-al">
					<!-- <span><strong>典型案例</strong></span>
					<ul>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签3</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
					</ul> -->
				</div>
            </div>
			 <div id="xn5" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>二号桥小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>咸宁市咸安二号桥小学于1981年建校，占地面积17944平方米。学校现有教学班27个，在校学生1574余人，专职教师70人，中学高级教师9人，小学高级教师65人。</p>
                </div>
				<div class="dt-al">
					<span><strong>教师信息</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="word/erhaoqiao-zhoushuqi.doc" class="toup-zy-23">【文档】学校教师周淑琪的简介</a></li>
						<li><a href="word/erhaoqiao-liaolanfen.doc" class="toup-zy-24">【文档】学校教师廖兰芬的简介</a></li>
						<li><a href="word/erhaoqiao-qiandan.doc" class="toup-zy-25">【文档】学校教师钱丹的简介</a></li>
						<li><a href="word/erhanqiao-shijing.docx" class="toup-zy-26">【文档】学校教师施静的简介</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn6" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>汀泗桥镇大坪教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>大坪教学点是一所位于汀泗桥镇的偏远的山区学校，现有5个教学班（学前班、一年级至四年级），共有学生54人，老师4人。</p>
                </div>
				<div class="dt-al">
					<span><strong>行动实录</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="#" class="toup-zy-27">【师生心声】校长访谈--宋明晚</a></li>
						<li><a href="#" class="toup-zy-28">【师生心声】班主任访谈--郑远</a></li>
						<li><a href="#" class="toup-zy-29">【师生心声】学生访谈--吴中向</a></li>
						<li><a href="#" class="toup-zy-30">【课堂实录】多媒体教学课堂</a></li>
						<li><a href="#" class="toup-zy-31">【课堂实录】专递课堂教学点端</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn7" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>汀泗桥镇星星教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>汀泗桥镇星星教学点是一所地处大山中的教学点。现有幼儿班、一年级、二年级共三个教学班，学生20人，多为留守儿童，教师1人。</p>
                </div>
				<div class="dt-al">
					<span><strong>教师信息</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="word/xingxing.doc" class="toup-zy-32">【文档】学校教师晏电平的简介</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn8" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>桂花镇苏家坊小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>桂花镇苏家坊教学点原名同心小学，后因生源减少，布局调整后，设为教学点，隶属石城小学管理。学校一二年级现有学生49人，教职工2人。</p>
                </div>
				<div class="dt-al">
					<span><strong>教师信息</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="word/shujia-jiaoshi.xls" class="toup-zy-41">【文档】苏家坊教学点教师信息</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn9" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>桂花镇刘祠小学</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                    
                    <p>刘祠教学点位于桂花镇南川村境内，隶属南川小学管理。学校占地面积近6亩。现有学生73人，开办学前班、一至四年级共5个教学班，教师5人。</p>
                </div>
				<div class="dt-al">
					<span><strong>教师信息</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="word/liuci-jiaoshi.xls" class="toup-zy-33">【文档】刘祠教学点教师信息表</a></li>
						<!-- <li><a href="#" class="toup-zy-4">刘祠教学点教师信息表</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn10" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>大幕乡蔡桥教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>蔡桥教学点的前身是蔡桥小学， 2008年撤并到常收小学。目前，教学点共开设一二三年级，有学生46人，教师3人，三个教学班。</p>
                </div>
				<div class="dt-al">
					<span><strong>教师信息</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="word/caiqiao-chendean.docx" class="toup-zy-34">【文档】教学点教师陈德安的简介</a></li>
						<!-- <li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li>
						<li><a href="#" class="toup-zy-4">文本标签文本标签文本标签</a></li> -->
					</ul>
				</div>
            </div>
			 <div id="xn11" class="school_info_div hidden">
                <div class="mt-50">
                    <span class="td-js"><strong>大幕乡桃花尖教学点</strong></span>
                </div>
				<div class="tb-bk-left mt-20" style="background:url(<%=style %>images/lh_map_bk.png) no-repeat left -15px; width:23px; height:80px; margin-left:2px"></div>
                <div class="td-bk mt-10">
                   
                    <p>桃花尖教学点位于咸安区大幕乡美丽的桃花尖村。学校目前共有教师3名，在校学生42名，设有三个年级。</p>
                </div>
				<div class="dt-al">
					<span><strong>行动实录</strong></span>
					<span class="fr"><a href="#">直播课程表</a></span>
					<ul>
						<li><a href="#" class="toup-zy-35">【师生心声】校长专访--佘继英</a></li>
						<li><a href="#" class="toup-zy-36">【师生心声】班主任的采访</a></li>
						<li><a href="#" class="toup-zy-37">【师生心声】教师专访--廖玖玖</a></li>
						<li><a href="#" class="toup-zy-38">【师生心声】学生谈同步课堂1</a></li>
						<li><a href="#" class="toup-zy-39">【师生心声】学生谈同步课堂2</a></li>
						<li><a href="#" class="toup-zy-40">【课堂实录】同步课堂教学点端</a></li>
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
    <div class="pop-box-16 hidden">
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




<!-- 弹出层 -->
    <div class="pop-box-17 hidden">
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





<!-- 弹出层 -->
    <div class="pop-box-18 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><!-- <img src="images/kc-pic.jpg" width="945" /> -->
<script type="text/javascript">

var swf_width=960  //改视频宽度
var swf_height=546//改视频高度
var texts=''
var files='../video/waixiao-yuwen.flv' //视频路径地址
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




<!-- 弹出层 -->
    <div class="pop-box-19 hidden">
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




<!-- 弹出层 -->
    <div class="pop-box-20 hidden">
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



<!-- 弹出层 -->
   <!--  <div class="pop-box-21 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
   <!--  <div class="pop-box-22 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div>
 -->

<!-- 弹出层 -->
    <!-- <div class="pop-box-23 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <!-- <div class="pop-box-24 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <!-- <div class="pop-box-25 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <!-- <div class="pop-box-26 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <div class="pop-box-27 hidden">
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


<!-- 弹出层 -->
    <div class="pop-box-28 hidden">
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

<!-- 弹出层 -->
    <div class="pop-box-29 hidden">
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

<!-- 弹出层 -->
    <div class="pop-box-30 hidden">
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

<!-- 弹出层 -->
    <div class="pop-box-31 hidden">
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

<!-- 弹出层 -->
    <!-- <div class="pop-box-32 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div>
 -->

<!-- 弹出层 -->
   <!--  <div class="pop-box-33 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <!-- <div class="pop-box-34 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<div class="title clearfix">
			<span class="to-close"></span>
            <div><img src="images/kc-pic.jpg" width="945" /></div>
		</div>
	</div>
</div> -->


<!-- 弹出层 -->
    <div class="pop-box-35 hidden">
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



<!-- 弹出层 -->
    <div class="pop-box-36 hidden">
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



<!-- 弹出层 -->
    <div class="pop-box-37 hidden">
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



<!-- 弹出层 -->
    <div class="pop-box-38 hidden">
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



<!-- 弹出层 -->
    <div class="pop-box-39 hidden">
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



<!-- 弹出层 -->
    <div class="pop-box-40 hidden">
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


	$(document).ready(function(){
		//alert("加载作图组件！");
			
		var click_num = 1;
		//最多允许10个子校
		var max_num = 10; 
		var totalCoordinates = new Array();
		
		/*
		
		$("#school_distribution_box").find("a").each(function() {
			$(this).bind("click",function() {
				var click_text = $(this).find("div").text();
				var text_one = "<font color='red'>"+click_text+"</font>";
				var text_two = "<font color='blue'>"+click_text+"</font>";
				//获取起点坐标
				//alert("执行第 ："+click_num+" 次不重复的点");


				/*
				if ( event.pageX == null && original.clientX != null ) {
					eventDoc = event.target.ownerDocument || document;
					doc = eventDoc.documentElement;
					body = eventDoc.body;

					event.pageX = original.clientX + ( doc && doc.scrollLeft || body && body.scrollLeft || 0 ) - ( doc && doc.clientLeft || body && body.clientLeft || 0 );
					event.pageY = original.clientY + ( doc && doc.scrollTop  || body && body.scrollTop  || 0 ) - ( doc && doc.clientTop  || body && body.clientTop  || 0 );
				}
				//*
				
				
				//alert($(this).offset().left);
				//alert($(this).offset().top);

				var mid_x = $(this).offset().left+$(this).width()/2;
				var bottom_y = $(this).offset().top+$(this).height()+2;

				//alert($(this).get(0).pageX);
				//var mid_x = $(this).pageX+$(this).width()/2;
				//var bottom_y = $(this).pageY+$(this).height()+2;
				//alert($(this).get(0).offsetLeft);
				//var mid_x = $(this).get(0).offsetLeft+$(this).width()/2;
				//var bottom_y = $(this).get(0).offsetTop+$(this).height()+2;

				var flag = true;
				//alert(mid_x);
				//alert(bottom_y);
				document.body.appendChild(point(mid_x,bottom_y));
				
				//判断重复
				if(totalCoordinates != null && totalCoordinates.length > 0){
					for(var i = 0;i < totalCoordinates.length;i++){
						if (totalCoordinates[i].x == mid_x && totalCoordinates[i].y == bottom_y) {
							//重复点暂时不做任何处理
							flag = false;
							alert("重复选择！");
						}
					}
					if(flag){
						if(click_num > max_num){
							click_num = 1;
							totalCoordinates.splice(0,totalCoordinates.length);  
							$("body").find("div.school_line_dot").remove();
							//document.body.appendChild(point_first(mid_x,bottom_y));
							remove_font_color();
							$(this).find("div").css("color","red");
						}else{
							click_num++;
							$(this).find("div").css("color","blue");
						}
						
						
						var coordinate_point = new Object();
						coordinate_point.x = mid_x;
						coordinate_point.y = bottom_y;
						totalCoordinates.push(coordinate_point);
						//开始处理连线
						if(totalCoordinates != null && totalCoordinates.length > 0){
							//alert(123);
							drawLine(totalCoordinates[0].x,totalCoordinates[0].y,totalCoordinates[totalCoordinates.length-1].x,totalCoordinates[totalCoordinates.length-1].y)
						}
					}
				}else{
					if(click_num > max_num){
						click_num = 1;
						totalCoordinates.splice(0,totalCoordinates.length);
						$("body").find("div.school_line_dot").remove(); 
						remove_font_color();
					}else{
						click_num++;
					}

					if(click_num = 1){
						//document.body.appendChild(point_first(mid_x,bottom_y));
						$(this).find("div").css("color","red");
					}else{
						$(this).find("div").css("color","blue");
					}
					var coordinate_point = new Object();
					coordinate_point.x = mid_x;
					coordinate_point.y = bottom_y;
					totalCoordinates.push(coordinate_point);
				}
				//alert(totalCoordinates.length);
				//alert(JSON.stringify(totalCoordinates));
				//JSON.parse
				//所有动作处理完成

			});
		}); 
  
		
		//alert("作图组件加载完毕！");
		*/
	});
	
	

	function offsetTop(elements){
		var top = elements.offsetTop;
		var parent = elements.offsetParent;
		while( parent !== null ){
			top += parent.offsetTop;
			parent = parent.offsetParent;
		}
		return top;
	};

	function offsetLeft(elements){
		var left = elements.offsetLeft;
		var parent = elements.offsetParent;
		while( parent !== null ){
			left += parent.offsetLeft;
			parent = parent.offsetParent;
		}
		return left;
	};


	function point(x,y){//画点  
		var oDiv=document.createElement('div');
		oDiv.setAttribute('class','school_line_dot');
		oDiv.style.position='absolute';  
		oDiv.style.height='2px';  
		oDiv.style.width='2px';  
		oDiv.style.backgroundColor='#197bd1';  
		oDiv.style.left=x+'px';  
		oDiv.style.top=y+'px';  
		//document.body.appendChild(oDiv);  
		return oDiv;//注意：返回的值是一个dom节点，但并未追加到文档中  
	}

	//移除所有字体添加颜色
	function remove_font_color(){
		$("#school_distribution_box").find("a").each(function() {
			$(this).find("div").removeAttr("style");
		});
	}

	function point_first(x,y){//画点  
		var oDiv=document.createElement('div');
		oDiv.setAttribute('class','school_line_dot');
		oDiv.style.position='absolute';  
		oDiv.style.height='5px';  
		oDiv.style.width='5px';  
		oDiv.style.backgroundColor='red';  
		oDiv.style.left=x+'px';  
		oDiv.style.top=y+'px';  
		//document.body.appendChild(oDiv);  
		return oDiv;//注意：返回的值是一个dom节点，但并未追加到文档中  
	} 

	function drawLine(x1,y1,x2,y2){//画一条直线的方法  
		var x=x2-x1;//宽  
		var y=y2-y1;//高  
		var frag=document.createDocumentFragment();  
		if(Math.abs(y)>Math.abs(x)){//那个边更长，用那边来做画点的依据（就是下面那个循环），如果不这样，当是一条垂直线或	水平线的时候，会画不出来  
			if(y>0){
				for(var i=0;i<y;i++){
					//x/y是直角两个边长的比，根据这个比例，求出新坐标的位置  
					var width=x/y*i  
					{  
						frag.appendChild(point(width+x1,i+y1));  
					}  
				}
			}//正着画线是这样的  
			  
			if(y<0){//有时候是倒着画线的  
				for(var i=0;i>y;i--){  
					var width=x/y*i  
						{  
						frag.appendChild(   point(width+x1,i+y1));  
						}  
				}  
			}  
		} else {  
			if(x>0){
				for(var i=0;i<x;i++){  
					var height=y/x*i  
					{  
						frag.appendChild(point(i+x1,height+y1));  
					}  
				} 
			}//正着画线是这样的  
			 
			if(x<0){//有时候是倒着画线的  
				for(var i=0;i>x;i--){  
					var height=y/x*i  
					{  
						frag.appendChild(   point(i+x1,height+y1));  
					}  
				}  
			}//end if  
		}  
		//document.body.appendChild(frag);  
		document.getElementById('school_distribution_box').appendChild(frag);  
		//var oDiv=document.createElement('div')  
		//oDiv.appendChild(frag);  
		//document.body.appendChild(oDiv);  
	} 
	

			

</script>
            </div>
		</div>
	</div>
</div>


</body>
</html>