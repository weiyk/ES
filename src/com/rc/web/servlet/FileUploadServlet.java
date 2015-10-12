package com.rc.web.servlet;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.qam.framework.context.ApplicationConfig;
import com.qam.framework.context.ContextService;
/**
 * 
 * <p>application name:      附件下载</p>
 
 * <p>application describing:附件下载</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = -7825355637448948879L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public static byte[] getBytesFromFile(File f) {
		if (f == null) {
			return null;
		}
		try {
			FileInputStream stream = new FileInputStream(f);
			ByteArrayOutputStream out = new ByteArrayOutputStream(1000);
			byte[] b = new byte[1000];
			int n;
			while ((n = stream.read(b)) != -1)
				out.write(b, 0, n);
			stream.close();
			out.close();
			return out.toByteArray();
		} catch (IOException e) {
		}
		return null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
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
		base = base.substring(0, base.indexOf("WEB-INF")) + "upload";
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
			List<?> items = upload.parseRequest(request);
			FileItem item = null;
			String fileName = null;
			Random random = new Random();
			random.nextInt(1000);
			PrintWriter out = response.getWriter();
			for (int i = 0; i < items.size(); i++) {
				item = (FileItem) items.get(i);
				// 保存文件
				if (!item.isFormField() && item.getName().length() > 0) {
					String bh = ContextService.lookupSequenceService().generateId("SEQ_ShenLingDBH");
					fileName = base + File.separator + bh + item.getName().substring(item.getName().lastIndexOf("."));
					item.write(new File(fileName));
					String msg = "";// dbi.batchImport(request, fileName, bh);
					if(msg.length() > 0) new File(fileName).delete();
					out.print(msg);
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
