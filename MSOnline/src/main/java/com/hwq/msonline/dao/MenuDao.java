package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseDao;
/**
 * 
 * @author Administrator
 *菜单管理 DAO
 */
public interface MenuDao extends BaseDao {
	/**
	 * 
	 * @param params
	 * @return  返回左侧导航菜单
	 */
    public List<Map<String,Object>> getNavMenus(Map<String,Object> params);
    
    /**
     * 
     * @param params  
     * @return 根据用户 和 父菜单ID 查素有子菜单
     */
    public List<Map<String,Object>>getChildMenu(Map<String, Object> params);
    
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
     * @param id
     * @param statu
     * 修改菜单状态
     */
	public void updateMenuStatu(Map<String,Object> params);
	
}
