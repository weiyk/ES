package com.rc.web.utils;

import com.qam.framework.util.CommonUtils;

/**
 * 
 * <p>application name:      动态拼接前台条件SQL</p>
 
 * <p>application describing:动态拼接前台条件SQL</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class JasperSqlPlus {

/**统计报表*/
	/**预算管理*/
	
	//单位预算项目执行进度总表
	public String danweiyssxzxjdzb(String danweibh ,String jiezhirq, String yusuansx,String niandu){
		String sql = "";
		sql = " SELECT   T4.*, "
            + " (    SELECT   SUM (PIFUZE) "
            + " FROM   (SELECT   * "
            + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
            + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
            + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
            + " YSPF_CAIZHENGPFZB YSPF, "
            + " ZCGL_BAOXIAOSQD BXSQD, "
            + " YSPF_NEIBUPFZB NBZB, "
            + " SRGL_YUSUANZJDZXMPP DZPP, "
            + " SRGL_YUSUANZJDZXM DZXM, "
            + " YSPF_YUSUANZBPP YSPP "
            + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
            + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
            + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
            + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
            + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
            + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND YSSX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
    	   sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
    	   sql += " AND TO_CHAR ( BXSQD.BAOXIAORQ, 'yyyy-MM-dd' ) <= '" + jiezhirq + "'"
            	+ " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
        sql += " GROUP BY   YSSX.BIANHAO) T1 "
             + " RIGHT JOIN "
             + " (SELECT   T1.*, T2.LEIJIDZJE "
             + " FROM      (  SELECT   SX.BIANHAO, "
             + " SX.JICI, "
             + " SX.SHANGJIBH, "
             + " SX.SHIXIANGMC, "
             + " SUM (ZB.PIFUZE) PIFUZE, "
             + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
             + " SUM (ZB.YUSUANJE) YUSUANJE "
             + " FROM      YSPZ_CAIZHENGYSSX SX "
             + " LEFT JOIN "
             + " YSPF_CAIZHENGPFZB ZB "
             + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
       	sql += " AND SX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
       	sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
        sql += " GROUP BY   SX.BIANHAO, "
             + " ZB.YUSUANDWBH, "
             + " SX.JICI, "
             + " SX.SHANGJIBH, "
             + " SX.SHIXIANGMC) T1 "
             + " LEFT JOIN "
             + " (  SELECT   ZB.YUSUANSXBH, "
             + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
             + " FROM   YSPF_CAIZHENGPFZB ZB, "
             + " SRGL_YUSUANZJDZXMPP DZPP, "
             + " SRGL_YUSUANZJDZXM DZXM "
             + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
             + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
           sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
    	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }                                   
        sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
             + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
             + " ON T1.SXBH = T2.BIANHAO " 
             + " ) T3 "
             + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
             + " START WITH   T3.BianHao = T4.BIANHAO) "
             + " PIFUZEHZ, "
             + " (    SELECT   SUM (TIAOZHENGZE) "
             + " FROM (SELECT   * "
             + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
             + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
             + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
             + " YSPF_CAIZHENGPFZB YSPF, "
             + " ZCGL_BAOXIAOSQD BXSQD, "
             + " YSPF_NEIBUPFZB NBZB, "
             + " SRGL_YUSUANZJDZXMPP DZPP, "
             + " SRGL_YUSUANZJDZXM DZXM, "
             + " YSPF_YUSUANZBPP YSPP "
             + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
             + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
             + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
             + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
             + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
             + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND YSSX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
    	   sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
    	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
        sql += " GROUP BY   YSSX.BIANHAO) T1 "
            + " RIGHT JOIN "
            + " (SELECT   T1.*, T2.LEIJIDZJE "
            + " FROM      (  SELECT   SX.BIANHAO, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC, "
            + " SUM (ZB.PIFUZE) PIFUZE, "
            + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
            + " SUM (ZB.YUSUANJE) YUSUANJE "
            + " FROM      YSPZ_CAIZHENGYSSX SX "
            + " LEFT JOIN "
            + " YSPF_CAIZHENGPFZB ZB "
            + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND SX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
    	   sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       sql += " GROUP BY   SX.BIANHAO, "
            + " ZB.YUSUANDWBH, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC) T1 "
            + " LEFT JOIN "
            + " (  SELECT   ZB.YUSUANSXBH, "
            + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
            + " FROM   YSPF_CAIZHENGPFZB ZB, "
            + " SRGL_YUSUANZJDZXMPP DZPP, "
            + " SRGL_YUSUANZJDZXM DZXM "
            + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
            + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
           sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
    	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
       sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
            + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
            + " ON T1.SXBH = T2.BIANHAO "
            + " ) T3 "
            + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
            + " START WITH   T3.BIANHAO = T4.BIANHAO) "
            + " TIAOZHENGZEHZ, "
            + " (    SELECT   SUM (YUSUANJE) "
            + " FROM   (SELECT   * "
            + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
            + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
            + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
            + " YSPF_CAIZHENGPFZB YSPF, "
            + " ZCGL_BAOXIAOSQD BXSQD, "
            + " YSPF_NEIBUPFZB NBZB, "
            + " SRGL_YUSUANZJDZXMPP DZPP, "
            + " SRGL_YUSUANZJDZXM DZXM, "
            + " YSPF_YUSUANZBPP YSPP "
            + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
            + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
            + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
            + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
            + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
            + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND YSSX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
           sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
           sql += " AND TO_CHAR ( BXSQD.BAOXIAORQ, 'yyyy-MM-dd' ) <= '" + jiezhirq + "'"
            	+ " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
       sql += " GROUP BY   YSSX.BIANHAO) T1 "
            + " RIGHT JOIN "
            + " (SELECT   T1.*, T2.LEIJIDZJE "
            + " FROM      (  SELECT   SX.BIANHAO, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC, "
            + " SUM (ZB.PIFUZE) PIFUZE, "
            + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
            + " SUM (ZB.YUSUANJE) YUSUANJE "
            + " FROM      YSPZ_CAIZHENGYSSX SX "
            + " LEFT JOIN "
            + " YSPF_CAIZHENGPFZB ZB "
            + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND SX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
    	   sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       sql += " GROUP BY   SX.BIANHAO, "
            + " ZB.YUSUANDWBH, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC) T1 "
            + " LEFT JOIN "
            + " (  SELECT   ZB.YUSUANSXBH, "
            + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
            + " FROM   YSPF_CAIZHENGPFZB ZB, "
            + " SRGL_YUSUANZJDZXMPP DZPP, "
            + " SRGL_YUSUANZJDZXM DZXM "
            + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
            + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
           sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
    	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
        sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
             + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
             + " ON T1.SXBH = T2.BIANHAO "
             + " ) T3 "
             + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
             + " START WITH   T3.BianHao = T4.BIANHAO) "
             + " YUSUANJEHZ, "
             + " (    SELECT   SUM (LEIJIDZJE) "
             + " FROM   (SELECT   * "
             + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
             + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
             + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
             + " YSPF_CAIZHENGPFZB YSPF, "
             + " ZCGL_BAOXIAOSQD BXSQD, "
             + " YSPF_NEIBUPFZB NBZB, "
             + " SRGL_YUSUANZJDZXMPP DZPP, "
             + " SRGL_YUSUANZJDZXM DZXM, "
             + " YSPF_YUSUANZBPP YSPP "
             + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
             + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
             + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
             + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
             + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
             + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//预算单位
            sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
        }
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
            sql += " AND TO_CHAR ( BXSQD.BAOXIAORQ, 'yyyy-MM-dd' ) <= '" + jiezhirq + "'"
            	 + " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
         sql += " GROUP BY   YSSX.BIANHAO) T1 "
            + " RIGHT JOIN "
            + " (SELECT   T1.*, T2.LEIJIDZJE "
            + " FROM      (  SELECT   SX.BIANHAO, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC, "
            + " SUM (ZB.PIFUZE) PIFUZE, "
            + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
            + " SUM (ZB.YUSUANJE) YUSUANJE "
            + " FROM      YSPZ_CAIZHENGYSSX SX "
            + " LEFT JOIN "
            + " YSPF_CAIZHENGPFZB ZB "
            + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND SX.NIANDU = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//预算单位
      	    sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
        } 
        sql += " GROUP BY   SX.BIANHAO, "
             + " ZB.YUSUANDWBH, "
             + " SX.JICI, "
             + " SX.SHANGJIBH, "
             + " SX.SHIXIANGMC) T1 "
             + " LEFT JOIN "
             + " (  SELECT   ZB.YUSUANSXBH, "
             + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
             + " FROM   YSPF_CAIZHENGPFZB ZB, "
             + " SRGL_YUSUANZJDZXMPP DZPP, "
             + " SRGL_YUSUANZJDZXM DZXM "
             + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
             + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
     	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//预算单位
            sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
        }
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
     	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
         sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
              + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
              + " ON T1.SXBH = T2.BIANHAO "
              + " ) T3 "
              + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
              + " START WITH   T3.BianHao = T4.BIANHAO) "
              + " LEIJIDZJEHZ, "
              + " (    SELECT   SUM (SJZFSHU) "
              + " FROM   (SELECT   * "
              + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
              + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
              + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
              + " YSPF_CAIZHENGPFZB YSPF, "
              + " ZCGL_BAOXIAOSQD BXSQD, "
              + " YSPF_NEIBUPFZB NBZB, "
              + " SRGL_YUSUANZJDZXMPP DZPP, "
              + " SRGL_YUSUANZJDZXM DZXM, "
              + " YSPF_YUSUANZBPP YSPP "
              + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
              + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
              + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
              + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
              + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
              + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
            if(niandu != null && !"".equals(niandu)){//预算年度
            	sql += " AND YSSX.NIANDU = '" + niandu + "'";
            }
            if(danweibh != null && !"".equals(danweibh)){//预算单位
            	sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
            }
            if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
            	sql += " AND TO_CHAR ( BXSQD.BAOXIAORQ, 'yyyy-MM-dd' ) <= '" + jiezhirq + "'"
            	     + " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
            }
       sql += " GROUP BY   YSSX.BIANHAO) T1 "
            + " RIGHT JOIN "
            + " (SELECT   T1.*, T2.LEIJIDZJE "
            + " FROM      (  SELECT   SX.BIANHAO, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC, "
            + " SUM (ZB.PIFUZE) PIFUZE, "
            + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
            + " SUM (ZB.YUSUANJE) YUSUANJE "
            + " FROM      YSPZ_CAIZHENGYSSX SX "
            + " LEFT JOIN "
            + " YSPF_CAIZHENGPFZB ZB "
            + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND SX.NIANDU = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
    	   sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       sql += " GROUP BY   SX.BIANHAO, "
            + " ZB.YUSUANDWBH, "
            + " SX.JICI, "
            + " SX.SHANGJIBH, "
            + " SX.SHIXIANGMC) T1 "
            + " LEFT JOIN "
            + " (  SELECT   ZB.YUSUANSXBH, "
            + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
            + " FROM   YSPF_CAIZHENGPFZB ZB, "
            + " SRGL_YUSUANZJDZXMPP DZPP, "
            + " SRGL_YUSUANZJDZXM DZXM "
            + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
            + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
       if(niandu != null && !"".equals(niandu)){//预算年度
    	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
       }
       if(danweibh != null && !"".equals(danweibh)){//预算单位
           sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
       }
       if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
     	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
       }
        sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
             + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
             + " ON T1.SXBH = T2.BIANHAO "
             + " ) T3 "
             + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
             + " START WITH   T3.BianHao = T4.BIANHAO) "
             + " SJZFZEHZ "
             + " FROM   (SELECT   * "
             + " FROM      (  SELECT   YSSX.BIANHAO SXBH, "
             + " SUM(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END) SJZFSHU "
             + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
             + " YSPF_CAIZHENGPFZB YSPF, "
             + " ZCGL_BAOXIAOSQD BXSQD, "
             + " YSPF_NEIBUPFZB NBZB, "
             + " SRGL_YUSUANZJDZXMPP DZPP, "
             + " SRGL_YUSUANZJDZXM DZXM, "
             + " YSPF_YUSUANZBPP YSPP "
             + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
             + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
             + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
             + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
             + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
             + " AND YSPP.NEIPIZB = NBZB.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//预算单位
            sql += " AND YSPF.YUSUANDWBH LIKE '" + danweibh + "'";
        }
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
            sql += " AND TO_CHAR ( BXSQD.BAOXIAORQ, 'yyyy-MM-dd' ) <= '" + jiezhirq + "'"
            	 + " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
        sql += " GROUP BY   YSSX.BIANHAO) T1 "
             + " RIGHT JOIN "
             + " (SELECT   T1.*, T2.LEIJIDZJE "
             + " FROM      (  SELECT   SX.BIANHAO, "
             + " SX.JICI, "
             + " SX.SHANGJIBH, "
             + " SX.SHIXIANGMC, "
             + " SUM (ZB.PIFUZE) PIFUZE, "
             + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
             + " SUM (ZB.YUSUANJE) YUSUANJE "
             + " FROM      YSPZ_CAIZHENGYSSX SX "
             + " LEFT JOIN "
             + " YSPF_CAIZHENGPFZB ZB "
             + " ON ZB.YUSUANSXBH = SX.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND SX.NIANDU = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//预算单位
          	sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
        }    
         sql += " GROUP BY   SX.BIANHAO, "
              + " ZB.YUSUANDWBH, "
              + " SX.JICI, "
              + " SX.SHANGJIBH, "
              + " SX.SHIXIANGMC) T1 "
              + " LEFT JOIN "
              + " (  SELECT   ZB.YUSUANSXBH, "
              + " SUM (DZXM.LEIJIDZJE) LEIJIDZJE "
              + " FROM   YSPF_CAIZHENGPFZB ZB, "
              + " SRGL_YUSUANZJDZXMPP DZPP, "
              + " SRGL_YUSUANZJDZXM DZXM "
              + " WHERE       DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
              + " AND DZPP.CAIPIZBBH = ZB.BIANHAO ";
         if(niandu != null && !"".equals(niandu)){//预算年度
      	   sql += " AND ZB.YUSUANND = '" + niandu + "'";
         }
         if(danweibh != null && !"".equals(danweibh)){//预算单位
             sql += " AND ZB.YUSUANDWBH = '" + danweibh + "'";
         }
         if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
       	   sql += " AND TO_CHAR (DZXM.DAOZHANGSJ,'yyyy-MM-dd') <= '" + jiezhirq + "'";
         }
         sql += " GROUP BY   ZB.YUSUANSXBH) T2 "
              + " ON T1.BIANHAO = T2.YUSUANSXBH) T2 "
              + " ON T1.SXBH = T2.BIANHAO "
              + " ) T4 "
              + " CONNECT BY   PRIOR T4.BIANHAO = T4.SHANGJIBH ";
         if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
        	 sql += " START WITH   T4.BIANHAO = '" + yusuansx + "'";
         }else{
         	 sql += " START WITH   T4.SHANGJIBH IS NULL ";
         }
		return sql;
		
	}
	
	//单位预算项目执行进度明细表
	public String danweiyssxzxjdmxb(
			String jiezhirq,String niandu,String danweibh,String zhibiaomc,String pifufs,String yusuansx,String gnkm){
		String sql = " SELECT   NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T1.SJZFSHU, 0) SJZFSHU, "
                   + " NVL (T1.LEIJIDZJE, 0) LEIJIDZJE, "
                   + " NVL ( (CASE WHEN YUSUANJE = 0 THEN 0 ELSE LEIJIDZJE / YUSUANJE END),0) DZLV, "
                   + " NVL ( (CASE WHEN LEIJIDZJE = 0 THEN 0 ELSE SJZFSHU / LEIJIDZJE END),0) ZXLV, "
                   + " T2.KEMUMC, "
                   + " T2.ZBBH ZBBH, "
                   + " T2.ZHIBIAOMC, "
                   + " T2.PIFUFS, "
                   + " T2.YUSUANDWBH, "
                   + " T2.SHIXIANGMC "
                   + " FROM      (  SELECT   T0.ZBBH, "
                   + " T0.KEMUMC, "
                   + " T0.KMBH, "
                   + " SUM (T0.LEIJIDZJE) LEIJIDZJE, "
                   + " SUM (T0.SJZFSHU) SJZFSHU "
                   + " FROM   (SELECT   DISTINCT "
                   + " YSSX.BIANHAO, "
                   + " YSPF.BIANHAO ZBBH, "
                   + " YSPF.PIFUZE, "
                   + " YSPF.TIAOZHENGZE, "
                   + " YSPF.YUSUANJE, "
                   + " DZXM.LEIJIDZJE, "
                   + " (CASE WHEN BXSQD.BAOXIAODZT > 3 THEN BAOXIAOJE ELSE 0 END) SJZFSHU, "
                   + " GNKM.BIANHAO KMBH, "
                   + " GNKM.KEMUMC "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX, "
                   + " YSPF_CAIZHENGPFZB YSPF, "
                   + " ZCGL_BAOXIAOSQD BXSQD, "
                   + " YSPF_NEIBUPFZB NBZB, "
                   + " SRGL_YUSUANZJDZXMPP DZPP, "
                   + " SRGL_YUSUANZJDZXM DZXM, "
                   + " YSPF_YUSUANZBPP YSPP, "
                   + " SRGL_CAIZHENGGNKM GNKM "
                   + " WHERE       YSPF.YUSUANSXBH = YSSX.BIANHAO "
                   + " AND YSPF.BIANHAO = YSPP.CAIPIZB "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
                   + " AND DZPP.YUSUANZJDZXM = DZXM.BIANHAO "
                   + " AND DZPP.CAIPIZBBH = YSPF.BIANHAO "
                   + " AND YSPP.NEIPIZB = NBZB.BIANHAO "
                   + " AND GNKM.BIANHAO = YSPF.CAIZHENGGNKM ";
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'"
         	     + " AND TO_CHAR (DZXM.DAOZHANGSJ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }                          
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }                            
		if(danweibh != null && !"".equals(danweibh)){//单位编号
      	    sql += " AND   YSPF.YUSUANDWBH = '" + danweibh + "'";
        }                          
		if(zhibiaomc != null && !"".equals(zhibiaomc)){//指标名称
			if(!"".equals(zhibiaomc.trim())){
				sql += " AND   YSPF.ZHIBIAOMC LIKE '" + zhibiaomc.trim() + "'";
			}	
        }                          
		if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND YSSX.BIANHAO = '" + yusuansx + "'";
        }
		if(gnkm != null && !"".equals(gnkm)){//功能科目
			sql += " AND GNKM.BIANHAO = '" + gnkm + "'";
		}
		if(pifufs != null && !"".equals(pifufs)){//批复方式
			sql += " AND YSPF.PIFUFS = '" + pifufs + "'";
		}
              sql += " ) T0 "
                   + " GROUP BY   T0.ZBBH, "
                   + " T0.KEMUMC, "
                   + " T0.KMBH) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   T1.*, GNKM.KEMUMC,JHY.ZHI PIFUFS "
                   + " FROM   (SELECT   ZB.BIANHAO ZBBH, "
                   + " ZB.ZHIBIAOMC, "
                   + " ZB.PIFUZE, "
                   + " ZB.TIAOZHENGZE, "
                   + " ZB.YUSUANJE, "
                   + " ZB.PIPEIJE, "
                   + " ZB.PIFUFS PFFS, "
                   + " ZB.CAIZHENGGNKM, "
                   + " ZB.YUSUANDWBH, "
                   + " SX.BIANHAO SXBH, "
                   + " SX.SHIXIANGMC "
                   + " FROM      YSPF_CAIZHENGPFZB ZB "
                   + " LEFT JOIN "
                   + " YSPZ_CAIZHENGYSSX SX "
                   + " ON ZB.YUSUANSXBH = SX.BIANHAO "
                   + " WHERE 1=1 ";
         if(pifufs != null && !"".equals(pifufs)){//批复方式
        	 sql += " AND ZB.PIFUFS = '" + pifufs + "'";
      	 }
         if(danweibh != null && !"".equals(danweibh)){//单位编号
        	 sql += " AND   ZB.YUSUANDWBH = '" + danweibh + "'";
         }
         if(zhibiaomc != null && !"".equals(zhibiaomc)){//指标名称
        	 if(!"".equals(zhibiaomc.trim())){
        		 sql += " AND   ZB.ZHIBIAOMC LIKE '" + zhibiaomc.trim() + "'";
        	 }
         }              
         if(niandu != null && !"".equals(niandu)){//预算年度
 			sql += " AND NIANDU = '" + niandu + "'";
         }
         if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
 			sql += " AND SX.BIANHAO = '" + yusuansx + "'";
         }
              sql += " ) T1, "
                   + " SRGL_CAIZHENGGNKM GNKM ,QAM_JIHEYZ JHY "
                   + " WHERE   T1.CAIZHENGGNKM = GNKM.BIANHAO "
                   + " AND  T1.PFFS = JHY.BIANMA "
                   + " AND  JHY.JIHEYLX = 'JH_PiFuLX' AND JHY.ZHUANGTAI = 1 ";
         if(gnkm != null && !"".equals(gnkm)){//功能科目
        	 sql += " AND GNKM.BIANHAO = '" + gnkm + "'";
         }
              sql += " ) T2 "
                   + " ON T1.ZBBH = T2.ZBBH "
                   + " ORDER BY  ZBBH ";
		return sql;
		
	}
	
	//年单位内部预算分解统计表(子表)
	public String niandanweinbysfjtjbsub(
			String niandu,String yusuansx,String zbmc,String gnkm,String jiezhirq,String danweibh){
		String sql = " SELECT   T1.*,T2.CPBH "
                   + " FROM      (  SELECT   YSPF.BIANHAO BIANHAO, "
                   + " YSPF.ZHIBIAOMC CPMC, "
                   + " YSPF.PIFUZE CPZE, "
                   + " YSPF.PIPEIJE CPPPJE, "
                   + " GNKM.BIANHAO KMBH, "
                   + " GNKM.KEMUMC, "
                   + " YSSX.BIANHAO CPSXBH, "
                   + " YSSX.SHIXIANGMC CPSXMC, "
                   + " GLZZ.ZUZHIMC, "
                   + " NBZB.BIANHAO NBBH, "
                   + " NBZB.ZHIBIAOMC NBMC, "
                   + " NBZB.JIESHOUZZ, "
                   + " NBZB.PIFUZE NBPFZE, "
                   + " NBZB.PIPEIJE NBPPJE, "
                   + " NBSX.BIANHAO NBSXBH, "
                   + " NBSX.SHIXIANGMC NBSXMC "
                   + " FROM   YSPF_CAIZHENGPFZB YSPF, "
                   + " SRGL_CAIZHENGGNKM GNKM, "
                   + " YSPZ_CAIZHENGYSSX YSSX, "
                   + " YSPF_YUSUANZBPP YSPP, "
                   + " YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " ZZ_GUANLIZZ GLZZ "
                   + " WHERE       YSPF.CAIZHENGGNKM = GNKM.BIANHAO "
                   + " AND YSSX.BIANHAO = YSPF.YUSUANSXBH "
                   + " AND YSPP.CAIPIZB = YSPF.BIANHAO "
                   + " AND YSPP.NEIPIZB = NBZB.BIANHAO "
                   + " AND NBSX.BIANHAO = NBZB.YUSUANSX "
                   + " AND GLZZ.BIANHAO = NBZB.JIESHOUZZ ";
		if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND YSSX.BIANHAO = '" + yusuansx + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND YSPF.YUSUANND = '" + niandu + "'";
        }
		if(danweibh != null && !"".equals(danweibh)){//单位编号
      	    sql += " AND   YSPF.YUSUANDWBH = '" + danweibh + "'";
        } 
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (YSPF.LURURQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }  
		if(gnkm != null && !"".equals(gnkm)){//功能科目
			sql += " AND GNKM.BIANHAO = '" + gnkm + "'";
		}
		if(zbmc != null && !"".equals(zbmc)){//指标名称
			if(!"".equals(zbmc.trim())){
				sql += " AND   YSPF.ZHIBIAOMC LIKE '" + zbmc.trim() + "'";
			}
        }             
               sql += " ORDER BY   YSPF.BIANHAO, YSSX.BIANHAO) T1 "
                    + " RIGHT JOIN "
                    + " (SELECT   ZB.BIANHAO CPBH, "
                    + " ZB.ZHIBIAOMC CPMC, "
                    + " ZB.PIFUZE, "
                    + " ZB.PIPEIJE, "
                    + " ZB.CAIZHENGGNKM, "
                    + " SX.BIANHAO SXBH, "
                    + " SX.SHIXIANGMC SXMC "
                    + " FROM      YSPF_CAIZHENGPFZB ZB "
                    + " LEFT JOIN "
                    + " YSPZ_CAIZHENGYSSX SX "
                    + " ON ZB.YUSUANSXBH = SX.BIANHAO "
                    + " WHERE 1=1 ";
         if(niandu != null && !"".equals(niandu)){//预算年度
        	 sql += " AND ZB.YUSUANND = '" + niandu + "'";
         }
       	 if(danweibh != null && !"".equals(danweibh)){//单位编号
             sql += " AND   ZB.YUSUANDWBH = '" + danweibh + "'";
         }
               sql += " ) T2 "
                    + " ON T1.BIANHAO = T2.CPBH "
                    + " WHERE T2.CPBH = $P{CPBH} ";
		return sql;
		
	}
	
	//年单位内部预算分解统计表(主表)
	public String niandanweinbysfjtjbmain(
			String niandu,String yusuansx,String zbmc,String gnkm,String jiezhirq,String danweibh){
		String sql = " SELECT   T1.*, GNKM.BIANHAO,GNKM.KEMUMC "
                   + " FROM   (SELECT   ZB.BIANHAO CPBH, "
                   + " ZB.ZHIBIAOMC CPMC, "
                   + " ZB.PIFUZE, "
                   + " ZB.PIPEIJE, "
                   + " ZB.CAIZHENGGNKM, "
                   + " SX.BIANHAO SXBH, "
                   + " SX.SHIXIANGMC SXMC "
                   + " FROM      YSPF_CAIZHENGPFZB ZB "
                   + " LEFT JOIN "
                   + " YSPZ_CAIZHENGYSSX SX "
                   + " ON ZB.YUSUANSXBH = SX.BIANHAO "
                   + " WHERE  1=1 ";
		if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND SX.BIANHAO = '" + yusuansx + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZB.YUSUANND = '" + niandu + "'";
        }
		if(danweibh != null && !"".equals(danweibh)){//单位编号
      	    sql += " AND   ZB.YUSUANDWBH = '" + danweibh + "'";
        }  
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (ZB.LURURQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }        
        if(zbmc != null && !"".equals(zbmc)){//指标名称
        	if(!"".equals(zbmc.trim())){
        		sql += " AND   ZB.ZHIBIAOMC LIKE '" + zbmc.trim() + "'";
        	}
        }
        sql += " ) T1, "
             + " SRGL_CAIZHENGGNKM GNKM "
             + " WHERE   T1.CAIZHENGGNKM = GNKM.BIANHAO ";
		
        if(gnkm != null && !"".equals(gnkm)){//功能科目
			sql += " AND GNKM.BIANHAO = '" + gnkm + "'";
		}
         
		return sql;
		
	}
	
	//单位内部预算执行进度总表
	public String danweinbyszxjdzb(String niandu,String danweibh,String jiezhirq,String yusuansx){
		String sql = " SELECT   T4.*, "
                   + " (    SELECT   SUM (PIFUZE) "
                   + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                   + " T2.SHIXIANGMC SXMC, "
                   + " T2.SHANGJIBH, "
                   + " T2.JICI, "
                   + " NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T2.YIFABJE, 0) YIFABJE, "
                   + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                   + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   NBSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " YSPZ_DANWEINBYSSX DWNBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
      	    sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
        }
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
      	  sql += " AND   NBSX.NIANDU = '" + niandu + "'";
        }
              sql += " GROUP BY   NBSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   T1.*, "
                   + " SUM (NBZB.PIFUZE) PIFUZE, "
                   + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                   + " SUM (NBZB.YIFABJE) YIFABJE, "
                   + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                   + " FROM "
                   + " (SELECT   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                   + " WHERE   NEIBUYSSXBH = BIANHAO ";
         if(danweibh != null && !"".equals(danweibh)){//单位编号
        	 sql += " AND   GUANLIZZBH = '" + danweibh + "'";
         }   
         if(niandu != null && !"".equals(niandu)){//预算年度
        	 sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
         }
              sql += " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_NEIBUPFZB NBZB "
                   + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " GROUP BY   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " ) T2 "
                   + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BianHao = T4.BIANHAO) "
                   + " PIFUZEHZ, "
                   + " (    SELECT   SUM (TIAOZHENGZE) "
                   + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                   + " T2.SHIXIANGMC SXMC, "
                   + " T2.SHANGJIBH, "
                   + " T2.JICI, "
                   + " NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T2.YIFABJE, 0) YIFABJE, "
                   + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                   + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   NBSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " YSPZ_DANWEINBYSSX DWNBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
            if(danweibh != null && !"".equals(danweibh)){//单位编号
            	sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
            }
      		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
               	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
            }
      		if(niandu != null && !"".equals(niandu)){//预算年度
           	 sql += " AND   NBSX.NIANDU = '" + niandu + "'";
            }
              sql += " GROUP BY   NBSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   T1.*, "
                   + " SUM (NBZB.PIFUZE) PIFUZE, "
                   + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                   + " SUM (NBZB.YIFABJE) YIFABJE, "
                   + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                   + " FROM "
                   + " (SELECT   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                   + " WHERE   NEIBUYSSXBH = BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
              }
              if(niandu != null && !"".equals(niandu)){//预算年度
            	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
              }
               sql += " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_NEIBUPFZB NBZB "
                   + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " GROUP BY   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " ) T2 "
                   + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BIANHAO = T4.BIANHAO) "
                   + " TIAOZHENGZEHZ, "
                   + " (    SELECT   SUM (YUSUANJE) "
                   + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                   + " T2.SHIXIANGMC SXMC, "
                   + " T2.SHANGJIBH, "
                   + " T2.JICI, "
                   + " NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T2.YIFABJE, 0) YIFABJE, "
                   + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                   + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   NBSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " YSPZ_DANWEINBYSSX DWNBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
              	sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
              }
        		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
                 	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
              }
        		if(niandu != null && !"".equals(niandu)){//预算年度
             	 sql += " AND   NBSX.NIANDU = '" + niandu + "'";
              }
              sql += " GROUP BY   NBSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   T1.*, "
                   + " SUM (NBZB.PIFUZE) PIFUZE, "
                   + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                   + " SUM (NBZB.YIFABJE) YIFABJE, "
                   + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                   + " FROM "
                   + " (SELECT   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                   + " WHERE   NEIBUYSSXBH = BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
              }
              if(niandu != null && !"".equals(niandu)){//预算年度
            	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
              }
               sql += " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_NEIBUPFZB NBZB "
                   + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " GROUP BY   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " ) T2 "
                   + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BIANHAO = T4.BIANHAO) "
                   + " YUSUANJEHZ, "
                   + " (    SELECT   SUM (YIFABJE) "
                   + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                   + " T2.SHIXIANGMC SXMC, "
                   + " T2.SHANGJIBH, "
                   + " T2.JICI, "
                   + " NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T2.YIFABJE, 0) YIFABJE, "
                   + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                   + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   NBSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " YSPZ_DANWEINBYSSX DWNBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
              }
              if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
            	  sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
              }
          	  if(niandu != null && !"".equals(niandu)){//预算年度
                  sql += " AND   NBSX.NIANDU = '" + niandu + "'";
              }
              sql += " GROUP BY   NBSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   T1.*, "
                   + " SUM (NBZB.PIFUZE) PIFUZE, "
                   + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                   + " SUM (NBZB.YIFABJE) YIFABJE, "
                   + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                   + " FROM "
                   + " (SELECT   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                   + " WHERE   NEIBUYSSXBH = BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
              }
              if(niandu != null && !"".equals(niandu)){//预算年度
            	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
              }
              sql += " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_NEIBUPFZB NBZB "
                   + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " GROUP BY   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " ) T2 "
                   + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BIANHAO = T4.BIANHAO) "
                   + " YIFABJEHZ, "
                   + " (    SELECT   SUM (ZHANYONGJE) "
                   + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                   + " T2.SHIXIANGMC SXMC, "
                   + " T2.SHANGJIBH, "
                   + " T2.JICI, "
                   + " NVL (T2.PIFUZE, 0) PIFUZE, "
                   + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                   + " NVL (T2.YIFABJE, 0) YIFABJE, "
                   + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                   + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   NBSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " YSPZ_DANWEINBYSSX DWNBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
              }
              if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
            	  sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
              }
          	  if(niandu != null && !"".equals(niandu)){//预算年度
                  sql += " AND   NBSX.NIANDU = '" + niandu + "'";
              }
              sql += " GROUP BY   NBSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   T1.*, "
                   + " SUM (NBZB.PIFUZE) PIFUZE, "
                   + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                   + " SUM (NBZB.YIFABJE) YIFABJE, "
                   + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                   + " FROM "
                   + " (SELECT   NEIBUYSSXBH, "
                   + " SHIXIANGMC, "
                   + " SHANGJIBH, "
                   + " JICI "
                   + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                   + " WHERE   NEIBUYSSXBH = BIANHAO ";
              if(danweibh != null && !"".equals(danweibh)){//单位编号
            	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
              }
              if(niandu != null && !"".equals(niandu)){//预算年度
            	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
              }
               sql += " ) T1 "
                    + " LEFT JOIN "
                    + " YSPF_NEIBUPFZB NBZB "
                    + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                    + " GROUP BY   NEIBUYSSXBH, "
                    + " SHIXIANGMC, "
                    + " SHANGJIBH, "
                    + " JICI "
                    + " ) T2 "
                    + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                    + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                    + " START WITH   T3.BIANHAO = T4.BIANHAO) "
                    + " ZHANYONGJEHZ, "
                    + " (    SELECT   SUM (ZHICHUSHU) "
                    + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                    + " T2.SHIXIANGMC SXMC, "
                    + " T2.SHANGJIBH, "
                    + " T2.JICI, "
                    + " NVL (T2.PIFUZE, 0) PIFUZE, "
                    + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                    + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                    + " NVL (T2.YIFABJE, 0) YIFABJE, "
                    + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                    + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                    + " FROM      (  SELECT   NBSX.BIANHAO, "
                    + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                    + " FROM   YSPF_NEIBUPFZB NBZB, "
                    + " YSPZ_NEIBUYSSX NBSX, "
                    + " YSPZ_DANWEINBYSSX DWNBSX, "
                    + " ZCGL_BAOXIAOSQD BXSQD "
                    + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                    + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                    + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
               if(danweibh != null && !"".equals(danweibh)){//单位编号
             	  sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
               }
               if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
             	  sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
               }
           	   if(niandu != null && !"".equals(niandu)){//预算年度
                   sql += " AND   NBSX.NIANDU = '" + niandu + "'";
               }
               sql += " GROUP BY   NBSX.BIANHAO) T1 "
                    + " RIGHT JOIN "
                    + " (  SELECT   T1.*, "
                    + " SUM (NBZB.PIFUZE) PIFUZE, "
                    + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                    + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                    + " SUM (NBZB.YIFABJE) YIFABJE, "
                    + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                    + " FROM "
                    + " (SELECT   NEIBUYSSXBH, "
                    + " SHIXIANGMC, "
                    + " SHANGJIBH, "
                    + " JICI "
                    + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                    + " WHERE   NEIBUYSSXBH = BIANHAO ";
               if(danweibh != null && !"".equals(danweibh)){//单位编号
             	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
               }
               if(niandu != null && !"".equals(niandu)){//预算年度
             	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
               }
                sql += " ) T1 "
                    + " LEFT JOIN "
                    + " YSPF_NEIBUPFZB NBZB "
                    + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                    + " GROUP BY   NEIBUYSSXBH, "
                    + " SHIXIANGMC, "
                    + " SHANGJIBH, "
                    + " JICI "
                    + " ) T2 "
                    + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T3 "
                    + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                    + " START WITH   T3.BIANHAO = T4.BIANHAO) "
                    + " ZHICHUSHUHZ "
                    + " FROM   (SELECT   T2.NEIBUYSSXBH BIANHAO, "
                    + " T2.SHIXIANGMC SXMC, "
                    + " T2.SHANGJIBH, "
                    + " T2.JICI, "
                    + " NVL (T2.PIFUZE, 0) PIFUZE, "
                    + " NVL (T2.TIAOZHENGZE, 0) TIAOZHENGZE, "
                    + " NVL (T2.YUSUANJE, 0) YUSUANJE, "
                    + " NVL (T2.YIFABJE, 0) YIFABJE, "
                    + " NVL (T2.ZHANYONGJE, 0) ZHANYONGJE, "
                    + " NVL (ZHICHUSHU, 0) ZHICHUSHU "
                    + " FROM      (  SELECT   NBSX.BIANHAO, "
                    + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                    + " FROM   YSPF_NEIBUPFZB NBZB, "
                    + " YSPZ_NEIBUYSSX NBSX, "
                    + " YSPZ_DANWEINBYSSX DWNBSX, "
                    + " ZCGL_BAOXIAOSQD BXSQD "
                    + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                    + " AND DWNBSX.NEIBUYSSXBH = NBZB.YUSUANSX "
                    + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
               if(danweibh != null && !"".equals(danweibh)){//单位编号
              	  sql += " AND   DWNBSX.GUANLIZZBH = '" + danweibh + "'";
               }
               if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
              	  sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
               }
               if(niandu != null && !"".equals(niandu)){//预算年度
                  sql += " AND   NBSX.NIANDU = '" + niandu + "'";
               }
               sql += " GROUP BY   NBSX.BIANHAO) T1 "
                    + " RIGHT JOIN "
                    + " (  SELECT   T1.*, "
                    + " SUM (NBZB.PIFUZE) PIFUZE, "
                    + " SUM (NBZB.TIAOZHENGZE) TIAOZHENGZE, "
                    + " SUM (NBZB.YUSUANJE) YUSUANJE, "
                    + " SUM (NBZB.YIFABJE) YIFABJE, "
                    + " SUM (NBZB.YIFABJE - NBZB.KEYONGYE) ZHANYONGJE "
                    + " FROM "
                    + " (SELECT   NEIBUYSSXBH, "
                    + " SHIXIANGMC, "
                    + " SHANGJIBH, "
                    + " JICI "
                    + " FROM   YSPZ_DANWEINBYSSX, YSPZ_NEIBUYSSX "
                    + " WHERE   NEIBUYSSXBH = BIANHAO ";
               if(danweibh != null && !"".equals(danweibh)){//单位编号
              	  sql += " AND   GUANLIZZBH = '" + danweibh + "'";
               }
               if(niandu != null && !"".equals(niandu)){//预算年度
              	  sql += " AND   YSPZ_NEIBUYSSX.NIANDU = '" + niandu + "'";
               }
               sql += " ) T1 "
                    + " LEFT JOIN "
                    + " YSPF_NEIBUPFZB NBZB "
                    + " ON T1.NEIBUYSSXBH = NBZB.YUSUANSX "
                    + " GROUP BY   NEIBUYSSXBH, "
                    + " SHIXIANGMC, "
                    + " SHANGJIBH, "
                    + " JICI "
                    + " ) T2 "
                    + " ON T1.BIANHAO = T2.NEIBUYSSXBH) T4 "
                    + " CONNECT BY   PRIOR T4.BIANHAO = T4.SHANGJIBH ";
               if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
              	 sql += " START WITH   T4.BIANHAO = '" + yusuansx + "'";
      	       }else{
      	    	 sql += " START WITH   T4.SHANGJIBH IS NULL ";
      	       }
               sql += " ORDER SIBLINGS BY   T4.BIANHAO ";
		return sql;
		
	}
	
	//单位内部预算执行进度明细表
	public String danweinbyszxjdmxb(String niandu,String danweibh,String jiezhirq,String yusuansx,String zhibiaomc,String suoshubm){
		String sql = " SELECT   T2.*, "
                   + " T1.ZHICHUSHU "
                   + " FROM      (  SELECT   NBZB.BIANHAO ZBBH, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND BXSQD.ZHIBIAOBH = NBZB.BIANHAO ";
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }
		if(zhibiaomc != null && !"".equals(zhibiaomc)){//指标名称
			if(!"".equals(zhibiaomc.trim())){
				sql += " AND   NBZB.ZHIBIAOMC LIKE '" + zhibiaomc.trim() + "'";
			}	
        }
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
		if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND NBSX.BIANHAO = '" + yusuansx + "'";
        }
		if(danweibh != null && !"".equals(danweibh)){//单位编号
      	    sql += " AND   NBZB.PIFUZZ = '" + danweibh + "'";
        }   
		if(suoshubm != null && !"".equals(suoshubm)){//所属部门
      	    sql += " AND   NBZB.JIESHOUZZ = '" + suoshubm + "'";
        }
              sql += " GROUP BY   NBZB.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   ZB.BIANHAO ZBBH, "
                   + " ZB.ZHIBIAOMC, "
                   + " ZB.PIFUZE, "
                   + " ZB.TIAOZHENGZE, "
                   + " ZB.YUSUANJE, "
                   + " ZB.YIFABJE, "
                   + " ZB.PIFUZE - ZB.KEYONGYE ZHANYONGJE, "
                   + " SX.BIANHAO SXBH, "
                   + " SX.SHIXIANGMC, "
                   + " GLZZ.ZUZHIMC "
                   + " FROM   YSPF_NEIBUPFZB ZB, YSPZ_NEIBUYSSX SX ,ZZ_GUANLIZZ GLZZ "
                   + " WHERE       ZB.YUSUANSX = SX.BIANHAO "
                   + " AND ZB.JIESHOUZZ = GLZZ.BIANHAO ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND   ZB.PIFUZZ = '" + danweibh + "'";
        }
        if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZB.YUSUANND = '" + niandu + "'";
        }         
        if(zhibiaomc != null && !"".equals(zhibiaomc)){//指标名称
			if(!"".equals(zhibiaomc.trim())){
				sql += " AND   ZB.ZHIBIAOMC LIKE '" + zhibiaomc.trim() + "'";
			}	
        }             
        if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND SX.BIANHAO = '" + yusuansx + "'";
        }        
        if(suoshubm != null && !"".equals(suoshubm)){//所属部门
      	    sql += " AND   ZB.JIESHOUZZ = '" + suoshubm + "'";
        }
              sql += " ) T2 "
                   + " ON T1.ZBBH = T2.ZBBH "
                   + " ORDER BY   T2.ZBBH, T2.SXBH ";
		return sql;
		
	}

	//单位内各部门预算执行进度总表
	public String danweingbmyszxjdzb(String niandu,String danweibh,String jiezhirq){
		String sql = " SELECT   * "
                   + " FROM      (  SELECT   NBZB.JIESHOUZZ, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " ZCGL_BAOXIAOSQD BXSQD, "
                   + " ZZ_GUANLIZZ GLZZ "
                   + " WHERE       BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
                   + " AND NBZB.JIESHOUZZ = GLZZ.BIANHAO ";
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }        
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND   NBZB.PIFUZZ = '" + danweibh + "'";
        }            
              sql += " GROUP BY   NBZB.JIESHOUZZ) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   ZB.JIESHOUZZ SSBM, GLZZ.ZUZHIMC, "
                   + " SUM (ZB.PIFUZE) PIFUZE, "
                   + " SUM (ZB.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (ZB.YUSUANJE) YUSUANJE, "
                   + " SUM (ZB.YIFABJE) YIFABJE, "
                   + " SUM (ZB.PIFUZE - ZB.KEYONGYE) ZHANYONGJE "
                   + " FROM   YSPF_NEIBUPFZB ZB, ZZ_GUANLIZZ GLZZ "
                   + " WHERE       ZB.JIESHOUZZ = GLZZ.BIANHAO ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND   ZB.PIFUZZ = '" + danweibh + "'";
        }
        if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZB.YUSUANND = '" + niandu + "'";
        }              
              sql += " GROUP BY   ZB.JIESHOUZZ, GLZZ.ZUZHIMC) T2 "
                   + " ON T1.JIESHOUZZ = T2.SSBM "
                   + " ORDER BY T1.JIESHOUZZ";
		return sql;
	}

	//单位内各部门预算执行明细表
	public String danweingbmyszxjdmxb(String niandu,String danweibh,String jiezhirq,String yusuansx,String suoshubm){
		String sql = " SELECT   T2.*, "
                   + " T1.ZHICHUSHU "
                   + " FROM      (  SELECT   NBZB.BIANHAO ZBBH, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " YSPZ_NEIBUYSSX NBSX, "
                   + " ZCGL_BAOXIAOSQD BXSQD, "
                   + " ZZ_GUANLIZZ GLZZ "
                   + " WHERE       BXSQD.ZHIBIAOBH = NBZB.BIANHAO "
                   + " AND NBZB.YUSUANSX = NBSX.BIANHAO "
                   + " AND NBZB.JIESHOUZZ = GLZZ.BIANHAO ";
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }               
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND   NBZB.PIFUZZ = '" + danweibh + "'";
        }
		if(suoshubm != null && !"".equals(suoshubm)){//所属部门
      	    sql += " AND   NBZB.JIESHOUZZ = '" + suoshubm + "'";
        }
		if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND NBSX.BIANHAO = '" + yusuansx + "'";
        }
              sql += " GROUP BY   NBZB.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   NBZB.BIANHAO ZBBH, "
                   + " NBZB.ZHIBIAOMC, "
                   + " NBSX.BIANHAO SXBH, "
                   + " NBSX.SHIXIANGMC, "
                   + " NBZB.PIFUZE, "
                   + " NBZB.TIAOZHENGZE, "
                   + " NBZB.YUSUANJE, "
                   + " NBZB.YIFABJE, "
                   + " NBZB.PIFUZE - NBZB.KEYONGYE ZHANYONGJE "
                   + " FROM   YSPF_NEIBUPFZB NBZB, YSPZ_NEIBUYSSX NBSX "
                   + " WHERE       NBZB.YUSUANSX = NBSX.BIANHAO ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }   
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND   NBZB.PIFUZZ = '" + danweibh + "'";
        }          
        if(suoshubm != null && !"".equals(suoshubm)){//所属部门
      	    sql += " AND   NBZB.JIESHOUZZ = '" + suoshubm + "'";
        }            
        if(CommonUtils.null2Blank(yusuansx).length() > 0 && !"null".equals(yusuansx)){//预算事项
			sql += " AND NBSX.BIANHAO = '" + yusuansx + "'";
        }
               sql += " ) T2 "
                    + " ON T1.ZBBH = T2.ZBBH "
                    + " ORDER BY T2.ZBBH,T2.SXBH ";
		return sql;
	}

