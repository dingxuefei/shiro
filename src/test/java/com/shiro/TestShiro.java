package com.shiro;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;
import org.apache.shiro.mgt.SecurityManager;

/**
 * 
 * @ClassName TestShiro.java
 * @Description 测试
 * 
 * @author 1904
 * @version V1.0
 * @Date 2015年6月12日 下午4:14:24
 */
public class TestShiro {

	private transient final static Logger logger = Logger.getLogger(TestShiro.class);
	
	public static void main(String[] args) throws Exception {
		testHelloworld();
	}

	public static void testHelloworld() {
		// 1、获取SecurityManager工厂，此处使用Ini配置文件初始化SecurityManager
		Factory<SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro.ini");
		
		// 2、得到SecurityManager实例并绑定给SecurityUtils
		SecurityManager securityManager = factory.getInstance();
		SecurityUtils.setSecurityManager(securityManager);
		
		// 3、得到Subject及创建用户名/密码身份验证Token（即用户身份/凭证）
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken("zhang", "123");
		try {
			// 4、登录，即身份验证
			subject.login(token);
			System.out.println("认证成功");
		} catch (AuthenticationException e) {
			// 5、身份验证失败
			logger.error("失败", e);
		}
		Assert.assertEquals(true, subject.isAuthenticated()); // 断言用户已经登录
		// 6、退出
		subject.logout();
	}

}
