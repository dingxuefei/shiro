package com.shiro.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shiro.dao.OperationLogDao;
import com.shiro.model.OperationLog;
import com.shiro.service.OperationLogService;
import com.shiro.util.Page;

@Service
public class OperationLogServiceImpl implements OperationLogService {

	@Autowired
	private OperationLogDao operationLogDao;

	@Override
	public OperationLog insert(OperationLog operation) {
		return operationLogDao.insert(operation);
	}

	@Override
	public void del(Long id) {
		operationLogDao.del(id);
	}

	@Override
	public List<OperationLog> findOperations(Map<String, String> map) {
		return operationLogDao.findOperations(map);
	}

	@Override
	public OperationLog getOperationLog(Long id) {
		return operationLogDao.getOperationLog(id);
	}

	@Override
	public Page<OperationLog> fingPages(int pageNo, int pageSize, Map<String, String> map) {
		return operationLogDao.fingPages(pageNo, pageSize, map);
	}

}