/**统计报表*/
	/**支出管理*/
	//经费支出对比总表		
	public String jingfeizcdbzb(String dwlx,String zcfl,String begindate,String enddate,String ysnd){//单位类型。 支出分类。 起始时间。 截止时间。
		String sql ="SELECT  DWJE.BAOXIAOJE,DWJHQJ.BIANHAO,DWJHQJ.ZUZHIMC,DWJHQJ.DANWEILX,DWJHQJ.BIANMA,DWJHQJ.ZHI,DWJHQJ.DANWEILXZ " 
				+"FROM     (SELECT   GLZZ.BIANHAO, GLZZ.ZUZHIMC, JHY.ZHI, jhy.bianma, " 
				+"SUM(NVL ( CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) baoxiaoje " 
				+" FROM   ZCGL_BAOXIAOSQD BXSQD, " 
				+" QAM_JIHEYZ JHY, " 
				+" YSPZ_ZHICHUSX ZCSX, " 
				+" ZZ_GUANLIZZ GLZZ, " 
				+"ZZ_ZuZhiJG ZZJG " 
				+" WHERE    ZCSX.BIANHAO = BXSQD.ZHICHUSX  " 
				+"AND BXSQD.GuanLiZZBH = GLZZ.BIANHAO " 
				+"AND JHY.BIANMA = ZCSX.ZHICHUFL " 
				+"AND GLZZ.DuiYingZZJG = ZZJG.BIANHAO " 
				+"AND JHY.JIHEYLX = 'JH_ZhiChuFL' " 
				+"AND BXSQD.NIANDU='"+ysnd+"'"; 
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
	    }
			sql+="AND JHY.ZHUANGTAI = '1' " 
				+"GROUP BY   GLZZ.BIANHAO,GLZZ.ZUZHIMC, JHY.ZHI,jhy.bianma)DWJE " 
				+" RIGHT JOIN  " 
				+"( SELECT DW.BIANHAO,DW.ZUZHIMC,JH.BIANMA,JH.ZHI ,DW.DANWEILX,DW.DANWEILXZ " 
				+"FROM   ( SELECT   GLZZ.bianhao, GLZZ.zuzhimc,ZZJG.DANWEILX,JHY.ZHI DANWEILXZ " 
				+"FROM   zz_guanlizz GLZZ,ZZ_ZUZHIJG ZZJG,QAM_JIHEYZ JHY " 
				+"WHERE   zuzhilx = '1' " 
				+"AND JHY.BIANMA = ZZJG.DANWEILX  " 
				+"AND JHY.JIHEYLX ='JHY_DanWeiLX' " ;
		if(dwlx != null && !"".equals(dwlx)){//单位类型
			sql += " AND ZZJG.DanWeiLX IN( " + dwlx + ")";
	    }
			sql+="AND ZZJG.BIANHAO = GLZZ.DuiYingZZJG)DW " 
				+"join " 
				+" ( SELECT   jhy.bianma, jhy.zhi " 
				+"FROM   QAM_JIHEYZ JHY " 
				+"WHERE  JHY.JIHEYLX = 'JH_ZhiChuFL' "; 
		if(zcfl != null && !"".equals(zcfl)){//支出分类
			sql += " AND jhy.bianma  in (" + zcfl + ") ";
	    }			
			sql+="AND JHY.ZHUANGTAI = '1')JH " 
				+"ON 1=1) DWJHQJ " 
				+"ON DWJE.BIANHAO =DWJHQJ.BIANHAO AND DWJE.bianma=DWJHQJ.bianma " ;
		return sql;
		
	}
	
    //单位经费支出总表
	public String danweijfzczb(String niandu,String danweibh,String begindate,String enddate){
		String sql = " SELECT   * "
                   + " FROM      (SELECT   T2.*, DECODE(T1.ZHICHUSHU,NULL,0,T1.ZHICHUSHU) ZHICHUSHU "
                   + " FROM      (  SELECT   JHY.BIANMA, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END, 0 )) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " QAM_JIHEYZ JHY, "
                   + " YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
         	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }   
		if(niandu != null && !"".equals(niandu)){//单位编号
        	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
              sql += " GROUP BY   JHY.BIANMA) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   BIANMA, ZHI "
                   + " FROM   QAM_JIHEYZ "
                   + " WHERE   JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND ZHUANGTAI = '1') T2 "
                   + " ON T1.BIANMA = T2.BIANMA) T3 "
                   + " JOIN "
                   + " (SELECT SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) HJ "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " QAM_JIHEYZ JHY, "
                   + " YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
        if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
              sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
      	if(danweibh != null && !"".equals(danweibh)){//单位编号
              sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
              sql += " ) ON 1 = 1 ORDER BY BIANMA";
		return sql;
	}

	//单位经费支出明细表
	public String danweijfzcmxb(String niandu,String danweibh,String zhichufl,String begindate,String enddate){
		String sql = " SELECT   T2.*, DECODE (T1.ZHICHUSHU, NULL, 0, T1.ZHICHUSHU) ZHICHUSHU, HJ "
                   + " FROM      (  SELECT   ZCSX.BIANHAO, "
                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " QAM_JIHEYZ JHY, "
                   + " YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
            sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
		if(zhichufl != null && !"".equals(zhichufl)){//支出分类
        	sql += " AND JHY.BIANMA = '" + zhichufl + "'";
        }
               sql += " GROUP BY   ZCSX.BIANHAO) T1 "
                    + " RIGHT JOIN "
                    + " (SELECT   ZCSX.BIANHAO ZCSXBH, ZCSX.SHIXIANGMC ZCSXMC,JHY.ZHI "
                    + " FROM   YSPZ_DANWEIZCSX DWZCSX, YSPZ_ZHICHUSX ZCSX,QAM_JIHEYZ JHY "
                    + " WHERE   DWZCSX.ZHICHUSXBH = ZCSX.BIANHAO "
                    + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                    + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                    + " AND JHY.ZHUANGTAI = '1' ";
         if(zhichufl != null && !"".equals(zhichufl)){//支出分类
        	 sql += " AND JHY.BIANMA = '" + zhichufl + "'";
         }        
         if(danweibh != null && !"".equals(danweibh)){//单位编号
         	sql += " AND DWZCSX.GUANLIZZBH = '" + danweibh + "'";
         }
         if(niandu != null && !"".equals(niandu)){//预算年度
          	sql += " AND ZCSX.NIANDU = '" + niandu + "'";
          }
               sql += " ) T2 "
                    + " ON T1.BIANHAO = T2.ZCSXBH, "
                    + " (SELECT SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) HJ "
                    + " FROM   ZCGL_BAOXIAOSQD BXSQD, QAM_JIHEYZ JHY, YSPZ_ZHICHUSX ZCSX "
                    + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                    + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                    + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                    + " AND JHY.ZHUANGTAI = '1' ";
         if(zhichufl != null && !"".equals(zhichufl)){//支出分类
        	 sql += " AND JHY.BIANMA = '" + zhichufl + "'";
         }     
         if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
             sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
         }
         if(niandu != null && !"".equals(niandu)){//预算年度
           	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
          }
         if(danweibh != null && !"".equals(danweibh)){//单位编号
          	sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
         }     
                sql += " )ORDER BY T2.ZCSXBH";
		return sql;
	}

	//单位内各部门经费支出总表
	public String danweingbmjfzczb(String niandu,String danweibh,String begindate,String enddate) throws Exception{
//		Connection conn = ContextService.lookupDefaultDataBaseAccess().getConnection();
//		Statement stsm = conn.createStatement();
//		ResultSet rs = stsm.executeQuery("SELECT BIANMA, ZHI FROM QAM_JIHEYZ WHERE JIHEYLX = 'JH_ZhiChuFL' AND ZHUANGTAI = '1'");
//		String sql = " SELECT MAX(ZUZHIMC) ZUZHIMC";
//		while(rs.next()){
//			sql += " ,NVL(SUM(BIANMA" + rs.getString("BIANMA") + "),0) LX" + rs.getString("BIANMA");
//		}
////                   + " ,NVL(SUM(BIANMA1),0) LX1 "
////                   + " ,NVL(SUM(BIANMA2),0) LX2 "
////                   + " ,NVL(SUM(BIANMA3),0) LX3 "
////                   + " ,NVL(SUM(BIANMA4),0) LX4 "
////                   + " ,NVL(SUM(BIANMA5),0) LX5 "
////                   + " ,NVL(SUM(BIANMA6),0) LX6 "
////                   + " ,NVL(SUM(BIANMA7),0) LX7 "
////                   + " ,NVL(SUM(BIANMA8),0) LX8 "
////                   + " ,NVL(SUM(BIANMA9),0) LX9 "
//              sql += " FROM ( "
//                   + " SELECT * FROM ( "
//                   + " SELECT   T1.SHENQINGBM,T1.BIANMA, ";
//        ResultSet rs1 = stsm.executeQuery("SELECT BIANMA, ZHI FROM QAM_JIHEYZ WHERE JIHEYLX = 'JH_ZhiChuFL' AND ZHUANGTAI = '1'");
//		while(rs1.next()){
//			sql += " CASE WHEN T1.BIANMA = '" 
//				+ rs1.getString("BIANMA") 
//				+ "' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA"
//				+ rs1.getString("BIANMA") + ",";
//		}
////                   + " CASE WHEN T1.BIANMA = '1' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA1, "
////                   + " CASE WHEN T1.BIANMA = '2' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA2, "
////                   + " CASE WHEN T1.BIANMA = '3' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA3, "
////                   + " CASE WHEN T1.BIANMA = '4' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA4, "
////                   + " CASE WHEN T1.BIANMA = '5' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA5, "
////                   + " CASE WHEN T1.BIANMA = '6' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA6, "
////                   + " CASE WHEN T1.BIANMA = '7' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA7, "
////                   + " CASE WHEN T1.BIANMA = '8' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA8, "
////                   + " CASE WHEN T1.BIANMA = '9' THEN SUM(T1.ZHICHUSHU) ELSE 0 END BIANMA9 "
//		sql = sql.substring(0,sql.length()-1);
//              sql += " FROM      (  SELECT   JHY.BIANMA,BXSQD.SHENQINGBM, "
//                   + " SUM(NVL (CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
//                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
//                   + " QAM_JIHEYZ JHY, "
//                   + " YSPZ_ZHICHUSX ZCSX "
//                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
//                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
//                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
//                   + " AND JHY.ZHUANGTAI = '1' ";
//		if(danweibh != null && !"".equals(danweibh)){//单位编号
//          	sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
//        }
//		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
//            sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
//        }                    
//              sql += " GROUP BY   BXSQD.SHENQINGBM, JHY.BIANMA) T1 "
//                   + " GROUP BY T1.SHENQINGBM,T1.BIANMA)T1 "
//                   + " RIGHT JOIN "
//                   + " (SELECT   BIANHAO, ZUZHIMC "
//                   + " FROM   ZZ_GUANLIZZ "
//                   + "  WHERE   1 = 1 ";
//        if(danweibh != null && !"".equals(danweibh)){//单位编号
//        	sql += " AND SHANGJIZZ = '" + danweibh + "'";
//        }    
//	          sql += " )T2 "
//                   + " ON T1.SHENQINGBM = T2.BIANHAO) GROUP BY BIANHAO ORDER BY LX1 DESC ";
		String sql = " SELECT   T2.BIANMA, "
                   + " T2.ZHI, "
                   + " DECODE (T1.ZHICHUSHU, NULL, 0, T1.ZHICHUSHU) ZHICHUSHU, "
                   + " T2.ZUZHIMC "
                   + " FROM(  SELECT   BXSQD.SHENQINGBM, "
                   + " JHY.BIANMA, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " QAM_JIHEYZ JHY, "
                   + " YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
	    if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
              sql += " GROUP BY   BXSQD.SHENQINGBM, JHY.BIANMA) T1 "
                   + " RIGHT JOIN (SELECT   T1.*, T2.* FROM "
                   + " (SELECT   BIANHAO, ZUZHIMC "
                   + " FROM   ZZ_GUANLIZZ "
                   + " WHERE   1 = 1 "; 
        if(danweibh != null && !"".equals(danweibh)){//单位编号
      		sql += " AND SHANGJIZZ = '" + danweibh + "'";
        }
              sql += " )T1 JOIN "
                   + " (SELECT   BIANMA, ZHI "
                   + " FROM   QAM_JIHEYZ "
                   + " WHERE   JIHEYLX = 'JH_ZhiChuFL' AND ZHUANGTAI = '1') T2 "
                   + " ON 1 = 1) T2 "
                   + " ON T1.SHENQINGBM = T2.BIANHAO AND T1.BIANMA = T2.BIANMA "
                   + " ORDER BY   ZUZHIMC ";
      
		return sql;
	}

    //单位内各部门经费支出明细表
	public String danweingbmjfzcmxb(String niandu,String danweibh,String begindate,String enddate,String zhichufl,String zhichusx,String order,String suoshubm){
		String sql = " SELECT   T2.*, "
                   + " T1.ZUZHIMC, "
                   + " T1.ZHI, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   ZCSX.BIANHAO, "
                   + " GLZZ.ZUZHIMC, "
                   + " JHY.ZHI, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " QAM_JIHEYZ JHY, "
                   + " YSPZ_ZHICHUSX ZCSX, "
                   + " ZZ_GUANLIZZ GLZZ "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND BXSQD.SHENQINGBM = GLZZ.BIANHAO "
                   + " AND JHY.BIANMA = ZCSX.ZHICHUFL "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        } 
		if(zhichufl != null && !"".equals(zhichufl)){//支出分类
			sql += " AND JHY.BIANMA = '" + zhichufl + "'";
        }
		if(zhichusx != null && !"".equals(zhichusx)){//支出事项
			sql += " AND ZCSX.BIANHAO = '" + zhichusx + "'";
        }
		if(suoshubm != null && !"".equals(suoshubm)){//所属部门
			sql += " AND BXSQD.SHENQINGBM = '" + suoshubm + "'";
		}
              sql += " GROUP BY   ZCSX.BIANHAO, GLZZ.ZUZHIMC, JHY.ZHI "
                   + " ORDER BY   BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   ZCSX.BIANHAO, ZCSX.SHIXIANGMC "
                   + " FROM   YSPZ_DANWEIZCSX DWZCSX, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE   DWZCSX.ZHICHUSXBH = ZCSX.BIANHAO ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND DWZCSX.GUANLIZZBH = '" + danweibh + "'";
        } 
        if(zhichusx != null && !"".equals(zhichusx)){//支出事项
			sql += " AND ZCSX.BIANHAO = '" + zhichusx + "'";
        }
        if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZCSX.NIANDU = '" + niandu + "'";
        }
              sql += " ORDER BY   BIANHAO) T2 "
                   + " ON T1.BIANHAO = T2.BIANHAO ";
        if(order != null && !"".equals(order) && "2".equals(order)){//按支出金额降序排列
        	sql += " ORDER BY   ZHICHUSHU DESC ";
        }
        if(order != null && !"".equals(order) && "1".equals(order)){//按支出金额升序排列
        	sql += " ORDER BY   ZHICHUSHU ";
        }
		return sql;
	}

	//单位重点经费控制执行情况(子表)
	public String danweizdjfkzzxqksub(String niandu,String danweibh,String jiezhirq,String zhichusx,String bumenbh){
		String sql = " SELECT   T2.BIANHAO, "
                   + " T2.ZUZHIMC, "
                   + " T1.SXBH, "
                   + " T1.SHIXIANGMC, "
                   + " NVL (T1.FEIYONGED, 0) FEIYONGED, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU, "
                   + " NVL (T1.KEYONGYE, 0) KEYONGYE "
                   + " FROM      ( "
			       + " SELECT   T2.*, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU, "
                   + " CASE WHEN (NVL (T2.FEIYONGED, 0) - NVL (T1.ZHICHUSHU, 0)) < 0 THEN 0 "
                   + " ELSE (NVL (T2.FEIYONGED, 0) - NVL (T1.ZHICHUSHU, 0)) END KEYONGYE "
                   + " FROM      (  SELECT   BXSQD.SHENQINGBM, "
                   + " ZCSX.BIANHAO, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE   BXSQD.ZHICHUSX = ZCSX.BIANHAO ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
		if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
         	sql += " AND TO_CHAR (BXSQD.BAOXIAORQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }             
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND ZCSX.NIANDU = '" + niandu + "'";
        }
		if(zhichusx != null && !"".equals(zhichusx)){//支出事项
        	sql += " AND ZCSX.BIANHAO = '" + zhichusx + "'";
        }
              sql += " AND ZCSX.ZHONGDIANZCSX = 1 "
                   + " GROUP BY   BXSQD.SHENQINGBM, ZCSX.BIANHAO "
                   + " ORDER BY   BXSQD.SHENQINGBM, ZCSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   GLZZ.BIANHAO, "
                   + " GLZZ.ZUZHIMC, "
                   + " ZCSX.BIANHAO SXBH, "
                   + " ZCSX.SHIXIANGMC, "
                   + " BMFYED.FEIYONGED "
                   + " FROM   YSPZ_BUMENFYED BMFYED, "
                   + " ZZ_GUANLIZZ GLZZ, "
                   + " YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BMFYED.ZHICHUSXBH = ZCSX.BIANHAO "
                   + " AND BMFYED.BUMENBH = GLZZ.BIANHAO ";
         if(danweibh != null && !"".equals(danweibh)){//单位编号
        	 sql += " AND GLZZ.SHANGJIZZ = '" + danweibh + "'";
         }
         if(zhichusx != null && !"".equals(zhichusx)){//支出事项
         	sql += " AND ZCSX.BIANHAO = '" + zhichusx + "'";
         }
         if(niandu != null && !"".equals(niandu)){//预算年度
          	sql += " AND ZCSX.NIANDU = '" + niandu + "'";
          }
              sql += " ORDER BY   GLZZ.BIANHAO, ZCSX.BIANHAO) T2 "
                   + " ON T1.SHENQINGBM = T2.BIANHAO AND T1.BIANHAO = T2.SXBH ";  
              	   
         if(bumenbh != null && !"".equals(bumenbh)){//所属部门
        	 sql += " AND T2.BIANHAO = '" + bumenbh + "'";
         }
              sql += " ) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   BIANHAO, ZUZHIMC "
                   + " FROM   ZZ_GUANLIZZ "
                   + " WHERE   1 = 1 ";
         if(danweibh != null && !"".equals(danweibh)){//单位编号
        	 sql += " AND SHANGJIZZ = '" + danweibh + "'";
         }
            sql += " ) T2 "
                 + " ON T1.BIANHAO = T2.BIANHAO "
                 + " WHERE T2.BIANHAO = $P{bianhao} ";
		return sql;
	}
	
	//单位重点经费控制执行情况(主表)
	public String danweizdjfkzzxqkmain(String danweibh,String suoshubm){
		String sql = " SELECT BIANHAO,ZUZHIMC FROM ZZ_GUANLIZZ WHERE 1=1 ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND SHANGJIZZ = '" + danweibh + "'";
        }
		if(suoshubm != null && !"".equals(suoshubm)){//所属部门
       	 sql += " AND BIANHAO = '" + suoshubm + "'";
        }
		return sql;
	}

	//单位重点经费支出总表
	public String danweizdjfzczb(String niandu,String danweibh,String begindate,String enddate){
		String sql = " SELECT   T2.*, NVL (T1.ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   ZCSX.BIANHAO, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE   BXSQD.ZHICHUSX = ZCSX.BIANHAO ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        } 
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
              sql += " AND ZCSX.ZHONGDIANZCSX = 1 "
                   + " GROUP BY   ZCSX.BIANHAO "
                   + " ORDER BY   ZCSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   ZCSX.BIANHAO, ZCSX.SHIXIANGMC "
                   + " FROM   YSPZ_DANWEIZCSX DWZCSX, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE   DWZCSX.ZHICHUSXBH = ZCSX.BIANHAO ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND DWZCSX.GUANLIZZBH = '" + danweibh + "'";
        }
        if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZCSX.NIANDU = '" + niandu + "'";
        }
              sql += " ) T2 "
                   + " ON T1.BIANHAO = T2.BIANHAO ";
		return sql;
	}

    //单位重点经费支出明细表
	public String danweizdjfzcmxb(String niandu,String danweibh,String begindate,String enddate){
		String sql = " SELECT   CASE WHEN T2.ZUZHIMC IS NULL THEN '办公室' ELSE T2.ZUZHIMC END ZUZHIMC, "
                   + " CASE WHEN T1.SHIXIANGMC IS NULL THEN '交通费' ELSE T1.SHIXIANGMC END SHIXIANGMC, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (SELECT   T2.BIANHAO, "
                   + " T2.SHIXIANGMC, "
                   + " T1.SHENQINGBM, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   ZCSX.BIANHAO, "
                   + " BXSQD.SHENQINGBM, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }                         
              sql += " AND ZCSX.ZHONGDIANZCSX = 1 "
                   + " GROUP BY   ZCSX.BIANHAO, BXSQD.SHENQINGBM "
                   + " ORDER BY   ZCSX.BIANHAO) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   ZCSX.BIANHAO, ZCSX.SHIXIANGMC "
                   + " FROM   YSPZ_DANWEIZCSX DWZCSX, YSPZ_ZHICHUSX ZCSX "
                   + " WHERE   DWZCSX.ZHICHUSXBH = ZCSX.BIANHAO ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND DWZCSX.GUANLIZZBH = '" + danweibh + "'";
        }
        if(niandu != null && !"".equals(niandu)){//预算年度
			sql += " AND ZCSX.NIANDU = '" + niandu + "'";
        }
              sql += " )T2 "
                   + " ON T1.BIANHAO = T2.BIANHAO) T1 "
                   + " FULL JOIN "
                   + " (SELECT   BIANHAO, ZUZHIMC "
                   + " FROM   ZZ_GUANLIZZ GLZZ "
                   + " WHERE   1 = 1 ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND SHANGJIZZ = '" + danweibh + "'";
        }
              sql += " ) T2 "
                   + " ON T1.SHENQINGBM = T2.BIANHAO ";
         return sql;
	}
	
	//单位内部预算支出统计(子表)
	public String danweinbyszctjsub(String niandu,String danweibh,String begindate,String enddate){
		String sql = " SELECT   T2.*, "
                   + " T1.SHIXIANGMC, "
                   + " T1.ZHI, "
                   + " NVL (T1.FEIYONGED, 0) FEIYONGED, "
                   + " NVL (T1.ZHICHUSHU, 0) ZHICHUSHU "
                   + " FROM      (  SELECT   BXSQD.ZHIBIAOBH, "
                   + " ZCSX.SHIXIANGMC, "
                   + " JHY.ZHI, "
                   + " SUM (BMFYED.FEIYONGED) FEIYONGED, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUSHU "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD, "
                   + " YSPZ_ZHICHUSX ZCSX, "
                   + " YSPZ_BUMENFYED BMFYED, "
                   + " QAM_JIHEYZ JHY "
                   + " WHERE       BXSQD.ZHICHUSX = ZCSX.BIANHAO "
                   + " AND BMFYED.ZHICHUSXBH = ZCSX.BIANHAO "
                   + " AND ZCSX.ZHICHUFL = JHY.BIANMA "
                   + " AND JHY.JIHEYLX = 'JH_ZhiChuFL' "
                   + " AND JHY.ZHUANGTAI = '1' ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
			sql += " AND BXSQD.GUANLIZZBH = '" + danweibh + "'";
        }
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
              sql += " GROUP BY   BXSQD.ZHIBIAOBH, ZCSX.SHIXIANGMC, JHY.ZHI "
                   + " ORDER BY   BXSQD.ZHIBIAOBH) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   NBZB.BIANHAO "
                   + " FROM   YSPF_NEIBUPFZB NBZB "
                   + " WHERE 1=1 ";
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND NBZB.PIFUZZ = '" + danweibh + "'";
        }   
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }
              sql += " ) T2 "
                   + " ON T1.ZHIBIAOBH = T2.BIANHAO "
                   + " WHERE T2.BIANHAO = $P{zhibiaobh} ";
		return sql;
	}
	
	//单位内部预算支出统计(主表)
	public String danweinbyszctjmain(String niandu,String danweibh){
		String sql = " SELECT   NBZB.BIANHAO, "
                   + " NBZB.ZHIBIAOMC, "
                   + " NBYSSX.SHIXIANGMC, "
                   + " GLZZ.ZUZHIMC, "
                   + " JHY.ZHI PIFULX, "
                   + " NBZB.YUSUANJE, "
                   + " NBZB.YIFABJE, "
                   + " NBZB.KEYONGYE "
                   + " FROM   YSPF_NEIBUPFZB NBZB, "
                   + " ZZ_GUANLIZZ GLZZ, "
                   + " YSPZ_NEIBUYSSX NBYSSX, "
                   + " QAM_JIHEYZ JHY "
                   + " WHERE       NBZB.JIESHOUZZ = GLZZ.BIANHAO "
                   + " AND NBYSSX.BIANHAO = NBZB.YUSUANSX "
                   + " AND JHY.BIANMA = NBZB.PIFULX "
                   + " AND JHY.JIHEYLX = 'JH_PiFuLX' "
                   + " AND JHY.ZHUANGTAI = 1 ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND NBZB.PIFUZZ = '" + danweibh + "'";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND NBZB.YUSUANND = '" + niandu + "'";
        }
		return sql;
	}

	//XXXX年度单位出国(境)经费明细表		 年度，单位编号，部门编号，起始时间，截止时间，出国经费，单据号			
	public String nianduchuguojfmxb(String niandu,String dwbh,String bmmc,String begindate,String enddate,String cgjf,String djh ){
		String sql = "SELECT      BX.BXDBH BXDBH, " 
				+" BX.ZCSXBH ZCSXBH, " 
				+" TO_CHAR(BX.JingBanSJ,'yyyy-MM-dd') SJ, " 
				+"BX.DANJUH DANJUH, " 
				+"BX.BAOXIAOJE BAOXIAOJE, " 
				+"BX.DWMC DWMC, " 
				+"BX.BMMC BMMC, "
				+"BX.SHIXIANGMC SHIXIANGMC, " 
				+"TO_CHAR(MX.NEIRONG) NEIRONG, " 
				+"MX.MC ZCMXMC, " 
				+"MX.PX " 
				+"FROM  (SELECT   BXD.BIANHAO BXDBH, " 
				+"ZCSX.BIANHAO ZCSXBH , " 
				+"BXD.BAOXIAOJE, " 
				+"BXD.DANJUH DANJUH , " 
				+"BXD.JingBanSJ JingBanSJ , " 
				+"DW.ZUZHIMC DWMC, " 
				+"BM.ZUZHIMC BMMC, " 
				+"ZCSX.SHIXIANGMC SHIXIANGMC " 
				+"FROM   ZCGL_BaoXiaoSQD BXD, " 
				+"ZZ_GuanLiZZ DW, " 
				+"ZZ_GUANLIZZ BM, "
				+"YSPZ_ZhiChuSX ZCSX " 
				+"WHERE       BXD.GUANLIZZBH = DW.BIANHAO " 
				+"AND BXD.ShenQingBM = BM.BIANHAO " 
				+"AND BXD.ZhiChuSX = ZCSX.BIANHAO " 
				+"AND BXD.NIANDU='"+niandu+"'" ;
		if(dwbh != null && !"".equals(dwbh)){//单位编号
	    	sql += " AND BXD.GUANLIZZBH = '" + dwbh + "'";
	    }	
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
	    }
		if(bmmc != null && !"".equals(bmmc)){//部门编号
	    	sql += " AND BM.ZuZhiMC LIKE '%" + bmmc + "%'";
	    }
		if(djh != null && !"".equals(djh)){//单据号
	    	sql += " AND BXD.DANJUH LIKE '%" + djh + "%'";
	    }
		if(cgjf != null && !"".equals(cgjf)){//单据号
	    	sql += " AND ZCSX.BIANHAO = '" + cgjf + "'";
	    }
			 sql+="AND ZCSX.ZHONGDIANZCSX = '1')BX " 
				+"LEFT  JOIN " 
				+"(   SELECT      BXDZCMX.BAOXIAODBH BXDBH, " 
				+"to_char(BXDZCMX.BaoXiaoJE) NEIRONG, " 
				+"ZCMX.MINGXIMC MC, " 
				+"2 PX " 
				+"FROM        ZCGL_BaoXiaoSQDZCMX BXDZCMX, " 
				+"YSPZ_ZhiChuSXMX ZCMX " 
				+"WHERE       ZCMX.BIANHAO = BXDZCMX.ZHICHUSXMXBH " 
				+"UNION all " 
				+"SELECT     BXDFZMX.SHENQINGBXBH BXDBH, " 
				+"BXDFZMX.FUZHUXNR NEIRONG, " 
				+"FZMX.MingCheng MC, " 
				+"1 PX " 
				+"FROM       ZCGL_BaoXiaoSQFZMX BXDFZMX , " 
				+"YSPZ_FuZhuXMX FZMX " 
				+"WHERE      BXDFZMX.FUZHUXBH = FZMX.BianHao " 
				+"ORDER by NEIRONG )MX " 
				+"ON       MX.BXDBH = BX.BXDBH " 
				+" GROUP BY BX.BXDBH , " 
				+"BX.ZCSXBH , " 
				+"BX.JingBanSJ , " 
				+"BX.DANJUH , " 
				+" BX.DWMC , " 
				+"BX.BMMC , " 
				+"BX.SHIXIANGMC , " 
				+" MX.NEIRONG, " 
				+"MX.MC , " 
				+"BX.BAOXIAOJE, " 
				+"MX.PX " 
				+"ORDER BY MX.PX DESC" ;
			return sql;
	}
	
