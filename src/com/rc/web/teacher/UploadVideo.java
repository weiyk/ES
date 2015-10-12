package com.rc.web.teacher;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

/**
 * 上传教学视频
 * @author admin
 *
 */
public class UploadVideo extends HttpServlet{

	private static final long serialVersionUID = 7445278453359312002L;
	private static final Log log = LogFactory.getLog("UploadVideo");
	private static IDataBaseAccess dataBaseAccess = null;
	// 资源课件目录
	private static final String JXSP_DIR = "upload/teacher/jiaoxueshipin";
	
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
		base = base.substring(0, base.indexOf("WEB-INF")) + JXSP_DIR;
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
					if ("di_ShiPinLJ".equalsIgnoreCase(item.getFieldName())) {
						// 视频路径
						reqMap.put("di_ShiPinLJ", JXSP_DIR + "/" + saveFile.getName());
					}
				} else {
					reqMap.put(item.getFieldName(), item.getString("utf-8"));
				}
			}
			
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
			dataBaseAccess.openConnection();
			
			// 主讲人
			String zhuJiangR = (String)request.getSession().getAttribute("YONGHUXM");
			reqMap.put("zhuJiangR", zhuJiangR);
			
			// 操作类型标识，1：更新操作，其他为添加操作
			String operation = reqMap.get("operation");
			if ("1".equals(operation)) {
				// 更新资源
				updateJiaoXueSP(reqMap);
			} else {
				// 添加资源
				saveJiaoXueSP(reqMap);
			}
			
			// 跳转
			String page = request.getContextPath() + "/servlet/jspcontrolservlet?_qam_dialog=GNDH_JiaoXueSP&cs_KeShiBH=" + reqMap.get("di_KeShiBH");
			response.sendRedirect(page);
			//request.getRequestDispatcher(page).forward(request, response);
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 更新教学视频
	 * @Author    :  wyk 
	 * @param reqMap
	 * @throws QamFrameworkException 
	 */
	private void updateJiaoXueSP(Map<String, String> reqMap) {
		try {
			// 获得新上传的视频路径
			String shiPinLJ = reqMap.get("di_ShiPinLJ");
			StringBuffer sqlBuffer = new StringBuffer();
			
			// 如果上传了新视频文件，则删除原来的视频文件
			if (shiPinLJ != null && !"".equals(shiPinLJ)) {
				/**
				 * 删除原来的视频文件
				 */
				sqlBuffer.append("select BianHao, ShiPinLJ");
				sqlBuffer.append(" from JSKJ_JiaoXueSP");
				sqlBuffer.append(" where BianHao='" + reqMap.get("di_ShiPinBH") + "'");
				log.info("查询视频sql：" + sqlBuffer);
				ResultSet rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
				if (rs.next()) {
					// 视频路径
					String toDelFuJianLJ = rs.getString("ShiPinLJ");
					
					// 绝对路径
					String tmp = ApplicationConfig.getInstance().REAL_PATH;
					String basePath = tmp.substring(0, tmp.lastIndexOf("\\") + 1);
					// 附件File
					File fuJianFile = new File(basePath + toDelFuJianLJ);
					if (fuJianFile.exists()) {
						fuJianFile.delete();
					}
				}
				if (rs !=null )
					rs.close();
			}
			
			/**
			 *  更新数据库记录
			 */
			sqlBuffer.delete(0, sqlBuffer.length());
			sqlBuffer.append("update JSKJ_JiaoXueSP set ");
			sqlBuffer.append(" ShiPinMC = '" + reqMap.get("di_ShiPinMC") + "'");	// 视频名称
			sqlBuffer.append(" , ShiPinJJ = '" + reqMap.get("di_ShiPinJJ") + "'");	// 视频简介
			sqlBuffer.append(" , XueXiao = '" + reqMap.get("di_XueXiao") + "'");	// 学校
			if (shiPinLJ != null && !"".equals(shiPinLJ))
				sqlBuffer.append(" , ShiPinLJ='" + shiPinLJ + "' ");	// 视频路径
			sqlBuffer.append(" where BianHao='" + reqMap.get("di_ShiPinBH") + "'");
			log.info("更新视频SQL：" + sqlBuffer);
			dataBaseAccess.executeUpdate(sqlBuffer.toString());
			
			if (dataBaseAccess != null)
				dataBaseAccess.closeConnection();
		} catch (QamFrameworkException e) {
			log.error(e);
			e.printStackTrace();
		} catch (SQLException e) {
			log.error(e);
			e.printStackTrace();
		}
	}
	
	/**
	 * 保存教学视频
	 * @param reqMap
	 * @return
	 * @throws QamFrameworkException
	 */
	private void saveJiaoXueSP(Map<String, String> reqMap) throws QamFrameworkException {
		// 编号
		String bh = ContextService.lookupSequenceService().generateId("SEQ_JiaoXueSP");
		StringBuffer sqlBuf = new StringBuffer();
		sqlBuf.append("insert into JSKJ_JiaoXueSP (BianHao, KeShiBH, ShiPinMC, ShiPinJJ, XueXiao, ZhuJiangR, ShiPinLJ) values");
		sqlBuf.append(" ('" + bh + "', '" + reqMap.get("di_KeShiBH") + "', '" + reqMap.get("di_ShiPinMC") + "', '" );
		sqlBuf.append(reqMap.get("di_ShiPinJJ") + "', '" + reqMap.get("di_XueXiao") + "', '" + reqMap.get("zhuJiangR") + "', '" + reqMap.get("di_ShiPinLJ") + "')");
		log.debug(sqlBuf.toString());
		dataBaseAccess.execute(sqlBuf.toString());
		dataBaseAccess.closeConnection();
	}
}
