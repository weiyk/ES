<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@include file="/common/framework.jspf" %>
<%@include file="/common/jquery.jspf" %>
<%@page import="com.rc.tools.safty.ToDate" %>
<%@page import="java.util.*"%>
<%@page import="com.rc.tools.jsonexplain.*"%>

<%
	//获取样式
	String style=request.getContextPath()+"/style";
	//获取路径
	String path=request.getContextPath();
	String yonghuxm =(String)session.getAttribute("YONGHUXM");
	String schoolName=(String) session.getAttribute("schoolName");
	String className=(String) session.getAttribute("className");
	String yonghubh=(String) session.getAttribute("XiTongHYBH");
	String imgUrl=(String)request.getSession().getAttribute("imgUrl");
	String image=(String)request.getSession().getAttribute("Image");
	
	
	
	
	String uid=(String)request.getSession().getAttribute("XiTongHYBH");//获取UID,系统用户编号
	String key=(String)request.getSession().getAttribute("QuanZhi");//获取鉴值
	String schoolId=(String)request.getSession().getAttribute("schoolId");//获取学校编号
	//通知公告列表
	TongZhiGG TZGG=new TongZhiGG();
	List<Object> obj=TZGG.getJSONGongGaoBS(schoolId,key,uid,"3","1","4");
	List<Map<String,Object>> TZGGlist=null;
	String msgCode=(String)obj.get(0);//获取标示符
	boolean bool=false;
	if(msgCode.equals("1")){
		TZGGlist=TZGG.getJSONGongGaoLB(obj.get(2));
		bool=true;
	}
	request.setAttribute("bool",bool);
	
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>学生空间</title>
	<link href="<%=style%>/style/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=style%>/style/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=style%>/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=style%>/js/base.js"></script>
</head>


<body>
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
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueShengKJ" class="cur">首页</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_XueYiXue">学一学</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_DuYiDu">读一读</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_LianYiLian">练一练</a></li>
			<li><a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_CeYiCe">测一测</a></li>
		</ul>
	</div>
