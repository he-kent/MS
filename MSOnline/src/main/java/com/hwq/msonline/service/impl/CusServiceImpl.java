package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.CusDao;
import com.hwq.msonline.service.CusService;

@Service("cusService")
public class CusServiceImpl implements CusService {
    
	@Autowired
	private CusDao cusDao;
	@Override
	public void add(Map<String, Object> params) {
		cusDao.add(params);
	}

	@Override
	public void delete(Map<String, Object> params) {
		cusDao.delete(params);
	}

	@Override
	public void update(Map<String, Object> params) {
		cusDao.update(params);
	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = cusDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = cusDao.getDateById(id);
		return dateById;
	}

	@Override
	public List<Map<String, Object>> getCardConsumpList(Map<String, Object> params) {
		List<Map<String, Object>> datas=cusDao.getCardConsumpList(params);
		return datas;
	}

	@Override
	public List<Map<String, Object>> getCardConsumpDetailList(Map<String, Object> params) {
		List<Map<String, Object>> datas =cusDao.getCardConsumpDetailList(params);
		return datas;
	}

}
