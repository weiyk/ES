package com.rc.tools.jsonexplain;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.QamFrameworkException;
import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;

/**
 * 新增订阅查询
 * @author Cui-YH
 *
 */


public class ZiYuanDYServlet extends HttpServlet {
	private static IDataBaseAccess dataBaseAccess = null;
	private static final Log log = LogFactory.getLog("ZiYuanDYServlet");
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");//设置字符集编码格式
			String fenleimc=request.getParameter("InputfenLeiMC");//获取分类名称
			String ziyuanlb=Convert(request.getParameterValues("ziyuanlb"));//获取资源列表
			String meitilx=Convert(request.getParameterValues("meitilx"));//获取媒体类型
			String ziyuanlbText=request.getParameter("ziyuanlbText");//获取资源列表
			String meitilxText=request.getParameter("meitilxText");//获取媒体类型
			boolean falg=DingyueInsert(fenleimc, ziyuanlb, meitilx,ziyuanlbText,meitilxText);
			if(falg){
				log.debug("新增成功！");
				request.setAttribute("msg","新增成功！");
				request.getRequestDispatcher("/servlet/jspcontrolservlet?_qam_dialog=GNDH_ZiYuanDY").forward(request, response);
			
			}else{
				log.debug("新增失败！");
				request.setAttribute("msg","新增失败！");
				request.getRequestDispatcher("/servlet/jspcontrolservlet?_qam_dialog=GNDH_ZiYuanDY").forward(request, response);
			}
	}
	/**
	 * 新增订阅信息
	 * 
	 * @param bianhao  编号
	 * @param fenleimc 分类名称
	 * @param ziyuanlb 资源列表
	 * @param meitilx  媒体类型
	 * @return
	 */
	private boolean DingyueInsert(String fenleimc,String ziyuanlb,String meitilx,String ziyuanlbText,String meitilxText){
		boolean falg=false;
		dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
		try {
			dataBaseAccess.openConnection();
			String bianhao = ContextService.lookupSequenceService().generateId("SEQ_ZiYuanDY");//获取编号
			String sql="INSERT INTO JSKJ_DingYueFL(bianhao,fenleimc,ziyuanlb,meitilx,ZiYuanLBMC,MeiTiLXMC) " +
					"VALUES('"+bianhao+"','"+fenleimc+"','"+ziyuanlb+"','"+meitilx+"','"+ziyuanlbText+"','"+meitilxText+"')";
			dataBaseAccess.execute(sql.toString());//执行新增
			falg=true;
			log.debug(sql.toString());
		} catch (QamFrameworkException e) {
			falg=false;
			log.debug(e.getMessage());
			e.printStackTrace();
		}finally{
			dataBaseAccess.closeConnection();//关闭连接
		}
		return falg;
	}
	/**
	 * 把数组转换为字符串
	 * 
	 * @param ary 数组
	 * @return
	 */
	private String Convert(String[] ary){
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < ary.length; i++){
			if((i+1) < ary.length){
				sb. append(ary[i]+",");
			}else{
				sb. append(ary[i]);
			}
		}
		return sb.toString();
	}
	
}
