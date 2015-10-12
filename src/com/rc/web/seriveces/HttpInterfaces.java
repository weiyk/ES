package com.rc.web.seriveces;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * 加密工具类
 * @author jianfei
 *
 */
public class HttpInterfaces {
	

	public static String getPost(String path){
		StringBuilder sb = new StringBuilder();
		try {
            URL url = new URL(path);    // 把字符串转换为URL请求地址
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();// 打开连接
            connection.connect();// 连接会话
            // 获取输入流
            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = br.readLine()) != null) {// 循环读取流
                sb.append(line);
            }
            br.close();// 关闭流
            connection.disconnect();// 断开连接
        } catch (Exception e) {
            e.printStackTrace();
            return "失败";
        }
        return sb.toString();
	}
}

