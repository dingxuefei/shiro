package com.shiro;

/**
 * 常量配置
 * @author 1904
 * @version V1.0 
 * @Date 2015年6月16日 上午10:11:34
 */
public interface Constants {
    String CURRENT_USER = "user";
    String SESSION_FORCE_LOGOUT_KEY = "session.force.logout";
    
    /**
     * 上个页面地址
     */
    String BACK_URL = "BackURL";

    String IGNORE_BACK_URL = "ignoreBackURL";
    
    String CONTEXT_PATH = "ctx";
    
    /**
     * 当前请求的地址 带参数
     */
    String CURRENT_URL = "currentURL";
    
    /**
     * 当前请求的地址 不带参数
     */
    String NO_QUERYSTRING_CURRENT_URL = "noQueryStringCurrentURL";
}
