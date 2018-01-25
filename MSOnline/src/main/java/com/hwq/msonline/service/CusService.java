package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;

public interface CusService extends BaseService {
    /**
     * 客户vip卡消耗合计 (按编号)
     * @param params
     * @return
     */
	List<Map<String, Object>> getCardConsumpList(Map<String, Object> params);
    /**
     * 客户vip卡消耗明细
     * @param params
     * @return
     */
	List<Map<String, Object>> getCardConsumpDetailList(	Map<String, Object> params);

}
