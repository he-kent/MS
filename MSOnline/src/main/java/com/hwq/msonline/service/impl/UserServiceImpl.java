package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.UserDao;
import com.hwq.msonline.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
    private UserDao userDao;
	
	public void add(Map<String, Object> params) {
		userDao.add(params);
	}

	public void delete(Map<String, Object> params) {
		userDao.delete(params);
	}

	public void update(Map<String, Object> params) {
		userDao.update(params);
	}

	public List<Map<String, Object>> getDates(Map<String, Object> params) {
	   List<Map<String, Object>> dates = userDao.getDates(params);
		return dates;
	}

	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = userDao.getDateById(id);
		return dateById;
	}
	public Map<String, Object> getUserByName(String username) {
		Map<String, Object> userByName = userDao.getUserByName(username);
		return userByName;
	}

	@Override
	public void updateUserStatus(Map<String, Object> params) {
		userDao.updateUserStatus(params);
		
	}

	@Override
	public void updateUserRole(Map<String, Object> params) {
		userDao.updateUserRole(params);
		
	}

}
