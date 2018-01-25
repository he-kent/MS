package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseDao;
import com.hwq.msonline.entity.MenuTree;

/**
 * 
 * @author Administrator
     角色Dao 接口
 */

public interface RoleDao extends BaseDao {
    
    /**
     * @param params
     * 修改角色状态
     */
	public void updateRoleStatus(Map<String, Object> params);
	
	public List<MenuTree> getMenuTree();
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
	 * 保存用户角色
	 */
	public void savePermission(Map<String, Object> params);
	/**
	 * 删除角色权限
	 * @param params
	 */
	public void deleteRoleMenus(Map<String, Object> params);
}
