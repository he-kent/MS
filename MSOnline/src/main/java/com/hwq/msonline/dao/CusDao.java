package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseDao;

public interface CusDao extends BaseDao {

	List<Map<String, Object>> getCardConsumpList(Map<String, Object> params);

	List<Map<String, Object>> getCardConsumpDetailList(Map<String, Object> params);

}
