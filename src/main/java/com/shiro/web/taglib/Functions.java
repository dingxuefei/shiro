package com.shiro.web.taglib;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.util.CollectionUtils;

import com.shiro.Constants;
import com.shiro.model.Resource;
import com.shiro.model.Role;
import com.shiro.model.ScheduleJobGroup;
import com.shiro.model.User;
import com.shiro.service.ResourceService;
import com.shiro.service.RoleService;
import com.shiro.service.ScheduleJobGroupService;
import com.shiro.service.ScheduleJobService;
import com.shiro.service.UserService;
import com.shiro.util.SpringUtils;

import java.util.Collection;



@SuppressWarnings("all")
public class Functions {

    public static boolean in(Iterable iterable, Object element) {
        if(iterable == null) {
            return false;
        }
        return CollectionUtils.contains(iterable.iterator(), element);
    }

    
    public static String principal(Session session) {
        PrincipalCollection principalCollection = (PrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
        if(principalCollection != null)
        	return (String)principalCollection.getPrimaryPrincipal();
        else
        	return null;
    }
    
    
    public static boolean isForceLogout(Session session) {
        return session.getAttribute(Constants.SESSION_FORCE_LOGOUT_KEY) != null;
    }

    
    /**
     * 根据ID显示角色名
     * @param roleId
     * @return
     */
    public static String roleName(Long roleId) {
        Role role = getRoleService().findOne(roleId);
        if(role == null) {
            return "";
        }
        return role.getDescription();
    }

    
    /**
     * 根据id列表显示多个角色名称
     * @param roleIds
     * @return
     */
    public static String roleNames(Collection<Long> roleIds) {
        if(CollectionUtils.isEmpty(roleIds)) {
            return "";
        }

        StringBuilder s = new StringBuilder();
        for(Long roleId : roleIds) {
            Role role = getRoleService().findOne(roleId);
            if(role == null) {
                return "";
            }
            s.append(role.getDescription());
            s.append(",");
        }

        if(s.length() > 0) {
            s.deleteCharAt(s.length() - 1);
        }

        return s.toString();
    }
    
    
    /**
     * 根据id显示资源名称
     * @param resourceId
     * @return
     */
    public static String resourceName(Long resourceId) {
        Resource resource = getResourceService().findOne(resourceId);
        if(resource == null) {
            return "";
        }
        return resource.getName();
    }
    
    
    /**
     * 根据id列表显示多个资源名称
     * @param resourceIds
     * @return
     */
    public static String resourceNames(Collection<Long> resourceIds) {
        if(CollectionUtils.isEmpty(resourceIds)) {
            return "";
        }

        StringBuilder s = new StringBuilder();
        for(Long resourceId : resourceIds) {
            Resource resource = getResourceService().findOne(resourceId);
            if(resource == null) {
                return "";
            }
            s.append(resource.getName());
            s.append(",");
        }

        if(s.length() > 0) {
            s.deleteCharAt(s.length() - 1);
        }

        return s.toString();
    }

    
    /**
     * 根据分组ID显示分组名称
     * @param scheduleJobGroupId
     * @return
     */
    public static String scheduleJobGroupName(Long scheduleJobGroupId){
    	ScheduleJobGroup scheduleJobGroup = getScheduleJobGroupService().getScheduleJobGroup(scheduleJobGroupId);
        if(scheduleJobGroup == null) {
            return "";
        }
        return scheduleJobGroup.getScheduleJobGroupName();
    }
    
    
    /**
     * 根据用户ID显示用户名
     * @param userId
     * @return
     */
    public static String userName(Long userId){
    	User user = getUserService().findOne(userId);
    	if(user == null){
    		return "";
    	}
    	return user.getUsername();
    }

    
    private static RoleService roleService;
    private static ResourceService resourceService;
    private static ScheduleJobGroupService scheduleJobGroupService;
    private static UserService userService;

    public static RoleService getRoleService() {
        if(roleService == null) {
            roleService = SpringUtils.getBean(RoleService.class);
        }
        return roleService;
    }

    public static ResourceService getResourceService() {
        if(resourceService == null) {
            resourceService = SpringUtils.getBean(ResourceService.class);
        }
        return resourceService;
    }
    
    public static ScheduleJobGroupService getScheduleJobGroupService() {
        if(scheduleJobGroupService == null) {
        	scheduleJobGroupService = SpringUtils.getBean(ScheduleJobGroupService.class);
        }
        return scheduleJobGroupService;
    }
    
    public static UserService getUserService(){
    	if(userService == null){
    		userService = SpringUtils.getBean(UserService.class);
    	}
    	return userService;
    }
}
