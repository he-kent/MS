package com.hwq.msonline.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.TreatmentCostDao;
import com.hwq.msonline.service.TreatmentCostService;
@Service("treatmentCostService")
public class TreatmentCostServiceImpl implements TreatmentCostService {
	@Autowired
	private TreatmentCostDao treatmentCostDao;
	
	@Override
	public void add(Map<String, Object> params) {
		treatmentCostDao.add(params);

	}

	@Override
	public void delete(Map<String, Object> params) {
		treatmentCostDao.delete(params);

	}

	@Override
	public void update(Map<String, Object> params) {
		treatmentCostDao.update(params);

	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = treatmentCostDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = treatmentCostDao.getDateById(id);
		return dateById;
	}

	@Override
	public void addCardConsumption(Map<String, Object> params) {
		treatmentCostDao.addCardConsumption(params);
		
	}

	@Override
	public void addAndUpdate(Map<String, Object> params) {
		String payType=(String) params.get("payType");
		if("1".equals(payType)){//如果是使用卡支付 ，则更新费用支付表 并 在卡消耗表中添加记录
			update(params);
			addCardConsumption(params);
		}else{
			update(params);
		}
		
		
	}

}
