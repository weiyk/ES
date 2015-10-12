package com.rc.web.utils;

import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRPrintElement;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JRPrintText;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.fill.JRTemplatePrintRectangle;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleWriterExporterOutput;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * 
 * <p>application name:      导出文件</p>
 
 * <p>application describing:导出文件</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class JasperUtils {
	private static final Log log = LogFactory.getLog(JasperUtils.class);
	public JasperUtils() {
	}

	public static final String PRINT_TYPE = "print";

	public static final String PDF_TYPE = "pdf";

	public static final String EXCEL_TYPE = "excel";

	public static final String HTML_TYPE = "html";

	public static final String WORD_TYPE = "word";

	/**
	 * 导出excel
	 * @throws Exception 
	 */
	public static void exportExcel(JasperPrint jasperPrint,
			HttpServletResponse response, HttpServletRequest request,String filename)
			throws Exception {
		JRXlsExporter exporter = new JRXlsExporter();
	    byte[] bytes;   
	    ByteArrayOutputStream baos = new ByteArrayOutputStream();   
	    exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
	    exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(baos));
	    //exporter.setExporterOutput(new Simpleexpor)
//        
//        exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);   
//        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,baos);
////      exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
//        exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE); 
//        exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE); 
//        exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
        try {
			exporter.exportReport();
		} catch (JRException e) {
			e.printStackTrace();
			log.error(e.getMessage());
		}   
        bytes = baos.toByteArray();
        String view= request.getHeader("User-Agent").toLowerCase();
        if   (bytes != null && bytes.length > 0){  
        	response.reset();
        	response.setCharacterEncoding("utf-8");
        	response.setHeader("Content-Type", "application/force-download");
        	response.setContentType("application/vnd.ms-excel;charset=utf-8");   
        	response.setHeader("Content-disposition","attachment;   filename=\"" + exportlx(view,filename) + ".xls\"");
        	response.setContentLength(bytes.length);   
        	ServletOutputStream ouputStream = response.getOutputStream();   
        	ouputStream.write(bytes,0,bytes.length);   
        	ouputStream.flush();   
        	ouputStream.close();   
        }
	}

	/**
	 * 导出pdf
	 * @throws Exception 
	 */
	public static void exportPDF(JasperPrint jasperPrint,
			HttpServletResponse response, HttpServletRequest request,String filename)
			throws Exception {
		//JRExporter exporter = new JRPdfExporter();
	    byte[] bytes = JasperExportManager.exportReportToPdf(jasperPrint);   
        String view= request.getHeader("User-Agent").toLowerCase();
        if   (bytes != null && bytes.length > 0){   
        	response.reset();   
        	response.setCharacterEncoding("utf-8");
        	response.setContentType("application/vnd.ms-pdf;charset=GB2312");   
        	response.setHeader("Content-disposition","attachment;   filename=\"" + exportlx(view,filename) + ".pdf\"");   
        	response.setContentLength(bytes.length);   
        	ServletOutputStream ouputStream = response.getOutputStream();   
        	ouputStream.write(bytes,0,bytes.length);   
        	ouputStream.flush();   
        	ouputStream.close();   
        }
	}

	/**
	 * 导出html
	 * @throws Exception 
	 */
	public static void exportHTML(JasperPrint jasperPrint,
			HttpServletResponse response, HttpServletRequest request,String filename)
			throws Exception {
		response.setContentType("text/html");
		JRHtmlExporter exporter = new JRHtmlExporter();
//		Map<String,Object> imagesMap = new HashMap<String,Object>();  
//		request.getSession().setAttribute("IMAGES_MAP", imagesMap);  
//		exporter.setParameter(JRHtmlExporterParameter.IMAGES_MAP, imagesMap);  
//		exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI,  "image.jsp image=");  
		exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,Boolean.FALSE);  

		byte[] bytes ;   
        ByteArrayOutputStream baos = new ByteArrayOutputStream();   
        exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);   
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,baos);
//      exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML, "<br style='page-break-before:always;'>");//强制打印分页
//      exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
        try {
			exporter.exportReport();
		} catch (JRException e) {
			// TODO Auto-generated catch block
//			e.printStackTrace();
			log.error(e.getMessage());
		}   
        bytes = baos.toByteArray();
        String view= request.getHeader("User-Agent").toLowerCase();
        if   (bytes != null && bytes.length > 0){   
        	response.reset();   
        	response.setCharacterEncoding("utf-8");
        	response.setContentType("application/vnd.ms-html;charset=GB2312");   
        	response.setHeader("Content-disposition","attachment;   filename=\"" + exportlx(view,filename) + ".html\"");   
        	response.setContentLength(bytes.length);   
        	ServletOutputStream ouputStream = response.getOutputStream();   
        	ouputStream.write(bytes,0,bytes.length);   
        	ouputStream.flush();   
        	ouputStream.close();   
        }
	}

	/**
	 * 导出word
	 * @throws Exception 
	 */
	public static void exportWord(JasperPrint jasperPrint,
			HttpServletResponse response, HttpServletRequest request,String filename)
			throws Exception {
		JRExporter exporter = new JRRtfExporter();
		byte[] bytes;   
        ByteArrayOutputStream baos = new ByteArrayOutputStream();   
        exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);   
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,baos);
//      exporter.setParameter(JRExporterParameter.CHARACTER_ENCODING, "UTF-8");
        try {
			exporter.exportReport();
		} catch (JRException e) {
			// TODO Auto-generated catch block
//			e.printStackTrace();
			log.error(e.getMessage());
		}   
        bytes = baos.toByteArray();
        String view= request.getHeader("User-Agent").toLowerCase();
        if   (bytes != null && bytes.length > 0){   
        	response.reset();   
        	response.setCharacterEncoding("utf-8");
        	response.setContentType("application/vnd.ms-word;charset=GB2312");   
        	response.setHeader("Content-disposition","attachment;   filename=\"" + exportlx(view,filename) + ".doc\"");   
        	response.setContentLength(bytes.length);   
        	ServletOutputStream   ouputStream   =   response.getOutputStream();   
        	ouputStream.write(bytes,0,bytes.length);   
        	ouputStream.flush();   
        	ouputStream.close();   
        }
	}

	/**
	 * 打印
	 */
