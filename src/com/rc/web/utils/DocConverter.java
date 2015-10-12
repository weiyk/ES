package com.rc.web.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageEncoder;
import com.sun.media.jai.codec.JPEGEncodeParam;

/**
 * s doc DOCX格式转换
 */
public class DocConverter {
	private static final Log log = LogFactory.getLog(DocConverter.class);
	//private String fileString;// (只涉及pdf2swf路径问题)
	@SuppressWarnings("unused")
	private String outputPath = "";// 输入路径 ，如果不设置就输出在默认的位置
	private String fileName;
	private File pdfFile;
	private File swfFile;
	private File officeFile;
	private File odtFile;// 解决中文乱码
	private File imgFile;
	private File cimgFile;
	private String allImg = ".bmp,.pcx,.tiff,.tga,.exif,.fpx,.svg,.psd,.cdr,.pcd,.dxf,.ufo,.eps,.ai,.hdri,.raw,.jpg,.gif";
	private String extensionName="";//文件后缀名
	private boolean oldpdf=false;
	private HttpServletRequest request;
	
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	public DocConverter(String fileString) {
		ini(fileString);
	}
	public DocConverter(String fileString,HttpServletRequest request) {
		this.setRequest(request);
		ini(fileString);
	}
	/**
	 * 重新设置 file
	 * 
	 * @param fileString
	 */
	public void setFile(String fileString) {
		ini(fileString);
	}

	/**
	 * 初始化
	 * 
	 * @param fileString
	 */
	@SuppressWarnings("static-access")
	private void ini(String fileString) {
		try {
			//this.fileString = fileString;
			fileName = fileString.substring(0, fileString.lastIndexOf("/"));
			officeFile = new File(fileString);
			imgFile = new File(fileString);
			pdfFile = new File(fileString.substring(0,fileString.lastIndexOf(".")) + ".pdf");
			String s = fileString.substring(fileString.lastIndexOf("/") + 1,
					fileString.lastIndexOf("."));
			s = s.replaceAll(" ", "");
			char[] chars = s.toCharArray();
			String fileName2 = "";
			for (int i = 0; i < chars.length; i++) {
				fileName2 = fileName2 + "" + (int) chars[i];
			}
			fileName = fileName + "/" + fileName2;

			// 用于处理TXT文档转化为PDF格式乱码,获取上传文件的名称（不需要后面的格式）
			extensionName = fileString.substring(fileString.lastIndexOf("."));
			// 判断上传的文件是否是TXT文件
			if (".pdf".equalsIgnoreCase(extensionName)) {
				//pdfFile = new File(fileName + ".pdf");
				this.oldpdf=true;
				//this.copyFile(officeFile, pdfFile); 
			}else if(allImg.contains(extensionName.toLowerCase())){//若为其他格式图片，则转换为jpeg格式
				cimgFile = new File(fileName+".jpeg");
				this.changeIMG(imgFile, cimgFile);
				extensionName = ".jpeg";
			}
			swfFile = new File(fileName + ".swf");
		} catch (Exception e) {
			// e.printStackTrace();
			log.error(e.getMessage());
		}
	}

	/**
	 * 文档类转换成 SWF
	 * 
	 */
	private void pdf2swf() throws Exception {
		if (swfFile != null && !swfFile.exists()) {
			if (pdfFile != null && pdfFile.exists()) {
				Process p = null;
				try {
					//-s poly2bitmap
					String cmd = FlexPagerUtils.getSWFToolsCMD(".pdf") + " -T9 -f -t -G -s storeallcharacters " + getPath(pdfFile) + " -o " + swfFile.getPath() + " ";
					log.debug(cmd);
					p = Runtime.getRuntime().exec(cmd); 
					loadStream(p.getInputStream());
					//log.error(loadStream(p.getErrorStream()));
					log.debug("****swf转换成功，文件输出：" + swfFile.getPath() + "****");
				} catch (IOException e) {
					log.error(e.getMessage());
				}finally{
					if (pdfFile.exists()&!this.oldpdf) {
						pdfFile.delete();
					}
					p.destroy();
				}
			}
		} else {
			log.debug("****swf已经存在不需要转换****");
		}

	}
	/**
	 * 
	 * JPEG（*.JPG *.JPEG *.JPE）格式 PNG 格式
	 * 
	 * 图片转为SWF
	 * 
	 * tools 根据图片的后缀名去动态加入需要调用的转换工具
	 * 
	 */
	private void img2swf(String type) throws Exception {
		if (imgFile != null && imgFile.exists()) {
			if (swfFile != null && !swfFile.exists()) {
				Process p = null;
				try {
					String cmd = FlexPagerUtils.getSWFToolsCMD(type) + (cimgFile != null ? getPath(cimgFile) : getPath(imgFile)) + " -o " + swfFile.getPath();
					log.debug(cmd);
					p =  Runtime.getRuntime().exec(cmd);
					loadStream(p.getInputStream());
					log.debug("****图片转换swf成功，文件输出：" + swfFile.getPath()
							+ "****");
				} catch (IOException e) {
					log.error(e.getMessage());
				}finally{
					if(cimgFile != null && cimgFile.exists()){
						cimgFile.delete();
					}
					if(p != null){
						//p.destroy();
						//p = null;
					}
				}
			} else {
				log.debug("****swf已经存在不需要转换****");
			}
		} else {
			log.debug("****img文件不存在****");
		}

	}

