package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;
import com.hwq.msonline.entity.MenuTree;

/**
 * role service interface
 * @author Administrator
 *
 */
public interface RoleService extends BaseService {
     /**
      * 修改角色状态
      * @param params
      */
	public void updateRoleStatus(Map<String, Object> params);
	public List<MenuTree> getMenuTree(Integer roleId);
	/**
	 * 
	 * @param roleId
	 * @return
	 * 用 roleId　查询角色的所有菜单
	 */
	public List<Integer> getRoleMenus(Integer roleId);
	/**
	 * 
	 * @param params
	 * 保存角色权限
	 */
	public void savePermission(Map<String, Object> params);
}
