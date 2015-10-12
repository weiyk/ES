package com.rc.eschool.fundmanage.expend;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
/**
 * 
 * <p>application name:      获取url</p>
 
 * <p>application describing:获取url</p>
 */
public class GetUrl {
	public String getUrl(String url){
		InputStream inputStream = this.getClass().getClassLoader()
		.getResourceAsStream("com/rc/eschool/fundmanage/expend/url.properties");
		Properties p = new Properties();
		try {
			p.load(inputStream);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return p.getProperty(url);
	}
}
