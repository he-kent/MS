package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;
/**
 * 菜单管理Service
 * @author Administrator
 *
 */
public interface MenuService extends BaseService {
	/**
	 * 
	 * @param params
	 * @return 返回左侧导航菜单
	 */
    public List<Map<String,Object>> getNavMenus(Map<String,Object> params);
    /**
     * 
     * @param p  
     * @return 根据菜单ID 查询所有子菜单
     */
    public List<Map<String,Object>>getChildMenu(Map<String, Object> p);
    /**
     * 
     * @param id
     * @return
     * 根据父菜单ID 查询该菜单的子菜单
     */
    public List<Map<String,Object>>getChildMenusByPid(Integer id);
    /**
     * 
     * @param params
     * @return 查询所有菜单
     */
    public List<Map<String,Object>>getAllMenus(Map<String,Object> params);
    /**
     * 
     * 修改菜单状态
     */
	public void updateMenuStatu(Map<String,Object> params);
}
