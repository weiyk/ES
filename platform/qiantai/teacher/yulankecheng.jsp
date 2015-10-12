<%@page import="com.rc.web.extension.component.getjiekouxx.GetInterfacesValue"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.beans.submitreturn.RecordSet"%>
<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//获取样式
	String style=request.getContextPath()+"/platform/qiantai/teacher";
	//获取路径
	String path=request.getContextPath()+"/servlet";
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	//获取学校名字
	 String schoolName=(String) session.getAttribute("schoolName");
	 String imgUrl=(String)request.getSession().getAttribute("imgUrl");
%>
<html>
<head>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程预览</title>
<meta name="Keywords" content="">
<meta name="Description" content="">
<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=style %>/js/base.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/common/jwplayer7/jwplayer.js"></script>
<script type="text/javascript">jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";</script>
</head>
<body>
<html:dialog id="GNDH_YuLanKC" state="DHZT_YuLanSPCX"/>
<%
	// 课程信息
	RecordSet kcxxRS = executeResult.getRecordSet("SWDY_KeChengXXCX");
	kcxxRS.next();
	
	IDataBaseAccess dbm = null;
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		ResultSet rs = null;
		// session获取登录用户编号
		String yonghubh =(String)session.getAttribute("XiTongHYBH");
		String sql = "select x.BIANHAO, x.DENGLUM, x.descn from xt_yonghu x where x.bianhao='" + yonghubh + "'";	
		rs = dbm.executeQuery(sql);
		if (rs.next()) {
			request.setAttribute("descn", rs.getString("descn"));
		}
	} catch (Exception e) {
		e.printStackTrace();	
	} finally {
		if (dbm != null)
			dbm.closeConnection();
	}
%>
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

<div class="wrap-kc clearfix">
    <div id="div_left" class="fl w-230">
      <!-- 授课老师 -->
		<div class="cp-course-techer mt-400">
			<div class="pic"><a href="<%=path%>/jspdispatchservlet?_qam_dialog=GNDH_LaoShiGRKJ"><img src="${imgUrl}${TouXiang}" alt="" /></a></div>
            <div class="title-teach">授课老师</div>
			<div class="name mt-10">${YONGHUXM}</div>
			<div class="sc-info" style="margin-left: 70px;">${schoolName} </div>
			<div class="teacher-info">
			<p>${descn }</p>
			</div>
		</div>
    </div>

        <div class="fl mt-10" style="margin-left:15px; min-width: 600px;">
				 <div class="td-zt">
					 您所在的位置：<%=kcxxRS.getString("di_NianJi") %>/<%=kcxxRS.getString("di_KeMu") %>&nbsp;<%=kcxxRS.getString("di_KeShiMC") %>
				 </div>
				 
			<%
				//预览课程查询
				RecordSet ylkcRS = executeResult.getRecordSet("SWDY_YuLanKCCX");
				StringBuffer playList = new StringBuffer("[");
				// 是否添加“,”标识
				boolean comman = false;
				while (ylkcRS.next()) {
					if (comman)
						playList.append(",");
					playList.append("{title: '" + ylkcRS.getString("di_ShiPinMC") + "', file:'" + request.getContextPath() + "/" + ylkcRS.getString("di_ShiPinLJ") + "'}");
					comman = true;
				}
				playList.append("]");
				
				System.out.println(playList);
			%>
				 <div class="title-bar clearfix mt-20">
							<h2><%String shiPinMC = ylkcRS.getString("di_ShiPinMC"); if (shiPinMC != null) {out.println(shiPinMC);}%></h2>
				</div>
				
				<div class="z_edit_wrap">
				    <div class="z_edit_h">
				        <div class="list_warp" id="J_list_warp">
				      	  <div class="z_edit_text" style="margin: 0 auto;width: 720px;">
					            <div style="position: relative; display: block; width: 720px; height: 365px;" id="J_player_wrapper">
				            		<div id="container">Loadingthe player...</div>
									<script type="text/javascript">
									    jwplayer("container").setup({
									        flashplayer:"<%=request.getContextPath() %>/common/jwplayer7/jwplayer.flash.swf",
									        playlist: <%=playList.toString()%>,
									        "playlist.position":"right",
									        "playlist.size":360,
									        height:365,
									        width:720
									    });
									</script>
					            </div>
							</div>
				        </div>
				    </div>
				</div>
			<%
			%>
			<%
				String yonghubh=(String) session.getAttribute("XiTongHYBH");
				String key=(String) session.getAttribute("QuanZhi");
				String pagesize=(String)request.getParameter("pagesize");
				if("".equals(pagesize)||pagesize==null){
					pagesize="1";
				}
				String kechengbh=kcxxRS.getString("di_KeChengBH");
				GetInterfacesValue	getInterfacesValue=new GetInterfacesValue();
				String json=getInterfacesValue.getJson(pagesize,yonghubh,key,kechengbh);
				int count=getInterfacesValue.getPageCount(yonghubh,key,kechengbh);
				int sum=count/3;
				if(count<3){
					sum=1;
				}else{
					if(count%3>0){
						sum+=1;
					}
				}
			%>
			
			<script type="text/javascript">
			function click(i){
				$('#pageNumber').val(i);
				pageSubmit(i);
			}
			function pageSubmit(i){
				var sum=$('#pageSum').val();
				var kechenbh='<%=kechengbh%>';
				$("#liebiao").attr("src","<%=request.getContextPath() %>/platform/qiantai/student/tiebaxx.jsp?pagesize="+i+"&&KeChengBH="+kechenbh + "&zhi=1");
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
	    				alert("当前页为首页");
	    			}
	    		}else if(e==2){//下一页 
	    			if(s<sum){
	    				s=parseFloat(s)+1;
	    				$("#pageNumber").val(s);
	    				pageSubmit(s);
	    			}else{
	    				alert("当前页为尾页");
	    			}
	    		}
	    	}
			</script>
			<input type="hidden" id="pageNumber" value="<%=pagesize%>"/>
			<input type="hidden" id="pageSum" value="<%=sum%>"/>
			    <!--列表-->
<iframe width="100%" height="570px" align="top"  id="liebiao"
	src="<%=request.getContextPath() %>/platform/qiantai/student/tiebaxx.jsp?pagesize=1&&KeChengBH=<%=kcxxRS.getString("di_KeChengBH")%>"
	style="border:none;" frameborder="0" scrolling="auto"></iframe>
        </div>

        <div id="div_right" class="fr w-230" style="margin-top: 55px;">
            <div class="cour-two-lcyl mt-10">           
            <div class="ckxxzd-kc mykc">
                <div class="title" style="color:#fff;">
                  	  查看学习指导
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcxxRS.getString("di_KeShiBH") %>">课前寄语</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcxxRS.getString("di_KeShiBH") %>">相关知识回顾</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_KeQianDX&cs_KS_BianHao=<%=kcxxRS.getString("di_KeShiBH") %>">学习重难点</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiMB&cs_KS_BianHao=<%=kcxxRS.getString("di_KeShiBH") %>">学习目标</a>
                </div>
            </div>

            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=<%=kcxxRS.getString("di_KeShiBH") %>" >获得更多学习资源</a>
                </div>
            </div>
           <div class="ckxxzd-white mykc">
                <div class="title">
                    <a href="<%=path%>/jspcontrolservlet?_qam_dialog=GNDH_XueXiHD&cs_KeShiBH=<%=kcxxRS.getString("di_KeShiBH") %>" >查看学习活动</a>
                </div>
            </div>
            </div>
        </div>
    </div>
<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />
</body>
</html>