</div>
<%
		//循环生成课程列表
 		IDataBaseAccess dbm = null;
		StringBuffer htmlT= new StringBuffer();
		StringBuffer html=null;
		StringBuffer html_2=null;
		StringBuffer html_3=null;
		StringBuffer html_4=null;
		String zhi=(String)request.getParameter("zhi");
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
    					htmlT.append("<li class=\"cur\"><a href=\""+path+"/platform/qiantai/student/xueshengkongjian.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}else{
    					htmlT.append("<li ><a href=\""+path+"/platform/qiantai/student/xueshengkongjian.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}
        		}
    		}else{
    			while (rsT.next()) {
    				if((zhi).equals(rsT.getString(2))){
    					htmlT.append("<li class=\"cur\"><a href=\""+path+"/platform/qiantai/student/xueshengkongjian.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}else{
    					htmlT.append("<li ><a href=\""+path+"/platform/qiantai/student/xueshengkongjian.jsp?zhi="+rsT.getString(2)+"\">"+rsT.getString(1)+"</a></li>");
    				}
        		}
    		}
    		//最近学习课程-新课讲授
    		html= new StringBuffer();
    		StringBuffer sql=new StringBuffer(100);
    		sql.append("select ks.keshimc,jl.kechenbh,date_format(jl.xuexisj,'%Y-%m-%d'),jl.zhangjiebm,jl.keshibh from xskj_xuexijl jl,jskj_keshi ks,jskj_kecheng kc where jl.kechenbh=kc.bianhao and jl.keshibh=ks.bianhao and jl.xueshengbh='"+yonghubh+"' and kc.kemu='"+zhi+"' and jl.keshilx=1 order by jl.xuexisj desc limit 1 ");
    		ResultSet rs = dbm.executeQuery(sql.toString());
    		String kcbh=null;
    		String ksbh=null;
    		if (rs.next()) {
    			kcbh=rs.getString(2);
    			ksbh=rs.getString(5);
    			html.append("<li><span class=\"list-name type-1\">你上次学了《"+rs.getString(1)+"》</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?KeChengBH="+rs.getString(2)+"&BianMuBH="+rs.getString(4)+"&KeShiBH="+rs.getString(5)+"&zhi="+zhi+"\">继续学习</a> <span class=\"time\">"+rs.getString(3)+"</span></li>");
    		}
    		//如果没有学习过显示
    		if(html.length()==0){
    			html.append("<li><span class=\"list-name type-1\">你还没有学习过课程</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+zhi+"\">现在就去学习</a></li>");
    		}
    		//最近资源更新
    		StringBuffer sql_zy=new StringBuffer(100);
    		sql_zy.append("select ks.BianHao,ks.KeShiMC,concat(substring(kj.BianHao,5,4),'-',substring(kj.BianHao,9,2),'-',substring(kj.BianHao,11,2)) time from jskj_kecheng kc,jskj_keshi ks,jskj_xuexizy zy,jskj_ziyuankj kj ");
    		sql_zy.append(" where kc.BianHao=ks.KeChengBH and ks.BianHao=zy.KeShiBH and zy.BianHao=kj.XueXiZYBH");
    		sql_zy.append(" and kc.BianHao='"+kcbh+"' and ks.bianhao='"+ksbh+"' ORDER BY kj.BianHao DESC LIMIT 1");
    		ResultSet rs_zy = dbm.executeQuery(sql_zy.toString());
    		if (rs_zy.next()) {
    			html.append("<li><span class=\"list-name type-2\">《"+rs_zy.getString(2)+"》的学习资源有了新内容</span> <a href=\""+path+"/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+rs_zy.getString(1)+"&zhi="+zhi+"\">现在就去</a> <span class=\"time\">"+rs_zy.getString(3)+"</span></li>");
    		}
    		//最近学习课程-复习巩固
    		html_2= new StringBuffer();
    		StringBuffer sql_2=new StringBuffer(100);
    		sql_2.append("select ks.keshimc,jl.kechenbh,date_format(jl.xuexisj,'%Y-%m-%d'),jl.zhangjiebm,jl.keshibh from xskj_xuexijl jl,jskj_keshi ks,jskj_kecheng kc where jl.kechenbh=kc.bianhao and jl.keshibh=ks.bianhao and jl.xueshengbh='"+yonghubh+"' and kc.kemu='"+zhi+"' and jl.keshilx=2 order by jl.xuexisj desc limit 1 ");
    		ResultSet rs_2 = dbm.executeQuery(sql_2.toString());
    		String kcbh_2=null;
    		String ksbh_2=null;
    		if (rs_2.next()) {
    			kcbh_2=rs_2.getString(2);
    			ksbh_2=rs_2.getString(5);
    			html_2.append("<li><span class=\"list-name type-1\">你上次学了《"+rs_2.getString(1)+"》</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?KeChengBH="+rs_2.getString(2)+"&BianMuBH="+rs_2.getString(4)+"&KeShiBH="+rs_2.getString(5)+"&zhi="+zhi+"\">继续学习</a> <span class=\"time\">"+rs_2.getString(3)+"</span></li>");
    		}
    		//如果没有学习过显示
    		if(html_2.length()==0){
    			html_2.append("<li><span class=\"list-name type-1\">你还没有学习过课程</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+zhi+"\">现在就去学习</a></li>");
    		}
    		//最近资源更新
    		StringBuffer sql_zy_2=new StringBuffer(100);
    		sql_zy_2.append("select ks.BianHao,ks.KeShiMC,concat(substring(kj.BianHao,5,4),'-',substring(kj.BianHao,9,2),'-',substring(kj.BianHao,11,2)) time from jskj_kecheng kc,jskj_keshi ks,jskj_xuexizy zy,jskj_ziyuankj kj ");
    		sql_zy_2.append(" where kc.BianHao=ks.KeChengBH and ks.BianHao=zy.KeShiBH and zy.BianHao=kj.XueXiZYBH");
    		sql_zy_2.append(" and kc.BianHao='"+kcbh_2+"' and ks.bianhao='"+ksbh_2+"' ORDER BY kj.BianHao DESC LIMIT 1");
    		ResultSet rs_zy_2 = dbm.executeQuery(sql_zy_2.toString());
    		if (rs_zy_2.next()) {
    			html_2.append("<li><span class=\"list-name type-2\">《"+rs_zy_2.getString(2)+"》的学习资源有了新内容</span> <a href=\""+path+"/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+rs_zy_2.getString(1)+"&zhi="+zhi+"\">现在就去</a> <span class=\"time\">"+rs_zy_2.getString(3)+"</span></li>");
    		}
    		//最近学习课程-讨论课
    		html_3= new StringBuffer();
    		StringBuffer sql_3=new StringBuffer(100);
    		sql_3.append("select ks.keshimc,jl.kechenbh,date_format(jl.xuexisj,'%Y-%m-%d'),jl.zhangjiebm,jl.keshibh from xskj_xuexijl jl,jskj_keshi ks,jskj_kecheng kc where jl.kechenbh=kc.bianhao and jl.keshibh=ks.bianhao and jl.xueshengbh='"+yonghubh+"' and kc.kemu='"+zhi+"' and jl.keshilx=3 order by jl.xuexisj desc limit 1 ");
    		ResultSet rs_3 = dbm.executeQuery(sql_3.toString());
    		String kcbh_3=null;
    		String ksbh_3=null;
    		if (rs_3.next()) {
    			kcbh_3=rs_3.getString(2);
    			ksbh_3=rs_3.getString(5);
    			html_3.append("<li><span class=\"list-name type-1\">你上次学了《"+rs_3.getString(1)+"》</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?KeChengBH="+rs_3.getString(2)+"&BianMuBH="+rs_3.getString(4)+"&KeShiBH="+rs_3.getString(5)+"&zhi="+zhi+"\">继续学习</a> <span class=\"time\">"+rs_3.getString(3)+"</span></li>");
    		}
    		//如果没有学习过显示
    		if(html_3.length()==0){
    			html_3.append("<li><span class=\"list-name type-1\">你还没有学习过课程</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+zhi+"\">现在就去学习</a></li>");
    		}
    		//最近资源更新
    		StringBuffer sql_zy_3=new StringBuffer(100);
    		sql_zy_3.append("select ks.BianHao,ks.KeShiMC,concat(substring(kj.BianHao,5,4),'-',substring(kj.BianHao,9,2),'-',substring(kj.BianHao,11,2)) time from jskj_kecheng kc,jskj_keshi ks,jskj_xuexizy zy,jskj_ziyuankj kj ");
    		sql_zy_3.append(" where kc.BianHao=ks.KeChengBH and ks.BianHao=zy.KeShiBH and zy.BianHao=kj.XueXiZYBH");
    		sql_zy_3.append(" and kc.BianHao='"+kcbh_3+"' and ks.bianhao='"+ksbh_3+"' ORDER BY kj.BianHao DESC LIMIT 1");
    		ResultSet rs_zy_3 = dbm.executeQuery(sql_zy_3.toString());
    		if (rs_zy_3.next()) {
    			html_3.append("<li><span class=\"list-name type-2\">《"+rs_zy_3.getString(2)+"》的学习资源有了新内容</span> <a href=\""+path+"/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+rs_zy_3.getString(1)+"&zhi="+zhi+"\">现在就去</a> <span class=\"time\">"+rs_zy_3.getString(3)+"</span></li>");
    		}
    		//最近学习课程-习题课
    		html_4= new StringBuffer();
    		StringBuffer sql_4=new StringBuffer(100);
    		sql_4.append("select ks.keshimc,jl.kechenbh,date_format(jl.xuexisj,'%Y-%m-%d'),jl.zhangjiebm,jl.keshibh from xskj_xuexijl jl,jskj_keshi ks,jskj_kecheng kc where jl.kechenbh=kc.bianhao and jl.keshibh=ks.bianhao and jl.xueshengbh='"+yonghubh+"' and kc.kemu='"+zhi+"' and jl.keshilx=4 order by jl.xuexisj desc limit 1 ");
    		ResultSet rs_4 = dbm.executeQuery(sql_4.toString());
    		String kcbh_4=null;
    		String ksbh_4=null;
    		if (rs_4.next()) {
    			kcbh_4=rs_4.getString(2);
    			ksbh_4=rs_4.getString(5);
    			html_4.append("<li><span class=\"list-name type-1\">你上次学了《"+rs_4.getString(1)+"》</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?KeChengBH="+rs_4.getString(2)+"&BianMuBH="+rs_4.getString(4)+"&KeShiBH="+rs_4.getString(5)+"&zhi="+zhi+"\">继续学习</a> <span class=\"time\">"+rs_4.getString(3)+"</span></li>");
    		}
    		//如果没有学习过显示
    		if(html_4.length()==0){
    			html_4.append("<li><span class=\"list-name type-1\">你还没有学习过课程</span> <a href=\""+path+"/platform/qiantai/student/zijixue.jsp?zhi="+zhi+"\">现在就去学习</a></li>");
    		}
    		//最近资源更新
    		StringBuffer sql_zy_4=new StringBuffer(100);
    		sql_zy_4.append("select ks.BianHao,ks.KeShiMC,concat(substring(kj.BianHao,5,4),'-',substring(kj.BianHao,9,2),'-',substring(kj.BianHao,11,2)) time from jskj_kecheng kc,jskj_keshi ks,jskj_xuexizy zy,jskj_ziyuankj kj ");
    		sql_zy_4.append(" where kc.BianHao=ks.KeChengBH and ks.BianHao=zy.KeShiBH and zy.BianHao=kj.XueXiZYBH");
    		sql_zy_4.append(" and kc.BianHao='"+kcbh_4+"' and ks.bianhao='"+ksbh_4+"' ORDER BY kj.BianHao DESC LIMIT 1");
    		ResultSet rs_zy_4 = dbm.executeQuery(sql_zy_4.toString());
    		if (rs_zy_4.next()) {
    			html_4.append("<li><span class=\"list-name type-2\">《"+rs_zy_4.getString(2)+"》的学习资源有了新内容</span> <a href=\""+path+"/platform/qiantai/student/xiangguanxxzy.jsp?KeShiBH="+rs_zy_4.getString(1)+"&zhi="+zhi+"\">现在就去</a> <span class=\"time\">"+rs_zy_4.getString(3)+"</span></li>");
    		}
        }
        catch(Exception e){
        	e.printStackTrace();
        }finally{
			if(dbm != null) dbm.closeConnection();
		}
					
