package com.shiro.web.controller;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.util.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    @RequestMapping(value = "/login")
    public String showLoginForm(HttpServletRequest req, Model model) {
        String exceptionClassName = (String)req.getAttribute("shiroLoginFailure");
        String error = null;
        if(UnknownAccountException.class.getName().equals(exceptionClassName)) {
            error = "用户名/密码错误";
        } else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
            error = "用户名/密码错误";
        } else if(exceptionClassName != null) {
            error = "其他错误：" + exceptionClassName;
        }
        String kickout = req.getParameter("kickout");
        String forceLogout = req.getParameter("forceLogout");
        if(StringUtils.hasText(kickout)){
        	error = "您的账号已在其他地方登录";
        }
        if(StringUtils.hasText(forceLogout)) {
        	error = "您已经被管理员强制退出，请重新登录";
    	}
        model.addAttribute("error", error);
        return "login/login";
    }

}
