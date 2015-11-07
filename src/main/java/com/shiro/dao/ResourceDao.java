package com.shiro.dao;

import java.util.List;

import com.shiro.model.Resource;

/**
 * @author 1904
 * @version V1.0
 * @Date 2015年6月15日 下午7:47:00
 */
public interface ResourceDao {

	/**
	 * 增加资源
	 * 
	 * @param resource
	 * @return
	 */
	public Resource createResource(Resource resource);

	/**
	 * 更新资源
	 * 
	 * @param resource
	 * @return
	 */
	public Resource updateResource(Resource resource);

	/**
	 * 删除资源
	 * 
	 * @param resourceId
	 */
	public void deleteResource(Long resourceId);

	/**
	 * 查找单一资源
	 * 
	 * @param resourceId
	 * @return
	 */
	public Resource findOne(Long resourceId);

	/**
	 * 查找全部资源
	 * 
	 * @return
	 */
	public List<Resource> findAll();
	
	
	/**
	 * 查找子菜单
	 * @param parent_id
	 * @return
	 */
	public List<Resource> findMenus(Long parent_id);

}
