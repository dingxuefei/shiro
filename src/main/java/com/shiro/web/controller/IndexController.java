package com.shiro.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.shiro.model.Resource;
import com.shiro.model.User;
import com.shiro.service.ResourceService;
import com.shiro.service.UserService;
import com.shiro.web.bind.annotation.CurrentUser;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private UserService userService;
    
    private Gson gson = new Gson();

    @RequestMapping("/")
    public String index(@CurrentUser User loginUser, Model model) {
        Set<String> permissions = userService.findPermissions(loginUser.getUsername());
        List<Resource> menus = resourceService.findMenus(permissions);
        model.addAttribute("menus", menus);
        return "index/index";
    }

    @RequestMapping("/welcome")
    public String welcome() {
        return "index/welcome";
    }
    
    
    @RequestMapping(value = "submenu", method = RequestMethod.GET, produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String submenu(@CurrentUser User loginUser, HttpServletRequest request){
    	Set<String> permissions = userService.findPermissions(loginUser.getUsername());
    	List<Resource> resources = new ArrayList<Resource>();
    	String parent_id = request.getParameter("parent_id");
    	List<Resource> list = resourceService.findMenus(Long.valueOf(parent_id), permissions);
    	for(Resource resource : list){
    		if(resourceService.findMenus(resource.getId(), permissions).size() > 0){
    			resource.setIsChild(true);
    		}
    		resources.add(resource);
    	}
    	return gson.toJson(resources);
    }

}
