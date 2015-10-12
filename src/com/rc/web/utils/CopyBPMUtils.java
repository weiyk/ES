package com.rc.web.utils;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;

import com.qam.framework.util.CommonUtils;
/**
 * 
 * <p>application name:      跨年设置</p>
 
 * <p>application describing:跨年设置</p>
 
 * @author zhou
 * @version ver 1.0
 */
public final class CopyBPMUtils {
	private static final Log log = LogFactory.getLog(CopyBPMUtils.class);
	private static Map<String, String[]> tableMap = new HashMap<String, String[]>(20);//存放表名称第一个元素为名，第二个元素为Q8序列ID
	private static Map<String,String[]> relationMap = new HashMap<String, String[]>(10);//存放依赖关系，value[1]依赖字段,value[0]依赖表名
	private static Map<String,JSONObject> fieldMap = new HashMap<String, JSONObject>(20);//存放表字段
	private static Map<String,Boolean> treeMap = new HashMap<String, Boolean>(4);//主表是否为树形结构
	private static Map<String, String> dateField = new HashMap<String, String>();//存放日期字段
	private static Map<String, String[]> clobInfo = new HashMap<String, String[]>();//存放大字段字段 key 表ID，value[0]sql.value[1]参数id
	private static Map<String, String> clobField = new HashMap<String, String>();//存放大字段列名
	private static Map<String, String> clobCurrent = new HashMap<String, String>();//存放获取本年主键
	static{
		//存放日期字段
		dateField.put("ChuangJianSJ", "ChuangJianSJ");
		clobInfo.put("zc", new String[]{"UPDATE YSPZ_ZhiChuSX SET JingFeiZCZN = ? WHERE BIANHAO = ?","JingFeiZCZN,BianHao"});//支出事项[0]sql,[1]取上年数据,[2]去本年数据
		clobInfo.put("zc_dw", new String[]{"UPDATE YSPZ_DanWeiZCSX SET JingFeiZCZN = ? WHERE GUANLIZZBH = ? AND ZHICHUSXBH = ?","JingFeiZCZN,GUANLIZZBH,ZHICHUSXBH"});//单位支出事项
		clobField.put("JingFeiZCZN", "JingFeiZCZN");
		clobCurrent.put("BianHao", "BianHao");
		clobCurrent.put("ZHICHUSXBH", "ZHICHUSXBH");
		//对应表名称
		tableMap.put("cp", new String[]{"YSPZ_CaiZhengYSSX","SEQ_WaiBuYSSX","外部预算事项"});//外部预算事项
		tableMap.put("cp_np",  new String[]{"YSPZ_CaiPiNPYSSXYS","","财批/内批预算事项映射"});//财批内批映射
		tableMap.put("np", new String[]{"YSPZ_NeiBuYSSX","SEQ_NeiBuSXBH","内部部预算事项"});//内部预算事项
		tableMap.put("np_dw", new String[]{"YSPZ_DanWeiNBYSSX","","单位内部预算事项"});//单位内部预算事项
		tableMap.put("np_zc", new String[]{"YSPZ_NeiBuYSSXDYZCSX","","内部预算事项对应支出事项"});//内部预算事项对应支出事项
		tableMap.put("np_ys_zc", new String[]{"YSPZ_YuSuanSXYSZCSX","SEQ_YingSheBH","预算事项映射支出事项"});//预算事项映射支出事项
		tableMap.put("np_gk", new String[]{"GKCS_GuanKongSXZC","SEQ_GuanKongSXBH","管控事项组成"});//管控事项组成
		tableMap.put("np_gk_yw", new String[]{"GKCS_GuiKouGLYWFW","SEQ_GuanKongFWBH","归口管理业务范围"});//归口管理业务范围
		tableMap.put("zc", new String[]{"YSPZ_ZhiChuSX","SEQ_ZhiChuSXBH","支出事项"});//支出事项
		tableMap.put("zc_mx", new String[]{"YSPZ_ZhiChuSXMX","SEQ_ZhiChuMXBH","支出明细"});//支出明细
		tableMap.put("zc_fz", new String[]{"YSPZ_FuZhuXMX","SEQ_FuZhuXMXBH","辅助项明细"});//辅助项明细
		tableMap.put("zc_dw", new String[]{"YSPZ_DanWeiZCSX","","单位支出事项"});//单位支出事项
		tableMap.put("zc_fy", new String[]{"YSPZ_BuMenFYED","","部门费用额度"});//部门费用额度
		tableMap.put("zc_ys", new String[]{"YSPZ_ZhiChuSXYSKJKM","","支出事项映射会计科目"});//支出事项映射会计科目
		tableMap.put("kjkm", new String[]{"YSPZ_KuaiJiKM","SEQ_KuaiJiKMBH","会计科目"});//会计科目
		tableMap.put("kjkm_dw", new String[]{"YSPZ_DanWeiKJKM","","单位会计科目"});//单位会计科目
		//依赖关系
		relationMap.put("cp", new String[]{"YSPZ_CaiPiNPYSSXYS,BianHao","YSPZ_BenNianDYWNGX,BenNianSX"});
		relationMap.put("np", new String[]{"YSPZ_CaiPiNPYSSXYS,NeiBuYSSXBH","YSPZ_DanWeiNBYSSX,NeiBuYSSXBH","YSPZ_NeiBuYSSXDYZCSX,NeiBuYSSXBH",
				"YSPZ_YuSuanSXYSZCSX,NeiBuYSSXBH","GKCS_GuanKongSXZC,ShiXiangBH","GKCS_GuiKouGLYWFW,ShiXiangBH","YSPZ_BenNianDYWNGX,BenNianSX"});
		relationMap.put("zc", new String[]{"YSPZ_ZhiChuSXMX,ZhiChuSXBH","YSPZ_FuZhuXMX,ZhiChuSXBH","YSPZ_DanWeiZCSX,ZhiChuSXBH",
				"YSPZ_BuMenFYED,ZhiChuSXBH","YSPZ_ZhiChuSXYSKJKM,ZhiChuSXBH","GKCS_GuanKongSXZC,ShiXiangBH","GKCS_GuiKouGLYWFW,ShiXiangBH",
				"YSPZ_NeiBuYSSXDYZCSX,ZhiChuSXBH","YSPZ_YuSuanSXYSZCSX,ZhiChuSXBH","YSPZ_BenNianDYWNGX,BenNianSX"});
		relationMap.put("kjkm", new String[]{"YSPZ_DanWeiKJKM,KuaiJiKMBH","YSPZ_ZhiChuSXYSKJKM,KuaiJiKMBH","YSPZ_BenNianDYWNGX,BenNianSX"});
		//初始化表字段
		try{
			fieldMap.put("cp", getJson("BianHao,ShangJiBH,NianDu,ShiXiangBM,ShiXiangMC,ShiXiangLX,ZhuangTai,BeiZhu,JiCi,ShiFouDC,TongJiFL",
					"BianHao,ShangJiBH","NianDu","","1"));
			fieldMap.put("np", getJson("BianHao,ShangJiBH,NianDu,ShiXiangBM,ShiXiangMC,JiCi,ShiFouDC,ZhuangTai,BeiZhu,TongJiFL,ZhiJieZXXE,AnShangJiYSPFSXE",
					"BianHao,ShangJiBH", "NianDu", "", "2"));
			fieldMap.put("zc", getJson("BianHao,NianDu,ShiXiangBM,ShiXiangMC,ZhiChuFL,ZhongDianZCSX,JingFeiZCZN,ShiFouSGJF,ZhuangTai,BeiZhu,ShiFouCGSX",
					"BianHao", "NianDu", "", "3"));
			fieldMap.put("kjkm", getJson("BianHao,ShangJiBH,NianDu,BianMa,MingCheng,BeiZhu,ChuangJianYH,ChuangJianSJ,ShiFouDC","BianHao,ShangJiBH", 
					"NianDu", "", "4"));
			//子表字段
			fieldMap.put("cp_np", getJson("BianHao,NeiBuYSSXBH,GuanLiZZBH,ShiFouYXDWZDY", "NeiBuYSSXBH,BianHao", "", 
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE NeiBuYSSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("np_dw",getJson("GuanKongLX,GuanLiZZBH,NeiBuYSSXBH,ShiFiuYXZDYJFZCJG,AnShangJiYSPFSXE", "NeiBuYSSXBH", "",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE NeiBuYSSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("np_zc", getJson("NeiBuYSSXBH,ZhiChuSXBH,GuanKongLX,ShiFouJY", "NeiBuYSSXBH,ZhiChuSXBH", "",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE NeiBuYSSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("np_ys_zc", getJson("BianHao,GuanLiZZBH,ShiFouYXSX,NeiBuYSSXBH,ZhiChuSXBH,ShiFouZDY", "NeiBuYSSXBH,ZhiChuSXBH", "BianHao",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE NeiBuYSSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("np_gk", getJson("BianHao,ShiXiangBH,GuanKongLCBH,LeiXing", "ShiXiangBH", "BianHao", 
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE ShiXiangBH = BIANHAO AND NIANDU=P-) OR EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ShiXiangBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("np_gk_yw", getJson("BianHao,ShiXiangBH,LeiXing,GuanLiZZBH", "ShiXiangBH", "BianHao", 
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_NeiBuYSSX WHERE ShiXiangBH = BIANHAO AND NIANDU=P-) OR EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ShiXiangBH = BIANHAO AND NIANDU=P-)", ""));
			
			fieldMap.put("zc_mx", getJson("BianHao,MingXiBM,MingXiMC,ZhuangTai,BeiZhu,ZhiChuSXBH", "ZhiChuSXBH", "BianHao",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ZhiChuSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("zc_fz", getJson("BianHao,ZhiChuSXBH,MingCheng,ZhuangTai,ShiFouBT,BeiZhu", "ZhiChuSXBH", "BianHao",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ZhiChuSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("zc_dw", getJson("YunXuZDYYSKJKM,GuanLiZZBH,ZhiChuSXBH,JingFeiZCZN", "ZhiChuSXBH", "",
					 " WHERE EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ZhiChuSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("zc_fy", getJson("BuMenBH,ZhiChuSXBH,FeiYongED,BeiZhu", "ZhiChuSXBH", "",
					" WHERE EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ZhiChuSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("zc_ys", getJson("ZhiChuSXBH,KuaiJiKMBH,GuanLiZZBH", "ZhiChuSXBH", "", " WHERE EXISTS (SELECT BIANHAO FROM YSPZ_ZhiChuSX WHERE ZhiChuSXBH = BIANHAO AND NIANDU=P-)", ""));
			fieldMap.put("kjkm_dw", getJson("GuanLiZZBH,KuaiJiKMBH", "KuaiJiKMBH", "", " WHERE EXISTS (SELECT BIANHAO FROM YSPZ_KuaiJiKM WHERE KuaiJiKMBH = BIANHAO AND NIANDU=P-)", ""));
		}catch(Exception e){
			log.error(e.getMessage());
			e.printStackTrace();
		}
		//主表是否否为树结构
		treeMap.put("cp", true);
		treeMap.put("np", true);
		treeMap.put("zc", false);
		treeMap.put("kjkm", true);
	}
	/**
	 * 返回json对象
	 * @param fields 字段
	 * @param relation 关联字段
	 * @param finalVal 定值
	 * @param condition 条件
	 * @param leixing 类型
	 * @return
	 * @throws Exception
	 */
	private static JSONObject getJson(String fields,String relation,String finalVal,String condition,String leixing) throws Exception{
		JSONObject json_c = new JSONObject();
		json_c.put("fields", fields);
		json_c.put("relation", relation);
		json_c.put("final", finalVal);
		json_c.put("condition", condition);
		json_c.put("leixing", leixing);
		return json_c;
	}
	/**
	 * 获取表名
	 * @param key 页面表对应id
	 * @return
	 */
	public static String getTableName(String key){
		return tableMap.get(key)[0];
	}
	/**
	 * 获取通讯序列ID
	 * @param key
	 * @return
	 */
	public static String getSeqId(String key){
		return tableMap.get(key)[1];
	}
	/**
	 * 获取说明
	 * @param key
	 * @return
	 */
	public static String getTableNote(String key){
		return tableMap.get(key)[2];
	}
	
	/**
	 * 获取主表对应关系表
	 * @param key 主表ID
	 * @return
	 */
	public static String[] getRelation(String key){
		return relationMap.get(key);
	}
	/**
	 * 获取表对应列
	 * @param key 表ID
	 * @return
	 */
	public static String getFields(String key) throws Exception{
		return fieldMap.get(key).getString("fields");
	}
	
	/**
	 * 获取上年主表数据sql
	 * @param key
	 * @param ysnd 上年年度
	 * @return
	 */
	public static String getSelectSql(String key,int ysnd) throws Exception{
		StringBuffer sql = new StringBuffer(128);
		sql.append("SELECT ").append(getFields(key)).append(" FROM ").append(getTableName(key));
		if(CommonUtils.null2Blank(fieldMap.get(key).getString("condition")).length() > 0){
			sql.append((fieldMap.get(key).getString("condition")).replaceAll("P-",  ysnd+""));
		}else{
			sql.append(" WHERE NianDu = ").append(ysnd);
		}
		if(treeMap.get(key) != null && treeMap.get(key)){
			sql.append(" CONNECT BY PRIOR BIANHAO = SHANGJIBH START WITH SHANGJIBH IS NULL ORDER SIBLINGS BY BIANHAO");
		}
		return sql.toString();
	}
	/**
	 * 是否为树形结构
	 * @param key
	 * @return
	 */
	public static Boolean isTree(String key){
		return treeMap.get(key);
	}
	/**
	 * 获取主表插入语句
	 * @param key 表id
	 * @param rs 结果集
	 * @param reMap 对应上年结果集
	 * @param finalVal 定值
	 * @param jcxx 是否为基础信息
	 * @return
	 * @throws Exception
	 */
	public static String getInsertSql(String key,ResultSet rs,Map<String, ?> reMap,Object finalVal,StringBuffer gxsql) throws Exception{
		StringBuffer sql = new StringBuffer(128);
		if("zc".equalsIgnoreCase(key)){// 支出事项为非树形结构则直接记录关系表
			gxsql.append("INSERT INTO YSPZ_BenNianDYWNGX(ShiXiangLX,BenNianND,BenNianSX,ShangNianND,ShangNianSX) VALUES(");
			gxsql.append(getValue(fieldMap.get(key).get("leixing"))).append(",").append(finalVal).append(",").append(getValue(reMap.get(rs.getString(1))));
			gxsql.append(",").append(getSNND((String)finalVal)).append(",").append(getValue(rs.getString(1))).append(")");
		}
		sql.append(" INSERT INTO ").append(getTableName(key)).append("(").append(getFields(key)).append(")");
		sql.append(" VALUES(");
		for(String field : CopyBPMUtils.getFields(key).split(",")){
			if(clobField.get(field) != null){
				sql.append("null,");
			}else if(fieldMap.get(key).getString("relation").contains(field)){
				sql.append(getValue(reMap.get(rs.getString(field)))).append(",");
			}else if(fieldMap.get(key).getString("final").contains(field)){
				sql.append(getValue(finalVal)).append(",");
			}else{
				//如果是底层
				if("ShiFouDC".equalsIgnoreCase(field) && "1".equals(rs.getString("ShiFouDC"))){
					gxsql.append("INSERT INTO YSPZ_BenNianDYWNGX(ShiXiangLX,BenNianND,BenNianSX,ShangNianND,ShangNianSX) VALUES(");
					gxsql.append(getValue(fieldMap.get(key).get("leixing"))).append(",").append(finalVal).append(",").append(getValue(reMap.get(rs.getString(1))));
					gxsql.append(",").append(getSNND((String)finalVal)).append(",").append(getValue(rs.getString(1))).append(")");
				}
				if(dateField.get(field) != null){
					sql.append((rs.getDate(field) == null ? "NULL," : "TO_DATE('"+rs.getDate(field)+"','yyyy-MM-dd'),"));
				}else{
					sql.append(getValue(rs.getString(field))).append(",");
				}
			}	
		}
		sql.delete(sql.length()-1, sql.length());
		sql.append(")");
		return sql.toString();
	}
	/**
	 * 获取修改大字段参数
	 * @param key
	 * @return
	 */
	public static String getClobParam(String key){
		return clobInfo.get(key) != null ? clobInfo.get(key)[1] : null;
	}
	/**
	 * 获取修改字段sql
	 * @param key
	 * @return
	 */
	public static String getClobSql(String key){
		return clobInfo.get(key) != null ? clobInfo.get(key)[0] : null;
	}
	/**
	 * 获取大字段
	 * @param key
	 * @return
	 */
	public static String getClobField(String key){
		return clobField.get(key);
	}
	/**
	 * 获取当年数据
	 * @param key
	 * @return
	 */
	public static String getClobCurrent(String key){
		return clobCurrent.get(key);
	}
	/**
	 * 返回值
	 * @param str
	 * @return
	 */
	private static String getValue(Object str){
		return CommonUtils.null2Blank(str).length() > 0 ? "'"+str+"'" : null;
	}
	/**
	 * 返回上年年度
	 * @param ysnd
	 * @return
	 */
	public static int getSNND(String ysnd){
		return Integer.parseInt(ysnd)-1;
	}
}
