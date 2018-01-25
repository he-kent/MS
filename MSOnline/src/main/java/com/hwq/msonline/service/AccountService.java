package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;

public interface AccountService extends BaseService {
   
	/**
	 * 店铺费用统计
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getAccStat(Map<String, Object> params);

}
