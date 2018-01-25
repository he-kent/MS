package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.AccountDao;
import com.hwq.msonline.service.AccountService;
@Service("accountService")
public class AccountServiceImpl implements AccountService {
	 @Autowired
     private AccountDao accountDao;
	@Override
	public void add(Map<String, Object> params) {
		accountDao.add(params);
	}

	@Override
	public void delete(Map<String, Object> params) {
		accountDao.delete(params);
	}

	@Override
	public void update(Map<String, Object> params) {
		accountDao.update(params);
	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = accountDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = accountDao.getDateById(id);
		return dateById;
	}

	@Override
	public List<Map<String, Object>> getAccStat(Map<String, Object> params) {
		List<Map<String, Object>> datas=accountDao.getAccStat(params);
		return datas;
	}

}
