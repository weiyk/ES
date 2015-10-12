package com.rc.web.teacher;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

/**
 * 教学准备-上传课件资源
 * @author admin
 *
 */
public class UploadCourseware extends HttpServlet{

	private static final long serialVersionUID = 395115206181356599L;
	private static final Log log = LogFactory.getLog("UploadCourseware");
	private static IDataBaseAccess dataBaseAccess = null;
	// 资源课件目录
	private static final String ZYKJ_DIR = "upload/teacher/ziyuankejian";
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("charset", ApplicationConfig.getInstance()
				.getEncoding());
		// 设置响应的字符编码
		response.setContentType("text/xml;charset="
				+ ApplicationConfig.getInstance().getEncoding());
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置内存缓冲区，超过后写入临时文件
		factory.setSizeThreshold(10240000);
		// 设置临时文件存储位置
		String base = ApplicationConfig.getInstance().REAL_PATH;
		base = base.substring(0, base.indexOf("WEB-INF")) + ZYKJ_DIR;
		File file = new File(base);
		if (!file.exists())
			file.mkdirs();
		factory.setRepository(file);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 设置单个文件的最大上传值
		upload.setFileSizeMax(10002400000l);
		// 设置整个request的最大值
		upload.setSizeMax(10002400000l);
		upload.setHeaderEncoding("UTF-8");

		try {
			Map<String, String> reqMap = new HashMap<String, String>();
			List<?> items = upload.parseRequest(request);
			FileItem item = null;
			String fileName = null;
			for (int i = 0; i < items.size(); i++) {
				item = (FileItem) items.get(i);
				// 保存文件
				if (!item.isFormField() && item.getName().length() > 0) {
					// 文件名称编号
					String bh = ContextService.lookupSequenceService().generateId("SEQ_WenJianBH");
					fileName = base + File.separator + bh + item.getName().substring(item.getName().lastIndexOf("."));
					File saveFile = new File(fileName);
					item.write(saveFile);
					if ("ZiYuanLJ".equalsIgnoreCase(item.getFieldName())) {
						// 资源路径
						reqMap.put("ZiYuanLJ", ZYKJ_DIR + "/" + saveFile.getName());
					} else {
						// 封面路径
						reqMap.put("FengMianLJ", ZYKJ_DIR + "/" + saveFile.getName());
					}
				} else {
					reqMap.put(item.getFieldName(), item.getString("utf-8"));
				}
			}
			
			// 保存课件
			String page = saveZiYuanKJ(request, reqMap);
			response.sendRedirect(request.getContextPath() + page);
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 保存资源 课件
	 * @throws QamFrameworkException 
	 */
	private String saveZiYuanKJ(HttpServletRequest request, Map<String, String> reqMap) throws QamFrameworkException {
		dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
		dataBaseAccess.openConnection();
		// 编号
		String bh = ContextService.lookupSequenceService().generateId("SEQ_ZiYuanKJ");
		StringBuffer sqlBuf = new StringBuffer();
		sqlBuf.append("insert into JSKJ_ZiYuanKJ (BianHao, XueXiZYBH, ZiYuanMC, ZiYuanLJ, ZiYuanLX, FengMianLJ) values");
		sqlBuf.append(" ('" + bh + "', '" + reqMap.get("di_XueXiZYBH") + "', '" + reqMap.get("di_ZiYuanMC") + "', '" );
		
		// 获得资源路径
		String ziYuanLJ = reqMap.get("ZiYuanLJ");
		if (ziYuanLJ == null || "".equals(ziYuanLJ)) {
			// 资源路径
			ziYuanLJ = reqMap.get("ZiYuanLJ_Name");
			// 根据资源路径下载文件到本地
			String tmp = getResource(request, ziYuanLJ);
			if (tmp != null) {
				ziYuanLJ = tmp; 
			}
		}
		// 封面路径
		String fengMianLJ = reqMap.get("FengMianLJ");
		if (fengMianLJ == null || "".equals(fengMianLJ)) {
			fengMianLJ = reqMap.get("FengMianLJ_Name");
		}
		
		sqlBuf.append(ziYuanLJ + "', '" + reqMap.get("di_ZiYuanLX") + "', '" + fengMianLJ + "')");
		log.info(sqlBuf);
		dataBaseAccess.execute(sqlBuf.toString());
		dataBaseAccess.closeConnection();
		
		// 执行完保存后，要跳转到的页面
		String page = "/servlet/jspcontrolservlet?_qam_dialog=GNDH_XueXiZY&cs_KeShiBH=" + reqMap.get("di_KeShiBH");
		return page;
	}
	
	/**
	 * 从远程服务器获取资源
	 * 仅下载电子书文件
	 * @Author    :  wyk 
	 * @param url
	 */
	private String getResource(HttpServletRequest request, String url) {
		// 文件格式
		String suffix = url.substring(url.lastIndexOf(".")).toLowerCase();
		
		// 该数组中的文件类型需要被下载到本地
		String[] suffixs = {".txt", ".doc", ".docx", ".xls", ".ppt", ".pdf", ".jpg", ".jpeg", ".png", ".bpm", "gif"};
		boolean down = false;
		for (String s : suffixs) {
			if (suffix.equals(s)) {
				down = true;
				break;
			}
		}
		
		// 不下载
		if (!down)
			return null;
		
		try {
			/**
			 * 存放资源目录
			 */
			String base = ApplicationConfig.getInstance().REAL_PATH;
			base = base.substring(0, base.indexOf("WEB-INF")) + ZYKJ_DIR;
			File dir = new File(base);
			if (!dir.exists())
				dir.mkdir();
			
			// 新的文件名
			String bh = ContextService.lookupSequenceService().generateId("SEQ_WenJianBH");
			File f = new File(dir.getPath() + "\\" + bh + suffix);
			
			// 下载资源
			URL httpUrl = new URL(request.getSession().getAttribute("imgUrl").toString() + url);
			FileUtils.copyURLToFile(httpUrl, f);
			
			// 返回路径
			return ZYKJ_DIR + "\\" + bh + suffix;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
