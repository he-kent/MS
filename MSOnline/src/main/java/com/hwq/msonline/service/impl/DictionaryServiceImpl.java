package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.DictionaryDao;
import com.hwq.msonline.service.DictionaryService;
@Service("dictionaryService")
public class DictionaryServiceImpl implements DictionaryService {
	 @Autowired
     private DictionaryDao dictionaryDao;
	@Override
	public void add(Map<String, Object> params) {
		dictionaryDao.add(params);
	}

	@Override
	public void delete(Map<String, Object> params) {
		dictionaryDao.delete(params);
	}

	@Override
	public void update(Map<String, Object> params) {
		dictionaryDao.update(params);

	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = dictionaryDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = dictionaryDao.getDateById(id);
		return dateById;
	}

	@Override
	public List<Map<String, Object>> getDicByCode(Map<String, Object> params) {
		List<Map<String, Object>> dicByCode = dictionaryDao.getDicByCode(params);
		return dicByCode;
	}

	@Override
	public void updateDicStatus(Map<String, Object> params) {
		dictionaryDao.updateDicStatus(params);
	}

}
