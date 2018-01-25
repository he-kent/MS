package com.hwq.msonline.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwq.msonline.dao.CostStatDao;
import com.hwq.msonline.service.CostStatService;
@Service("costStatService")
public class CostStatServiceImpl implements CostStatService {
	@Autowired
    private CostStatDao costStatDao;
	@Override
	public List<Map<String, Object>> getCostStatList(Map<String, Object> params) {
		List<Map<String, Object>> costStatList = costStatDao.getCostStatList(params);
		return costStatList;
	}
	@Override
	public List<Map<String, Object>> getCostCardStatList(
			Map<String, Object> params) {
		List<Map<String, Object>> costCardStatList = costStatDao.getCostCardStatList(params);
		return costCardStatList;
	}
	@Override
	public Map<String, Object> getMoneyAndCount(Map<String, Object> params) {
		Map<String, Object> result = new HashMap<String,Object>();
		List<Map<String, Object>> costCardStatList = getCostCardStatList(params);//VIP 支付次数
		result.put("payCount", costCardStatList);
		List<Map<String, Object>> costStatList = getCostStatList(params);//非VIP 支付数据
		result.put("payCost", costStatList);
		return result;
	}
	@Override
	public List<Map<String, Object>> getHandleCardMoney(Map<String, Object> params) {
		List<Map<String, Object>> handleCardMoney = costStatDao.getHandleCardMoney(params);
		return handleCardMoney;
	}
	@Override
	public List<Map<String, Object>> getHandleCardCount(Map<String, Object> params) {
		List<Map<String, Object>> handleCardCount = costStatDao.getHandleCardCount(params);
		return handleCardCount;
	}
	@Override
	public Map<String, Object> getCardMoneyAndCount(Map<String, Object> params) {
		List<Map<String, Object>> moneyDatas = getHandleCardMoney(params);
		List<Map<String, Object>> countDatas = getHandleCardCount(params);
		Map<String, Object> result = new HashMap<String,Object>();
		result.put("moneyDatas", moneyDatas);
		result.put("countDatas", countDatas);
		return result;
	}

}