//	public static void exportPrint(JasperPrint jasperPrint,
//			HttpServletResponse response, HttpServletRequest request)
//			throws IOException {
//		try {
//			JasperPrintManager.printReport(jasperPrint,true);
//		} catch (JRException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		response.setContentType("application/octet-stream");    
//	    ServletOutputStream ouputStream = response.getOutputStream();    
//	    try {    
//	        ObjectOutputStream oos = new ObjectOutputStream(ouputStream);   
//	        //这里是调用了另外一个servlet，其结果也是返回一个JasperPrint对象     
//	        //JasperPrint jpt = rst.getReportPrint(rptCode, context,object, tradeTypeInput);  
//	        oos.writeObject(jasperPrint);    
//	        oos.flush();    
//	        oos.close();    
//	    } catch (Exception e) {    
//	        //处理    
//	    }   
//
//	}
	/**
	  * 按照类型导出不同格式文件
	  * 
	  * @param JASPER
	  *            
	  * @param type文件类型
	  * 
	  * @param request
	  * @param response
	 * @throws Exception 
	  */

	public static void export(JasperPrint jasperPrint,String type, HttpServletResponse response,
			HttpServletRequest request,String filename) throws Exception {
		if (EXCEL_TYPE.equals(type)) {//导出EXCEL文件
			exportExcel(jasperPrint, response, request,filename);
		} else if (PDF_TYPE.equals(type)) {//导出PDF文件
			exportPDF(jasperPrint, response, request,filename);
		} else if (HTML_TYPE.equals(type)) {//导出HTML文件
			exportHTML(jasperPrint, response, request,filename);
		} else if (WORD_TYPE.equals(type)) {//导出WORD文件
			try {
				exportWord(jasperPrint, response, request,filename);
			} catch (JRException e) {
				e.printStackTrace();
				log.error(e.getMessage());
			}
//		} else if (PRINT_TYPE.equals(type)) {//打印报表
//			exportPrint(jasperPrint, response, request);
		}
	}
   public static String exportlx(String view,String fileName) throws Exception{
	   if (view.indexOf("firefox") > 0){
			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");// firefox浏览器
	   }else{
			fileName = URLEncoder.encode(fileName, "UTF-8");
	   }		
	   return fileName;
   }
   /**
    * 处理JasperPrint
    * @param jasperPrint
    */
   public static void HandleJasperPrinter(JasperPrint jasperPrint){
	   List<JRPrintPage> pages = jasperPrint.getPages();
		if (pages != null && !pages.isEmpty()) {
			JRPrintPage page = pages.get(0);
			List<JRPrintElement> elements = page.getElements();
			List<JRTemplatePrintRectangle> jRTemplatePrintRectangleList = getJRTemplatePrintRectangleList(elements);
			for (JRTemplatePrintRectangle jrTemplatePrintRectangle : jRTemplatePrintRectangleList) {
				List<JRPrintElement> subReportList = new ArrayList<JRPrintElement>();
				int sumHeight = 0;
				int count = 0;
				for (JRPrintElement jrPrintElement : elements) {
					if(jrPrintElement.getX() >= jrTemplatePrintRectangle.getX() && jrPrintElement.getX() < jrTemplatePrintRectangle.getX() + jrTemplatePrintRectangle.getWidth() && jrPrintElement.getY()>= jrTemplatePrintRectangle.getY() && jrPrintElement.getY() < jrTemplatePrintRectangle.getY() + jrTemplatePrintRectangle.getHeight() && jrPrintElement instanceof JRPrintText){
						subReportList.add(jrPrintElement);
						if(jrPrintElement.getX() == jrTemplatePrintRectangle.getX()){
							sumHeight += jrPrintElement.getHeight();
							count++;
						}
					}
				}
				if(sumHeight != 0 && sumHeight < jrTemplatePrintRectangle.getHeight()){
					List<Integer> sortList = getSortList(subReportList);
					for (JRPrintElement jrPrintElement2 : subReportList) {
						jrPrintElement2.setHeight(jrPrintElement2.getHeight() + (jrTemplatePrintRectangle.getHeight()-sumHeight)/count);
						int _count = sortList.indexOf(jrPrintElement2.getY());
						jrPrintElement2.setY(jrPrintElement2.getY() + (jrTemplatePrintRectangle.getHeight()-sumHeight)/count*_count);
					}
				}
			}
		}
   }
   /**
    * 根据report中最右边的元素位置来设置 report的宽度
    * @param jasperPrint
    */
   public static void setWidth(JasperPrint jasperPrint){
	   List<JRPrintPage> pages = jasperPrint.getPages();
	   int max = 0;
	   if (pages != null && !pages.isEmpty()) {
		   JRPrintPage page = pages.get(0);
			List<JRPrintElement> elements = page.getElements();
			for (JRPrintElement jrPrintElement : elements) {
				if (jrPrintElement.getX()+jrPrintElement.getWidth() > max) {
					max = jrPrintElement.getX()+jrPrintElement.getWidth();
					//jrPrintElement.
				}
			}
	   }
	   if(max>0){
			jasperPrint.setPageWidth(max + jasperPrint.getLeftMargin() + jasperPrint.getRightMargin());
		}
   }
   
   private static List<Integer> getSortList(List<JRPrintElement> subReportList){
	 //取出所有的Y坐标 并排序滤重
		Set<Integer> set = new HashSet<Integer>();
		for(JRPrintElement jrPrintElement2 : subReportList){
			set.add(jrPrintElement2.getY());
		}
		Object[] arrObj = set.toArray();
		int[] arrInt = new int[arrObj.length];
		for (int i = 0; i < arrObj.length; i++) {
			arrInt[i] = (Integer) arrObj[i];
		}
		Arrays.sort(arrInt);
		List<Integer> sortList = new ArrayList<Integer>();
		for (Integer integer : arrInt) {
			sortList.add(integer);
		}
	   return sortList;
   }
   
	//所有子表区域
	private static List<JRTemplatePrintRectangle> getJRTemplatePrintRectangleList(
			List<JRPrintElement> elements) {
		List<JRTemplatePrintRectangle> list = new ArrayList<JRTemplatePrintRectangle>();
		for (JRPrintElement jrPrintElement : elements) {
			if(jrPrintElement instanceof JRTemplatePrintRectangle){
				list.add((JRTemplatePrintRectangle)jrPrintElement);
			}
		}
		return list;
	}
}
