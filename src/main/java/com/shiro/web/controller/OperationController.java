package com.shiro.web.controller;

import java.util.Date;
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

import com.shiro.model.OperationLog;
import com.shiro.service.OperationLogService;
import com.shiro.service.UserService;
import com.shiro.util.Page;
import com.shiro.util.TimeUtil;

@Controller
@RequestMapping("/logs")
public class OperationController {

	@Autowired
	private OperationLogService operationLogService;
	
	@Autowired
	private UserService userService;
	
	
	/**
	 * 操作日志列表
	 * @param model
	 * @param request
	 * @return
	 */
	@RequiresPermissions("sys:log:view")
	@RequestMapping
	public String job(Model model, HttpServletRequest request){
		int pageNo = 1;   
		int pageSize = 20;
		String userName = request.getParameter("userName");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String story = request.getParameter("story");
		String pageNoString = request.getParameter("pageNo");
		String pageSizeString = request.getParameter("pageSize");
		
		if(StringUtils.isNotBlank(pageNoString)){
			pageNo = Integer.valueOf(pageNoString);
		}
		
		if(StringUtils.isNotBlank(pageSizeString)){
			pageSize = Integer.valueOf(pageSizeString);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		if(StringUtils.isBlank(beginTime)){
			beginTime = TimeUtil.getDateToString(new Date(), "yyyy-MM-dd") +" 00:00";
		}
		if(StringUtils.isBlank(endTime)){
			endTime = TimeUtil.getDateToString(new Date(), "yyyy-MM-dd HH:mm");
		}
		if(StringUtils.isNotBlank(userName)){
			if(userService.findByUsername(userName) != null){
				map.put("userId", userService.findByUsername(userName).getId().toString());
			}
		}
		map.put("story", story);
		map.put("beginTime", TimeUtil.getStringToLong(beginTime, "yyyy-MM-dd HH:mm").toString());
		map.put("endTime", TimeUtil.getStringToLong(endTime, "yyyy-MM-dd HH:mm").toString());
		
		model.addAttribute("userName", userName);
		model.addAttribute("beginTime", beginTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("story", story);
		Page<OperationLog> page = operationLogService.fingPages(pageNo, pageSize, map);
		model.addAttribute("logs", page.getList());
		model.addAttribute("page", page);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		return "logs/list";
	}
	
	
	/**
	 * 查看日志详情
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:log:detail")
    @RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
	public String detail(@PathVariable("id") Long id, RedirectAttributes redirectAttributes, Model model){
		model.addAttribute("log", operationLogService.getOperationLog(id));
		return "logs/detail";
	}
	
	
	/**
	 * 删除日志
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:log:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
	public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		operationLogService.del(id);
		redirectAttributes.addFlashAttribute("msg", "删除日志成功");
		return "redirect:/logs";
	}
}
