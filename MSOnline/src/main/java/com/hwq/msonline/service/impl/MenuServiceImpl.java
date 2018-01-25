package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.MenuDao;
import com.hwq.msonline.service.MenuService;
@Service("menuService")
public class MenuServiceImpl implements MenuService {
	
	 @Autowired
	 private MenuDao menuDao;
	 
	@Override
	public void add(Map<String, Object> params) {
		menuDao.add(params);

	}

	@Override
	public void delete(Map<String, Object> params) {
		menuDao.delete(params);

	}

	@Override
	public void update(Map<String, Object> params) {
		menuDao.update(params);

	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = menuDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = menuDao.getDateById(id);
		return dateById;
	}

	@Override
	public List<Map<String, Object>> getNavMenus(Map<String, Object> params) {
		List<Map<String, Object>> navMenus = menuDao.getNavMenus(params);
		return navMenus;
	}

	@Override
	public List<Map<String, Object>> getChildMenu(Map<String,Object> params) {
		List<Map<String, Object>> childMenu = menuDao.getChildMenu(params);
		return childMenu;
	}

	@Override
	public List<Map<String, Object>> getChildMenusByPid(Integer id) {
		List<Map<String, Object>> childMenusByPid = menuDao.getChildMenusByPid(id);
		return childMenusByPid;
	}

	@Override
	public List<Map<String, Object>> getAllMenus(Map<String, Object> params) {
		List<Map<String, Object>> allMenus = menuDao.getAllMenus(params);
		return allMenus;
	}

	@Override
	public void updateMenuStatu(Map<String,Object> params) {
		menuDao.updateMenuStatu(params);
		
	}

}
