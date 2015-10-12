package com.rc.web.extension.ajax;

import java.sql.ResultSet;




import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qam.framework.context.ContextService;
import com.qam.framework.jdbc.IDataBaseAccess;
import com.qam.web.facade.ajax.AjaxServiceParameter;
import com.qam.web.facade.ajax.IAjaxService;

/**
 * 
 * @author 重置密码
 *
 */
public class HuoQuKS  implements IAjaxService {
	private static Log log = LogFactory.getLog("HuoQuKS");
	public String execute(AjaxServiceParameter params) throws Exception {
		IDataBaseAccess dbm = null;
		String kcbmbh = params.getParameter("kcbmbh");//课程编目编号
		String zjbh = params.getParameter("zjbh");//章节编号 
		String ksbmbh = params.getParameter("ksbmbh");//课时编目编号
		String strDeviceTr="<td id=\"ks_td\">";
		try {
			dbm = ContextService.lookupDefaultDataBaseAccess();
			StringBuffer sql = new StringBuffer(128);
			sql.append("select bianhao, bianmumc,shangjibh from jskj_kechengbm where shangjibh in(select bianhao from jskj_kechengbm where shangjibh='"+kcbmbh+"')");
			log.debug("根据章节获得课时列表SQL:"+sql);
			dbm.openConnection();
			if(zjbh==""||zjbh==null){
				ResultSet rs=dbm.executeQuery("select shangjibh from jskj_kechengbm where bianhao='"+ksbmbh+"'");
				if(rs.next()){zjbh=rs.getString("shangjibh");}
			}
			ResultSet rs = dbm.executeQuery(sql.toString());
			while(rs.next()){
				if(rs.getString("shangjibh").equals(zjbh)){
					if(rs.getString("bianhao").equals(ksbmbh)){
						strDeviceTr += "<input id=\"bmks\" type=\"radio\" name=\"bmks\" onclick=\"selectks('"+rs.getString("bianhao")+"','"+rs.getString("bianmumc")+"')\" value=\"" + rs.getString("bianhao") + "\" style=\"width:5%\" class=\"FormElement ui-widget-content ui-corner-all\" checked=\"true\">"+rs.getString("bianmumc");
					}else{
						strDeviceTr += "<input id=\"bmks\" type=\"radio\" name=\"bmks\" onclick=\"selectks('"+rs.getString("bianhao")+"','"+rs.getString("bianmumc")+"')\" value=\"" + rs.getString("bianhao") + "\" style=\"width:5%\" class=\"FormElement ui-widget-content ui-corner-all\">"+rs.getString("bianmumc");
					}
				}
			}
			strDeviceTr += "</td>";
			strDeviceTr+="&"+zjbh;
			rs.close();
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		} finally{
			dbm.closeConnection();
		}
		return strDeviceTr;
	}
}
