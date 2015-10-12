<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.resource.ResourceHelper"%>
<%@page import="com.qam.framework.util.CommonUtils"%>
<%@page import="java.util.*"%>
<%@ taglib uri="qamer-html" prefix="html"%>
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
	//获取学校名字
	String schoolName = (String) session.getAttribute("schoolName");
	//imgUrl
	String url = (String) request.getSession().getAttribute("imgUrl");
	//资源类型
	String keyword = request.getParameter("keyword");
	//分页相关参数 
	String currentPage = request.getParameter("currentPage");
	if(CommonUtils.null2Blank(currentPage).length() == 0){
		currentPage = "1";
	}
	//资源类别
	String ziyuanlb=request.getParameter("ziyuanlb");
	//媒体类型
	String meitilx=request.getParameter("meitilx");
	//获取搜索资源
	ResourceHelper rshelp = new ResourceHelper();
	List<List<String>> list = rshelp.getResourceBySearch(keyword,ziyuanlb,meitilx,currentPage,"10",null,null,null,null); 
	List<String> list_cout=null;
	List<String> list_res=null;
	if(list.size()>0){
		list_cout=list.get(0);
		list_res=list.get(1);
	}
	
	int sum=0;//总页数
	int totalnum=0;//总条数
	if(list_cout!=null&&list_cout.get(0)!=null){
		totalnum=Integer.parseInt(list_cout.get(0));
		sum=Integer.parseInt(list_cout.get(0));
		}
	if(sum%10==0){
		sum=(int)sum/10;
	}else{
		sum=((int)sum/10)+1;
	}
	request.setAttribute("sum",sum);//保存至内置对象
	//获取资源类别
	List<List<String>> list_restype=rshelp.getType();
	
	//判断展示方式
	String showview =request.getParameter("showview");
	String display_list="block";
	String display_grid="none";
	if(showview==null||"list".equals(showview)){
		display_list="block";
		display_grid="none";
		showview ="list";
	}else{
		display_list="none";
		display_grid="block";
		showview ="grid";
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- 平台 --%>
<%@ include file="/common/script/ExtFunctionCM.jspf" %>
<title>资源搜索</title>
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/common.css" rel="stylesheet" type="text/css" />
<link href="<%=resource_style%>/resource.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=style%>/js/base.js"></script>
<script type="text/javascript" src="<%=style%>/js/sea.js"></script>
<style type="">
 .to-sub {
    background: #2cb4f3 none repeat scroll 0 0;
    border: 0 none;
    color: #fff;
    cursor: pointer;
    font-weight: bold;
    height: 38px;
    line-height: 38px;
    margin-left: 10px;
    vertical-align: middle;
    width: 60px;
}
</style>
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
	<div class="wrap clearfix">
		<div class="wrap clearfix" style="height:auto;">
			<div class="res-content">
				<div class="layout">
					<!--二级导航开始-->
					<div class="subnav">
						<ul>
							<li><a
								href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX"
								class="subnav-click">资源检索</a></li>
							<li><a
								href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSC">资源收藏</a>
							</li>
							<li><a href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload">资源上传</a>
							</li>
							<li><a
								href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanFX">资源分享</a>
							</li>
							<li><a
								href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanXZ">资源下载</a>
							</li>
							<li><a
								href="<%=request.getContextPath()%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanDY">资源订阅</a>
							</li>

						</ul>
					</div>
					<!--二级导航结束--->
					<div class="clear"></div>
					<div class="newr">
						检索到包含关键字“<span class="newr-text"><%=keyword%></span>”的资源<%=totalnum %>条
					</div>
					<!--内容1开始-->
					<div class="sea-right fl">
						<div class="search-content fl">
							<ul>
								<li class="list-class">资源类别：</li>
								<% if("null".equals(ziyuanlb)||ziyuanlb==null||"total".equals(ziyuanlb)){ %>
								<li><a class="reslist-click" href="javascript:zylb_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:zylb_click('total')">全部</a></li>
								<%} %>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int i=0;i<list_restype.get(0).size();i++ ){ String[] type=list_restype.get(0).get(i).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%> 
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(小)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(小)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int j=0;j<list_restype.get(1).size();j++ ){ String[] type=list_restype.get(1).get(j).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%>
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(初)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(初)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<%if(list_restype.size()>0){for(int k=0;k<list_restype.get(2).size();k++ ){ String[] type=list_restype.get(2).get(k).split("&"); %>
									<%if(type[0].equals(ziyuanlb)){%>
									<li><a class="reslist-click"
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(高)</span></a>
									</li>
									<%} else{%>
									<li><a class=""
										href="javascript:zylb_click(<%=type[0]%>)"><span style="font-size: 10px;"><%=type[1] %>(高)</span></a>
									</li>
									<%} %>
								<%} }%>
							</ul>
							<ul>
								<li class="list-class">媒体类型：</li>
								<%if("null".equals(meitilx)||meitilx==null||"total".equals(meitilx)){ %>
								<li><a class="reslist-click" href="javascript:mtlx_click('total')">全部</a></li>
								<%}else{ %>
								<li><a class="" href="javascript:mtlx_click('total')">全部</a></li>
								<%} %>
								
								<%if("1".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(1)">电子书</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(1)">电子书</a>
								</li>
								<%} %>
								
								<%if("2".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(2)">视频</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(2)">视频</a>
								</li>
								<%} %>
								
								<%if("3".equals(meitilx)){%>
								<li><a class="reslist-click"
									href="javascript:mtlx_click(3)">音频</a>
								</li>
								<%} else{%>
								<li><a class=""
									href="javascript:mtlx_click(3)">音频</a>
								</li>
								<%} %>
							</ul>
							<!--  
							<ul>
								<li class="list-class">文件格式：</li>
								<li><a class="reslist-click"
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">全部</a>
								</li>
								<li><a class=""
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;extension=rar&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">rar</a>
								</li>
								<li><a class=""
									href="http://localhost/hs_edu/index.php?m=resource&amp;c=index&amp;a=serach&amp;keyword=%E5%85%AD%E5%B9%B4%E7%BA%A7&amp;userType=&amp;showType=grid&amp;cateId=&amp;typeId=&amp;extension=zip&amp;subjectId=&amp;gradeId=&amp;classId=&amp;chapterId=">zip</a>
								</li>
							</ul>
							-->
						</div>

						<div class="lei_count">
							<!--列表内容切换开始-->
							<div class="list-content">
								<div class="sea-switchbox">
									<ul class="search-nav">
										<li class=" current_01 switch-btn"
											onclick="showview('list')"></li>
										<li class="current_002 switch-btn"
											onclick="showview('grid')"></li>
									</ul>
								</div>
								<div class="aui-switch-list">
									<div class="list-wrap">
									
										<div class="aui-switch-list" style="display: <%=display_list %>;" id="list">
											<div class="list-wrap">
												<ul id="featured">
													<%if(list_res!=null){ for(int i=0;i<list_res.size();i++ ){ String[] res=list_res.get(i).split("&");%>
													<li class="sea-icn">
														<!--图标-->
														<div class="tu_lef">
															<a
																href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>"
																target="_blank"><span class="list-bg"></span>
															</a>
														</div>
														<div class="tu_mid">
															<span class="sp_01">
																<img src="<%=url %><%=res[0] %>" class="tu_lei" height="20"/>
																<a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>" 
																target="_blank"><%=res[2] %></a>
															</span>
															<p class="res-brief">简介：</p>
															<a title="<%=res[3] %>" ><span class="sp_02"><%=res[3].length()<=45?res[3]:res[3].substring(0,45) %></span> </a>
															<span class="sp_02"></span> 
															<span class="sp_02"></span> 
															<span class="sp_02"><%=res[4] %>上传</span>
														</div>
														<div class="tu_rig">
															<div class="sp_04"><%=res[5] %>人已下载</div>
															<div class="sp_03" style="display: none">
																<span class="vote-star"><i style="width:0%"></i>
																</span><span class="vote-number">分</span>
															</div>
															<div class="clear"></div>
															<div class="res-button">
																<ul>
																	<li><a
																		href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>"
																		target="_blank">预览</a>
																	</li>
																	<li><a
																		href="javascript:updatedownloadcount('<%=res[1] %>','<%=res[2] %>','<%=url%><%=res[6] %>')"
																		target="">下载</a>
																	</li>
																	<li><a
																		href="javascript:updatecollectcount('<%=res[1] %>')">收藏</a>
																	</li>
																</ul>
															</div>
														</div>
													</li>
													<%} }%>
												</ul>
											</div>
										</div>
										<!-- grid 展示-->
										<div class="aui-switch-grid" style="display: <%=display_grid %>;" id="grid">
                            				<div class="grid-content">
                            					<%if(list_res!=null){ for(int i=0;i<list_res.size();i++ ){ String[] res=list_res.get(i).split("&");%>
                                            	<div class="grid-content-box">
                                   					 <div class="resource-name">
                                               			 <span class="sp_01">
                                                   			 <a title="<%=res[2] %>" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>" target="_blank"><img src="<%=url %><%=res[0] %>" width="177" height="200" class="tu_lei"/></a>
                                                    	 	 <a title="<%=res[2] %>" href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_YuanChengZYYL&CS_RESID=<%=res[1] %>" target="_blank"><%=res[2] %></a>
                                                    	 </span><br/>
                                                    	 <span class="sp_03"><%=res[4] %>上传</span>
                                        				 <span class="sp_04"><%=res[5] %>人已下载</span>
                                   					 </div>
                               					 </div>
                               					 <%} }%>
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
							<div class="page-list clearfix" align="center">
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
	</div>

	<div class="clear"></div>
	</html:form>
	<!-- 页尾 -->
	<jsp:include page="/bottomPage.jsp" />
	<script type="text/javascript">
	$("img").one("error", function() {
		$(this).attr("src", "<%=style%>/images/default.png");
	});
$(function(){
	//样式
	$("#page"+$("#currentPage").val()).addClass("cur");
	//给文本框赋值
	$("#wenben").val($("#currentPage").val());
});
//提交分页
    function pageSubmit(){
		document.forms[0].action="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanSS";
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