	/**
	 * 
	 * @param in
	 * @return
	 * @throws IOException
	 */
	private void loadStream(InputStream in) throws IOException {
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
		String line = null;
		while ((line = bufferedReader.readLine()) != null){
			try {
			  log.debug(line);
			} catch (Exception e) {
			 log.error(e.getMessage());
			}
		}
	}

	/**
	 * 转换主方法
	 * 
	 * @return
	 */
	public boolean conver() {
		if (swfFile != null && swfFile.exists()) {
			log.debug("****转换器开始工作，该文件已经转换为swf****");
			return true;
		}
		try {
			// 得到文件的扩展名
			/**
			 * 判断是否为图片 JPEG（*.JPG *.JPEG *.JPE）
			 * 
			 * PNG
			 * 
			 * 如果为图片就直接转换为SWF格式; 否则就先转换为PDF格式，然后在转换为SWF格式;
			 */
			if (".JPEG".equalsIgnoreCase(extensionName) || ".PNG".equalsIgnoreCase(extensionName)) {
				img2swf(extensionName);
				log.debug("转换图片完成！！！");
			}else if(".swf".equalsIgnoreCase(extensionName)){
				FileUtils.copyFile(officeFile, swfFile);//直接预览swf文件
				log.debug("swf直接调看");
			}else {
				//doc2pdf();
				if(FlexPagerUtils.convert2PDF(officeFile.getPath(),pdfFile.getPath())){
					log.debug("=====15");
					pdf2swf();
					log.debug("=====16");
					log.debug("转换文档结束！！！");
				}else{
					log.debug("pdf转换失败。");
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}

		if (swfFile.exists()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 返回文件路径
	 * 
	 * @param s
	 */
	public String getswfPath() {
		return getPath(swfFile);
	}
	/**
	 * 返回odt 转换文件
	 * @return
	 */
	public String getodtPath() {
		return getPath(odtFile);
	}
	/**
	 * 替换文件路径
	 * @param file
	 * @return
	 */
	private String getPath(File file){
		if (file !=null && file.exists()) {
			return file.getPath().replaceAll("\\\\", "/");
		}
		return "";
	}
	/**
	 * 图片转换 若不为jpg gif jpeg的图片均转换为jpeg后预览
	 * @param src 原图片文件
	 * @param desc 目标图片文件
	 * @throws Exception 
	 */
	private void changeIMG(File src,File desc) throws Exception{
		RenderedOp ro = JAI.create("fileload", src.getPath());  
        OutputStream os = new FileOutputStream(desc);  
        JPEGEncodeParam jpegParam = new JPEGEncodeParam();  
        //指定格式类型，jpg 属于 JPEG 类型  
        ImageEncoder enc2 = ImageCodec.createImageEncoder("JPEG", os, jpegParam);  
        enc2.encode(ro);  
        os.close();  
	}
	/**
	 * 设置输出路径
	 */
	public void setOutputPath(String outputPath) {
		this.outputPath = outputPath;
		if (!outputPath.equals("")) {
			String realName = fileName.substring(fileName.lastIndexOf("/"),
					fileName.lastIndexOf("."));
			if (outputPath.charAt(outputPath.length()) == '/') {
				swfFile = new File(outputPath + realName + ".swf");
			} else {
				swfFile = new File(outputPath + realName + ".swf");
			}
		}
	}
	
	/**
	 * copy文件
	 * 
	 * @param sourceFile
	 * @param targetFile
	 * @throws IOException
	 */
	public static void copyFile(File sourceFile, File targetFile)
			throws IOException {
		FileInputStream input = new FileInputStream(sourceFile);// 新建文件输入流并对它进行缓冲
		BufferedInputStream inBuff = new BufferedInputStream(input);
		FileOutputStream output = new FileOutputStream(targetFile); // 新建文件输出流并对它进行缓冲
		BufferedOutputStream outBuff = new BufferedOutputStream(output);
		byte[] b = new byte[1024 * 5];// 缓冲数组
		int len;
		while ((len = inBuff.read(b)) != -1) {
			outBuff.write(b, 0, len);
		}
		outBuff.flush();// 刷新此缓冲的输出流
		// 关闭流
		inBuff.close();
		outBuff.close();
		output.close();
		input.close();
	}
}