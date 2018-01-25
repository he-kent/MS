package com.hwq.msonline.entity;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class NavMenu {
    private Integer id;
    private String menuName;
    private String menuUrl;
    private String menuStatus;
    private Date   createTime;
    private Date updateTime;
    private Integer pid ;
    private List<Map<String,Object>>childrenMenu;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public String getMenuStatus() {
		return menuStatus;
	}
	public void setMenuStatus(String menuStatus) {
		this.menuStatus = menuStatus;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public List<Map<String, Object>> getChildrenMenu() {
		return childrenMenu;
	}
	public void setChildrenMenu(List<Map<String, Object>> childrenMenu) {
		this.childrenMenu = childrenMenu;
	}
	@Override
	public String toString() {
		return "NavMenu [id=" + id + ", menuName=" + menuName + ", menuUrl="
				+ menuUrl + ", menuStatus=" + menuStatus + ", createTime="
				+ createTime + ", updateTime=" + updateTime + ", pid=" + pid
				+ ", childrenMenu=" + childrenMenu + "]";
	}
    
    
}
