package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

public interface CostStatService {
    /**
     * 诊疗费用支付分类统计
     * @param params
     * @return
     */
	List<Map<String, Object>> getCostStatList(Map<String, Object> params);
	/**
	 * 按支付方式统计VIP卡支付的次数 
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getCostCardStatList(Map<String, Object> params);
	/**
	 * 合并vip支付 与非VIP支付数据 
	 * @param params
	 * @return
	 */
	Map<String, Object> getMoneyAndCount(Map<String, Object> params);
	
	/**
	 * 按卡类 统计办卡金额 
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getHandleCardMoney(Map<String, Object> params);
	/**
	 * 按卡类 统计办卡次数
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getHandleCardCount(Map<String, Object> params);
	/**
	 * 合并数据 getHandleCardMoney 和  getHandleCardCount
	 * @param params
	 * @return
	 */
	Map<String, Object> getCardMoneyAndCount(Map<String, Object> params);

}
