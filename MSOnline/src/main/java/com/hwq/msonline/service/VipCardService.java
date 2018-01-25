package com.hwq.msonline.service;

import java.util.List;
import java.util.Map;

import com.hwq.msonline.comms.BaseService;
/**
 * 会员卡管理
 * @author Administrator
 *
 */
public interface  VipCardService extends BaseService {
/**
 * 修改卡状态
 * @param params
 */
public	void updateCardStatus(Map<String, Object> params);
/**
 * 根据状态查询卡
 */
public List<Map<String, Object>> getEffectiveCard(Integer status);

}
