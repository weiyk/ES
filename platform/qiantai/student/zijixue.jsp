<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
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
//获取样式
String style=request.getContextPath()+"/style";
//jwplayer7 样式
String style_jw=request.getContextPath()+"/common/jwplayer7";
//获取路径
String path=request.getContextPath();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>自己学</title>
	<meta name="Keywords" content=""/>
	<meta name="Description" content=""/>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
	<script type="text/javascript" src="<%=style_jw%>/jwplayer.js"></script>
	<html:dialog id="GNDH_ZiJiXX" state="DHZT_JinRu"/>
</head>

<body>
<%
String kechengbh=(String)request.getParameter("KeChengBH");//课程编号
String keshibh=(String)request.getParameter("KeShiBH");//课时编号
String bianmubh=(String)request.getParameter("BianMuBH");//课时上级编目编号

String image=(String)request.getSession().getAttribute("Image");
String imgUrl=(String)request.getSession().getAttribute("imgUrl");
String kcmc="";
String kechengmc="";
String kslj="";//视频路径
String spmc="";//视频名称
StringBuffer splj=new StringBuffer();//播放器默认视频路径
StringBuffer keshiHtml= new StringBuffer();
String zhi=(String)request.getParameter("zhi");
//循环生成课程列表
IDataBaseAccess dbm = null;
      try{
      	dbm = ContextService.lookupDefaultDataBaseAccess();
  		dbm.openConnection();
  		StringBuffer sql=new StringBuffer(100);
  		sql.append("SELECT  DISTINCT JSKJ_KeCheng.BiaoTi AS di_KeChengBT ,JSKJ_KeCheng.BianHao AS di_KeChengBH  FROM jskj_kecheng jskj_kecheng ,jskj_keshi where jskj_keshi.kechengbh=jskj_kecheng.bianhao and fabuzt='1' and biaoti is not null and kemu= '"+zhi+"'");
  		ResultSet rs = dbm.executeQuery(sql.toString());
  		if("".equals(kechengbh)||kechengbh==null){
  			while (rs.next()) {
  				kcmc=rs.getString("di_KeChengBT");
  				if(!"".equals(kcmc)&&kcmc!=null){
  					kechengbh=rs.getString("di_KeChengBH");
  					kechengmc=rs.getString("di_KeChengBT");
  				}
  			} 
  		}else{
  			while (rs.next()) {
  				kcmc=rs.getString("di_KeChengBT");
  				if(!"".equals(kcmc)&&kcmc!=null){
  					if(kechengbh.equals(rs.getString("di_KeChengBH"))){
  						kechengmc=kcmc;
  					}
  				}
  			}
  		}
  		StringBuffer kemu=new StringBuffer();
  		kemu.append("select distinct sj.bianmumc,sj.bianhao from jskj_kechengbm bj,jskj_keshi,jskj_kechengbm sj where jskj_keshi.BianMuBH=bj.BianHao and fabuzt='1' and kechengbh='"+kechengbh+"' and sj.BianHao= bj.ShangJiBH");
  		ResultSet rskm = dbm.executeQuery(kemu.toString());
  		while (rskm.next()) {
  			StringBuffer keshi=new StringBuffer();
  			if(null==bianmubh||bianmubh.equals(rskm.getString(2))){
  				keshiHtml.append("<h5 class=\"cur\"><s></s>"+rskm.getString(1)+"</h5>");
  				keshiHtml.append("<ul >");
  				bianmubh="";
  			}else{
  				keshiHtml.append("<h5 ><s></s>"+rskm.getString(1)+"</h5>");
  				keshiHtml.append("<ul class=\"hidden\">");
  			}
  			
  			keshi.append("select distinct jskj_keshi.BianHao,jskj_keshi.KeShiMC,func_getsplj(jskj_jiaoxuesp.KeShiBH) as ShiPinLJ,jskj_keshi.KeShiLX,bm.ShangJiBH,func_getspmc(jskj_jiaoxuesp.KeShiBH) as ShiPinMC from jskj_keshi,jskj_jiaoxuesp,jskj_kechengbm bm where jskj_keshi.BianHao=jskj_jiaoxuesp.KeShiBH and fabuzt='1' and kechengbh='"+kechengbh+"' and bm.BianHao=jskj_keshi.BianMuBH and bm.ShangJiBH='"+rskm.getString(2)+"'");
  			ResultSet rsks = dbm.executeQuery(keshi.toString());
  			while (rsks.next()) {
  				if("".equals(kslj)){
  					if(keshibh==null){//如果课时编号为空，默认路径为第一章第一课
  						kslj=rsks.getString(3);
  						if(kslj.indexOf("jymis")!=-1){
  							kslj=imgUrl+kslj;
  						}else{
  							kslj=kslj.replaceAll("upload", path+"/upload");
  						}
  						spmc=rsks.getString(6);
  						//播放器初始化路径
  						String ksljs[]=kslj.split("&");
  						String spmcs[]=spmc.split("&");
  						for(int i=0;i<ksljs.length;i++){
  							splj.append("{file:\"");splj.append(ksljs[i]);splj.append("\",title:\"");splj.append(spmcs[i]);splj.append("\"},");
  						}
  						splj.append("{}");
  					}else
  					if(keshibh.equals(rsks.getString(1))){//课时编号不为空，路径为当前课时对应视频路径 
  						kslj=rsks.getString(3);
  						if(kslj.indexOf("jymis")!=-1){
  							kslj=imgUrl+kslj;
  						}else{
  							kslj=kslj.replaceAll("upload", path+"/upload");
  						}
  						spmc=rsks.getString(6);
  						//播放器初始化路径
  						String ksljs[]=kslj.split("&");
  						String spmcs[]=spmc.split("&");
  						for(int i=0;i<ksljs.length;i++){
  							splj.append("{file:\"");splj.append(ksljs[i]);splj.append("\",title:\"");splj.append(spmcs[i]);splj.append("\"},");
  						}
  						splj.append("{}");
  					}
  				}
  				if("".equals(keshibh)||keshibh==null){
  					keshibh=rsks.getString(1);
  				}
  				//判断是否本地资源
  				String splj_=rsks.getString(3);
  				if(splj_.indexOf("jymis")!=-1){//远端资源
					splj_=splj_.replaceAll("jymis", imgUrl+"/jymis");
				}else{//本地资源
					splj_=splj_.replaceAll("upload", path+"/upload");
				}
				String spmc_=rsks.getString(6);
				
  				keshiHtml.append("<li><a href=\"#\" onClick=\"shipin('"+splj_+"','"+rsks.getString(1)+"','"+rsks.getString(4)+"','"+rsks.getString(5)+"','"+spmc_+"')\">"+rsks.getString(2)+"</a></li>");
  			}
  			keshiHtml.append("</ul>");
  		}
  		
      }
      catch(Exception e){
      	e.printStackTrace();
      }finally{
	if(dbm != null) dbm.closeConnection();
}
%>	
<%
	String yonghubh=(String) session.getAttribute("XiTongHYBH");
	String schoolName=(String) session.getAttribute("schoolName");
	String key=(String) session.getAttribute("QuanZhi");
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
<div class="top-u-bar">
	<div class="wrap">
		<p>欢迎你！ <a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengGRKJ&" class="user-name blk"><%=yonghuxm %></a> <%=schoolName %> <a href="<%=path%>/servlet/desktop.html" class="to-quit">退出</a></p>
	</div>
