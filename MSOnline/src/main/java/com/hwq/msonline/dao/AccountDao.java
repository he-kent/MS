package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseDao;

public interface AccountDao extends BaseDao {
    /**
     * 店铺费用统计
     * @param params
     * @return
     */
	List<Map<String, Object>> getAccStat(Map<String, Object> params);

}
