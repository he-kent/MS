package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

public interface CostStatDao {
	   /**
     * 按支付方式统计非VIP卡支付的金额 
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
	
}
