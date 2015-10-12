<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.rc.tools.jsonexplain.*" %>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@ taglib uri="qamer-html" prefix="html"%>
<%
String style = request.getContextPath()+ "/platform/qiantai/teacher/images/resource";//获取样式
String resource_style = request.getContextPath()+ "/platform/qiantai/teacher/style/resource";//获取资源样式
String path = request.getContextPath() + "/servlet";//获取路径
String http=(String) request.getSession().getAttribute("imgUrl");
if(CommonUtils.null2Blank(http).length() == 0){
	return;
}
String YONGHUXM = (String) request.getSession().getAttribute("YONGHUXM");//获取用户姓名
String UID = (String) request.getSession().getAttribute("XiTongHYBH");//获取用户UID
String schoolName = (String) session.getAttribute("schoolName");//获取学校名字
String keyword = request.getParameter("keyword");//资源类型
String ziyuanlb=request.getParameter("ziyuanlb");//资源类别
if(CommonUtils.null2Blank(ziyuanlb).length() == 0){
	ziyuanlb = "";
}
String meitilx=request.getParameter("meitilx");//媒体类型
if(CommonUtils.null2Blank(meitilx).length() == 0){
	meitilx = "";
}
String currentPage = request.getParameter("currentPage");//分页相关参数 
if(CommonUtils.null2Blank(currentPage).length() == 0){
	currentPage = "1";
}
//调用接口返回数据
SubscribeJson sj=new SubscribeJson();
List<Object> obj=sj.getSubscribeJsonBS("","","","",currentPage,"12",meitilx,ziyuanlb,"");
List<Map<String,Object>> listMap=new ArrayList<Map<String,Object>>();
int count=1;
int sum=0;
if(obj.size()>0){
	int msgCode=(Integer)obj.get(0);//返回标示
	if(msgCode == 1){
		listMap=sj.getSubscribeJsonXQ(obj.get(3));
		count=(Integer)obj.get(2);	 //资源总条数
	}
}
if(count%12==0){
	sum=(int)count/12;
}else{
	sum=((int)count/12)+1;
}
request.setAttribute("sum",sum);//保存至内置对象
ResourceHelper rshelp = new ResourceHelper();//获取搜索资源
List<List<String>> list_restype=rshelp.getType();//获取资源类别
//判断展示方式
String showview =request.getParameter("showview");
String display_list="block";
String display_grid="none";
if(showview==null||"list".equals(showview)){
	display_list="block";
	display_grid="none";
}else{
	display_list="none";
	display_grid="block";
}
//查询左侧的查询条件
IDataBaseAccess dbm = null;
List<Map<String,String>> list=new ArrayList<Map<String,String>>();
try{
	dbm = ContextService.lookupDefaultDataBaseAccess();
	dbm.openConnection();
	String sql="SELECT BianHao,FenLeiMC,ZiYuanLB,MeiTiLX,ZiYuanLBMC,MeiTiLXMC FROM JSKJ_DingYueFL";
	ResultSet rs = dbm.executeQuery(sql.toString());
			while(rs.next()){
				Map<String,String> map=new HashMap<String,String>();
				map.put("BianHao",rs.getString("BianHao"));
				map.put("FenLeiMC",rs.getString("FenLeiMC"));
				map.put("ZiYuanLB",rs.getString("ZiYuanLB"));
				map.put("MeiTiLX",rs.getString("MeiTiLX"));
				map.put("ZiYuanLBMC",rs.getString("ZiYuanLBMC"));
				map.put("MeiTiLXMC",rs.getString("MeiTiLXMC"));
				list.add(map);
			}
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(dbm != null) 
	dbm.closeConnection();
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- 平台 --%>
<%@include file="/common/framework.jspf" %>
<!-- jquery -->
<%@include file="/common/jquery.jspf" %>
<%-- 验证 --%>
<%@include file="/common/jquery.validate.jspf" %>
<!-- ui -->
<%@include file="/common/ui.jspf"%>
<%-- jqgrid --%>
<%@include file="/common/jqgrid.jspf"%>	
<title>资源订阅</title>
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
<style type="text/css">
	.to-closes {width: 30px;height: 30px;float: right;cursor: pointer;}
	.page-lists a{display:inline-block;padding:0 14px;height:35px;line-height:35px;border:solid 1px #e0e0e0;text-align:center;color:#888;font-size:12px}
	.page-lists a.cur,.page-lists a.cur:hover{background:#2cb4f3;color:#fff;border-color:#2cb4f3}
	.page-lists .jp-ip{width:35px;height:35px;border:solid 1px #e0e0e0;vertical-align:middle;line-height:35px;text-align:center;margin:0 5px;}
	.to-submit{background:#FF6700 none repeat scroll 0% 0%;display: inline-block;font-size: 16px;color: #FFF;height:40px;line-height:40px;width:120px;text-align:center;border:0pxnone;vertical-align:middle;}
	.box-act a:hover{color: #FFF;}
	.table td{height: 35px;border:2px solid #F1F1F1;}
	.black_overlay{display: none;position: absolute;top:0%;left:0%;width:100%;height:100%;background-color:#272727;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=88);} 
	.white_content { display:none;position:absolute;top:25%;left: 25%;width: 55%;height: 55%;border: 1px solid #2CB4F3;background-color: white;z-index:1002;overflow: auto;} 
	.dibu a:hover{color: #FFF;}
	.quxiao{display: inline-block;background: #9B9B9B none repeat scroll 0% 0%;font-size: 16px;color: #FFF;height: 40px;line-height: 40px;width: 120px;text-align: center;margin-right: 20px;vertical-align: middle;}
	.dibu{border-top: 1px solid #D9D9D9; padding: 15px;text-align: center;}
	.titles{background:#2cb4f3;padding:10px;font-size: 16px;color: #FFF;height: 30px;}
	.titles h2{line-height: 1.9em;}
</style>
</head>
<body>
<div class="top-u-bar">
	<div class="wrap"><p>欢迎你！ <a href="gerenzhongxin.htm" class="user-name blk"><%=YONGHUXM%></a><%=schoolName%>
								 <a href="<%=path%>/desktop.html" class="to-quit">退出</a>
						</p>
	</div>
</div>
<!-- 头部 开始-->
<jsp:include page="/platform/qiantai/teacher/resource/header.jsp" />
<!-- 头部结束 -->
<html:form>
<div class="clear"></div>
<div class="wrap clearfix">
<div class="wrap clearfix" style="height:auto;">
<div class="res-content">
<div class="layout">
<!--二级导航开始-->
<div class="subnav">
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源检索</a></li>

		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSC">资源收藏</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload">资源上传</a>
		</li>
		<li><a
			href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanFX">资源分享</a>
		</li>
		<li><a
			href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanXZ">资源下载</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanDY" class="subnav-click">资源订阅</a>
		</li>
	</ul>
</div>
<!--二级导航结束--->
<!--内容1开始-->
<div class="menu fl">
    <div class="manage">
        <ul>
            <li>
            	<span class="icon-newclass"></span>
            	<a href="javascript:void(0)" id="n_addkc" name="n_addkc" class="toup-zy-1 n_addkc">新建订阅</a>
            </li>
            <li>
            	<span class="icon-manage"></span>
            	<a href="javascript:void(0)" onclick ="javascript:showGL()" id="m_addkc" name="m_addkc" class="m_addkc">订阅管理</a>
            </li>
        </ul>
    </div>
    <div class="leftmenu" style="margin-top:20px;">
        <ul>
        <%if(list.size()>0){for(int i=0;i<list.size();i++){Map<String,String> mapa=list.get(i);%>
        	<li style="word-break:break-all;"><a href="javascript:cxtj_click('<%=mapa.get("ZiYuanLB")%>','<%=mapa.get("MeiTiLX")%>')"><%=mapa.get("FenLeiMC")%></a></li>
        <%}}%>
       </ul>
    </div>
</div>
<div class="reslist-right fl">
        <div class="reslist-right-content fl">
        <ul>
            <li class="list-class">资源类别：</li>
           <% if("null".equals(ziyuanlb)||ziyuanlb==null||"".equals(ziyuanlb)){ %>
			<li><a class="reslist-click" href="javascript:zylb_click('')">全部</a></li>
			<%}else{ %>
			<li><a class="" href="javascript:zylb_click('')">全部</a></li>
			<%} %>
		 </ul>
         <ul>		
			<%if(list_restype.size()>0){for(int i=0;i<list_restype.get(0).size();i++ ){ String[] type=list_restype.get(0).get(i).split("&"); %>
				<%if(type[0].equals(ziyuanlb)){%> 
				<li><a class="reslist-click" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(小)</span></a>
				</li>
				<%} else{%>
				<li><a class="" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(小)</span></a>
				</li>
				<%} %>
			<%} }%>
		 </ul>
		 <br />
         <ul>
			<%if(list_restype.size()>0){for(int j=0;j<list_restype.get(1).size();j++ ){ String[] type=list_restype.get(1).get(j).split("&"); %>
				<%if(type[0].equals(ziyuanlb)){%>
				<li><a class="reslist-click" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(初)</span></a>
				</li>
				<%} else{%>
				<li><a class="" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(初)</span></a>
				</li>
				<%} %>
			<%} }%>
		</ul>
		 <br />
         <ul>
			<%if(list_restype.size()>0){for(int k=0;k<list_restype.get(2).size();k++ ){ String[] type=list_restype.get(2).get(k).split("&"); %>
				<%if(type[0].equals(ziyuanlb)){%>
				<li><a class="reslist-click" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(高)</span></a>
				</li>
				<%} else{%>
				<li><a class="" href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 11px;"><%=type[1] %>(高)</span></a>
				</li>
				<%} %>
			<%} }%>
		</ul>
		 <br />
        <ul>
            <li class="list-class">媒体类型：</li>
			<%if("null".equals(meitilx)||meitilx==null||"".equals(meitilx)){ %>
			<li><a class="reslist-click" href="javascript:mtlx_click('')">全部</a></li>
			<%}else{ %>
			<li><a class="" href="javascript:mtlx_click('')">全部</a></li>
			<%} %>
		 </ul>
         <ul>	
			<%if("1".equals(meitilx)){%>
			<li><a class="reslist-click" href="javascript:mtlx_click(1)">电子书</a>
			</li>
			<%} else{%>
			<li><a class="" href="javascript:mtlx_click(1)">电子书</a>
			</li>
			<%} %>
			
			<%if("2".equals(meitilx)){%>
			<li><a class="reslist-click" href="javascript:mtlx_click(2)">视频</a>
			</li>
			<%} else{%>
			<li><a class="" href="javascript:mtlx_click(2)">视频</a>
			</li>
			<%} %>
			
			<%if("3".equals(meitilx)){%>
			<li><a class="reslist-click" href="javascript:mtlx_click(3)">音频</a>
			</li>
			<%} else{%>
			<li><a class="" href="javascript:mtlx_click(3)">音频</a>
			</li>
			<%} %>
       </ul>
    </div>
    <div class="lei_count">
        <!--列表内容切换开始-->
        <div class="list-content">
            <div class="switch-box">
            <ul class="list-nav">
            	<li class=" current_01 switch-btn" onclick="showview('list')"></li>
				<li class="current_002 switch-btn" onclick="showview('grid')"></li>
            </ul>
          </div>
          <div class="aui-switch-list">
                <div class="list-wrap">
                
                <div class="aui-switch-list" style="display: <%=display_list %>;" id="list">
				 <div class="list-wrap">
                    <ul id="featured">
                    	<%if(listMap.size()>0){
                    		for(int i=0;i<listMap.size();i++){
                    			Map<String,Object> maps=listMap.get(i);
                    			String dateTime=(String)maps.get("creatTime");
                    			dateTime=dateTime.substring(0,10);
                    	%>
                    		<li class="bd_icn"><!--图标-->
                            <div class="tu_lef"><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=maps.get("id") %>" target="_blank"><span class="list-bg"></span></a></div>
                            <div class="tu_mid">
                                <span class="sp_01">
	                                <img src="<%=http %><%=maps.get("icon")%>" class="tu_lei" height="30px;" width="30px;"/>
	                                <a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=maps.get("id") %>" target="_blank"><%=maps.get("name")%></a>
                                </span>
                                <p class="res-brief">简介：<%=maps.get("introduction")%></p> 
                                <span class="sp_02">作者：<%=maps.get("author") %></span>
                                <span class="sp_02"><%=dateTime%>上传</span>
                            </div>
                            <div class="tu_rig">
                               	<div class="sp_04"><%=maps.get("downCount")%>人已下载</div>
                                   <div class="sp_03">
                                    	<span class="sp_02"><%=maps.get("companyName") %></span>
                                   	<%-- 
                                        <span class="vote-star"><i style="width:0%"></i></span><span class="vote-number">分</span>
                                    --%>
                                   </div>
                                   <div class="clear"></div>
                               	<div class="res-button">
                                    <ul>
                                        <li><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=maps.get("id")%>" target="_blank">预览</a></li>
                                        <li><a href="javascript:ExtFunctionCM.downLoadFile('<%=http %><%=maps.get("downUrl")%>','<%=maps.get("name")%>')" target="">下载</a></li>
                                        <li><a href="javascript:updatecollectcount('<%=maps.get("id")%>')">收藏</a></li>
                                    </ul>
                               	</div>
                            </div>
                        </li>	
                    	<%}}%>
                	</ul>
                	</div>
                	</div>
                	<!-- grid 展示-->
                	<div class="aui-switch-grid" style="display: <%=display_grid %>;" id="grid">
                    	 <div class="grid-content">
             				<%if(listMap.size()>0){
                        		for(int i=0;i<listMap.size();i++){
                        			Map<String,Object> maps=listMap.get(i);
                        	%>
                            	<div class="grid-content-box">
                   					 <div class="resource-name">
                               			 <span class="sp_01">
                                   			 <a title="<%=maps.get("name")%>" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=maps.get("id") %>" target="_blank"><img src="<%=http %><%=maps.get("icon")%>" width="177" height="200" class="tu_lei"/></a>
                                    	 	 <a title="<%=maps.get("name")%>" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=maps.get("id") %>" target="_blank"><%=maps.get("name")%></a>
                                    	 </span><br/>
                                    	 <span class="sp_03">2015/02/02上传</span>
                        				 <span class="sp_04"><%=maps.get("downCount")%>人已下载</span>
                   					 </div>
               					 </div>
                			<%} }%>
						</div>
					</div>
                </div>
            </div>
    	</div>
    </div>
<!--tab结束-->
<!--翻页插件-->
<div class="clear"></div>
<input type="hidden" name="currentPage" value="<%=currentPage %>" id="currentPage"/>
<input type="hidden" name="keyword" value="<%=keyword %>" id="keyword"/>
<input type="hidden" name="ziyuanlb" value="<%=ziyuanlb %>" id="ziyuanlb"/>
<input type="hidden" name="meitilx" value="<%=meitilx %>" id="meitilx"/>
<input type="hidden" name="showview" value="<%=showview %>" id="showview"/>
<div class="page-lists clearfix" align="center">
		<a id="shang" href="javascript:SX(1,<%=sum%>)">上一页</a>
		<%
		int pages=Integer.parseInt(currentPage);
		int length=0;
		if(sum<=7){
			//循环六次
			for(int i=1;i<=sum;i++){%>
				<a  id="page<%=i%>" href="javascript:click(<%=i%>)"><%=i%></a>
			<%}
		}else{
			if(pages<=3){
				for(int j=1;j<=7;j++){
				%>
					<a  id="page<%=j%>" href="javascript:click(<%=j%>)"><%=j%></a>
				<% }
			}else{
				if(sum<pages+3){
					for(int k=sum-6;k<pages-3;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
				if(sum>pages+3){
					for(int k=pages-3;k<pages+4;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}else{
					for(int k=pages-3;k<sum+1;k++){
						%>
							<a  id="page<%=k%>" href="javascript:click(<%=k%>)"><%=k%></a>
						<% 
					}
				}
			}%>
		<%} %>
		<a id="xia" href="javascript:SX(2,<%=sum%>)">下一页</a>
		<span class="p-num">共<%=sum%>页</span> 到 <input id="wenben" type="text" class="jp-ip" /> 页	
		<button type="button" onclick="TiaoZhuan()"  style="background:red">确定</button>
</div>      
<!--翻页插件-->
</div>
<!--内容1结束-->
</div>
</div>
</div>
</div>
<div class="clear"></div>
</html:form>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<!--新建订阅弹出层开始 -->
<div class="pop-box-1 hidden">
	<div class="cover"></div>
	<div class="pop-content">
		<!--  onsubmit="return formValidate()" -->
		<form name="formDingYue" id="formDingYue" action="<%=request.getContextPath()%>/servlet/ziYuanDYServlet" method="post">
		<div class="title clearfix">
			<h2>新建订阅</h2>
			<span class="to-closes"></span>
		</div>
		<div class="box-c">
			<div class="upld-form">
			<table class="table">
			<tr>
				<td style="width: 60px;" align="right">分类名称:</td>
				<td align="left"><input type="text" name="InputfenLeiMC" id="InputfenLeiMC" style="width: 400px"/></td>
			</tr>
			<tr>
				<td align="right">资源类别:</td>
				<td align="left">
					<div class="reslist-right-content fl">
					<ul>
					<%if(list_restype.size()>0){for(int i=0;i<list_restype.get(0).size();i++ ){String[] type=list_restype.get(0).get(i).split("&");%>
						<li><input type="checkbox" id="ziyuanlb" name="ziyuanlb" value="<%=type[0]%>"/><%=type[1] %>(小)</li>
					<%} }%>
					</ul>
					<br />
					<ul>
					<%if(list_restype.size()>0){for(int j=0;j<list_restype.get(1).size();j++ ){ String[] type=list_restype.get(1).get(j).split("&"); %>
						<li><input type="checkbox" id="ziyuanlb" name="ziyuanlb" value="<%=type[0]%>"/><%=type[1] %>(初)</li>
					<%} }%>
					</ul>
					<br />
					<ul>
					<%if(list_restype.size()>0){for(int k=0;k<list_restype.get(2).size();k++ ){ String[] type=list_restype.get(2).get(k).split("&"); %>
						<li><input type="checkbox" id="ziyuanlb" name="ziyuanlb" value="<%=type[0]%>"/><%=type[1] %>(高)</li>
					<%} }%>
					</ul>
				</div>
					<input type="hidden" id="ziyuanlbText" name="ziyuanlbText"/>
				</td>
			</tr>
			<tr>
				<td align="right">媒体类型:</td>
				<td align="left">
					<div class="">
						<ul>
							<li style="float:left;"><input type="checkbox" id="meitilx" name="meitilx" value="1"/>电子书</li>
							<li style="float:left;"><input type="checkbox" id="meitilx" name="meitilx" value="2"/>视频</li>
							<li style="float:left;"><input type="checkbox" id="meitilx" name="meitilx" value="3"/>音频</li>
						</ul>
					</div>
					<input type="hidden" id="meitilxText" name="meitilxText"/>
				</td>
			</tr>
		</table>
			</div>
		</div>
		<div class="box-act">
			<a href="javascript:void(0)" class="to-submit" onclick="javascript:formValidate()">保存</a>
			<a href="javascript:void(0)" class="to-close">取消</a>
		</div>
	</form>
	</div>
</div>
<!--新建订阅弹出层结束-->
<!-- 管理弹出层开始 -->
<div id="light" class="white_content">
<form name="formShanChuDingYue" id="formShanChuDingYue" action="<%=request.getContextPath()%>/servlet/shanChuDYServlet" method="post">
<div class="titles " align="left">
	<h2>订阅管理</h2>
</div>
<div style="padding: 20px; height:190px; overflow: auto;">
<table class="table">
	   <tr>
        	<td  width="40px"><b>请选择</b></td>
        	<td  width="100px"><b>订阅名称</b></td>
        	<td  width="300px"><b>资源类别</b></td>
        	<td  width="100px"><b>媒体类型</b></td>
       </tr>
	 <%if(list.size()>0){for(int i=0;i<list.size();i++){Map<String,String> mapa=list.get(i);%>
        <tr>
        	<td  width="40px"><input type="checkbox" id="liebiaoBH" name="liebiaoBH" value="<%=mapa.get("BianHao")%>"/></td>
        	<td  width="10px" style="word-break:break-all"><%=mapa.get("FenLeiMC")%></td>
        	<td  width="300px" style="word-break:break-all"><%=mapa.get("ZiYuanLBMC")%></td>
        	<td  width="100px"><%=mapa.get("MeiTiLXMC")%></td>
        </tr>
     <%}}%>
</table>
</div>
<div class="dibu">
	<a href="javascript:void(0)" class="to-submit" onclick="javascript:formShanChu()">删除</a>
	<a href = "javascript:void(0)" onclick = "javascript:closeGL()" class="quxiao">取消</a>
</div>
</form>
</div> 
<div id="fade" class="black_overlay"></div> 
<!-- 管理弹出层结束 -->
<script type="text/javascript">
$("img").one("error", function() {
		$(this).attr("src", "<%=request.getContextPath()%>/platform/qiantai/teacher/images/default.png");
});
<%Object msg=request.getAttribute("msg");if(msg != null){%>
alert('<%=msg%>');
<%}%>
//关闭层
function closeGL(){
	document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none';
}
//弹出层
function showGL(){
	document.getElementById('light').style.display='block';
	document.getElementById('fade').style.display='block';
}
//初始化样式
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});
//提交分页
function pageSubmit(){
	document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanDY";
	document.forms[0].submit();
}
  //点击确定
function TiaoZhuan(){
  	var num=$("#wenben").val();
  	var sum='<%=sum%>';
  	if(Number(num)>Number(sum)){
  		$("#wenben").val("1");
  	}
  	var reg = new RegExp("^[0-9]*$");  
  	if(!reg.test(num)){
  		$("#wenben").val("1");
  	}
  	if(num<1){
  		$("#wenben").val("1");
  	}
	$("#currentPage").val($("#wenben").val());
	//控制当前页码
	pageSubmit();
}
//点击页码
function click(i){
	$("#currentPage").val(i);
	pageSubmit();
 }
//点击资源类别
function zylb_click(i){
	$("#ziyuanlb").val(i);
	pageSubmit();
}
//点击左侧查询条件
function cxtj_click(zylb,mtlx){
	$("#ziyuanlb").val(zylb);
	$("#meitilx").val(mtlx);
	pageSubmit();
}
//点击媒体类型
function mtlx_click(i){
	$("#meitilx").val(i);
	pageSubmit();
}
//点击上一页和下一页
function SX(e,sum){
	var s=$("#currentPage").val();
	if(e==1){//上一页
		if(s>1){
			s=s-1;
			$("#currentPage").val(s);
			pageSubmit();
		}
	}else if(e==2){//下一页 
		if(s<sum){
			s=parseFloat(s)+1;
			$("#currentPage").val(s);
			pageSubmit();
		}
	}
}
//改变展示类型
function showview(type){
	if(type=="list"){
		$("#list").show();
		$("#grid").hide();
	}else{
		$("#list").hide();
		$("#grid").show();
	}
	$("#showview").val(type);
}
//判断长度
function len(s) {
	 var l = 0;
	 var a = s.split("");
	 for (var i=0;i<a.length;i++) {
	  if (a[i].charCodeAt(0)<299) {
	   l++;
	  } else {
	   l+=2;
	  }
	 }
	 return l;
	}
//表单提交验证
function formValidate() {
	var InputfenLeiMC=$("#InputfenLeiMC").val();
	if(!InputfenLeiMC){
		alert("分类名称不允许为空！");
		return false;
	}
	if(len(InputfenLeiMC)> 20){
		alert("长度不能大于20个字符（一个中文等于2个字符）！");
		return false;
	}
	//判断资源类别是否有选中项，默认为无 
	var isSel1=FeiKongYZ('ziyuanlb');
	if(isSel1==false){ 
		alert("请选择资源类别！"); 
		return false; 
	}
	//判断媒体类型是否有选中项，默认为无 
	var isSel2=FeiKongYZ('meitilx');
	if(isSel2==false){ 
		alert("请选择媒体类型！"); 
		return false; 
	}
	//获取文本赋值
	$("#ziyuanlbText").val(getCheckBox('ziyuanlb','text'));
	$("#meitilxText").val(getCheckBox('meitilx','text'));
	//验证是否重复
	var FenLeiMCYZ=$("#InputfenLeiMC").val();
	var count = ExtFunctionCM.CheckRecordCount("JSKJ_DingYueFL"," WHERE  FenLeiMC='" + FenLeiMCYZ + "'");
	if (count > 0) {
		alert('分类名称已存在,请重新填写');
		return false;
	}
	var ZiYuanLBYZ=getCheckBox('ziyuanlb','value');
	var MeiTiLXYZ=getCheckBox('meitilx','value');
	var count1 = ExtFunctionCM.CheckRecordCount("JSKJ_DingYueFL"," WHERE  ZiYuanLB='" + ZiYuanLBYZ + "' AND MeiTiLX='" + MeiTiLXYZ + "'");
	if (count1 > 0) {
		alert('订阅已存在,请重新选择');
		return false;
	}
	//提交表单
	document.formDingYue.submit();
}
//删除
function formShanChu(){
	var isSel3=FeiKongYZ('liebiaoBH');
	if(isSel3==false){ 
		alert("请选择要删除的订阅！"); 
		return false; 
	}
	//提交表单
	document.formShanChuDingYue.submit();
}
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
//获取文本 或 value
function getCheckBox(canshu,state){
	var text;
    var obj=document.getElementsByName(canshu);  
    for(var i=0;i<obj.length;i++){  
         if(obj[i].checked){
        	 if(state=='text'){//如果state为text 就获取文本 否则获取value
        		 if(text){
                	 text=text+","+obj[i].nextSibling.nodeValue;
                 }else{
                	 text=obj[i].nextSibling.nodeValue;
                 }
        	 }else if(state=='value'){
        		 if(text){
             		text=text+","+obj[i].value;
             	 }else{
             		text=obj[i].value;
             	 }
        	 }
         }  
    } 
    return text;
} 
//非空验证
function FeiKongYZ(canshu){
	var objs=document.getElementsByName(canshu); 
	var isSel=false;
	for(var i=0;i<objs.length;i++){ 
		if(objs[i].checked==true){ 
			isSel=true; 
			break; 
		} 
	}
	return isSel;
}
</script>
</body>
</html>
