
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="com.rc.web.extension.component.gethaoyouxx.GetHaoYouLB" %>

<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.*" %>
<%@page import="java.text.ParseException" %>
<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue" %>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.rc.web.extension.component.tongxinlu.insertTongXinL"%>
<%@page import="java.util.Map,java.net.*"%>
<%-- 平台 --%>
	<%@include file="/common/framework.jspf"%>

 <%
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath();
	String YONGHUXM=(String)request.getSession().getAttribute("YONGHUXM");
	String yonghubh=(String)request.getSession().getAttribute("XiTongHYBH");
	String key=(String)request.getSession().getAttribute("QuanZhi");
	GetHaoYouLB haoyou=new GetHaoYouLB();
	String image=(String)request.getSession().getAttribute("Image");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>个人中心-教师</title>
	<meta name="Keywords" content=""/>
	<meta name="Description" content=""/>
    <link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
   
</head>
<style>
<!--
.zjx-areatext .txt-input{width:511px;height:100px;border: 2px solid #f1f1f1;margin-top:15px;}
-->
.page-list ul li{width:auto;white-space: nowrap;float: left;text-overflow:ellipsis; overflow: hidden; }
</style>
<%
String kechengbh=(String)request.getParameter("KeChengBH");
String kcmc="";
String kechengmc="";
String kslj="";
StringBuffer keshiHtml= new StringBuffer();
//循环生成课程列表
IDataBaseAccess dbm = null;
StringBuffer sql=new StringBuffer();
sql.append("select DISTINCT biaoti,jskj_kecheng.BianHao from jskj_kecheng ,jskj_keshi where jskj_keshi.kechengbh=jskj_kecheng.bianhao and jianlir='"+yonghubh+"' and biaoti is not null");
StringBuffer htmlKC=new StringBuffer();
try{
	dbm = ContextService.lookupDefaultDataBaseAccess();
	dbm.openConnection();
	ResultSet rs= dbm.executeQuery(sql.toString());
	while (rs.next()) {
		if("".equals(kechengbh)||kechengbh==null){
			kechengbh=rs.getString(2);
			kechengmc=rs.getString(1);
			htmlKC.append("<li ><a title=\""+rs.getString(1)+"\" style=\"width: 100px\" class=\"cur\" onClick=\"changePL('"+rs.getString(2)+"')\">"+rs.getString(1)+"</a></li>");
		}else{
			if(kechengbh.equals(rs.getString(2))){
				kechengmc=rs.getString(1);
				htmlKC.append("<li ><a title=\""+rs.getString(1)+"\" style=\"width: 100px\" class=\"cur\" onClick=\"changePL('"+rs.getString(2)+"')\">"+rs.getString(1)+"</a></li>");
			}else{
				htmlKC.append("<li ><a title=\""+rs.getString(1)+"\" style=\"width: 100px\" onClick=\"changePL('"+rs.getString(2)+"')\">"+rs.getString(1)+"</a></li>");
			}
		}
	} 
}
catch(Exception e){
	e.printStackTrace();
}finally{
if(dbm != null) dbm.closeConnection();
}
%>	
<%
	String pagesize=(String)request.getParameter("pagesize");
	if("".equals(pagesize)||pagesize==null){
		pagesize="1";
	}
	GetInterfacesValue	getInterfacesValue=new GetInterfacesValue();
	String json=getInterfacesValue.getJson(pagesize,yonghubh,key,kechengbh);
	int count=getInterfacesValue.getPageCount(yonghubh,key,kechengbh);
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	int sum=count/3;
	if(count<3){
		sum=1;
	}else{
		if(count%3>0){
			sum+=1;
		}
	}
	insertTongXinL txl=new insertTongXinL();
	txl.insertTXL(yonghubh,kechengmc,key,kechengbh);
%>
<body>
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ" class="user-name blk"><%=YONGHUXM %></a><%=schoolName %><a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueKJ" class="cur">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueZB">教学准备</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoShiFZ">教师发展</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_YingYongZX">应用中心</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_JiaoXueGZS">教师工作室</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanZX">资源中心</a></li>
		</ul>
	</div>
</div>
<div class="wrap clearfix">
<div class="fl mt-20 w-710">
<table>
	<tr>
		<td width="150px" align="center" valign="top">
			<div class="user-c-form">
				<div class="title-bar green-title clearfix">
					<h2 class="fl">课程列表</h2>
				</div>
			</div>
			<div class="page-list clearfix">
					<ul class="clearfix">
						<%=htmlKC %>
					</ul>
				</div>
		</td>
	<td>
		<html:form>
		    <div class="zjx-areatext">
              	 <textarea id="fabiaotl" rows="5" style="width: 100%" cols=""></textarea>
               <div class="begindiscus-btn"><img src="<%=style%>/images/begindiscus.png" onclick="startFT()"/></div>
            </div>
            <input type="hidden" id="pageNumber" value="<%=pagesize%>"/>
					<input type="hidden" id="pageSum" value="<%=sum%>"/>
                      <!--列表-->
				<iframe width="100%" height="590px" align="top"  id="liebiao"
						src="<%=path %>/platform/qiantai/student/tiebaxx_grkj.jsp?pagesize=1&&KeChengBH=<%=kechengbh%>"
						style="border:none;" frameborder="0" scrolling="auto"></iframe>
         </html:form>
	</td>
	</tr>
	
	</table>
    </div>
	<div class="fr w-230">
    	  <!-- 个人简介 -->
          	<div class="tech-user mt-20">
			<div class="pic"><a href="#"><img src="<%=imgUrl+image%>" alt="" /></a></div>
			<div class="name mt-10"><%=YONGHUXM %></div>
			<div class="sc-info">${schoolName}</div>
			<div class="user-num clearfix">
				<div class="fd-num fl">
					<a href="#" class="blk">语文</a> <br />
					任教学科
				</div>
				<div class="std-num fl">
					<a href="#" class="blk">二年级</a> <br />
					任教年级
				</div>
			</div>
			<html:form>
            <div class="tech-btn-mc">
                <span "tech-span-one"><input type="button" value="查看个人资料" class="yx-btn" onclick="chakangrzl()"/></span>
                <span "tech-span-two"><input type="button" value="我的好友" class="yx-btn" onclick="wodehaoyou()" /></span>
                
            </div>
            </html:form>
		</div>
		<script type="text/javascript">
				function wodehaoyou(){
					document.forms[0].action="<%=path %>/platform/qiantai/teacher/wodehaoyou.jsp";
					document.forms[0].submit();
				}
				function chakangrzl(){
					document.forms[0].action="<%=path %>/platform/qiantai/teacher/chakangerenzl.jsp";
					document.forms[0].submit();
				}
		</script>

        <!-- 导航列表 好友动态、与我相关、应用中心-->
		<div class="all-grzx-jslist mt-20">
			

			
		</div>
		

            <!--好友列表 -->
       <div class="tech-std mt-20">
			<div class="kc-ss">
				<h3>好友列表</h3>
			</div>
       <!--好友列表 -->   
        <div class="goodfriends-group-gr mt-20">
			<div class="the-list">
				<ul class="clearfix">
				
				<%
				List<List> list=new ArrayList<List>();
				list=haoyou.getHaoYou(yonghubh,key);
				StringBuffer html=new StringBuffer();
				int size=0;
				if(list.size()>10){
					size=10;
				}else{
					size=list.size();
				}
				for(int i=0;i<size;i++){
					html.append("<li>");
					html.append("<a><img src=\""+imgUrl+list.get(i).get(1)+"\" alt=\"\" /></a>");
					html.append("<span class=\"rr\">"+list.get(i).get(0)+"</span>");
					html.append("<span class=\"fr mm\"></span>");
					html.append("</li>");
				}
				%>
				<%=html.toString() %>
				</ul>
			</div>
		</div>
</div>
	</div>
	

</div>





<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
<script type="text/javascript">
					function changePL(kechengbh){
						document.forms[0].action="<%=path %>/platform/qiantai/teacher/gerenzhongxin-jiaoshi.jsp?pagesize=1&KeChengBH="+kechengbh;
						document.forms[0].submit();
					}
				
					function kechengtz(kechengbh){
						document.forms[0].action="<%=path %>/platform/qiantai/teacher/gerenzhongxin-jiaoshi.jsp?pagesize=1&KeChengBH="+kechengbh;
						document.forms[0].submit();
					}
					function startFT(){
						var neirong=$('#fabiaotl').val();
						if(!neirong){
							alert('请输入内容！');
							return false;
						}else{
							var kechenbh='<%=kechengbh%>';
							var result="";
							$.ajax({
								url:path+'/servlet/AjaxServlet',
								type:"post",
								traditional:true,
								async:false,
								data:{service:"com.rc.web.ajax.setFaBiaoTLService",
									parameter:["NeiRong","kechengbh","kechengmc"],
									value:[neirong,kechenbh,'<%=kechengmc%>']},
								complete:function(XHR, TS){
									result = XHR.responseText;
									if(result){
										alert("发布失败！");
									}else{
										$('#fabiaotl').val('');
										$("#liebiao").attr("src","<%=path %>/platform/qiantai/student/tiebaxx_grkj.jsp?pagesize=1&&KeChengBH="+kechenbh);
									}
									XHR = null;
								}
							});
						}
					}
					function click(i){
						$('#pageNumber').val(i);
						pageSubmit(i);
					}
					function pageSubmit(i){
						var sum=$('#pageSum').val();
						var kechenbh='<%=kechengbh%>';
						$("#liebiao").attr("src","<%=path %>/platform/qiantai/student/tiebaxx_grkj.jsp?pagesize="+i+"&&KeChengBH="+kechenbh);
					}
			    	//点击确定
			    	function TiaoZhuan(){
			    		var sun=$("#liebiao").contents().find("#wenben").val();
			    		var pageSum=$('#pageSum').val();
			    		if(sun<1||sun*1>pageSum*1){
			    			sun=1;
			    		}
			    		$("#pageNumber").val(sun);//控制当前页码
			    		pageSubmit(sun);
			    	}
			    	//点击上一页和下一页
			    	function SX(e,sum){
			    		var s=$("#pageNumber").val();
			    		if(e==1){//上一页
			    			if(s>1){
			    				s=s-1;
			    				$("#pageNumber").val(s);
			    				pageSubmit(s);
			    			}else{
			    				//alert("当前页为首页");
			    			}
			    		}else if(e==2){//下一页 
			    			if(s<sum){
			    				s=parseFloat(s)+1;
			    				$("#pageNumber").val(s);
			    				pageSubmit(s);
			    			}else{
			    				//alert("当前页为尾页");
			    			}
			    		}
			    	}
					</script>
</body>
</html>