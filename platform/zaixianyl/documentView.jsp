<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@page import="java.io.*"%>  
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.Enumeration"%>  
<%@page import="com.rc.web.utils.DocConverter"%>  
<%@page import="com.qam.framework.core.transaction.execution.CanReturnException" %>
<html>  
	<head>  
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<!-- 在线预览 -->
<%@include file="/common/fp.jspf" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
	<style type="text/css" media="screen">   
	            html, body  { height:100%; }  
	            body { margin:0; padding:0; overflow:auto; }     
	            #flashContent { display:none; }  
	        </style>   
	<title>预览</title> 

	</head> 
<%  
String filePath=request.getParameter("filePath");//路径和原始名字
String fileName=request.getParameter("fileName");//上传后新生成名字
String swfpath="";//路径
String odtPath = "";
String saveDirectory =application.getRealPath("");//获取盘符
//拼接新的路径
String converfilename=saveDirectory.replaceAll("\\\\","/")+"/"+ filePath.substring(0,filePath.lastIndexOf("/")+1)+fileName;
//创建转换类对象，并传入路径
DocConverter d = new DocConverter(converfilename);
d.conver();//调用转换方法进行转换
//返回转换过后swf的新路径
String swf = d.getswfPath();
//获取上传的目标文件夹名称
String path=filePath.substring(0,filePath.indexOf("/"));
if(CommonUtils.null2Blank(swf).length() > 0){
swfpath = swf.substring(swf.indexOf(path),swf.length());
}
String odt = d.getodtPath();
if(CommonUtils.null2Blank(odt).length() > 0){
	odtPath = odt.substring(odt.indexOf(path),odt.length());
}
%>  
	<body> 
	<%if(CommonUtils.null2Blank(swfpath).length() > 0){%>
	   <div style="position:absolute;left:0px;top:0px;right:0px;bottom:0px;">  
            <a id="viewerPlaceHolder" style="width:1150px;height:550px;display:block"></a>  
	            <script type="text/javascript">
	                var fp = new FlexPaperViewer(     
	                        '<%=request.getContextPath()%>/platform/zaixianyl/FlexPaperViewer',
	                         'viewerPlaceHolder', { config : {
	                        //escape  decodeURI //request.getContextPath()+"/"+    
	                        SwfFile : decodeURI('<%=request.getContextPath()+"/"+swfpath%>'),   
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
	}else{ %>
	        	<script type="text/javascript">
	        	if(confirm('该文件不支持在线预览，请下载后查看！')){
	        		$(this)._close(1);
	        	}else{
	        		$(this)._close(1);
	        	}
	        	</script>
	        <%}
	%>
	</body> 
	<html:hidden id="swfFile" value="<%=swfpath%>"/>
	<html:hidden id="odtFile" value="<%=odtPath%>"/>
</html>  
	