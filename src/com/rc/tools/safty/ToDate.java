package com.rc.tools.safty;

import java.util.Date;
import java.util.GregorianCalendar;
/**
 * 
 * @author 对返回的时间进行转换
 *
 */
public class ToDate {
	public String TimeConvert(String time){
		long sd=Long.parseLong(time);
        Date dat=new Date(sd);  
        GregorianCalendar gc = new GregorianCalendar();   
        gc.setTime(dat);  
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");  
        String sb=format.format(gc.getTime()); 
        return sb;
	}
	 
}
