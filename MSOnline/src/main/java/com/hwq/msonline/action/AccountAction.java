package com.hwq.msonline.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.AccountService;
import com.hwq.msonline.util.ConvertReqToMap;
import com.hwq.msonline.util.DateFormatUtil;
import com.hwq.msonline.util.MsStringUtil;

@Controller
@RequestMapping(value="/account")
public class AccountAction {
	 @Autowired
     private AccountService  accountService;
	@RequestMapping(value="/companyAccPage")
	public String toAccountPage(HttpServletRequest req){
		return "account/companyAccList";
	}
	@ResponseBody
	@RequestMapping(value="accountList")
	public Map<String,Object>accountList(HttpServletRequest req){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			Map<String,Object> params = new HashMap<String,Object>();
			String accType= req.getParameter("accType");
			if(!MsStringUtil.isEmpty(accType)){
				params.put("accType", Integer.valueOf(accType));
			}
			String accTimeStart=req.getParameter("startAccTime");
			if(!MsStringUtil.isEmpty(accTimeStart)){
				params.put("start", DateFormatUtil.formatDate(accTimeStart+" 00:00:00", "yyyy-MM-dd HH:mm:ss"));
			}
			String accTimeEnd=req.getParameter("endAccTime");
			if(!MsStringUtil.isEmpty(accTimeEnd)){
				params.put("end", DateFormatUtil.formatDate(accTimeEnd+" 23:59:59", "yyyy-MM-dd HH:mm:ss"));
			}
			List<Map<String, Object>> dates = accountService.getDates(params);
			resultMap.put("dates", dates);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	@ResponseBody
	@RequestMapping("/addAccount")
	public Map<String,Object>addAccount(HttpServletRequest req){
		Map<String,Object> msg=new HashMap<String,Object>();
		try {
			Map<String, Object> params = ConvertReqToMap.getParameterMap(req);
			params.put("accTime", new Date());
			accountService.add(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	/**
	 * 店铺费用统计
	 */
	@ResponseBody
	@RequestMapping(value="accountStatList")
	public Map<String,Object>accountStatList(HttpServletRequest req){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			Map<String,Object> params = new HashMap<String,Object>();
			String accType= req.getParameter("accType");
			if(!MsStringUtil.isEmpty(accType)){
				params.put("accType", Integer.valueOf(accType));
			}
			String accTimeStart=req.getParameter("startAccTime");
			if(!MsStringUtil.isEmpty(accTimeStart)){
				params.put("start", DateFormatUtil.formatDate(accTimeStart+" 00:00:00", "yyyy-MM-dd HH:mm:ss"));
			}
			String accTimeEnd=req.getParameter("endAccTime");
			if(!MsStringUtil.isEmpty(accTimeEnd)){
				params.put("end", DateFormatUtil.formatDate(accTimeEnd+" 23:59:59", "yyyy-MM-dd HH:mm:ss"));
			}
			List<Map<String, Object>> dates = accountService.getAccStat(params);
			resultMap.put("dates", dates);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	@RequestMapping(value="/companyCostStat")
    public String companyCostStat(HttpServletRequest req){
    	return "account/accCostStatList";
    }
}