/**统计报表*/
	/**收入管理*/
	//单位收入情况汇总表
	public String danweisrqkhzb(String niandu,String jiezhirq,String danweibh){
		String sql = " SELECT   T3.KEMUMC, "
                   + " NVL (T4.YUJISR, 0) YUJISR, "
                   + " NVL (T4.TIAOZHENGZE, 0) TIAOZHENGZE, "
                   + " NVL (T4.YUJISJ, 0) YUJISJ, "
                   + " NVL (T4.SHOURUJE, 0) SHOURUJE, "
                   + " NVL (T4.QIZHONGSJ, 0) QIZHONGSJ "
                   + " FROM      (SELECT   SRKM.BIANHAO, SRKM.KEMUMC "
                   + " FROM   SRGL_DANWEISRKM DWSRKM, SRGL_SHOURUKM SRKM "
                   + " WHERE   DWSRKM.SHOURUKMBH = SRKM.BIANHAO ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND DWSRKM.GUANLIZZBH = '" + danweibh + "'";
        }
              sql += " ) T3 "
                   + " LEFT JOIN "
                   + " (SELECT   T1.SHOURUKM, "
                   + " T2.YUJISR, "
                   + " T2.TIAOZHENGZE, "
                   + " T2.YUJISJ, "
                   + " T1.SHOURUJE, "
                   + " T1.QIZHONGSJ "
                   + " FROM      (  SELECT   SRDJ.SHOURUKM, "
                   + " SUM (SRDJ.SHOURUJE) SHOURUJE, "
                   + " SUM (SRDJ.QIZHONGSJ) QIZHONGSJ "
                   + " FROM   SRGL_SHOURUDJ SRDJ "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND SRDJ.YUSUANND = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND SRDJ.GUANLIZZ = '" + danweibh + "'";
        }      
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
        	sql += " AND TO_CHAR (SRDJ.DENGJIRQ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
              sql += " GROUP BY   SRDJ.SHOURUKM) T1 "
                   + " INNER JOIN "
                   + " (  SELECT   SRJH.SHOURUKM, "
                   + " SUM (SRJH.YUJISR) YUJISR, "
                   + " SUM (SRJH.TIAOZHENGZE) TIAOZHENGZE, "
                   + " SUM (SRJH.YUJISJ) YUJISJ "
                   + " FROM   SRGL_SHOURUJH SRJH "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND SRJH.YUSUANND = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND SRJH.GUANLIZZ = '" + danweibh + "'";
        }
              sql += " GROUP BY   SRJH.SHOURUKM) T2 "
                   + " ON T1.SHOURUKM = T2.SHOURUKM) T4 "
                   + " ON T3.BIANHAO = T4.SHOURUKM "
                   + " ORDER BY   T3.BIANHAO, T3.KEMUMC ";
		return sql;
	}

	//单位资金到账统计
	public String danweizjdztj(String niandu,String danweibh,String jiezhirq){
		String sql = " SELECT   T3.*, NVL (T4.ZHIFUJE, 0) ZHIFUJE "
                   + " FROM      (SELECT   T1.*, "
                   + " NVL (T2.QICHUYE, 0) QICHUYE, "
                   + " NVL (T2.LEIJIDZJE, 0) LEIJIDZJE "
                   + " FROM      (SELECT   ZJDZKM.BIANHAO, "
                   + " ZJDZKM.KEMUMC, "
                   + " ZJLY.MINGCHENG "
                   + " FROM   SRGL_DANWEIZJDZKM DWDZKM, "
                   + " SRGL_ZIJINDZKM ZJDZKM, "
                   + " YSPZ_ZIJINLY ZJLY "
                   + " WHERE       DWDZKM.DAOZHANGKMBH = ZJDZKM.BIANHAO "
                   + " AND ZJLY.BIANHAO = ZJDZKM.DUIYINGZJLY ";
		if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND DWDZKM.GUANLIZZBH = '" + danweibh + "'";
        }
              sql += " ) T1 "
                   + " LEFT JOIN "
                   + " (  SELECT   ZJDZXM.ZIJINDZKM, "
                   + " SUM (ZJDZXM.QICHUYE) QICHUYE, "
                   + " SUM (ZJDZXM.LEIJIDZJE) LEIJIDZJE "
                   + " FROM   SRGL_YUSUANZJDZXM ZJDZXM "
                   + " WHERE   1 = 1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND ZJDZXM.YUSUANND = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND ZJDZXM.GUANLIZZ = '" + danweibh + "'";
        } 
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
        	sql += " AND TO_CHAR (ZJDZXM.DAOZHANGSJ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
              sql += " GROUP BY   ZJDZXM.ZIJINDZKM) T2 "
                   + " ON T1.BIANHAO = T2.ZIJINDZKM) T3 "
                   + " LEFT JOIN "
                   + " (  SELECT   ZJDZXM.ZIJINDZKM, SUM (ZJZFJL.ZHIFUJE) ZHIFUJE "
                   + " FROM   SRGL_YUSUANZJDZXM ZJDZXM, ZCGL_ZIJINZFJL ZJZFJL "
                   + " WHERE   ZJDZXM.BIANHAO = ZJZFJL.ZIJINGDZXM ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND ZJDZXM.YUSUANND = '" + niandu + "'";
        }
        if(danweibh != null && !"".equals(danweibh)){//单位编号
        	sql += " AND ZJDZXM.GUANLIZZ = '" + danweibh + "'";
        }
        if(jiezhirq != null && !"".equals(jiezhirq)){//截止日期
        	sql += " AND TO_CHAR (ZJDZXM.DAOZHANGSJ, 'yyyy-MM-dd') <= '" + jiezhirq + "'";
        }
              sql += " GROUP BY   ZJDZXM.ZIJINDZKM) T4 "
                   + " ON T3.BIANHAO = T4.ZIJINDZKM "
                   + " ORDER BY T3.BIANHAO,T3.KEMUMC ";
		return sql;
	}
