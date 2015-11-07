package com.shiro.web.shiro.filter;

import org.apache.shiro.session.Session;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;

import com.shiro.Constants;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


/**
 * @ClassName ForceLogoutFilter.java
 * @Description 强制退出拦截器
 *
 * @author 1904
 * @version V1.0 
 * @Date 2015年6月24日 下午4:21:34
 */
public class ForceLogoutFilter extends AccessControlFilter {

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        Session session = getSubject(request, response).getSession(false);
        if(session == null) {
            return true;
        }
        return session.getAttribute(Constants.SESSION_FORCE_LOGOUT_KEY) == null;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        try {
            getSubject(request, response).logout();//强制退出
        } catch (Exception e) {
        }

        String loginUrl = getLoginUrl() + (getLoginUrl().contains("?") ? "&" : "?") + "forceLogout=1";
        WebUtils.issueRedirect(request, response, loginUrl);
        return false;
    }
}
