package com.rc.web.utils;
import java.io.File;
//import java.io.FileNotFoundException;
//import java.io.FileOutputStream;


public class DeleteUpload {
	/**
	 * 删除指定文件或文件夹下所有文件
	 * @param file 文件路径或者文件
	 * @param exName 要删除的文件后缀名
	 */
	public static void deleteFile(File file,String exName){		
		if(file.isDirectory()){//判断是否是文件夹
			File[] files = file.listFiles();	//得到当前文件夹下所有文件及文件夹
			if(files != null && files.length > 0)
				for(File f : files ){
					deleteFile(f,exName); //递归遍历
				}
		}else{
			if(file.isFile()){//判断是否为标准文件
				String eName = getExtensionName(file.getName()); //得到文件扩展名
				if(exName.equalsIgnoreCase(eName)){ //判断是否为要删除的文件扩展名
					file.delete(); //删除
				}
			}
		}		
	}
	/**
	 * 得到文件扩展名
	 * @param filename
	 * @return
	 */
	 public static String getExtensionName(String filename) {   
	        if ((filename != null) && (filename.length() > 0)) {   
	            int dot = filename.lastIndexOf('.');   
	            if ((dot >-1) && (dot < (filename.length() - 1))) {   
	                return filename.substring(dot + 1);   
	            }   
	        }   
	        return filename;   
	    }   
	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
//	public static void main(String[] args) throws Exception {
//		String path = "D://upload/";		
//		for(int i=0;i<20;i++){
//			String p = path+"_"+i+"/";
//			File files = new File(p);
//			files.mkdirs();
//			for(int k=0;k<10;k++){
//				String fileName = "";
//				if(k%2==0){	
//					fileName = p+""+k+".swf";
//				}else {
//					fileName = p+""+k+".s";
//				}
//				FileOutputStream oStream  = new FileOutputStream(fileName);
//				oStream.flush();
//				oStream.close();
//			}
//		}
//		
		//deleteFile(new File(path),"swf");
		
//	}

}
