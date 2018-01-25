package com.hwq.msonline.dao;

import java.util.Map;

import com.hwq.msonline.comms.BaseDao;

public interface CusCaseDao extends BaseDao {
	public int addCase(Map<String, Object> params);

}
