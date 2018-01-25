package com.hwq.msonline.dao;

import java.util.Map;

import com.hwq.msonline.comms.BaseDao;

public interface TreatmentCostDao extends BaseDao {
	/**
	 * 添加用户卡消耗记录（病历支付）
	 * @param params
	 */
    public void addCardConsumption(Map<String,Object> params);
    /**
     *该方法中 包含两个功能 
     *1.调用update 方法修改费用支付表
     *2.调用addCardConsumptiion 方法添加用户卡消耗记录
     * @param params
     */
    public void addAndUpdate(Map<String,Object> params);
}
