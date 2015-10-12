package com.rc.web.servlet;
/** 
 * 概要:DES加密算法，兼容PHP的解密 
 * @author cailin 
 * @since v2.0 
 */    
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import org.apache.commons.codec.binary.Base64;
  
public class DESCoder   
{  
    private final static String KEY = "LSQ7il8*1lod"; // 字节数必须是8的倍数  
    public static byte[] desEncrypt(byte[] plainText) throws Exception  
    {  
        SecureRandom sr = new SecureRandom();  
        DESKeySpec dks = new DESKeySpec(KEY.getBytes());  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");  
        SecretKey key = keyFactory.generateSecret(dks);  
        Cipher cipher = Cipher.getInstance("DES");  
        cipher.init(Cipher.ENCRYPT_MODE, key, sr);  
        byte data[] = plainText;  
        byte encryptedData[] = cipher.doFinal(data);  
        return encryptedData;  
    }  
      
    public static byte[] desDecrypt(byte[] encryptText) throws Exception   
    {  
    	
        SecureRandom sr = new SecureRandom();  
        DESKeySpec dks =  new DESKeySpec(KEY.getBytes());  
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");  
        SecretKey key = keyFactory.generateSecret(dks);  
        Cipher cipher = Cipher.getInstance("DES");  
        cipher.init(Cipher.DECRYPT_MODE, key, sr);  
        byte encryptedData[] = encryptText;  
        byte decryptedData[] = cipher.doFinal(encryptedData);  
        return decryptedData;  
    }  
      
    public static String encrypt(String input) throws Exception{
    	String str = input.replaceAll("+", "-");
        return base64Encode(desEncrypt(str.getBytes()));  
    }  
      
    public static String decrypt(String input) throws Exception{
    	String str = input.replaceAll("-", "+");
        byte[] result = base64Decode(str);  
        return new String(desDecrypt(result), "UTF-8");  
    }  
      
    public static String base64Encode(byte[] s) throws UnsupportedEncodingException{  
        if (s == null)  
            return null;  
        return  new String(Base64.encodeBase64(s), "UTF-8");
  
    }  
      
    public static byte[] base64Decode(String s) throws IOException{  
        if (s == null){  
           return null;  
        }  
        byte[] b = Base64.decodeBase64(s.getBytes("UTF-8"));  
        return b;  
    } 
    
    public static  void main(String args[]) {  
        try {  
            System.out.println(DESCoder.encrypt("dadfadfajii2343424"));  
            System.out.println(DESCoder.decrypt(DESCoder.encrypt("dadfadfajii2343424")));
            System.out.println(DESCoder.decrypt("cc0lJwe3NmHoGRrMNitqBaExxqHWWtLgfzxSmdM/bHHOVD2pRb96+g=="));
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
}  
