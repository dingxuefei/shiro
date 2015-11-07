package com.shiro.web.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shiro.Constants;
import com.shiro.web.taglib.Functions;



/**
 * @ClassName SessionController.java
 * @Description 在线会话管理
 *
 * @author 1904
 * @version V1.0 
 * @Date 2015年6月24日 下午3:41:43
 */
@Controller
@RequestMapping("/sessions")
public class SessionMonitorController {
	@Autowired
	private SessionDAO sessionDAO;

	
	@RequiresPermissions("sys:session:view")
	@RequestMapping()
	public String list(Model model) {
		List<Session> sessions = new ArrayList<Session>();
		Collection<Session> sessiondao = sessionDAO.getActiveSessions();  //获取所有活跃会话集合
		for(Session session : sessiondao){
			String username = Functions.principal(session);
			if(session.getAttribute(Constants.SESSION_FORCE_LOGOUT_KEY) != null || username == null){
				continue;
			}
			sessions.add(session);
		}
		model.addAttribute("sessions", sessions);
		model.addAttribute("sessionCount", sessions.size());
		return "sessions/list";
	}

	
	@RequiresPermissions("sys:session:forceLogout")
	@RequestMapping("/{sessionId}/forceLogout")
	public String forceLogout(@PathVariable("sessionId") String sessionId, RedirectAttributes redirectAttributes) {
		try {
			Session session = sessionDAO.readSession(sessionId);
			if (session != null) {
				session.setAttribute(Constants.SESSION_FORCE_LOGOUT_KEY, Boolean.TRUE);
			}
		} catch (Exception e) {
		}
		redirectAttributes.addFlashAttribute("msg", "强制退出成功！");
		return "redirect:/sessions";
	}
}