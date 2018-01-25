package com.hwq.msonline.comms;
import java.util.List;
import java.util.Map;
public interface BaseDao {
    public void add(Map<String,Object> params);
    public void delete(Map<String,Object> params);
    public void update(Map<String,Object> params);
    public List<Map<String,Object>> getDates(Map<String,Object> params);
    public Map<String,Object>getDateById(Integer id);
}
