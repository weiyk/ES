<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<%@page import="java.util.Properties"%>
<%@page import="com.qam.framework.context.ApplicationConfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@page import="java.io.*"%>  
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.Enumeration"%>  
<%@page import="com.rc.web.utils.DocConverter"%>  
<%@page import="com.qam.framework.core.transaction.execution.CanReturnException" %>
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	String schoolName=(String) session.getAttribute("schoolName");
	
	// 资源路径
	String filePath = "upload/teacher/jiaoxueshipin/123.png";//路径和原始名字
	// 封面路径
	String fengMianLJ = "";
	// 资源课件编号
	String ziYuanKJBH = request.getParameter("cs_ZiYuanKJBH");
	IDataBaseAccess dbm = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		ResultSet rs = null;
		// 查询集合列表
		String sql = "select bianHao, xueXiZYBH, ziYuanMC, ziYuanLJ, fengMianLJ from jskj_ziyuankj where bianHao = '" + ziYuanKJBH + "'";
		rs = dbm.executeQuery(sql);
		if (rs.next()) {
			filePath = rs.getString("ziYuanLJ");
			fengMianLJ = rs.getString("fengMianLJ");
		}
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (dbm != null)
			dbm.closeConnection();
	}
	
	// 获取文件后缀
	String suffix = filePath.substring(filePath.lastIndexOf(".") + 1).toLowerCase();
	// 文件类型
	String type = null;
	// 验证是否为视频格式
	if ("mp3".equals(suffix)) {
		// 音频
		type = "3";
	} else if ("flv".equals(suffix) || "avi".equals(suffix) || "rmvb".equals(suffix) || "mp4".equals(suffix)) {
		// 视频
		type = "2";
	} else {
		// 电子书
		type = "1";
	}
	
%>
<html>  
<head>  
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- 在线预览 -->
<%@include file="/common/fp.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预览</title> 
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
<style type="text/css" media="screen">   
            html, body  { height:100%; }  
            body { margin:0; padding:0; overflow:auto; }     
            #flashContent { display:none; }  
