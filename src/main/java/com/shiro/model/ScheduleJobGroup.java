package com.shiro.model;

import java.io.Serializable;


/**
 * @ClassName ScheduleJobGroup.java
 * @Description 定时器分组
 *
 * @author 1904
 * @version V1.0 
 * @Date 2015年7月22日 下午5:31:24
 */
public class ScheduleJobGroup implements Serializable  {

	private static final long serialVersionUID = 1L;

	private Long scheduleJobGroupId;

	private String scheduleJobGroupName;

	private String scheduleJobGroupDescription;
	
	private Integer status;
	
	private Long createTime;

	public ScheduleJobGroup() {
	}

	public ScheduleJobGroup(Long scheduleJobGroupId) {
		this.scheduleJobGroupId = scheduleJobGroupId;
	}

	public ScheduleJobGroup(Long scheduleJobGroupId, Integer status) {
		this.scheduleJobGroupId = scheduleJobGroupId;
		this.status = status;
	}

	public ScheduleJobGroup(String scheduleJobGroupName) {
		this.scheduleJobGroupName = scheduleJobGroupName;
	}

	public Long getScheduleJobGroupId() {
		return scheduleJobGroupId;
	}

	public void setScheduleJobGroupId(Long scheduleJobGroupId) {
		this.scheduleJobGroupId = scheduleJobGroupId;
	}

	public String getScheduleJobGroupName() {
		return scheduleJobGroupName;
	}

	public void setScheduleJobGroupName(String scheduleJobGroupName) {
		this.scheduleJobGroupName = scheduleJobGroupName;
	}

	public String getScheduleJobGroupDescription() {
		return scheduleJobGroupDescription;
	}

	public void setScheduleJobGroupDescription(
			String scheduleJobGroupDescription) {
		this.scheduleJobGroupDescription = scheduleJobGroupDescription;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	

}