%>

<div class="wrap clearfix">

	<div class="fl mt-20 w-710">
		<!-- 科目切换 -->
		<div class="km-tab-bar clearfix">
			<ul class="fl">
				<%=htmlT %>
			</ul>
		</div>

		<!-- 学习动态 -->
		<div class="mywork-box mt-10">
			<div class="one-dynamic">
				<div class="title" onclick="javascript:location.href='<%=path %>/platform/qiantai/student/zijixue.jsp'"><h3>新课讲授</h3><a href="<%=path %>/platform/qiantai/student/zijixue.jsp?zhi=<%=zhi %>" class="more-link">更多</a></div>
				<ul class="clearfix">
					<%=html %>
				</ul>
			</div>
			<div class="one-dynamic">
				<div class="title" onclick="javascript:location.href='<%=path %>/platform/qiantai/student/zijixue.jsp'"><h3>复习巩固</h3><a href="<%=path %>/platform/qiantai/student/zijixue.jsp?zhi=<%=zhi %>" class="more-link">更多</a></div>
				<ul class="clearfix">
					<%=html_2 %>
				</ul>
			</div>
			<div class="one-dynamic">
				<div class="title" onclick="javascript:location.href='<%=path %>/platform/qiantai/student/zijixue.jsp'"><h3>讨论课</h3><a href="<%=path %>/platform/qiantai/student/zijixue.jsp?zhi=<%=zhi %>" class="more-link">更多</a></div>
				<ul class="clearfix">
					<%=html_3 %>
				</ul>
			</div>
			<div class="one-dynamic">
				<div class="title" onclick="javascript:location.href='<%=path %>/platform/qiantai/student/zijixue.jsp'"><h3>习题课</h3><a href="<%=path %>/platform/qiantai/student/zijixue.jsp?zhi=<%=zhi %>" class="more-link">更多</a></div>
				<ul class="clearfix">
					<%=html_4 %>
				</ul>
			</div>
		</div>
		<!-- 读一读 -->
		<div class="reader-box mt-30">
			<div class="title-bar green-title clearfix">
				<h2 class="fl">读一读</h2>
				<a href="<%=path %>/platform/qiantai/student/duyidu.jsp" class="glk fr">更多</a>
			</div>
			<div class="sub-title mt-10">
				<h3>正在读</h3>
			</div>
			<div class="read-list myread-list">
				<ul class="clearfix">
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-1.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">成语故事精选</a></h4>
						<p>
							中国少年儿童出版社  鲁迅
							<br />
							<span class="jd">已读95%</span>
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-2.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">鲁兵孙漂流记</a></h4>
						<p>
							汕头大学出版社  杨旭
							<br />
							<span class="jd">已读75%</span>
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-3.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">钢铁是怎样炼成的</a></h4>
						<p>
							北京日知图书  笛福
							<br />
							<span class="jd">已读45%</span>
						</p>
					</li>
					<li class="last">
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-1-4.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">继续阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">小王子</a></h4>
						<p>
							少儿出版社  马振聘
							<br />
							<span class="jd">已读25%</span>
						</p>
					</li>
				</ul>
				<p class="all-read">
					<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">共有10本书在读</a>
				</p>
			</div>
			<div class="sub-title mt-10">
				<h3>推荐读</h3>
			</div>
			<div class="read-list">
				<ul class="clearfix">
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-a-1.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">开始阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">西游记</a></h4>
						<p>
							人民出版社  吴承恩
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-a-2.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">开始阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">三国演义</a></h4>
						<p>
							北京出版社  罗贯中
						</p>
					</li>
					<li>
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-a-3.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">开始阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">叶圣陶童话</a></h4>
						<p>
							少儿出版社  叶圣陶
						</p>
					</li>
					<li class="last">
						<div class="pic-box">
							<img src="<%=path %>/style/images/pic-5-a-4.jpg" alt="" />
							<div class="cover hidden"></div>
							<a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black" class="to-read hidden">开始阅读</a>
						</div>
						<h4><a href="http://www.zhiliaoshu.com.cn/download.html"  target="_black">上下五千年</a></h4>
						<p>
							科教出版社  林汉达
						</p>
					</li>
				</ul>
			</div>

		</div>
	</div>


	<div class="fr w-230 std-side">
		<!-- 学生个人 -->
		<div class="std-user mt-20">
			<div class="pic"><a href="<%=path %>/platform/qiantai/student/gerenzhongxin-xuesheng.jsp"><img src="<%=imgUrl+image %>" alt="" height="60px;"/></a></div>
			<div class="user-info clearfix">
				<div class="name"><%=yonghuxm %></div>
				<div class="sc-info">  <%=className %> <br />	<%=schoolName %></div>			
			</div>
			<ul class="user-act clearfix">
				<li><a href="<%=path %>/platform/qiantai/student/gerenzhongxin-xuesheng.jsp">个人中心</a></li>
				<li><a href="<%=path %>/platform/qiantai/student/wodehaoyoulb.jsp">我的好友</a></li>
			</ul>
		</div>
		
		<!-- 平台动态 -->
		<div class="pt-gg mt-20">
			<div class="side-title clearfix">
				<h3>学生动态</h3>
				<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_TongZhiSTUGG" class="more-link blk">更多》</a>
			</div>
			<ul class="the-list">
					<%
					if(bool){
					for(int i=0; i<TZGGlist.size();i++){
						Map<String,Object> maps=TZGGlist.get(i);
					%>
						<li>
							<a href="<%=path%>/servlet/jspdispatchservlet?_qam_dialog=GNDH_GongGaoSTUXQ&cs_BianHao=<%=maps.get("id")%>">【<b><%=maps.get("type")%></b>】<%=maps.get("title")%></a>
						</li>
					<%} }%>
			</ul>
		</div>
		<!-- 知了树家长端下载 -->
		<div class="fr w-230">
			<div class="test-side-act clearfix mt-20">
				<a href="http://www.zhiliaoshu.com.cn/download.html" target="_blank" class="btn-dl hover-a mt-10">知了树家长端下载</a>
			</div>
			<!-- 知了树二维码 -->
			<div class="ewm-box mt-20">
				<h3>知了树二维码：</h3>
				<img src="<%=path %>/style/images/student/zhiliaoshu.png" width="190px" height="190px" alt="" />
				<span>自主学习手机、平板专用APP
				</span>
			</div>
		</div>
		<!-- 我的应用 -->
		<div class="my-app mt-20">
			<div class="side-title clearfix">
				<h3>我的应用</h3>
				<a href="#" class="more-link"></a>
			</div>
			<ul class="the-list clearfix">
				<li>
					<a href="http://www.zhiliaoshu.com.cn/download.html" target="_black" class="pic"><img src="<%=path %>/style/images/student/app-pic.png" alt="" /></a>
					<div class="info">
						<a href="http://www.zhiliaoshu.com.cn/download.html" target="_black">普泰移动知了树</a>
						<p>普泰移动知了树为家长、学生、老师等提供集学习、资源、安全、通信于一体的教育信息化服务产品。</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
	

</div>

<!-- 页尾 -->
<jsp:include page="/bottomPage.jsp" />


</body>
</html>
