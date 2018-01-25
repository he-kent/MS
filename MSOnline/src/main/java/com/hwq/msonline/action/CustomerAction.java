package com.hwq.msonline.action;

import java.text.ParseException;
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

import com.hwq.msonline.service.CusCardService;
import com.hwq.msonline.service.CusCaseService;
import com.hwq.msonline.service.CusService;
import com.hwq.msonline.service.TreatmentCostService;
import com.hwq.msonline.util.ConvertReqToMap;
import com.hwq.msonline.util.DateFormatUtil;
import com.hwq.msonline.util.MsStringUtil;

/**
 * 客户维护Action 
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="cus")
public class CustomerAction {
	@Autowired
    private CusService cusService;
	@Autowired
	private CusCardService cusCardService;
	@Autowired
	private CusCaseService cusCaseService;
	@Autowired
	private TreatmentCostService treatmentCostService;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHssmm");
	@RequestMapping(value="/toCustomerPage")
	public String toCustomerPage(){
		return "customer/customerList";
	}
	  @ResponseBody
	  @RequestMapping(value="/getCusList")
	  public Map<String,Object> getCusList(HttpServletRequest req){
		  Map<String, Object> params;
		  Map<String,Object> resultMap = new HashMap<String,Object>();
		  String cusNameOrTel = req.getParameter("cusNameOrTel");
		try {
			   params = new HashMap<String,Object>();
			   if(!MsStringUtil.isEmpty(cusNameOrTel)){
					  params.put("cusNameOrTel", cusNameOrTel);
				  }
			  List<Map<String, Object>> dates = cusService.getDates(params);
			  resultMap.put("dates", dates);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "查询异常！");
			return resultMap;
		}
		return resultMap;
	  }
	  
	  @ResponseBody
	  @RequestMapping(value="/addCus")
	  public Map<String,Object>addCus(HttpServletRequest req){
		  Map<String,Object> resultMap = new HashMap<String,Object>();
		  try {
			  String cusName=req.getParameter("cusName");
			  String cusTel = req.getParameter("cusTel");
			  String cusBirthday = req.getParameter("cusBirthday");
			  String cusSex = req.getParameter("cusSex");
			  String cusAddress = req.getParameter("cusAddress");
			  String cusNote = req.getParameter("cusNote");
			  Date date = new Date();
			  if(MsStringUtil.isEmpty(cusName)){
				  resultMap.put("msg", "客户名称不能为空");
				  return resultMap;
			  }
			  Map<String,Object>params=new HashMap<String,Object>();
			  params.put("cusName", cusName);
			  params.put("cusTel", cusTel);
			  params.put("cusBirthday", cusBirthday);
			  params.put("cusSex", cusSex);
			  params.put("cusAddress", cusAddress);
			  params.put("cusNote", cusNote);
			  params.put("createtime", date);
			  params.put("updatetime",date);
			  cusService.add(params);
			  resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
		  return resultMap;
	  }
	  @ResponseBody
	  @RequestMapping(value="/updateCus")
	  public Map<String,Object>updateCus(HttpServletRequest req){
		  Map<String,Object> resultMap = new HashMap<String,Object>();
		  try {
			  String cusName=req.getParameter("cusName");
			  String cusTel = req.getParameter("cusTel");
			  String cusBirthday = req.getParameter("cusBirthday");
			  String cusSex = req.getParameter("cusSex");
			  String cusAddress = req.getParameter("cusAddress");
			  String cusNote = req.getParameter("cusNote");
			  String cusId = req.getParameter("cusId");
			  Date date = new Date();
			  if(MsStringUtil.isEmpty(cusName)){
				  resultMap.put("msg", "客户名称不能为空");
				  return resultMap;
			  }
			  if(MsStringUtil.isEmpty(cusId)){
				  resultMap.put("msg", "ID为空");
				  return resultMap;
			  }
			  
			  Map<String,Object>params=new HashMap<String,Object>();
			  params.put("id", cusId);
			  params.put("cusName", cusName);
			  params.put("cusTel", cusTel);
			  params.put("cusBirthday", cusBirthday);
			  params.put("cusSex", cusSex);
			  params.put("cusAddress", cusAddress);
			  params.put("cusNote", cusNote);
			  params.put("updatetime", date);
			  cusService.update(params);
			  resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
		  return resultMap;
	  }
	  @ResponseBody
	  @RequestMapping(value="/getCusById")
	  public Map<String,Object> getCusById(HttpServletRequest req){
		  String cusId = req.getParameter("cusId");
		  Map<String, Object> dates =null;
		try {
			   if(!MsStringUtil.isEmpty(cusId)){
				   dates=cusService.getDateById(Integer.valueOf(cusId));
				  }
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return dates;
	  }
	  
	  @ResponseBody
	  @RequestMapping("/addCusCard")
	  public Map<String,Object>addCusCard(HttpServletRequest req){
		  Map<String,Object> msg = new HashMap<String,Object>();
		  try {
			  String cusIdStr = req.getParameter("cusId");
			  String cusName = req.getParameter("cusName");
			  String cusTel = req.getParameter("cusTel");
			  String cardTypeCus = req.getParameter("cardTypeCus");
			  String cardAmount = req.getParameter("cardAmount");
			  String cuscardMoney = req.getParameter("cardMoney");
			  String cardNum = req.getParameter("cardNum");
			  String handlesCard = req.getParameter("handlesCard");
			  String expiryTime = req.getParameter("expiryTime");
			  String handelsNote = req.getParameter("handelsNote");
			  String validNum = req.getParameter("validNum");
			  Date date = new Date();
			  Map<String,Object>params = new HashMap<String,Object>();
			  if(!MsStringUtil.isEmpty(cusIdStr)){
				  params.put("cusId", Integer.valueOf(cusIdStr));
			  }
			     params.put("cusName", cusName);
			     params.put("cusTel", cusTel);
			     params.put("cardType", Integer.valueOf(cardTypeCus));
			     params.put("cardAmount", cardAmount);
			     params.put("cardMoney", cuscardMoney);
			     params.put("handlesCard", handlesCard);
			     params.put("expiryTime", DateFormatUtil.formatDate(expiryTime, "yyyy-MM-dd"));
			     params.put("handelsNote", handelsNote);
			     params.put("createtime", date);
			     params.put("updatetime", date);
			     params.put("handlestime", date);
			     params.put("cardId",Integer.valueOf(cardTypeCus));
			     params.put("cardUseStatus", 1);
			     if(MsStringUtil.isEmpty(cardNum)){
			    	 cardNum ="NO"+sdf.format(new Date());
			    	 params.put("cardNum", cardNum);
			     }else{
			    	 params.put("cardNum",cardNum);
			     }
			     params.put("validNum", validNum);
			     cusCardService.add(params);
			     msg.put("msg", 1);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			msg.put("msg", "格式化数据错误");
			return msg;
		} catch (ParseException e) {
			e.printStackTrace();
			msg.put("msg", "日期转换异常");
			return msg;
		}
		  return msg;
		  
	  }
	  @RequestMapping("/cardListPage")
	  public String cardListPage(HttpServletRequest req){
		  return "customer/cusCardList";
	  }
	  @ResponseBody
	  @RequestMapping("/cusCardList")
	  public Map<String,Object>cusCardList(HttpServletRequest req){
		  Map<String,Object> resutlMap = new HashMap<String,Object>();
		  
		  try {
			  String cusCardNameOrTel = req.getParameter("cusCardNameOrTel");
			  Map<String, Object> params = new HashMap<String,Object>();
			  if(!MsStringUtil.isEmpty(cusCardNameOrTel)){
				  params.put("cusCardNameOrTel", cusCardNameOrTel);
			  }
			  List<Map<String, Object>> dates = cusCardService.getDates(params );
			  resutlMap.put("dates", dates);
		   } catch (Exception e) {
			  e.printStackTrace();
			   resutlMap.put("msg", "查询异常");
		   }
		   return resutlMap;
	}
	@ResponseBody
	@RequestMapping(value="addCusCase")
	public Map<String,Object>addCusCase(HttpServletRequest req){
		 Map<String,Object> resutlMap = new HashMap<String,Object>();
		 try {
			 Map<String,Object> params = ConvertReqToMap.getParameterMap(req);
			 Date date = new Date();
			 params.put("createtime", date);
			 params.put("updatetime", date);
			 params.put("seeDoctorTime", DateFormatUtil.formatDate(String.valueOf(params.get("seeDoctorTime")), "yyyy-MM-dd"));
			 params.put("firstSeeDoctorTime", DateFormatUtil.formatDate(String.valueOf(params.get("firstSeeDoctorTime")), "yyyy-MM-dd"));
			 cusCaseService.addCase(params);
			 resutlMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resutlMap.put("msg", e);
		}
		return resutlMap;
	}
	/**
	 * 病历列表
	 * @param req
	 * @return
	 */
	 @RequestMapping("/cusCasePage")
	  public String cusCasePage(HttpServletRequest req){
		  return "customer/cusCaseList";
	  }
	  @ResponseBody
	  @RequestMapping("/cusCaseList")
	  public Map<String,Object>cusCaseList(HttpServletRequest req){
		  Map<String,Object> resutlMap = new HashMap<String,Object>();
		  
		  try {
			  String cusName = req.getParameter("cusName");
			  String cusTel = req.getParameter("cusTel");
			  Map<String, Object> params = new HashMap<String,Object>();
			  if(!MsStringUtil.isEmpty(cusName)){
				  params.put("cusName", cusName);
			  }
			  if(!MsStringUtil.isEmpty(cusTel)){
				  params.put("cusTel", cusTel);
			  }
			  List<Map<String, Object>> dates = cusCaseService.getDates(params );
			  resutlMap.put("dates", dates);
		   } catch (Exception e) {
			  e.printStackTrace();
			   resutlMap.put("msg", "查询异常");
		   }
		   return resutlMap;
	}
    @ResponseBody
    @RequestMapping(value="/payCase")
	public Map<String,Object>payCase(HttpServletRequest req){
    	Map<String,Object> resultMap=new HashMap<String,Object>();
    	Date date=new Date();
    	try {
			Map<String,Object> params = ConvertReqToMap.getParameterMap(req);
			params.put("payTime",new Date());
			params.put("payStatus", 2);
			params.put("updatetime", date);
			params.put("createtime", date);
			//treatmentCostService.update(params);
			treatmentCostService.addAndUpdate(params);
			resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg",0);
		}
		return resultMap;
	}
    @ResponseBody
    @RequestMapping(value="/cusCaseDetails")
    public Map<String,Object>cusCaseDetails(HttpServletRequest req, Integer caseId){
    	Map<String, Object> dateById = cusCaseService.getDateById(caseId);
    	return dateById;
    }
    /**
     * 跳转到客户卡消耗列表页面
     */
    @RequestMapping(value="/cardConsumptionPage")
    public String toCusConsumptionPage(){
    	return "customer/cardConsumption";
    }
    /**
     * 客户卡消耗列表(按卡编号合计)
     * @param req
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/cardConsumpList")
    public Map<String,Object>cardConsumpList(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		Map<String,Object> params = ConvertReqToMap.getParameterMap(req);
    		List<Map<String,Object>> datas=cusService.getCardConsumpList(params);
    		resultMap.put("datas", datas);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultMap;
    }
    /**
     * 客户卡消耗明细
     * @param req
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/cardConsumpDetailList")
    public Map<String,Object>cardConsumpDetailList(HttpServletRequest req){
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	try {
    		Map<String,Object> params = ConvertReqToMap.getParameterMap(req);
    		List<Map<String,Object>> datas=cusService.getCardConsumpDetailList(params);
    		resultMap.put("datas", datas);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultMap;
    }
    @RequestMapping(value="/cardConsumptionDetail")
    public String cardConsumptionDetailPage(HttpServletRequest req){
    	return "customer/cardConsumptionDetail";
    }
}
