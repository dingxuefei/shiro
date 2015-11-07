package com.shiro.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shiro.model.User;
import com.shiro.service.RoleService;
import com.shiro.service.UserService;
import com.shiro.util.Page;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @RequiresPermissions("sys:user:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model, HttpServletRequest request) {
    	int pageNo = 1;   
		int pageSize = 20;
		String pageNoString = request.getParameter("pageNo");
		String pageSizeString = request.getParameter("pageSize");
		
		if(StringUtils.isNotBlank(pageNoString)){
			pageNo = Integer.valueOf(pageNoString);
		}
		
		if(StringUtils.isNotBlank(pageSizeString)){
			pageSize = Integer.valueOf(pageSizeString);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		Page<User> page = userService.fingPages(pageNo, pageSize, map);
        model.addAttribute("userList", /*userService.findAll()*/page.getList());
        model.addAttribute("page", page);
        model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
        return "user/list";
    }

    @RequiresPermissions("sys:user:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model, HttpServletRequest request) {
        setCommonData(model);
        model.addAttribute("user", new User());
        model.addAttribute("op", "新增");
        model.addAttribute("icon_class", "icon-plus");
        return "user/edit";
    }

    
    @RequiresPermissions("sys:user:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(User user, RedirectAttributes redirectAttributes) {
        userService.createUser(user);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return "redirect:/user";
    }

    @RequiresPermissions("sys:user:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        setCommonData(model);
        model.addAttribute("user", userService.findOne(id));
        model.addAttribute("op", "修改");
        model.addAttribute("icon_class", "icon-edit");
        return "user/edit";
    }

    @RequiresPermissions("sys:user:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(User user, RedirectAttributes redirectAttributes) {
        userService.updateUser(user);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return "redirect:/user";
    }

    
    @RequiresPermissions("sys:user:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String showDeleteForm(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
    	userService.deleteUser(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return "redirect:/user";
    }

    @RequiresPermissions("sys:user:update")
    @RequestMapping(value = "/{id}/changePassword", method = RequestMethod.GET)
    public String showChangePasswordForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("user", userService.findOne(id));
        model.addAttribute("op", "修改密码");
        model.addAttribute("icon_class", "icon-edit");
        return "user/changePassword";
    }

    @RequiresPermissions("sys:user:update")
    @RequestMapping(value = "/{id}/changePassword", method = RequestMethod.POST)
    public String changePassword(@PathVariable("id") Long id, String newPassword, RedirectAttributes redirectAttributes) {
        userService.changePassword(id, newPassword);
        redirectAttributes.addFlashAttribute("msg", "修改密码成功");
        return "redirect:/user";
    }

    private void setCommonData(Model model) {
        model.addAttribute("roleList", roleService.findAll());
    }
}
