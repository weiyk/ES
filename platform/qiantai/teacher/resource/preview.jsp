<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="com.rc.web.utils.DocConverter"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	//获取样式
	String style = request.getContextPath()
			+ "/platform/qiantai/teacher";
	//获取资源样式
	String resource_style = request.getContextPath()
			+ "/platform/qiantai/teacher/style/resource";
	//获取路径
	String path = request.getContextPath() + "/servlet";
	//获取用户姓名
	String YONGHUXM = (String) request.getSession().getAttribute(
			"YONGHUXM");
	//获取用户UID
	String UID = (String) request.getSession().getAttribute(
			"XiTongHYBH");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资源中心</title>
   <%@include file="/common/framework.jspf" %>
    <%@include file="/common/jquery.jspf" %>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
</head>
<body>
<html:dialog id="GNDH_ZiYuanYL" state="DHZT_ChaXun"/>
<div class="top-u-bar">
	<div class="wrap">
		<p>
			欢迎你！ <a href="gerenzhongxin.htm" class="user-name blk"><%=YONGHUXM%></a><%=schoolName%><a
				href="<%=path%>/desktop.html" class="to-quit">退出</a>
		</p>
	</div>
</div>
<!-- 头部 开始-->
<jsp:include page="/platform/qiantai/teacher/resource/header.jsp" />
<%
	RecordSet zyRS = executeResult.getRecordSet("SWDY_ZiYuanYLCX");
	zyRS.next();
	// 资源文件
	String resourceFile = zyRS.getString("di_FuJianLJ");
	// 资源名称
	String ziYuanMC = zyRS.getString("di_ZiYuanMC");
	// 封面路径
	String fengMianLJ = zyRS.getString("di_FengMianLJ");
	
	IDataBaseAccess dbm = null;
	ResultSet rs = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		StringBuffer sqlBuffer = new StringBuffer();
		String matchName = ziYuanMC.substring(0, ziYuanMC.lastIndexOf("."));
		sqlBuffer.append("select bianHao, ziYuanMC from jskj_ziYuan where bianHao <> '" + zyRS.getString("di_ZiYuanBH") + "' and ziyuanMC like '%" + matchName + "%' limit 10");
		rs = dbm.executeQuery(sqlBuffer.toString());
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	// 获得后缀
	String suffix = resourceFile.substring(resourceFile.lastIndexOf(".") + 1).toLowerCase();
	
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
<div class="res-content">
    <div class="res-layout">
        <div class="res-detail-left fl">
            <div class="res-detail-lefttitle">
            	<img src="<%=style %>/images/resource/<%=suffix %>.png" class="tu_lei">
            		<%=zyRS.getString("di_ZiYuanMC") %>
            </div>
            <div class="clear"></div>
            <div class="res-detail-leftcontent">

<%
	if ("2".equals(type)) {
%>
	<!-- 视频播放 -->
	<div class="z_edit_wrap">
	    <div class="z_edit_h">
	        <div class="list_warp" id="J_list_warp">
				<div class="z_edit_text" style="margin: 0 auto;width: 720px;">
					<script type="text/javascript" src="<%=request.getContextPath() %>/common/jwplayer7/jwplayer.js"></script>
					<script type="text/javascript">jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";</script>
					<div id="container">Loadingthe player...</div>
					<script type="text/javascript">
					    jwplayer("container").setup({
					        flashplayer:"<%=request.getContextPath() %>/common/jwplayer7/jwplayer.flash.swf",
					        file: '<%=request.getContextPath() + "/" + resourceFile %>',
					        image: '<%=request.getContextPath() + "/" + fengMianLJ%>',
					        height:365,
					        width:720
					    });
					</script>
				</div>
				
	           <!-- <p class="mt_n ta_c">
	                <input class="btn btn_yellow btn_size_lg mr_s" type="submit" value="下 载" id="J_download" onclick="download()"/>
	                                <input class="btn btn_gray btn_size_lg" type="button" value="收 藏" id="J_collect" onclick="collect();"/>
	                                <input class="btn btn_gray btn_size_lg" type="button" value="分 享" id="J_share"  onclick="share();"/>
	            </p>-->
	        </div>
	    </div>
	</div>
<%
	} else if ("3".equals(type)) {
%>
	<script type="text/javascript" src="<%=style%>/js/audio.js"></script>
	<!-- 播放音频 -->
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
							<audio src="<%=request.getContextPath() + "/" + resourceFile %>" preload="none"></audio>
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
		String swfpath="";//路径
		String odtPath = "";
		String saveDirectory =application.getRealPath("");//获取盘符
		//拼接新的路径
		String converfilename=saveDirectory.replaceAll("\\\\","/")+"/"+ resourceFile;
		try {
			//创建转换类对象，并传入路径
			DocConverter d = new DocConverter(converfilename);
			d.conver();//调用转换方法进行转换
			//返回转换过后swf的新路径
			String swf = d.getswfPath();
			//获取上传的目标文件夹名称
			String dir=resourceFile.substring(0,resourceFile.indexOf("/"));
			if(CommonUtils.null2Blank(swf).length() > 0){
			swfpath = swf.substring(swf.indexOf(dir),swf.length());
			System.out.println(swfpath);
			}
			String odt = d.getodtPath();
			if(CommonUtils.null2Blank(odt).length() > 0){
				odtPath = odt.substring(odt.indexOf(dir),odt.length());
			}
		} catch (Exception e) {
			
		}
		
%>
		<%@include file="/common/fp.jspf" %>
		<div style="left:0px;top:0px;right:0px;bottom:0px;">  
	         <a id="viewerPlaceHolder" style="width:720px;height:420px;display:block"></a>  
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
	</div> 
<%
	}
