package com.hwq.msonline.service;

import java.util.Map;

import com.hwq.msonline.comms.BaseService;

/**
 * user service interface
 * @author Administrator
 *
 */
public interface UserService extends BaseService {
	public Map<String,Object> getUserByName(String username);
     /**
      * 修改用户状态
      * @param params
      */
	public void updateUserStatus(Map<String, Object> params);
	/**
	 * 修改用户角色
	 * @param params
	 */
	public void updateUserRole(Map<String, Object> params);
}
