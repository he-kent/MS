package com.hwq.msonline.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.MenuDao;
import com.hwq.msonline.dao.RoleDao;
import com.hwq.msonline.entity.MenuTree;
import com.hwq.msonline.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {
	
	@Autowired
    private RoleDao roleDao;
	
	@Autowired
	private MenuDao menuDao;
	
	public void add(Map<String, Object> params) {
		roleDao.add(params);
	}

	public void delete(Map<String, Object> params) {
		roleDao.delete(params);
	}

	public void update(Map<String, Object> params) {
		roleDao.update(params);
	}

	public List<Map<String, Object>> getDates(Map<String, Object> params) {
	   List<Map<String, Object>> dates = roleDao.getDates(params);
		return dates;
	}

	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = roleDao.getDateById(id);
		return dateById;
	}
	

	@Override
	public void updateRoleStatus(Map<String, Object> params) {
		roleDao.updateRoleStatus(params);
		
	}

	@Override
	public List<MenuTree> getMenuTree(Integer roleId) {
		List<MenuTree> trees = new ArrayList<MenuTree>();
		//查询权限的菜单
		List<Integer> roleMenusIds = getRoleMenus(roleId);
		//查询所有pid=0 的菜单
		List<Map<String, Object>> allMenus = menuDao.getAllMenus(null);
		for(Map<String,Object>menu:allMenus){
			MenuTree tree = new MenuTree();
			Integer menuId=(Integer) menu.get("id");
			tree.setId(String.valueOf(menuId));
			tree.setText(String.valueOf(menu.get("menuName")));
			tree.setPid((Integer)menu.get("pid"));
			System.out.println(roleMenusIds.contains(menuId));
			if(roleMenusIds.contains(menuId)){
				MenuTree.State state=new MenuTree.State();
				state.setChecked(true);
				state.setSelected(true);
				tree.setState(state);
			}
			List<Map<String, Object>> childMenu = menuDao.getChildMenusByPid((Integer)(menu.get("id")));
			List<MenuTree> childMenuTree = new ArrayList<MenuTree>();
			for(Map<String,Object> child:childMenu){
				MenuTree childNode = new MenuTree();
				Integer childMenuId = (Integer) child.get("id");
				childNode.setId(String.valueOf(childMenuId));
				childNode.setText(String.valueOf(child.get("menuName")));
				childNode.setPid((Integer)child.get("pid"));
				if(roleMenusIds.contains(childMenuId)){
					MenuTree.State state=new MenuTree.State();
					state.setChecked(true);
					state.setSelected(true);
					childNode.setState(state);
				}
				childMenuTree.add(childNode);
				tree.setNodes(childMenuTree);
			}
			trees.add(tree);
		}
		
		return trees;
	}

	@Override
	public List<Integer> getRoleMenus(Integer roleId) {
		List<Integer> roleMenusIds = roleDao.getRoleMenus(roleId);
		return roleMenusIds;
	}

	@Override
	public void savePermission(Map<String, Object> params) {
		//删除角色原来的权限菜单
		roleDao.deleteRoleMenus(params);
		//重新添加角色权限
		roleDao.savePermission(params);
	}

}