%>

<script type="text/javascript">
	seajs.config({
	    "base" : "/hs_edu/statics/web/",
	    'map': [[ /^(.*\.(?:css|js))(.*)$/i, '$1?t=13935292681991']]
	});
	seajs.use('js/dev/app/app_base');
</script>

            </div>
            <div class="res-button">
                <ul>
                    <li><a id="J_download" onclick="ExtFunctionCM.downLoadFile('<%=zyRS.getString("di_FuJianLJ") %>','<%=zyRS.getString("di_ZiYuanMC") %>')">下载</a></li>
             	</ul>
            </div>
        </div>
                <div class="res-detail-right fl">
            <div class="res-supply"><span class="icon-publisher"></span>华中师范大学出版社</div>
            <div class="res-update">更新于<%=zyRS.getString("di_ShangChuanSJ") %></div>
            <div class="res-info">所属学科： <%=zyRS.getString("di_SuoShuXK") %><br>
			                适用年级： <%=zyRS.getString("di_ShiYongNJ") %><br>
			                资源类别： <%
                	String meiTiLX = zyRS.getString("di_MeiTiLX");
                	if ("1".equals(meiTiLX))
                		out.println("电子书");
                	else if ("2".equals(meiTiLX))
                		out.println("视频");
                	else
                		out.println("音频");
                %><br>
		                文档格式： <%=zyRS.getString("di_WenJianGS") %><br>
		                资源大小： <%
                BigDecimal b1 = new BigDecimal(zyRS.getString("di_ZiYuanDX"));
                BigDecimal b2 = null;
                // 字节大小
                double size = Double.parseDouble(zyRS.getString("di_ZiYuanDX"));
                String unit = "KB";
        		if (size > 1048576) {
	        		b2 = new BigDecimal("1048576");
	        		unit = "MB";
        		} else {
	        		b2 = new BigDecimal("1024");
        		}
        		out.println(b1.divide(b2, 1, BigDecimal.ROUND_HALF_UP).doubleValue() + unit);
                %><br>
            </div>
            <div class="res-about">相关资料<span class="sep"></span></div>
            <ul class="res-about-list">
            	<%
            		String tmpName = null;
            		String shortName = null;
            		int i = 0;
            		while (rs.next()) {
            			i++;
            			tmpName = rs.getString("ziYuanMC");
            			if (tmpName.length() > 10) {
            				shortName = tmpName.substring(0, 15) + "...";
            			}
            	%>
					<li>
						<span class="res-about-num">0<%=i %></span>
						<span class="res-about-listname">
							<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanYL&cs_ZiYuanBH=<%=rs.getString("bianHao") %>" 
								title="<%=tmpName %>" target="_blank"><%=shortName %>
							</a>
						</span>
					</li>
            	<%
            		}
            	%>
            </ul>
        </div>


    </div>
</div>
<!--正文结束-->
<div class="clear"></div>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
</body>
</html>