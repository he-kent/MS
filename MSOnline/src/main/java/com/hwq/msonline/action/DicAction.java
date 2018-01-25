package com.hwq.msonline.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.DictionaryService;
import com.hwq.msonline.util.MsStringUtil;

/**
 * 字典维护
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/dic")
public class DicAction {
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Autowired
    private DictionaryService dictionaryService;
    @RequestMapping(value="/dictionaryPage")
    public String toDictionaryPage(HttpServletRequest req){
    	return "dic/dictionaryList";
    }
    
    @ResponseBody
    @RequestMapping(value="/getDicDates")
    public Map<String,Object> getDicDates(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		String dicCode = req.getParameter("dicCode");
    		String status = req.getParameter("dicStatus");
    		String dicname = req.getParameter("dicname");
    		Map<String,Object> params = new HashMap<String,Object>();
    		if(!MsStringUtil.isEmpty(dicname)){
    			params.put("dicname", dicname);
    		}
    		if(!MsStringUtil.isEmpty(dicCode)){
    			params.put("dicCode", dicCode);
    		}
    		if(!MsStringUtil.isEmpty(status)){
    			params.put("status", Integer.valueOf(status));
    		}
        	List<Map<String, Object>> dates = dictionaryService.getDates(params);
        	resultMap.put("dates", dates);
		} catch (Exception e) {
			e.printStackTrace();
			return resultMap;
		}
    	return resultMap;
    }
    @ResponseBody
    @RequestMapping(value="/addDic")
    public Map<String,Object>addDic(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		//"dicName":dicName,"dicStatus":dicStatus,"dicCode":dicCode,"dicNote":dicNote
    		String  dicName =req.getParameter("dicName");
    		String dicStatus = req.getParameter("dicStatus");
    		String dicCode = req.getParameter("dicCode");
    		String dicNote = req.getParameter("dicNote");
    		Map<String,Object> params = new HashMap<String,Object>();
    		if(!MsStringUtil.isEmpty(dicName)){
    			params.put("dicName", dicName);
    		}
    		if(!MsStringUtil.isEmpty(dicCode)){
    			params.put("dicCode", dicCode);
    		}
    		if(!MsStringUtil.isEmpty(dicNote)){
    			params.put("dicNote", dicNote);
    		}
    		if(!MsStringUtil.isEmpty(dicStatus)){
    			params.put("dicStatus", Integer.valueOf(dicStatus));
    		}
    		params.put("createtime",new Date());
    		params.put("updatetime", new Date());
    		dictionaryService.add(params);
    	    resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
    	return resultMap;
    }
    @ResponseBody
    @RequestMapping(value="/updateDic")
    public Map<String,Object>updateDic(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		String idStr = req.getParameter("id");
    		String  dicName =req.getParameter("dicName");
    		String dicStatus = req.getParameter("dicStatus");
    		String dicCode = req.getParameter("dicCode");
    		String dicNote = req.getParameter("dicNote");
    		Map<String,Object> params = new HashMap<String,Object>();
    		if(!MsStringUtil.isEmpty(idStr)){
    			params.put("id", Integer.valueOf(idStr));
    		}
    		if(!MsStringUtil.isEmpty(dicName)){
    			params.put("dicName", dicName);
    		}
    		if(!MsStringUtil.isEmpty(dicCode)){
    			params.put("dicCode", dicCode);
    		}
    		if(!MsStringUtil.isEmpty(dicNote)){
    			params.put("dicNote", dicNote);
    		}
    		if(!MsStringUtil.isEmpty(dicStatus)){
    			params.put("dicStatus", Integer.valueOf(dicStatus));
    		}
    		params.put("updatetime", new Date());
    		dictionaryService.update(params);
    	    resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
    	return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value="/deleteDic")
    public Map<String,Object>deleteDic(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		String idStr = req.getParameter("id");
    		Map<String,Object> params = new HashMap<String,Object>();
    		if(!MsStringUtil.isEmpty(idStr)){
    			params.put("id", Integer.valueOf(idStr));
    		}
    		dictionaryService.delete(params);
    	    resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
    	return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value="/updateDicStatus")
    public Map<String,Object>updateDicStatus(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		String idStr = req.getParameter("id");
    		String status=req.getParameter("status");
    		Map<String,Object> params = new HashMap<String,Object>();
    		if(!MsStringUtil.isEmpty(idStr)){
    			params.put("id", Integer.valueOf(idStr));
    		}
    		if(!MsStringUtil.isEmpty(status)){
    			params.put("status", Integer.valueOf(status));
    		}
    		dictionaryService.updateDicStatus(params);
    	    resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
    	return resultMap;
    }
    
    
    @ResponseBody
    @RequestMapping(value="/getDicById")
    public Map<String,Object>getDicById(HttpServletRequest req){
    	try {
    		String idStr = req.getParameter("id");
    		Integer id = null;
    		if(!MsStringUtil.isEmpty(idStr)){
    			id=Integer.valueOf(idStr);
    		}
    		Map<String, Object> date = dictionaryService.getDateById(id);
    		return date;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
}
