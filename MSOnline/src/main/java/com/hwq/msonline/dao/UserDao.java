package com.hwq.msonline.dao;

import java.util.Map;

import com.hwq.msonline.comms.BaseDao;

/**
 * 
 * @author Administrator
      �û��ӿ�
 */

public interface UserDao extends BaseDao {
    public Map<String,Object> getUserByName(String username);
    
    /**
     * @param params
     * 修改用户状态
     */
	public void updateUserStatus(Map<String, Object> params);
    
	/**
	 * 修改用户 角色
	 * @param params
	 */
	public void updateUserRole(Map<String, Object> params);
}
