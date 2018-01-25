package com.hwq.msonline.dao;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseDao;
/**
 * 字典维护
 * @author Administrator
 *
 */
public interface DictionaryDao extends BaseDao {
    
	public List<Map<String,Object>> getDicByCode(Map<String,Object> params);

	public void updateDicStatus(Map<String, Object> params);

}
