package com.shiro.web.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shiro.model.ScheduleJob;
import com.shiro.model.ScheduleJobGroup;
import com.shiro.service.ScheduleJobGroupService;
import com.shiro.service.ScheduleJobService;
import com.shiro.web.exception.ScheduleException;


@Controller
@RequestMapping("/job")
public class ScheduleJobController {

	@Autowired
	private ScheduleJobService scheduleJobService;
	
	@Autowired
	private ScheduleJobGroupService scheduleJobGroupService;
	
	
	@RequiresPermissions("maintain:job:view")
	@RequestMapping(value="/{active}", method = RequestMethod.GET)
	public String job(Model model, HttpServletRequest request, @PathVariable("active") Integer active){
		model.addAttribute("active",active);
		model.addAttribute("scheduleJobs", scheduleJobService.findAll());
		model.addAttribute("scheduleJobGroups", scheduleJobGroupService.getScheduleJobGroups());
		return "job/list";
	}
	
	
	/**
	 * 添加/修改定时器
	 * @param scheduleJob
	 * @param model
	 * @param request
	 * @return
	 */
	@RequiresPermissions({"maintain:job:create","maintain:job:update"})
	@RequestMapping(value="/createScheduleJob", method = RequestMethod.POST)
	public String createScheduleJob(ScheduleJob scheduleJob, RedirectAttributes redirectAttributes, HttpServletRequest request){
		String id = request.getParameter("id");
		if(StringUtils.isBlank(scheduleJob.getScheduleJobName())){
			throw new DataIntegrityViolationException("定时器名称不能为空");
		}
		if(StringUtils.isBlank(scheduleJob.getScheduleJobCronExpression())){
			throw new DataIntegrityViolationException("表达式不能为空");
		}
		if(StringUtils.isBlank(scheduleJob.getScheduleJobClass())){
			throw new DataIntegrityViolationException("调用类不能为空");
		}
		if(StringUtils.isBlank(scheduleJob.getScheduleJobMethod())){
			throw new DataIntegrityViolationException("调用方法不能为空");
		}
		if(scheduleJob.getScheduleJobGroupId() == null){
			throw new DataIntegrityViolationException("定时器分组不能为空");
		}
		if(StringUtils.isBlank(id)){
			scheduleJob.setCreateTime(new Date().getTime());
			scheduleJob.setStatus(1);
			scheduleJobService.insert(scheduleJob);
			redirectAttributes.addFlashAttribute("msg", "新增定时器成功");
		}else{
			ScheduleJob job = scheduleJobService.getScheduleJob(Long.valueOf(id));
			job.setScheduleJobClass(scheduleJob.getScheduleJobClass());
			job.setScheduleJobCronExpression(scheduleJob.getScheduleJobCronExpression());
			job.setScheduleJobDescription(scheduleJob.getScheduleJobDescription());
			job.setScheduleJobGroupId(scheduleJob.getScheduleJobGroupId());
			job.setScheduleJobMethod(scheduleJob.getScheduleJobMethod());
			job.setScheduleJobName(scheduleJob.getScheduleJobName());
			scheduleJobService.update(job, true);
			redirectAttributes.addFlashAttribute("msg", "修改定时器成功");
		}
		return "redirect:/job/1";
	}
	