/**决策分析*/
	/**预算管理*/
	//部门支出预算汇总对比统计
	public String bumenzcyshzdbtj(String niandu){
		String sql = " SELECT   T1.KEMUBH, "
                   + " T1.KEMUMC, "
                   + " NVL (SUM (T2.YUSUANJE), 0) SNYSJE, "
                   + " NVL (SUM (T3.YUSUANJE), 0) BNYSJE "
                   + " FROM         (SELECT   LEIKM.KEMUBH, LEIKM.KEMUMC, GNKM.BIANHAO "
                   + " FROM   (SELECT   GNKM.KEMUBH, GNKM.KEMUMC "
                   + " FROM   SRGL_CAIZHENGGNKM GNKM "
                   + " WHERE   GNKM.KEMULB = 0) LEIKM, "
                   + " SRGL_CAIZHENGGNKM GNKM "
                   + " WHERE   GNKM.KEMUBH LIKE LEIKM.KEMUBH || '%') T1 "
                   + " LEFT JOIN "
                   + " (  SELECT   CPZB.CAIZHENGGNKM, SUM (CPZB.YUSUANJE) YUSUANJE "
                   + " FROM   YSPF_CAIZHENGPFZB CPZB "
                   + " WHERE   1 = 1 ";
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND CPZB.YUSUANND = '" + (Integer.parseInt(niandu)-1) + "'";
        }
              sql += " GROUP BY   CPZB.CAIZHENGGNKM) T2 "
                   + " ON T1.BIANHAO = T2.CAIZHENGGNKM "
                   + " LEFT JOIN "
                   + " (  SELECT   CPZB.CAIZHENGGNKM, SUM (CPZB.YUSUANJE) YUSUANJE "
                   + " FROM   YSPF_CAIZHENGPFZB CPZB "
                   + " WHERE   1 = 1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND CPZB.YUSUANND = '" + niandu + "'";
        }  
              sql += " GROUP BY   CPZB.CAIZHENGGNKM) T3 "
                   + " ON T1.BIANHAO = T3.CAIZHENGGNKM "
                   + " GROUP BY   T1.KEMUBH, T1.KEMUMC "
                   + " UNION "
                   + " SELECT   '0' AS KEMUBH, "
                   + " '合计' AS KEMUMC, "
                   + " SUM (SNYSJE) SNYSJE, "
                   + " SUM (BNYSJE) BNYSJE "
                   + " FROM   (  SELECT   T1.KEMUBH, "
                   + " T1.KEMUMC, "
                   + " NVL (SUM (T2.YUSUANJE), 0) SNYSJE, "
                   + " NVL (SUM (T3.YUSUANJE), 0) BNYSJE "
                   + " FROM         (SELECT   LEIKM.KEMUBH, LEIKM.KEMUMC, GNKM.BIANHAO "
                   + " FROM   (SELECT   GNKM.KEMUBH, GNKM.KEMUMC "
                   + " FROM   SRGL_CAIZHENGGNKM GNKM "
                   + " WHERE   GNKM.KEMULB = 0) LEIKM, "
                   + " SRGL_CAIZHENGGNKM GNKM "
                   + " WHERE   GNKM.KEMUBH LIKE LEIKM.KEMUBH || '%') T1 "
                   + " LEFT JOIN "
                   + " (  SELECT   CPZB.CAIZHENGGNKM, "
                   + " SUM (CPZB.YUSUANJE) YUSUANJE "
                   + " FROM   YSPF_CAIZHENGPFZB CPZB "
                   + " WHERE   1 = 1 ";
      	if(niandu != null && !"".equals(niandu)){//预算年度
      		sql += " AND CPZB.YUSUANND = '" + (Integer.parseInt(niandu)-1) + "'";
        }
              sql += " GROUP BY   CPZB.CAIZHENGGNKM) T2 "
                   + " ON T1.BIANHAO = T2.CAIZHENGGNKM "
                   + " LEFT JOIN "
                   + " (  SELECT   CPZB.CAIZHENGGNKM, "
                   + " SUM (CPZB.YUSUANJE) YUSUANJE "
                   + " FROM   YSPF_CAIZHENGPFZB CPZB "
                   + " WHERE   1 = 1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND CPZB.YUSUANND = '" + niandu + "'";
        } 
              sql += " GROUP BY   CPZB.CAIZHENGGNKM) T3 "
                   + " ON T1.BIANHAO = T3.CAIZHENGGNKM "
                   + " GROUP BY   T1.KEMUBH, T1.KEMUMC) ";
		return sql;
	}
	
	//部门支出预算分类对比统计
	public String bumenzcysfldbtj(String niandu,String yusuansx,String jici){
		String sql = " SELECT SHIXIANGMC,BNDPIFUZEHZ,SNDPIFUZEHZ FROM ( "
                   + " SELECT   T2.*, "
                   + " (    SELECT   SUM (BNDYUSUANJE) "
                   + " FROM   ( "
                   + " SELECT BND.*,NVL(SND.SNDYUSUANJE,0) SNDYUSUANJE FROM "
                   + " (SELECT   T1.*, NVL (SUM (CPZB.YUSUANJE), 0) BNDYUSUANJE "
                   + " FROM      (SELECT   BIANHAO,SHIXIANGMC,JICI,SHANGJIBH "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
		      sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "//预算事项
                   + " WHERE   JICI >= " + jici + " ) T1 "//级次
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON T1.BIANHAO = CPZB.YUSUANSXBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH ) BND "
                   + " LEFT JOIN "
                   + " ( SELECT   T2.BIANHAO,T2.SHIXIANGMC ,SUM (T2.YUSUANJE) SNDYUSUANJE "
                   + " FROM   (  SELECT   T1.*, SUM (NVL (CPZB.YUSUANJE, 0)) YUSUANJE "
                   + " FROM      (SELECT   BND.BIANHAO, "
                   + " BND.SHIXIANGMC, "
                   + " BND.JICI, "
                   + " BND.SHANGJIBH, "
                   + " SND.BIANHAO SNDBH "
                   + " FROM   (SELECT   BIANHAO, SHIXIANGMC,JICI,SHANGJIBH,DUIYINGSNYSSX "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI, "
                   + " YSSX.DUIYINGSNYSSX "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) BND, YSPZ_CAIZHENGYSSX SND "
                   + " WHERE BND.DUIYINGSNYSSX LIKE '%' || SND.BIANHAO || '%') T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON CPZB.YUSUANSXBH = T1.SNDBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " T1.SHIXIANGMC, "
                   + " T1.JICI, "
                   + " T1.SHANGJIBH, "
                   + " T1.SNDBH) T2 "
                   + " GROUP BY   T2.BIANHAO,T2.SHIXIANGMC) SND "
                   + " ON BND.BIANHAO = SND.BIANHAO) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BIANHAO = T2.BIANHAO) "
                   + " BNDPIFUZEHZ, "
                   + " (    SELECT   SUM (SNDYUSUANJE) "
                   + " FROM   (SELECT BND.*,NVL(SND.SNDYUSUANJE,0) SNDYUSUANJE FROM "
                   + " (SELECT   T1.*, NVL (SUM (CPZB.YUSUANJE), 0) BNDYUSUANJE "
                   + " FROM      (SELECT   BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
         if(niandu != null && !"".equals(niandu)){//预算年度
        	 sql += " AND YSSX.NIANDU = '" + niandu + "'";
         }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON T1.BIANHAO = CPZB.YUSUANSXBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH ) BND "
                   + " LEFT JOIN "
                   + " ( SELECT   T2.BIANHAO,T2.SHIXIANGMC ,SUM (T2.YUSUANJE) SNDYUSUANJE "
                   + " FROM   (  SELECT   T1.*, SUM (NVL (CPZB.YUSUANJE, 0)) YUSUANJE "
                   + " FROM      (SELECT   BND.BIANHAO, "
                   + " BND.SHIXIANGMC, "
                   + " BND.JICI, "
                   + " BND.SHANGJIBH, "
                   + " SND.BIANHAO SNDBH "
                   + " FROM   (SELECT   BIANHAO, SHIXIANGMC,JICI,SHANGJIBH,DUIYINGSNYSSX "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI, "
                   + " YSSX.DUIYINGSNYSSX "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) BND, YSPZ_CAIZHENGYSSX SND "
                   + " WHERE BND.DUIYINGSNYSSX LIKE '%' || SND.BIANHAO || '%') T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON CPZB.YUSUANSXBH = T1.SNDBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " T1.SHIXIANGMC, "
                   + " T1.JICI, "
                   + " T1.SHANGJIBH, "
                   + " T1.SNDBH) T2 "
                   + " GROUP BY   T2.BIANHAO,T2.SHIXIANGMC) SND "
                   + " ON BND.BIANHAO = SND.BIANHAO) T3 "
                   + " CONNECT BY   PRIOR T3.BIANHAO = T3.SHANGJIBH "
                   + " START WITH   T3.BIANHAO = T2.BIANHAO) "
                   + " SNDPIFUZEHZ "
                   + " FROM   (SELECT BND.*,NVL(SND.SNDYUSUANJE,0) SNDYUSUANJE FROM "
                   + " (SELECT   T1.*, NVL (SUM (CPZB.YUSUANJE), 0) BNDYUSUANJE "
                   + " FROM      (SELECT   BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON T1.BIANHAO = CPZB.YUSUANSXBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH ) BND "
                   + " LEFT JOIN "
                   + " ( SELECT   T2.BIANHAO,T2.SHIXIANGMC ,SUM (T2.YUSUANJE) SNDYUSUANJE "
                   + " FROM   (  SELECT   T1.*, SUM (NVL (CPZB.YUSUANJE, 0)) YUSUANJE "
                   + " FROM      (SELECT   BND.BIANHAO, "
                   + " BND.SHIXIANGMC, "
                   + " BND.JICI, "
                   + " BND.SHANGJIBH, "
                   + " SND.BIANHAO SNDBH "
                   + " FROM   (SELECT   BIANHAO, SHIXIANGMC,JICI,SHANGJIBH,DUIYINGSNYSSX "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI, "
                   + " YSSX.DUIYINGSNYSSX "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) BND, YSPZ_CAIZHENGYSSX SND "
                   + " WHERE BND.DUIYINGSNYSSX LIKE '%' || SND.BIANHAO || '%') T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON CPZB.YUSUANSXBH = T1.SNDBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " T1.SHIXIANGMC, "
                   + " T1.JICI, "
                   + " T1.SHANGJIBH, "
                   + " T1.SNDBH) T2 "
                   + " GROUP BY   T2.BIANHAO,T2.SHIXIANGMC) SND "
                   + " ON BND.BIANHAO = SND.BIANHAO) T2 "
                   + " CONNECT BY   PRIOR T2.BIANHAO = T2.SHANGJIBH "
                   + " START WITH   T2.JICI = " + jici 
                   + " ORDER SIBLINGS BY   T2.BIANHAO) " 
                   + " WHERE JICI = " + jici
                   + " UNION "
                   + " SELECT '合计' AS SHIXIANGMC, SUM(T1.YUSUANJE) BNDPIFUZEHZ,SUM(T2.SNDYUSUANJE) SNDPIFUZEHZ FROM "
                   + " ( SELECT   T1.*, NVL (SUM (CPZB.YUSUANJE), 0) YUSUANJE "
                   + " FROM      (SELECT   BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + " ) T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON T1.BIANHAO = CPZB.YUSUANSXBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " SHIXIANGMC, "
                   + " JICI, "
                   + " SHANGJIBH  ) T1 "
                   + " LEFT JOIN "
                   + " (  SELECT   T2.BIANHAO,T2.SHIXIANGMC ,SUM (T2.YUSUANJE) SNDYUSUANJE "
                   + " FROM   (  SELECT   T1.*, SUM (NVL (CPZB.YUSUANJE, 0)) YUSUANJE "
                   + " FROM      (SELECT   BND.BIANHAO, "
                   + " BND.SHIXIANGMC, "
                   + " BND.JICI, "
                   + " BND.SHANGJIBH, "
                   + " SND.BIANHAO SNDBH "
                   + " FROM   (SELECT   BIANHAO, SHIXIANGMC,JICI,SHANGJIBH,DUIYINGSNYSSX "
                   + " FROM   (    SELECT   YSSX.BIANHAO, "
                   + " YSSX.SHIXIANGMC, "
                   + " YSSX.SHANGJIBH, "
                   + " YSSX.JICI, "
                   + " YSSX.DUIYINGSNYSSX "
                   + " FROM   YSPZ_CAIZHENGYSSX YSSX "
                   + " WHERE 1=1 ";
        if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND YSSX.NIANDU = '" + niandu + "'";
        }
              sql += " CONNECT BY   PRIOR YSSX.BIANHAO = YSSX.SHANGJIBH "
                   + " START WITH   YSSX.BIANHAO = '" + yusuansx + "') "
                   + " WHERE   JICI >= " + jici + ") BND, YSPZ_CAIZHENGYSSX SND "
                   + " WHERE BND.DUIYINGSNYSSX LIKE '%' || SND.BIANHAO || '%') T1 "
                   + " LEFT JOIN "
                   + " YSPF_CAIZHENGPFZB CPZB "
                   + " ON CPZB.YUSUANSXBH = T1.SNDBH "
                   + " GROUP BY   T1.BIANHAO, "
                   + " T1.SHIXIANGMC, "
                   + " T1.JICI, "
                   + " T1.SHANGJIBH, "
                   + " T1.SNDBH) T2 "
                   + " GROUP BY   T2.BIANHAO,T2.SHIXIANGMC )  T2 "
                   + " ON T1.BIANHAO = T2.BIANHAO ";
		return sql;
	}
	/**支出管理*/
    //出国(境)经费汇总统计
	public String chuguojjfhztj(String niandu,String begindate,String enddate,String zcsx,String danweilx){
		String sql = " SELECT   T2.ZUZHIMC, "
                   + " NVL (T1.MXJE, 0) MXJE, "
                   + " NVL (T2.ZHICHUJE, 0) ZHICHUJE, "
                   + " T2.MINGXIMC "
                   + " FROM      (  SELECT   BXSQD.GUANLIZZBH, "
                   + " BXSQD.ZHICHUSX, "
                   + " ZCSXMX.BIANHAO, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT > '3' THEN BXMX.BAOXIAOJE ELSE 0 END,0)) MXJE "
                   + " FROM   ZZ_GUANLIZZ GLZZ, "
                   + " ZZ_ZUZHIJG ZZJG, "
                   + " ZCGL_BAOXIAOSQD BXSQD, "
                   + " ZCGL_BAOXIAOSQDZCMX BXMX, "
                   + " YSPZ_ZHICHUSXMX ZCSXMX "
                   + " WHERE       GLZZ.DUIYINGZZJG = ZZJG.BIANHAO "
                   + " AND BXSQD.GUANLIZZBH = GLZZ.BIANHAO "
                   + " AND BXMX.BAOXIAODBH = BXSQD.BIANHAO "
                   + " AND BXMX.ZHICHUSXMXBH = ZCSXMX.BIANHAO ";
		if(zcsx != null && !"".equals(zcsx)){//重点经费支出事项
        	sql += " AND BXSQD.ZHICHUSX = '" + zcsx + "'";
        }
		if(danweilx != null && !"".equals(danweilx)){//单位类型
        	sql += " AND ZZJG.DANWEILX IN (" + danweilx + ")";
        }
		if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
	    	sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
        }
		if(niandu != null && !"".equals(niandu)){//预算年度
        	sql += " AND BXSQD.NIANDU = '" + niandu + "'";
        }
              sql += " GROUP BY   BXSQD.GUANLIZZBH, BXSQD.ZHICHUSX, ZCSXMX.BIANHAO "
                   + " ORDER BY   BXSQD.GUANLIZZBH) T1 "
                   + " RIGHT JOIN "
                   + " (SELECT   DW.BIANHAO, "
                   + " DW.ZUZHIMC, "
                   + " DW.ZHICHUJE, "
                   + " SXMX.BIANHAO MXBH, "
                   + " SXMX.MINGXIMC "
                   + " FROM      (SELECT   T2.*, T1.ZHICHUJE "
                   + " FROM      (  SELECT   BXSQD.GUANLIZZBH, "
                   + " SUM(NVL(CASE WHEN BXSQD.BAOXIAODZT >'3' THEN BXSQD.BAOXIAOJE ELSE 0 END,0)) ZHICHUJE "
                   + " FROM   ZCGL_BAOXIAOSQD BXSQD "
                   + " WHERE 1=1 ";
         if(begindate != null && !"".equals(begindate) && enddate != null && !"".equals(enddate)){//截止日期
        	 sql += " AND (TO_CHAR (BXSQD.BAOXIAORQ,'yyyy-MM-dd') BETWEEN '" + begindate + "' AND '" + enddate+ "') ";
         } 
         if(zcsx != null && !"".equals(zcsx)){//重点经费支出事项
        	 sql += " AND ZHICHUSX = '" + zcsx + "'";
         }
              sql += " GROUP BY   BXSQD.GUANLIZZBH) T1 "
                   + " RIGHT JOIN "
                   + " (  SELECT   GLZZ.BIANHAO, ZUZHIMC "
                   + " FROM   ZZ_GUANLIZZ GLZZ, "
                   + " ZZ_ZUZHIJG ZZJG "
                   + " WHERE   GLZZ.ZUZHILX = '1' "
                   + " AND GLZZ.DUIYINGZZJG = ZZJG.BIANHAO ";
         if(danweilx != null && !"".equals(danweilx)){//单位类型
        	 sql += " AND ZZJG.DANWEILX IN (" + danweilx + ")";
         }  
              sql += " ORDER BY   BIANHAO) T2 "
                   + " ON T1.GUANLIZZBH = T2.BIANHAO) DW "
                   + " JOIN "
                   + " (SELECT   BIANHAO, MINGXIMC "
                   + " FROM   YSPZ_ZHICHUSXMX "
                   + " WHERE   1 = 1 ";
         if(zcsx != null && !"".equals(zcsx)){//重点经费支出事项
        	 sql += " AND ZHICHUSXBH = '" + zcsx + "'";
         }        
              sql += " )SXMX "
                   + " ON 1 = 1) T2 "
                   + " ON T1.GUANLIZZBH = T2.BIANHAO AND T2.MXBH = T1.BIANHAO ";
		return sql;
	}
}

