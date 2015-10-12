package com.rc.web.teacher;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jspsmart.upload.Request;
import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

/**
 * 上传资源
 * @author admin
 *
 */
public class UploadResource extends HttpServlet{

	private static final long serialVersionUID = 5864857179333208641L;
	private static final Log log = LogFactory.getLog("UploadResource");
	private static final String ZYKJ_DIR = "upload/teacher/ziyuan";
	private static IDataBaseAccess dataBaseAccess = null;
	
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
		
		Map<String, String> reqMap = new HashMap<String, String>();
		List<?> items;
		try {
			items = upload.parseRequest(request);
			FileItem item = null;
			String filePath = null;
			for (int i = 0; i < items.size(); i++) {
				item = (FileItem) items.get(i);
				// 保存文件
				if (!item.isFormField() && item.getName().length() > 0) {
					// 原始文件名称
					String[] tmpArray = item.getName().split("\\.");
					String rawName = tmpArray[tmpArray.length -2];
					if (rawName.contains("\\")) {
						rawName = rawName.substring(rawName.lastIndexOf("\\") + 1);
					}
					// 文件后缀
					String suffix = tmpArray[tmpArray.length - 1];
					// 资源附件编号
					String bh = ContextService.lookupSequenceService().generateId("SEQ_ZiYuanFJ");
					filePath = base + File.separator + bh + item.getName().substring(item.getName().lastIndexOf("."));
					File saveFile = new File(filePath);
					item.write(saveFile);
					// 文件大小
					Long fileSize = saveFile.length();
					if ("di_FuJianLJ".equalsIgnoreCase(item.getFieldName())) {
						// 资源名称
						reqMap.put("ziYuanMC", rawName + "." + suffix);
						// 资源路径
						reqMap.put("di_FuJianLJ", ZYKJ_DIR + "/" + saveFile.getName());
						// 资源大小（字节）
						reqMap.put("di_ZiYuanDX", fileSize.toString());
						// 文件后缀
						reqMap.put("suffix", suffix);
					} else {
						// 封面路径
						reqMap.put("di_FengMianLJ", ZYKJ_DIR + "/" + saveFile.getName());
						// 资源大小
						reqMap.put("FengMianSize", fileSize.toString());
					}
				} else {
					reqMap.put(item.getFieldName(), item.getString("utf-8"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
			dataBaseAccess.openConnection();
		} catch (QamFrameworkException e) {
			e.printStackTrace();
		}
		
		// 操作类型标识，1：更新操作，其他为添加操作
		String operation = reqMap.get("operation");
		if ("1".equals(operation)) {
			// 更新资源
			updateResource(request, response, reqMap);
		} else {
			// 添加资源
			addResource(request, response, reqMap);
		}
		// 执行完保存后，要跳转到的页面
		String page = "/servlet/jspdispatchservlet?_qam_dialog=GNDH_ZiYuanUpload";
		request.getRequestDispatcher(page).forward(request, response);
	}
	
	/**
	 * 更新资源
	 * @param request
	 * @param response
	 * @throws QamFrameworkException 
	 */
	private void updateResource(HttpServletRequest request, HttpServletResponse response, Map<String, String> reqMap) {
		// 资源编号
		String di_ZiYuanBH = reqMap.get("di_ZiYuanBH");
		// 附件编号
		String di_FuJianBH = reqMap.get("di_FuJianBH");
		// 要删除的资源路径
		String toDelFuJianLJ = null;
		// 要删除的封面路径
		String toDelFengMianLJ = null;
		StringBuffer sqlBuffer = new StringBuffer();
		
		// 检查更新操作是否有上传文件
		if (reqMap.get("di_MeiTiLX") != null) {
			try {
				/**
				 * 查询附件详情
				 */
				sqlBuffer.append("select BianHao, FuJianLJ, FengMianLJ");
				sqlBuffer.append(" from JSKJ_ZiYuanFJ");
				sqlBuffer.append(" where BianHao='" + di_FuJianBH + "'");
				ResultSet rs = dataBaseAccess.executeQuery(sqlBuffer.toString());
				if (rs.next()) {
					toDelFuJianLJ = rs.getString("FuJianLJ");
					toDelFengMianLJ = rs.getString("FengMianLJ");
				}
			} catch (QamFrameworkException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
				
		/**
		 * 更新资源
		 */
		// 文件格式
		String suffix = reqMap.get("suffix");
		// 资源名称
		String ziYuanMC = reqMap.get("ziYuanMC");
		sqlBuffer.delete(0, sqlBuffer.length());
		sqlBuffer.append("update jskj_ziyuan set ");
		sqlBuffer.append(" SuoShuXK = '" + reqMap.get("di_SuoShuXK") + "'");	// 所属学科
		sqlBuffer.append(" ,ShiYongNJ = '" + reqMap.get("di_ShiYongNJ") + "'");	// 适用年级
		sqlBuffer.append(" ,ZiYuanLB = '" + reqMap.get("di_ZiYuanLB") + "'");	// 资源类别
		sqlBuffer.append(" ,MeiTiLX = '" + reqMap.get("di_MeiTiLX") + "'");		// 媒体类型
		sqlBuffer.append(" ,ZiYuanJJ = '" + reqMap.get("di_ZiYuanJJ") + "'");	// 资源简介
		// 文件格式
		if (suffix != null && !"".equals(suffix))
			sqlBuffer.append(" ,WenJianGS = '" + suffix + "'");	
		// 资源名称
		if (ziYuanMC != null && !"".equals(ziYuanMC))
			sqlBuffer.append(" ,ZiYuanMC= '" + ziYuanMC + "'");	
		sqlBuffer.append(" where BianHao = '" + di_ZiYuanBH + "'");
		log.debug(sqlBuffer.toString());
		try {
			dataBaseAccess.execute(sqlBuffer.toString());
		} catch (QamFrameworkException e) {
			e.printStackTrace();
		}
		
		/**
		 * 更新资源附件
		 */
		// 附件路径
		String fuJianLJ = reqMap.get("di_FuJianLJ");
		// 封面路径
		String fengMianLJ = reqMap.get("di_FengMianLJ");
		// 附件类型
		String fuJianLX = reqMap.get("di_MeiTiLX");
		// 资源大小
		String ziYuanDX = reqMap.get("di_ZiYuanDX");
		
		sqlBuffer.delete(0, sqlBuffer.length());
		sqlBuffer.append("update jskj_ziyuanfj set ");
		sqlBuffer.append(" ShangChuanSJ = now()");	// 上传时间
		// 附件名称
		if (ziYuanMC != null && !"".equals(ziYuanMC))
			sqlBuffer.append(" ,FuJianMC = '" + ziYuanMC + "'");
		// 附件路径
		if (fuJianLJ != null && !"".equals(fuJianLJ))
			sqlBuffer.append(" ,FuJianLJ = '" + fuJianLJ + "'");
		// 封面路径
		if (fengMianLJ != null && !"".equals(fengMianLJ))
			sqlBuffer.append(" ,FengMianLJ = '" + fengMianLJ + "'");
		// 附件类型
		if (fuJianLX != null && !"".equals(fuJianLX))
			sqlBuffer.append(" ,FuJianLX = '" + fuJianLX + "'");
		// 资源大小
		if (ziYuanDX != null && !"".equals(ziYuanDX))
			sqlBuffer.append(" ,ZiYuanDX = '" + ziYuanDX + "'");
		sqlBuffer.append(" where BianHao = '" + di_FuJianBH + "'");
		log.debug(sqlBuffer.toString());
		try {
			dataBaseAccess.execute(sqlBuffer.toString());
			dataBaseAccess.closeConnection();
		} catch (QamFrameworkException e) {
			e.printStackTrace();
		}
		
		/**
		 * 删除附件、封面文件
		 */
		if (fuJianLJ != null && !"".equals(fuJianLJ)) {
			// 绝对路径
			String tmp = ApplicationConfig.getInstance().REAL_PATH;
			String basePath = tmp.substring(0, tmp.lastIndexOf("\\") + 1);
			// 附件File
			File fuJianFile = new File(basePath + toDelFuJianLJ);
			if (fuJianFile.exists()) {
				fuJianFile.delete();
			}
			// 封面文件
			File fengMianFile = new File(basePath + toDelFengMianLJ);
			if (fengMianFile.exists()) {
				fengMianFile.delete();
			}
		}
		
		// 提示信息
		request.setAttribute("msg", "修改成功！");
	}
	
	/**
	 * 添加资源
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	private void addResource(HttpServletRequest request, HttpServletResponse response, Map<String, String> reqMap) {
		// 保存资源
		try {
			saveZiYuan(reqMap);
			request.setAttribute("msg", "添加资源成功！");
		} catch (QamFrameworkException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 保存资源
	 * @throws QamFrameworkException 
	 */
	private void saveZiYuan(Map<String, String> reqMap) throws QamFrameworkException {
		// 资源编号
		String zybh = ContextService.lookupSequenceService().generateId("SEQ_ZiYuan");
		
		/**
		 * 保存资源
		 */
		StringBuffer sqlBuf = new StringBuffer();
		sqlBuf.append("insert into JSKJ_ZiYuan ");
		sqlBuf.append("(BianHao, ZiYuanMC, ZiYuanJJ, SuoShuXK, ShiYongNJ, ZiYuanLB, MeiTiLX, WenJianGS, YueDuJLS, XiaZaiJLS, ShouCanJLS)");
		sqlBuf.append(" values ");
		sqlBuf.append("('" + zybh + "', '" + reqMap.get("ziYuanMC") + "', '" + reqMap.get("di_ZiYuanJJ") + "'");
		sqlBuf.append(",'" + reqMap.get("di_SuoShuXK") + "', '" + reqMap.get("di_ShiYongNJ") + "','" + reqMap.get("di_ZiYuanLB") + "'");
		sqlBuf.append(", '" + reqMap.get("di_MeiTiLX") + "', '" + reqMap.get("suffix") + "', 0, 0, 0");
		sqlBuf.append(")");
		log.debug(sqlBuf.toString());
		dataBaseAccess.execute(sqlBuf.toString());
		
		/**
		 * 保存资源附件
		 */
		// 附件编号
		String fjbh = ContextService.lookupSequenceService().generateId("SEQ_ZiYuanFJ");
		sqlBuf.delete(0, sqlBuf.length());
		/**
		 * 附件类型同资源表中的媒体类型一致
		 */
		sqlBuf.append("insert into JSKJ_ZiYuanFJ ");
		sqlBuf.append(" (BianHao, ZhuBiaoBH, FuJianMC, FuJianLJ, FengMianLJ, FuJianLX, ZiYuanDX, ShangChuanSJ)");
		sqlBuf.append(" values ('" + fjbh + "', '" + zybh + "', '" + reqMap.get("ziYuanMC") + "'");
		sqlBuf.append(", '" + reqMap.get("di_FuJianLJ") + "', '" + reqMap.get("di_FengMianLJ") + "', '" + reqMap.get("di_MeiTiLX") + "'");
		sqlBuf.append(", '" + reqMap.get("di_ZiYuanDX") + "', now()");
		sqlBuf.append(")");
		log.debug(sqlBuf.toString());
		dataBaseAccess.execute(sqlBuf.toString());
		dataBaseAccess.closeConnection();
	}
}