</div>
<!-- 头部 -->
<div class="header green-head">
	<div class="in-box wrap clearfix">
		<div class="logo fl">
			<a href="#">双轨数字学校</a>
		</div>
		<ul class="nav fr">
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" >首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue" class="cur">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>


<div class="wrap clearfix">
<%
		//循环生成课程列表
		StringBuffer html= new StringBuffer();
		StringBuffer htmlT= new StringBuffer();
		
        try{
        	dbm = ContextService.lookupDefaultDataBaseAccess();
    		dbm.openConnection();
    		StringBuffer title=new StringBuffer();
    		title.append("select zhi,bianma from qam_jiheyz where JiHeYLX='JH_KeMu' and zhuangtai='1'");
    		ResultSet rsT = dbm.executeQuery(title.toString());
    		if("".equals(zhi)||zhi==null){
    			while (rsT.next()) {
    				if(htmlT.length()<=0){
    					zhi=rsT.getString(2);
    					htmlT.append("<li class=\"cur\"><a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}else{
    					htmlT.append("<li ><a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}
        		}
    		}else{
    			while (rsT.next()) {
    				if((zhi).equals(rsT.getString(2))){
    					htmlT.append("<li class=\"cur\"><a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}else{
    					htmlT.append("<li ><a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
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
		<!-- 科目切换 -->
		<div class="km-tab-bar clearfix mt-10">
			<ul class="fl">
				<%=htmlT %>
			</ul>
		</div>

	<div class="fl mt-20 w-710">


		<!-- 正在直播 -->
		<div class="at-live mt-10">
			<div class="title-bar green-title clearfix">
			<%
			String selectSql="select DISTINCT biaoti,jskj_kecheng.bianhao from jskj_kecheng ,jskj_keshi where jskj_keshi.kechengbh=jskj_kecheng.bianhao and biaoti is not null and fabuzt='1' and kemu='"+zhi+"'";
			%>
				<h2 class="fl" > <html:select id="di_BianHao" style="width: 170px" value="<%=kechengbh %>" onchange="changgeKC()"  enumSQL="<%=selectSql %>" ></html:select></h2>
			</div>
			<div class="box-c mt-10">
                <div class="classone-ch-left">

					<div class="one-tree curtree">
						<div class="title clearfix">
							<h4>教材目录</h4>
						</div>
						<div class="list">
						<input type="hidden" id="di_KeShiBH" value="<%=keshibh%>"></input>
						<%=keshiHtml%>
						</div>
					</div>

				</div>
                <div class="classone-ch-pic">
					<a href="#">
						<object name="J_player" width="100%" height="100%" id="J_player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" style="position:absolute;top:0;left:0;">
				            <param name="movie" value="<%=style_jw%>/jwplayer.flash.swf">
				            <param name="src" value="<%=style_jw%>/jwplayer.flash.swf">
				            <param name="AllowScriptAccess" value="always">
				        </object>
					</a>
				</div>
				<script type="text/javascript">
					jwplayer.key="49MNt4knikJicC76KViI7zoyjbOMEs69Mn9ECA==";
					var playlist = new Array(<%=splj%>);
					var jwp=jwplayer("J_player").setup({
				    	 playlist:playlist,
						 width:521,
				         height:298,
				         dock: false,
				         autostart:true
				    });
				    jwp.onError(function(obj){alert("播放器出错!!!"+obj.message);});
				</script>
			</div>
			 <html:form>
			 <br />
			 
		    <div class="zjx-areatext">
               	<span class="fl cla-1" style="font-size: 20px;padding-bottom: 20px;">讨论区</span>
               <textarea id="fabiaotl" rows="8" style="width: 100%" cols=""></textarea>
               
               <div class="begindiscus-btn"><img src="<%=style%>/images/begindiscus.png" onclick="startFT()"/></div>
				<script type="text/javascript">
				function shipin(url,id,lx,bm,mc){
					//播放器切换路径
					var spljstr="[";
					var ksljs_init=url.split("&");
					var spmcs_init=mc.split("&");
					for(var i=0;i<ksljs_init.length;i++){
						spljstr+="{file:\""+ksljs_init[i]+"\",title:\""+spmcs_init[i]+"\"},";
					}
					spljstr+="{}]";
					jwp.load(eval(spljstr));
					jwp.playlistItem(0); 
					//播放器切换路径-结束
					$('#di_KeShiBH').val(id);
					//添加学习记录
					$.ajax({
						url:path+'/servlet/AjaxServlet',
						type:"post",
						traditional:true,
						async:true,
						data:{service:"com.rc.web.extension.ajax.TianJiaXXJL",
							parameter:["kechengbh","keshibh","keshilx","zhangjiebm"],
							value:['<%=kechengbh%>',id,lx,bm]},
						complete:function(XHR, TS){
							result = XHR.responseText;
							XHR = null;
						}
						
					});
				}
				function changgeKC(){
					var kechengbh=$('#di_BianHao').val();
					document.forms[0].action="<%=path %>/platform/qiantai/student/zijixue.jsp?pagesize=1&KeChengBH="+kechengbh+"&zhi="+'<%=zhi%>';
					document.forms[0].submit();
				}
					function kechengtz(kechengbh){
						document.forms[0].action="<%=path %>/platform/qiantai/student/zijixue.jsp?pagesize=1&KeChengBH="+kechengbh+"&zhi="+'<%=zhi%>';
						document.forms[0].submit();
					}
					function startFT(){
						var neirong=$('#fabiaotl').val();
						if(!neirong){
							alert('请输入内容！');
							return false;
						}else{
							var result='';
							var kechenbh=$('#di_BianHao').val();
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
										$("#liebiao").attr("src","<%=path %>/platform/qiantai/student/tiebaxx.jsp?pagesize=1&&KeChengBH="+kechenbh+"&zhi="+'<%=zhi%>');
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
						$("#liebiao").attr("src","<%=path %>/platform/qiantai/student/tiebaxx.jsp?pagesize="+i+"&&KeChengBH="+kechenbh+"&zhi="+'<%=zhi%>');
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
			    	function keqiandx(){
						var bh=$('#di_KeShiBH').val();
						document.forms[0].action="<%=path %>/platform/qiantai/student/keqiandx.jsp?KeShiBH="+bh;
						document.forms[0].submit();
						
					}
			    	function xueximb(){
						var bh=$('#di_KeShiBH').val();
						document.forms[0].action="<%=path %>/platform/qiantai/student/xueximb.jsp?KeShiBH="+bh;
						document.forms[0].submit();
						
					}
			    	function xuexizy(){
			    		var bh=$('#di_KeShiBH').val();
						document.forms[0].action="<%=path %>/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+bh;
						document.forms[0].submit();
			    	}
			    	function xuexihd(){
			    		var bh=$('#di_KeShiBH').val();
						document.forms[0].action="<%=path %>/platform/qiantai/student/xuexihd.jsp?KeShiBH="+bh;
						document.forms[0].submit();
			    	}
					</script>
					<input type="hidden" id="pageNumber" value="<%=pagesize%>"/>
					<input type="hidden" id="pageSum" value="<%=sum%>"/>
                      <!--列表-->
<iframe width="100%" height="570px" align="top"  id="liebiao"
	src="<%=path %>/platform/qiantai/student/tiebaxx.jsp?pagesize=1&&KeChengBH=<%=kechengbh%>&zhi=<%=zhi%>"
	style="border:none;" frameborder="0" scrolling="auto"></iframe>
								
            </div>
         </html:form>
        </div>

	</div>


	<div class="fr w-230 std-side">
  <!-- 查看学习指导 -->

            <div class="cour-two-line mt-60">           
            <div class="ckxxzd-kc mykc">
                <div class="title" style="color:#fff;">
                    查看学习指导
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">课前寄语</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">相关知识回顾</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="keqiandx()">学习重难点</a>
                </div>
            </div>
            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="xueximb()">学习目标</a>
                </div>
            </div>

            <div class="ckxxzd-white  mykc">
                <div class="title">
                    <a href="#" onclick="xuexizy()">获得更多学习资源</a>
                </div>
            </div>
           <div class="ckxxzd-white mykc">
                <div class="title">
                    <a href="#" onclick="xuexihd()">查看学习活动</a>
                </div>
            </div>
            </div>

	 <!-- 相关学习资源 -->	
	 <!--
		<div class="more-box-res mt-20">
			<div class="side-title clearfix">
				<h3>相关学习资源</h3>
				<a href="#" class="more-link">更多》</a>
			</div>
			<div class="the-list">
				<ul class="clearfix">
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-snow1.jpg" /></a>
						<p class="time">雪地里的小画家</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  2463</span><span class="sp-two">开始学习</span></div>
					</li>
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-aihu2.jpg" /></a>
						<p class="time">爱护环境</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  2026</span><span class="sp-two">开始学习</span></div>
					</li>
					<li>
						<a href="#"><img src="<%=style%>/images/student/about-sao3.jpg" /></a>
						<p class="time">扫雪</p><br/>
                        <div class="clearfix div-dj-sy"><span class="sp-one">点击量  1924</span><span class="sp-two">开始学习</span></div>
					</li>
                   
				</ul>
			</div>
		</div>
		-->
	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>
