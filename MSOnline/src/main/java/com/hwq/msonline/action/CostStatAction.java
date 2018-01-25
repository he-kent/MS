package com.hwq.msonline.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.CostStatService;
import com.hwq.msonline.util.DateFormatUtil;
import com.hwq.msonline.util.MsStringUtil;

/**
 * 费用统计 action
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="cost")
public class CostStatAction {
	 @Autowired
	 private CostStatService costStatService;
	 @RequestMapping(value="treatmentCostStat")
     public String treatmentCostStatPage(HttpServletRequest req){
		return "coststat/treatmentCostStat";
     }
	 /**
	  * 诊疗费用支付分类统计
	  * @param req
	  * @return
	  */
	 @ResponseBody
	 @RequestMapping(value="/treatmentCostStatList")
	 public Map<String,Object>treatmentCostStatList(HttpServletRequest req){
		 try {
			 Map<String,Object> params = new HashMap<String,Object>();
			 String start=req.getParameter("start");
			 if(!MsStringUtil.isEmpty(start)){
				 params.put("start", DateFormatUtil.formatDate(start+" 00:00:00", "yyyy-MM-dd HH:mm:ss"));
			 }
			 String end= req.getParameter("end");
             if(!MsStringUtil.isEmpty(end)){
            	 params.put("end", DateFormatUtil.formatDate(end+" 23:59:59", "yyyy-MM-dd HH:mm:ss"));
			 }
			Map<String,Object>datas=costStatService.getMoneyAndCount(params);
			 return datas;
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return null;
		
	 }
	 /**
	  * 按卡类型统计办卡金额 和办卡次数
	  * @param req
	  * @return
	  */
	 @ResponseBody
	 @RequestMapping(value="getCusCardStat")
	 public Map<String,Object>getCusCardStat(HttpServletRequest req){
		 try {
			 Map<String,Object> params = new HashMap<String,Object>();
			 String start=req.getParameter("start");
			 if(!MsStringUtil.isEmpty(start)){
				 params.put("start", DateFormatUtil.formatDate(start+" 00:00:00", "yyyy-MM-dd HH:mm:ss"));
			 }
			 String end= req.getParameter("end");
             if(!MsStringUtil.isEmpty(end)){
            	 params.put("end", DateFormatUtil.formatDate(end+" 23:59:59", "yyyy-MM-dd HH:mm:ss"));
			 }
			 Map<String, Object> cardMoneyAndCount = costStatService.getCardMoneyAndCount(params);
			 return cardMoneyAndCount;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	 }
}