	/**
	 * 添加/修改定时器分组
	 * @param scheduleJobGroup
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions({"maintain:job:create","maintain:job:update"})
	@RequestMapping(value="/createScheduleJobGroup", method = RequestMethod.POST)
	public String createScheduleJobGroup(ScheduleJobGroup scheduleJobGroup, RedirectAttributes redirectAttributes, HttpServletRequest request){
		String id = request.getParameter("id");
		if(StringUtils.isBlank(scheduleJobGroup.getScheduleJobGroupName())){
			throw new DataIntegrityViolationException("定时器分组名称不能为空");
		}
		if(StringUtils.isBlank(id)){
			scheduleJobGroup.setCreateTime(new Date().getTime());
			scheduleJobGroup.setStatus(1);
			scheduleJobGroupService.insert(scheduleJobGroup);
			redirectAttributes.addFlashAttribute("msg", "新增定时器分组成功");
		}else{
			ScheduleJobGroup group = scheduleJobGroupService.getScheduleJobGroup(Long.valueOf(id));
			group.setScheduleJobGroupDescription(scheduleJobGroup.getScheduleJobGroupDescription());
			group.setScheduleJobGroupName(scheduleJobGroup.getScheduleJobGroupName());
			scheduleJobGroupService.update(group);
			redirectAttributes.addFlashAttribute("msg", "修改定时器分组成功");
		}
		
		return "redirect:/job/2";
	}
	
	
	
	/**
	 * 删除定时器
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("maintain:job:delete")
    @RequestMapping(value = "/{id}/deleteScheduleJob", method = RequestMethod.GET)
	public String deleteScheduleJob(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		scheduleJobService.delete(scheduleJobService.getScheduleJob(id));
		redirectAttributes.addFlashAttribute("msg", "删除定时器成功");
		return "redirect:/job/1";
	}
	
	
	
	/**
	 * 删除定时器分组
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("maintain:job:delete")
    @RequestMapping(value = "/{id}/deleteScheduleJobGroup", method = RequestMethod.GET)
	public String deleteScheduleJobGroup(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		List<ScheduleJob> scheduleJobs = scheduleJobService.findScheduleJobByGroupId(id);
		if(scheduleJobs.size() != 0){
			throw new ScheduleException("请先删除该分组中的定时任务.");
		}
		scheduleJobGroupService.delete(scheduleJobGroupService.getScheduleJobGroup(id));
		redirectAttributes.addFlashAttribute("msg", "删除定时器分组成功");
		return "redirect:/job/2";
	}
		
	
	/**
	 * 加载添加/编辑定时器页面
	 * @param model
	 * @param req
	 * @return
	 */
	@RequiresPermissions({"maintain:job:create","maintain:job:update"})
	@RequestMapping("/scheduleJobView")
	public String createScheduleJobView(Model model, HttpServletRequest request) throws Exception{
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			model.addAttribute("scheduleJob", scheduleJobService.getScheduleJob(Long.valueOf(id)));
		}
		model.addAttribute("scheduleJobGroups", scheduleJobGroupService.getScheduleJobGroups());
		return "job/scheduleJob";
	}
	
	
	
	/**
	 * 加载添加/编辑定时器分组页面
	 * @param model
	 * @param req
	 * @return
	 */
	@RequiresPermissions({"maintain:job:create","maintain:job:update"})
	@RequestMapping("/scheduleJobGroupView")
	public String createScheduleJobGroupView(Model model, HttpServletRequest request) throws Exception{
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			model.addAttribute("scheduleJobGroup", scheduleJobGroupService.getScheduleJobGroup(Long.valueOf(id)));
		}
		return "job/scheduleJobGroup";
	}
	
	
	/**
	 * 启动定时器
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions({"maintain:job:start","maintain:job:update"})
    @RequestMapping(value = "/{id}/startScheduleJob", method = RequestMethod.GET)
	public String startScheduleJob(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		scheduleJobService.thaw(scheduleJobService.getScheduleJob(id));
		redirectAttributes.addFlashAttribute("msg", "启动定时器成功");
		return "redirect:/job/1";
	}
	
	
	/**
	 * 关闭定时器
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions({"maintain:job:stop","maintain:job:update"})
    @RequestMapping(value = "/{id}/stopScheduleJob", method = RequestMethod.GET)
	public String stopScheduleJob(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		scheduleJobService.congeal(scheduleJobService.getScheduleJob(id));
		redirectAttributes.addFlashAttribute("msg", "关闭定时器成功");
		return "redirect:/job/1";
	}
	
	
	
	/**
	 * 重启定时器
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions({"maintain:job:start","maintain:job:update"})
    @RequestMapping(value = "/{id}/restartScheduleJob", method = RequestMethod.GET)
	public String restartScheduleJob(@PathVariable("id") Long id, RedirectAttributes redirectAttributes){
		scheduleJobService.restart(id);
		redirectAttributes.addFlashAttribute("msg", "重启定时器成功");
		return "redirect:/job/1";
	}
	
	
	/**
	 * 同步所有任务
	 * @return
	 */
	@RequiresPermissions("maintain:job:start")
	@RequestMapping(value="/async")
	public String async(RedirectAttributes redirectAttributes){
		scheduleJobService.async();
		redirectAttributes.addFlashAttribute("msg", "同步所有任务成功");
		return "redirect:/job/1";
	}
	
	/**
	 * 启动/停止定时器分组
	 * @return
	 */
	@RequiresPermissions({"maintain:job:start","maintain:job:update"})
	@RequestMapping(value="/{id}/{status}/updateJobGroupstatus")
	public String updateJobGroupstatus(@PathVariable("id") Long id, @PathVariable("status") Integer status, RedirectAttributes redirectAttributes){
		ScheduleJobGroup scheduleJobGroup = scheduleJobGroupService.getScheduleJobGroup(id);
		if(status == 1){
			redirectAttributes.addFlashAttribute("msg", "停止定时器分组成功");
			List<ScheduleJob> scheduleJobs = scheduleJobService.findScheduleJobByGroupId(id);
			for(ScheduleJob scheduleJob : scheduleJobs){
				scheduleJobService.congeal(scheduleJob);
			}
		}
		if(status == 0){
			redirectAttributes.addFlashAttribute("msg", "启动定时器分组成功");
		}
		scheduleJobGroup.setStatus(status);
		scheduleJobGroupService.update(scheduleJobGroup);
		return "redirect:/job/2";
	}
}
