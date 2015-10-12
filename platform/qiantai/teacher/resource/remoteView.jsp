<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@page import="com.rc.web.utils.DocConverter"%>  
<%@page import="com.rc.web.utils.FlexPagerUtils"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%
	//获取样式
	String style = request.getContextPath() + "/platform/qiantai/teacher";
	//获取资源样式
	String resource_style = request.getContextPath() + "/platform/qiantai/teacher/style/resource";
	//获取路径
	String path = request.getContextPath() + "/servlet";
	//获取用户姓名
	String YONGHUXM = (String) request.getSession().getAttribute("YONGHUXM");
	//获取用户UID
	String UID = (String) request.getSession().getAttribute("XiTongHYBH");
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	//imgUrl
	String imgUrl = (String) request.getSession().getAttribute("imgUrl");
	
	//资源编号
	String RESID=request.getParameter("CS_RESID");
	//获取资源明细
	ResourceHelper rshelp = new ResourceHelper();
	List<Map<String, String>> detailreslist=rshelp.getResDetailByResid(RESID);
	Map<String, String> detailres=null;
	if(detailreslist.size()>0){
		detailres=detailreslist.get(0);
	}
	//获取相关资源
	List<List<String>> list = rshelp.getResourceBySearch(detailres.get("name"),null,null,"1","10",null,null,null,null); 
	List<String> list_cout=null;
	List<String> list_res=null;
	if(list.size()>0){
		list_cout=list.get(0);
		list_res=list.get(1);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- 平台 --%>
<%@ include file="/common/script/ExtFunctionCM.jspf"%>
<!-- 在线预览 -->
<%@include file="/common/fp.jspf" %>
<title>资源预览</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet"
	type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
<script type="text/javascript" src="<%=style%>/js/jwplayer.html5.js"></script>
<script type="text/javascript" src="<%=style%>/js/jwplayer.js"></script>
<script type="text/javascript" src="<%=style%>/js/audio.js"></script>
<script type="text/javascript">
	$().ready(function() {
	});
</script>
</head>
<body>
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
	<!-- 头部结束 -->
	<html:form>
		<div class="res-content">
			<div class="res-layout">
				<div class="res-detail-left fl">
					<div class="res-detail-lefttitle">
						<img src="<%=style %>/images/resource/<%=detailres.get("form") %>.png" class="tu_lei"/><%=detailres.get("name") %>
					</div>
					<!-- 
					<div class="res-detail-action">
						<div class="res-detail-action-info">
							浏览：<em class="score-grade"> 15 </em> 下载：<em class="score-grade">
								3 </em> 收藏：<em class="score-grade"> 0 </em>
						</div>
					</div>
					 -->
					<div class="clear"></div>
					<div class="res-detail-leftcontent">
						<div class="z_edit_wrap">
							<div class="z_edit_h">
								<div class="list_warp" id="J_list_warp">
									<div class="z_edit_text" style="margin: 0 auto;width: 720px;">
										<!-- 视频开始 -->
										<%if("flv,mp4,rmvb".contains(detailres.get("form"))){%>
										<div id="J_player_wrapper" style="position: relative; display: block; width: 720px; height: 420px;" >
											<object tabindex="0" name="J_player" id="J_player"
												bgcolor="#000000"
												data="<%=style %>/resource/jwplayer.swf"
												type="application/x-shockwave-flash" 
												height="100%"
												width="100%">
												<param value="true" name="allowfullscreen"/>
												<param value="always" name="allowscriptaccess"/>
												<param value="true" name="seamlesstabbing"/>
												<param value="opaque" name="wmode"/>
											</object>
											<script type="text/javascript">
											    jwplayer("J_player").setup({
											    	flashplayer: '<%=style %>/resource/jwplayer.swf',  
											        file: '<%=imgUrl+detailres.get("downUrl") %>',
											        width:720,
											        height:420,
											        image:"<%=imgUrl+detailres.get("icon") %>"
											    });
											</script>
										</div>
										<%}else %>
										<!-- 视频结束 -->
										
										<!-- 文档开始 -->
										<%if("txt,pdf,doc,xls,ppt,docx,xlsx,pptx,gif,jpg,JPG,JPEG,png".contains(detailres.get("form"))){ %>
										<div id=""  style="position:relative;left:0px;top:0px;right:0px;bottom:0px;">
										 <a id="viewerPlaceHolder" style="width: 720px; height: 420px;display:block"></a> 
											<%
											FlexPagerUtils fputils=new FlexPagerUtils();
											String fileName=(imgUrl+detailres.get("downUrl")).substring((imgUrl+detailres.get("downUrl")).lastIndexOf("/")+1);
											String filePath=fputils.downLoadFileSaveLocal(imgUrl+detailres.get("downUrl"),application.getRealPath("")+"\\"+"upload\\remotefile\\"+fileName);//路径和原始名字
											String swfpath="";//路径
											String odtPath = "";
											//拼接新的路径
											String converfilename=filePath.replaceAll("\\\\","/");
											//创建转换类对象，并传入路径
											DocConverter d = new DocConverter(converfilename);
											d.conver();//调用转换方法进行转换
											//返回转换过后swf的新路径
											String swf = d.getswfPath();
											//获取上传的目标文件夹名称
											//String path_=filePath.substring(0,filePath.indexOf("/"));
											if(CommonUtils.null2Blank(swf).length() > 0){
												swfpath = swf.substring(swf.indexOf(request.getContextPath()));
											}
											String odt = d.getodtPath();
											if(CommonUtils.null2Blank(odt).length() > 0){
												odtPath = odt;
											} %>  
									            <script type="text/javascript">
									                var fp = new FlexPaperViewer(     
									                        '<%=request.getContextPath()%>/platform/zaixianyl/FlexPaperViewer',
									                         'viewerPlaceHolder', { config : {
									                        SwfFile : decodeURI('<%=swfpath%>'),   
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
									    <%} else%>
									    <!-- 文档结束 -->
									    
									    <!-- 音频开始 -->
									    <%if("mp3".contains(detailres.get("form"))){ %>
									    <div class="voice-bg">
											<div class="z_edit_wrap">
											    <div class="z_edit_h" style="height:40px;line-height:40px; position: absolute; top:175px; left:145px; z-index: 999;">
											        <div class="list_warp" id="J_list_warp">
											        <div class="z_edit_text" style="margin: 0 auto;width:450px; text-align: center">
											            <div id="video_detail"><audio src="<%=imgUrl+detailres.get("downUrl") %>"  preload="preload"/></div>
											        </div>
											        </div>
											    </div>
											</div>
										</div>
										<script type="text/javascript">
										    audiojs.events.ready(function() {
										        var as = audiojs.createAll();
										    });
										</script>
									    <%}else%>
									    <!-- 音频结束 -->
									    
									    <!-- 其它开始 -->
									    <%if("rar,zip".contains(detailres.get("form"))){ %>
									    <div class="rar-bg">
											<div class="z_edit_wrap">
											    <div class="z_edit_h">
											        <div class="list_warp" id="J_list_warp" style="width: 800px;">
											        <h2 class="z_edit_title">eeee </h2>
											        <div class="z_edit_text" style="margin: 0 auto;width: 650px;">
											            <a title="2222" class="rar-text">此资源为压缩包，请点击下载</a>
											        </div>
											        </div>
											    </div>
											</div>
										</div>
									    <%} %>
									    <!-- 其它结束 -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="res-button" style="width: 720px;">
						<ul>
							<li>
								<a id="J_download" onclick="updatedownloadcount('<%=detailres.get("id") %>','<%=detailres.get("name") %>','<%=imgUrl%><%=detailres.get("downUrl") %>')">下载</a>
							</li>
							<li>
								<a id="J_collect" onclick="updatecollectcount('<%=detailres.get("id") %>')">收藏</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="res-detail-right fl">
					<div class="res-supply">
						<span class="icon-publisher"></span><%=detailres.get("publish") %>
					</div>
					<div class="res-update">更新于<%=detailres.get("modifyTime") %></div>
					<div class="res-info">
						文档格式： <%=detailres.get("form")%><br> 
						资源大小： <%=detailres.get("size") %>KB<br>
					</div>
					<div class="res-about">
						相关资料
					</div>
					<ul class="res-about-list">
						<%if(list_res!=null){ for(int i=0;i<list_res.size();i++ ){ String[] res=list_res.get(i).split("&");%>
						<li>
							<%if(i<9){ %>
							<span class="res-about-num"><%="0"+(i+1) %></span>
							<%}else{ %>
							<span class="res-about-num"><%=(i+1) %></span>
							<%} %>
							<span class="res-about-listname">
								<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>" title="<%=res[2] %>" target="_slef"><%=res[2]%></a> 
							</span>
						</li>
						<%}} %>
					</ul>
				</div>
			</div>
		</div>
		<div class="clear"></div>
	</html:form>
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp" />
<script>
//更新知了树下载数
function updatedownloadcount(id,name,url){
	//下载文件
	ExtFunctionCM.downLoadFile(url,name);
	//更新下载数
	$.ajax({
		url:'<%=path%>/AjaxServlet',
		type:"post",
		traditional:true,
		async:false,
		data:{service:"com.rc.web.extension.ajax.UpdateDownLoadCount",
		parameter:["id"],
		value:[id]},
		success:function(str){},
		complete:function(XHR, TS){
			result = XHR.responseText;
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
		} 
	});
} 
//更新知了树收藏数
function updatecollectcount(id){
	$.ajax({
		url:'<%=path%>/AjaxServlet',
		type:"post",
		traditional:true,
		async:false,
		data:{service:"com.rc.web.extension.ajax.UpdatecollectCount",
		parameter:["id","url"],
		value:[id,"savecollect_url"]},
		success:function(str){},
		complete:function(XHR, TS){
			result = XHR.responseText;
			alert(result);
			if('_qam_ajax_error'==result){
				$(this)._alert('\u63d0\u793a','ajax\u8c03\u7528\u5f02\u5e38');
				throw new Error("ajax\u8c03\u7528\u5f02\u5e38");
			}
			XHR = null;
		} 
	});
} 
</script>
</body>
</html>

