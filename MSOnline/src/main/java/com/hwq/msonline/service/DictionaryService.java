package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;

public interface DictionaryService extends BaseService {
	public List<Map<String,Object>> getDicByCode(Map<String,Object> params);

	public void updateDicStatus(Map<String, Object> params);
}
