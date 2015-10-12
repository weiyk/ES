<%@page import="com.qam.framework.context.ApplicationConfig"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="com.qam.framework.context.ContextService"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.qam.framework.jdbc.IDataBaseAccess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 资源编号
	String cs_ZiYuanBH = request.getParameter("cs_ZiYuanBH");
	//获得课程项目
	IDataBaseAccess dbm = null;
	ResultSet rs = null;
	// 资源类型
	try {
		dbm = ContextService.lookupDefaultDataBaseAccess();
		dbm.openConnection();
		// 查询所有科目
		String sql = "select BianHao, FuJianMC, FuJianLJ from JSKJ_ZIYUANFJ where ZhuBiaoBH='" + cs_ZiYuanBH + "'";
		rs = dbm.executeQuery(sql);
		
		// 附件名称
		String fuJianMC = null;;
		// 附件路径
		String fuJianLJ = null;
		// 后缀
		String suffix = null;
		if (rs.next()) {
			fuJianMC = rs.getString("FuJianMC");
			fuJianLJ = rs.getString("FuJianLJ");
			suffix = fuJianLJ.substring(fuJianLJ.lastIndexOf("."));
		}
		
		// 要下载的文件路径
		String filePath = this.getServletContext().getRealPath("/" + fuJianLJ);
		// 要下载的文件
		File downFile = new File(filePath);
		if (!downFile.exists()) {
			return;
		}
		
		//设置响应头，控制浏览器下载该文件
		String userAgent = request.getHeader("User-Agent"); 
		fuJianMC = userAgent.contains("Firefox") ? new String(fuJianMC.getBytes("UTF-8"), "ISO-8859-1") : URLEncoder.encode(fuJianMC, "UTF-8"); 
		response.setHeader("content-disposition", "attachment;filename=" + (fuJianMC + "." + suffix));
		response.setContentType("application/force-download");  
		// 读取文件保存到输入流
		FileInputStream fis = new FileInputStream(downFile);
		// 输出流
		OutputStream os = response.getOutputStream();
		// 缓存区
		byte[] buffer = new byte[1024];
		int len = 0;
		// 循环读取
		while ((len = fis.read(buffer)) > 0) {
			os.write(buffer, 0, len);
		}
		os.flush();
		//关闭输出流
		os.close();
		//关闭文件输入流
		fis.close();
		os = null;
		response.flushBuffer(); 
		out.clear();
		out = pageContext.pushBody();
	} catch (Exception e) {
		//e.printStackTrace();	
	} finally {
		if (rs != null)
			rs.close();
		if (dbm != null)
			dbm.closeConnection();
	}
%>
