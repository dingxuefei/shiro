package com.shiro.web.controller;


import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shiro.model.Resource;
import com.shiro.service.ResourceService;

@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @ModelAttribute("types")
    public Resource.ResourceType[] resourceTypes() {
        return Resource.ResourceType.values();
    }

    @RequiresPermissions("sys:resource:view")
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model, HttpServletRequest request) {
        model.addAttribute("resourceList", resourceService.findAll());
        return "resource/list";
    }

    @RequiresPermissions("sys:resource:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") Long parentId, Model model) {
        Resource parent = resourceService.findOne(parentId);
        model.addAttribute("parent", parent);
        Resource child = new Resource();
        child.setParentId(parentId);
        child.setParentIds(parent.makeSelfAsParentIds());
        model.addAttribute("resource", child);
        model.addAttribute("op", "新增子节点");
        model.addAttribute("icon_class", "icon-plus");
        if(parent.getPermission().indexOf("*") != -1){
        	model.addAttribute("permission", parent.getPermission().substring(0, parent.getPermission().indexOf("*")));
        }else{
        	model.addAttribute("permission", parent.getPermission());
        }
        return "resource/edit";
    }

    @RequiresPermissions("sys:resource:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    public String create(Resource resource, RedirectAttributes redirectAttributes) {
        resourceService.createResource(resource);
        redirectAttributes.addFlashAttribute("msg", "新增子节点成功");
        return "redirect:/resource";
    }

    @RequiresPermissions("sys:resource:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("resource", resourceService.findOne(id));
        model.addAttribute("op", "修改");
        model.addAttribute("icon_class", "icon-edit");
        return "resource/edit";
    }

    @RequiresPermissions("sys:resource:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Resource resource, RedirectAttributes redirectAttributes) {
        resourceService.updateResource(resource);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return "redirect:/resource";
    }

    @RequiresPermissions("sys:resource:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        resourceService.deleteResource(id);
        redirectAttributes.addFlashAttribute("msg", "删除成功");
        return "redirect:/resource";
    }


}
