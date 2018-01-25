package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.VipCardDao;
import com.hwq.msonline.service.VipCardService;

@Service("vipCardService")
public class VipCardServiceImpl implements VipCardService {
	 @Autowired
     private VipCardDao vipCardDao;
	@Override
	public void add(Map<String, Object> params) {
		vipCardDao.add(params);
	}

	@Override
	public void delete(Map<String, Object> params) {
		vipCardDao.delete(params);

	}

	@Override
	public void update(Map<String, Object> params) {
		vipCardDao.update(params);

	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = vipCardDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = vipCardDao.getDateById(id);
		return dateById;
	}

	@Override
	public void updateCardStatus(Map<String, Object> params) {
		vipCardDao.updateCardStatus(params);
		
	}

	@Override
	public List<Map<String, Object>> getEffectiveCard(Integer status) {
		List<Map<String, Object>> effectiveCard = vipCardDao.getEffectiveCard(status);
		return effectiveCard;
	}

}
