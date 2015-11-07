package com.shiro.dao;

import java.util.List;
import java.util.Map;

import com.shiro.model.OperationLog;
import com.shiro.util.Page;

/**
 * @ClassName OperationDao.java
 * @Description 日志记录
 * 
 * @author 1904
 * @version V1.0
 * @Date 2015年7月25日 下午1:19:12
 */
public interface OperationLogDao {

	/**
	 * 添加记录
	 * 
	 * @param operation
	 * @return
	 */
	public OperationLog insert(OperationLog operation);

	/**
	 * 删除记录
	 * 
	 * @param id
	 */
	public void del(Long id);

	/**
	 * 查询记录
	 * 
	 * @return
	 */
	public List<OperationLog> findOperations(Map<String, String> map);

	/**
	 * 根据ID查找对象
	 * 
	 * @param id
	 * @return
	 */
	public OperationLog getOperationLog(Long id);

	/**
	 * 分页查询
	 * 
	 * @param pageNo 当前页
	 * @param pageSize 每页条数
	 * @param map 参数
	 * @return
	 */
	public Page<OperationLog> fingPages(int pageNo, int pageSize, Map<String, String> map);

}
