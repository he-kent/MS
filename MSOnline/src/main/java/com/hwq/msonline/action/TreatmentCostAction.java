package com.hwq.msonline.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.TreatmentCostService;

@Controller
@RequestMapping(value="/treatment")
public class TreatmentCostAction {
	@Autowired
	private TreatmentCostService treatmentCostService;
	 @RequestMapping("/costPage")
     public String treatmentCostPage(HttpServletRequest req){
    	 return "treatment/treatmentCostList";
     }
	 @ResponseBody
	 @RequestMapping("/costList")
	 public Map<String,Object>costList(HttpServletRequest req){
		 Map<String,Object> resultMap = new HashMap<String,Object>();
		 try {
			 Map<String,Object>params= new HashMap<String,Object>();
			 List<Map<String, Object>> dates = treatmentCostService.getDates(params);
			 resultMap.put("dates", dates);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	 }
}
