package com.hwq.msonline.comms;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
/**
 * 
 * @author Administrator
 *  base service
 */
public interface BaseService {
	/**
	 * 
	 * @param params
	 * 
	 */
    public void add(Map<String,Object> params);
    /**
     * 
     * @param params
     */
    public void delete(Map<String,Object> params);
    /**
     * 
     * @param params
     */
    public void update(Map<String,Object> params);
    
    /**
     *
     * @param params
     * @return
     */
    public List<Map<String,Object>> getDates(Map<String,Object> params);
    /**
     *
     * @param id
     * @return
     */
    public Map<String,Object>getDateById(Integer id);
}
