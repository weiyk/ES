package com.rc.web.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * 
 * <p>application name:      金额大小写转换</p>
 
 * <p>application describing:金额大小写转换</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class Translate {
		public static String change(double n){
			if (n == 0.0D) return "零元整";
			DecimalFormat df = new DecimalFormat("#0.00");
			String digit[] = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
			String unit[] = {"元","万","亿","万P"};
			String un[]={"","拾","佰","仟"};
			String uni[]={"分", "角"};
			String  buffer=n>0?"":"零";
			String f = "";
			if(n < 0){
				f = "负";
				n = Math.abs(n);
			}
			BigDecimal num = new BigDecimal(n);
			num = num.divide(BigDecimal.ONE, 2, BigDecimal.ROUND_HALF_UP);
			String ns = df.format(num);
			int fl= Integer.parseInt(ns.substring(ns.indexOf(".")+1));
			String fll="";
			for (int i = 0; i < uni.length; i++) {
				fll = digit[fl%10]+uni[i]+fll;
				fl=fl/10;
			}
			buffer=fll.replaceAll("(零.零.)", "")+buffer;
			//if(Integer.MAX_VALUE > n){
				//int num =  (int)Math.floor(n);
			   // for (int i = 0; i < unit.length && num > 0; i++) {
			      //  String buffe ="";
			      //  for (int j = 0; j < un.length && n > 0; j++) {
			       // 	buffe = digit[num%10]+un[j] + buffe;
			       // 	num = num/10;
			      //  }
			      // buffer = buffe.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[i] + buffer;
			   // }
			//}else{
				BigDecimal b = new BigDecimal(ns.substring(0,ns.indexOf(".")));
				for (int i = 0; i < unit.length && b.compareTo(BigDecimal.ZERO) == 1; i++) {
			        String buffe ="";
			        for (int j = 0; j < un.length && n > 0; j++) {
			        	buffe = digit[b.remainder(BigDecimal.TEN).intValue()]+un[j] + buffe;
			        	b = b.divide(BigDecimal.TEN);
			        }
			       buffer = buffe.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[i] + buffer;
			      
			    }
				
			//}
		    buffer = f + buffer;
		    buffer = buffer.replaceAll("(零万(P))", "").replaceAll("(零.亿)", "").replaceAll("(零.)*零元", "元").replaceAll("(零.)+", "零").replaceAll("(角零)+", "角零分").replaceAll("^整$", "零元整")+"整";
		    if(buffer.contains("亿")){
		    	buffer = buffer.replaceAll("(P)", "");
		    }else{
		    	buffer = buffer.replaceAll("(P)", "亿");
		    }
		    if(buffer.startsWith("零")){
		    	 return buffer.replaceFirst("(零)", "");
		    }
		    return buffer;
		}
	}

