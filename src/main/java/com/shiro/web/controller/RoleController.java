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

import com.shiro.model.Role;
import com.shiro.service.ResourceService;
import com.shiro.service.RoleService;
import com.shiro.util.Page;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private ResourceService resourceService;

    @RequiresPermissions("sys:role:view")
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
		Page<Role> page = roleService.fingPages(pageNo, pageSize, map);
        model.addAttribute("roleList", /*roleService.findAll()*/page.getList());
        model.addAttribute("page", page);
        model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
        return "role/list";
    }

    @RequiresPermissions("sys:role:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        setCommonData(model);
        model.addAttribute("role", new Role());
        model.addAttribute("op", "新增");
        model.addAttribute("icon_class", "icon-plus");
        return "role/edit";
    }

    @RequiresPermissions("sys:role:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Role role, RedirectAttributes redirectAttributes) {
        roleService.createRole(role);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return "redirect:/role";
    }

    @RequiresPermissions("sys:role:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        setCommonData(model);
        model.addAttribute("role", roleService.findOne(id));
        model.addAttribute("op", "修改");
        model.addAttribute("icon_class", "icon-edit");
        return "role/edit";
    }

    @RequiresPermissions("sys:role:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Role role, RedirectAttributes redirectAttributes) {
        roleService.updateRole(role);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return "redirect:/role";
    }

    @RequiresPermissions("sys:role:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String showDeleteForm(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
    	roleService.deleteRole(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return "redirect:/role";
    }

    private void setCommonData(Model model) {
        model.addAttribute("resourceList", resourceService.findAll());
    }

}
