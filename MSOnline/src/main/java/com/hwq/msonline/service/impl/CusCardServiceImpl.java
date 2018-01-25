package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.CusCardDao;
import com.hwq.msonline.service.CusCardService;
@Service(value="cusCardService")
public class CusCardServiceImpl implements CusCardService {
	@Autowired
    private CusCardDao cusCardDao;
	@Override
	public void add(Map<String, Object> params) {
		cusCardDao.add(params);
	}

	@Override
	public void delete(Map<String, Object> params) {
		cusCardDao.delete(params);
	}

	@Override
	public void update(Map<String, Object> params) {
		cusCardDao.update(params);
	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = cusCardDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = cusCardDao.getDateById(id);
		return dateById;
	}

}
