package com.hwq.msonline.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.CusCaseDao;
import com.hwq.msonline.service.CusCaseService;
import com.hwq.msonline.service.TreatmentCostService;
@Service("cusCaseService")
public class CusCaseServiceImpl implements CusCaseService {
	 @Autowired
     private CusCaseDao cusCaseDao;
	 @Autowired
	 private TreatmentCostService treatmentCostService;
	 public void add(Map<String, Object> params) {
			treatmentCostService.add(params);
		}
	
	public int addCase(Map<String, Object> params) {
		//添加病历
		cusCaseDao.addCase(params);
		//获取添加后的数据id
		long id = (Long)params.get("id");
		
		Map<String,Object> costMap = new HashMap<String,Object>();
		costMap.put("cusCaseId", (int)id);
		costMap.put("treatmentCost", 0);
		costMap.put("payStatus", 1);
		costMap.put("payAmount", 0);
		costMap.put("payType", 0);
		costMap.put("payCardNum", 0);
		costMap.put("payCardType", 0);
		costMap.put("cusId", params.get("cusId"));
		costMap.put("createtime", new Date());
		costMap.put("updatetime", new Date());
		costMap.put("payTime", null);
		//添加病历的同时在费用表中 添加一条未支付  记录
		treatmentCostService.add(costMap);
		return 0;
	}

	@Override
	public void delete(Map<String, Object> params) {
		cusCaseDao.delete(params);
	}

	@Override
	public void update(Map<String, Object> params) {
       cusCaseDao.update(params);
	}

	@Override
	public List<Map<String, Object>> getDates(Map<String, Object> params) {
		List<Map<String, Object>> dates = cusCaseDao.getDates(params);
		return dates;
	}

	@Override
	public Map<String, Object> getDateById(Integer id) {
		Map<String, Object> dateById = cusCaseDao.getDateById(id);
		return dateById;
	}

}
