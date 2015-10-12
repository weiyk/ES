package com.rc.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qam.framework.context.ApplicationConfig;
import com.qam.web.facade.ajax.AjaxManager;
import com.qam.web.facade.servlet.BaseServlet;
/**
 * 
 * <p>application name:      ajax servlet响应</p>
 
 * <p>application describing:</p>
 
 * @author zhou
 * @version ver 1.0
 */
public final class AjaxServlet extends BaseServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 816577451190200011L;

	/**
	 * Constructor of the object.
	 */
	public AjaxServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AjaxManager ajaxManager = new AjaxManager();
		String result = "";
		//ajax post方式提交时 默认编码为UTF-8
		request.setCharacterEncoding("UTF-8");

		response.setHeader("charset",ApplicationConfig.getInstance().getEncoding());
		//设置响应的字符编码
		response.setContentType("text/xml;charset="+ApplicationConfig.getInstance().getEncoding()); 
		
		result = ajaxManager.transmit(request);
		PrintWriter out = response.getWriter();
		out.print(result);
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
