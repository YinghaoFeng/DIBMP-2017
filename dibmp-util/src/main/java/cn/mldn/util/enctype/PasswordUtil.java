package cn.mldn.util.enctype;

import java.util.Base64;

import cn.mldn.util.MD5Code;

/**
 * 定义一个专门进行密码加密的处理程序类，而且所有的密码一定要被循环加密多次
 * @author mldn 
 */
public class PasswordUtil {
	private static final int REPEAT_COUNT = 3 ;	// 加密的次数
	private static final String SALT = "mldnjava" ;	// 盐值的种子数
	private PasswordUtil() {}
	/** 
	 * 进行一个密码的加密处理操作
	 * @param pwd 原始密码
	 * @return 加密处理后的密码
	 */
	public static String encoder(String pwd) {
		byte data [] = SALT.getBytes() ;
		for (int x = 0 ; x < REPEAT_COUNT ; x ++) {
			data = Base64.getEncoder().encode(data) ;
		}
		String saltPwd = "{" + new String(data) + "}" + pwd;
		for (int x = 0 ; x < REPEAT_COUNT ; x ++) {
			saltPwd = new MD5Code().getMD5ofStr(saltPwd) ;
		}
		return saltPwd ;
	}
}
