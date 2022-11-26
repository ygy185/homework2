package com.dap.cloud.b2o.web.utils;

import java.security.Security;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class SecurityUtils {
	private static final String AES_KEY = "jkl;POIU1234++==";
	private static final String AES_MOD = "AES/CCM/NoPadding";
	public static final String SECURITY_YES = "1";		//需要加解密
	public static final String SECURITY_NO = "0";		//无需加解密
	public static final String SECURITY_CYES = "是";
	public static final String SECURITY_CNO = "否";
	private static byte[] nonce = {'a','b','c','d','e','f','g','h','i','j','k','l'};
	/**
	 * 位运算
	 * @param val
	 * @return
	 */
	public static String position(String val) {
		char[] array = val.toCharArray();
		//遍历字符数组
		for(int i=0;i<array.length;i++) {
			array[i] = (char)(array[i]^20000); //对每个数组元素进行异或运算
		}
		return new String(array);
	}
	
	/**
	 * AES加密
	 * @param val
	 * @return
	 */
	public static String Encrypt(String val) throws Exception {
		return position(val);
		//return AESEncrypt(val);
	}
	
	public static String AESEncrypt(String val) throws Exception {
		byte[] raw = AES_KEY.getBytes("utf-8");
		Security.addProvider(new BouncyCastleProvider());
		GCMParameterSpec parameterSpec = new GCMParameterSpec(32, nonce);
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		Cipher cipher = Cipher.getInstance(AES_MOD,"BC");//"算法/模式/补码方式"
		cipher.init(Cipher.ENCRYPT_MODE, skeySpec,parameterSpec);
		byte[] encrypted = cipher.doFinal(val.getBytes("utf-8"));
		return Base64.getEncoder().encodeToString(encrypted);
	}
	
	public static String AESDecrypt(String val) throws Exception {
		byte[] raw = AES_KEY.getBytes("utf-8");
		Security.addProvider(new BouncyCastleProvider());
		GCMParameterSpec parameterSpec = new GCMParameterSpec(32, nonce);
		SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
		Cipher cipher = Cipher.getInstance(AES_MOD,"BC");
		cipher.init(Cipher.DECRYPT_MODE, skeySpec,parameterSpec);
		
		//先解密
		byte[] encrypted1 = Base64.getDecoder().decode(val);
		
		byte[] original = cipher.doFinal(encrypted1);
		return new String(original,"utf-8");
	}
	
	/**
	 * AES解密
	 * @param val
	 * @return
	 * @throws Exception
	 */
	public static String Decrypt(String val) throws Exception {
		return position(val);
	}
}
