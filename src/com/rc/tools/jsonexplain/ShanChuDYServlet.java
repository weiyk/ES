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
 * 删除查询信息
 * @author Cui-YH
 *
 */

public class ShanChuDYServlet extends HttpServlet {
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
			String liebiaoBH=Convert(request.getParameterValues("liebiaoBH"));//获取资源列表
			boolean falg=DingyueDelete(liebiaoBH);
			if(falg){
				log.debug("删除成功！");
				request.setAttribute("msg","删除成功！");
				request.getRequestDispatcher("/servlet/jspcontrolservlet?_qam_dialog=GNDH_ZiYuanDY").forward(request, response);
				
			}else{
				log.debug("删除失败！");
				request.setAttribute("msg","删除失败！");
				request.getRequestDispatcher("/servlet/jspcontrolservlet?_qam_dialog=GNDH_ZiYuanDY").forward(request, response);
			}
			
	}
	/**
	 * 删除查询
	 * 
	 * @param bianhao  编号
	 * @return
	 */
	private boolean DingyueDelete(String bianhao){
		boolean falg=false;
		dataBaseAccess = ContextService.lookupDefaultDataBaseAccess();			
		try {
			dataBaseAccess.openConnection();
			String sql="DELETE FROM JSKJ_DingYueFL WHERE BianHao IN("+bianhao+")";
			int count=dataBaseAccess.executeUpdate(sql.toString());
			if(count>0){
				falg=true;
				log.debug(sql.toString());
			}
		} catch (QamFrameworkException e) {
			falg=false;
			try {
				dataBaseAccess.rollback();
				} catch (QamFrameworkException e1) {
					e1.printStackTrace();
				}
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
				sb. append("'"+ary[i]+"',");
			}else{
				sb. append("'"+ary[i]+"'");
			}
		}
		return sb.toString();
	}
	
}