</style>   
</head> 
<body>
<html:dialog id="GNDH_ZaiXianYL"/>
	<div class="top-u-bar">
		<div class="wrap">
			<p>欢迎你！ <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=yonghuxm %></a><%=schoolName %><a href="<%=path%>/desktop.html" class="to-quit">退出</a></p>
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
				<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB" class="cur">教学准备</a></li>
				<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
				<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
				<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
				<li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
			</ul>
		</div>
	</div>
	
	<div class="wrap-kc clearfix" style="min-height: 400px;">
		 <div class="fl mt-10" style="margin-left: 230px;">
			 <%
				if ("2".equals(type)) {
					// 播放视频文件
					// 读取图片所在服务器地址
					String server = "";
					String pfile = ApplicationConfig.getInstance().REAL_PATH+"admin.properties";
					Properties properties = new Properties();
					File configFile = new File(pfile);
					FileInputStream inputStream = null;
					try {
						inputStream=new FileInputStream(configFile);
						properties.load(inputStream);
						server = properties.getProperty("imgUrl");
					}catch (IOException e) {
						e.printStackTrace();
					}
					
					if (filePath != null && !"".equals(filePath)) {
						if (filePath.indexOf("jymis") > 0) {
							filePath = server + filePath;
						} else {
							filePath = request.getContextPath() + "/" + filePath;
						}
					}
					
					if (fengMianLJ != null && !"".equals(fengMianLJ)) {
						if (fengMianLJ.indexOf("jymis") > 0) {
							fengMianLJ = server + fengMianLJ;
						} else {
							fengMianLJ = request.getContextPath() + "/" + fengMianLJ;
						}
					}
			%>
				<script type="text/javascript" src="<%=request.getContextPath() %>/common/jwplayer7/jwplayer.js"></script>
				<script type="text/javascript">jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";</script>
			    <div class="list_warp" id="J_list_warp">
					<div class="z_edit_text" style="margin: 0 auto;width: 720px;">
			            <div style="position: relative; display: block; width: 720px; height: 365px;">
			            	<div id="container">Loadingthe player...</div>
							<script type="text/javascript">
							    jwplayer("container").setup({
							        flashplayer:"<%=request.getContextPath() %>/common/jwplayer7/jwplayer.flash.swf",
							        file: '<%=filePath %>',
							        image: '<%=fengMianLJ %>',
							        width:720,
							        height:365,
							    });
							</script>
			            </div>
					</div>
	        </div>
	        
			<%
				} else if ("3".equals(type)) {
					// 读取图片所在服务器地址
					String server = "";
					String pfile = ApplicationConfig.getInstance().REAL_PATH+"admin.properties";
					Properties properties = new Properties();
					File configFile = new File(pfile);
					FileInputStream inputStream = null;
					try {
						inputStream=new FileInputStream(configFile);
						properties.load(inputStream);
						server = properties.getProperty("imgUrl");
					}catch (IOException e) {
						e.printStackTrace();
					}
					
					if (filePath != null && !"".equals(filePath)) {
						if (filePath.indexOf("jymis") > 0) {
							filePath = server + filePath;
						} else {
							filePath = request.getContextPath() + "/" + filePath;
						}
					}
			%>
				<!-- 播放视频文件 -->
				<script type="text/javascript" src="<%=style%>/js/audio.js"></script>
				<div class="voice-bg">
				<div class="z_edit_wrap">
				 <div class="z_edit_h" style="height:40px;line-height:40px; position: absolute; top:175px; left:145px; z-index: 999;">
		        <div class="list_warp" id="J_list_warp">
		            <div class="z_edit_text" style="margin: 0 auto;width:450px; text-align: center">
		            <script type="text/javascript">
			            audiojs.events.ready(function() {
			                var as = audiojs.createAll();
			            });
		            </script>
					<div id="video_detail">
						<div id="audiojs_wrapper0" classname="audiojs" class="audiojs">
							<audio src="<%=filePath %>" preload="none"></audio>
							<div class="play-pause">
								<p class="play"></p>
								<p class="pause"></p>
								<p class="loading"></p>
								<p class="error"></p>
							</div>           
							<div class="scrubber">             
								<div class="progress"></div>             
								<div class="loaded"></div>           
							</div>           
							<div class="time">             
								<em class="played">00:00</em>/<strong class="duration">00:00</strong>           
							</div>           
							<div class="error-message"></div>
						</div>
					</div>
		           <!-- <p class="mt_n ta_c">
		                <input class="btn btn_yellow btn_size_lg mr_s" type="submit" value="下 载" id="J_download" onclick="download()"/>
		                                <input class="btn btn_gray btn_size_lg" type="button" value="收 藏" id="J_collect" onclick="collect();"/>
		                                <input class="btn btn_gray btn_size_lg" type="button" value="分 享" id="J_share"  onclick="alert('分享成功');"/>
		            </p>-->
		        </div>
		        </div>
		    </div>
		    </div>
		    </div>
			<%
				} else {
					// 非视频文件，使用openOffice打开
					String swfpath="";//路径
					String odtPath = "";
					String saveDirectory =application.getRealPath("");//获取盘符
					//拼接新的路径
					String converfilename=saveDirectory.replaceAll("\\\\","/")+"/"+ filePath;
					try {
						//创建转换类对象，并传入路径
						DocConverter d = new DocConverter(converfilename);
						d.conver();//调用转换方法进行转换
						//返回转换过后swf的新路径
						String swf = d.getswfPath();
						//获取上传的目标文件夹名称
						String dir=filePath.substring(0,filePath.indexOf("/"));
						if(CommonUtils.null2Blank(swf).length() > 0){
						swfpath = swf.substring(swf.indexOf(dir),swf.length());
						}
						String odt = d.getodtPath();
						if(CommonUtils.null2Blank(odt).length() > 0){
							odtPath = odt.substring(odt.indexOf(dir),odt.length());
						}
					} catch (Exception e) {
						
					}
					
				%>
			   <div style="left:0px;top:0px;right:0px;bottom:0px;">  
		            <a id="viewerPlaceHolder" style="width:800px;height:550px;display:block"></a>  
			            <script type="text/javascript">
			                var fp = new FlexPaperViewer(     
			                		 '<%=request.getContextPath()%>/platform/qiantai/zaixianyl/FlexPaperViewer',
			                         'viewerPlaceHolder', { config : {
			                        //escape  decodeURI //request.getContextPath()+"/"+    
			                        SwfFile: decodeURI('<%=request.getContextPath() + "/" + swfpath %>'),
			                        Scale : 0.6, //缩放的意思
									ZoomTransition : 'easeOut',//缩放样式的选择
									ZoomTime : 0.5,//缩放使用的时间
									ZoomInterval : 0.2,//缩放比例之间间隔，默认值为0.1
									FitPageOnLoad : false,//自适应页面
									FitWidthOnLoad : true,//自适应宽度
									FullScreenAsMaxWindow : false,//如果设置为true的时候，点击全屏并不是全屏而是一个新页面
									ProgressiveLoading : false,//true的话不全部加载文档，边看边加载
									MinZoomSize : 0.2,//最大缩放比例
									MaxZoomSize : 5,//最小缩放比例
									SearchMatchAll : false,//为true的时候搜索的时候便会出现高亮
									InitViewMode : 'Portrait',//设置启动模式如"Portrait" or "TwoPage" 
									PrintPaperAsBitmap : false,
									ViewModeToolsVisible : true,//工具栏上是否显示样式选择框
									ZoomToolsVisible : true,//工具栏上是否显示缩放工具
									NavToolsVisible : true,//工具栏上是否显示导航工具
									CursorToolsVisible : true,//工具栏上是否显示光标工具
									SearchToolsVisible : true,//工具栏上是否显示搜索
			                         }});  
		            	</script>              
						<html:hidden id="swfFile" value="<%=swfpath%>"/>
						<html:hidden id="odtFile" value="<%=odtPath%>"/>
				</div>   
		        <%
				}
				%>
		 </div>
	</div>
	
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp"/>	
	</body> 
</html>  
	