package com.hwq.msonline.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.VipCardService;
import com.hwq.msonline.util.MsStringUtil;

@Controller
@RequestMapping(value="/card")
public class VipCardAction {
  private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  @Autowired
  private VipCardService vipCardService;
  
  @RequestMapping(value="/toCardPage")
  public String toCardPage(HttpServletRequest req){
	  return "vipcard/cardList";
  }
  @ResponseBody
  @RequestMapping(value="/getCardList")
  public Map<String,Object> getCardList(HttpServletRequest req){
	  Map<String, Object> params;
	  Map<String,Object> resultMap = new HashMap<String,Object>();
	  String cardname = req.getParameter("cardname");
	try {
		   params = new HashMap<String,Object>();
		   if(!MsStringUtil.isEmpty(cardname)){
				  params.put("cardname", cardname);
			  }
		  List<Map<String, Object>> dates = vipCardService.getDates(params);
		  resultMap.put("dates", dates);
	} catch (Exception e) {
		e.printStackTrace();
		resultMap.put("msg", "查询异常！");
		return resultMap;
	}
	return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/addCard")
  public Map<String,Object>addCard(HttpServletRequest req,HttpServletResponse res){
	  Map<String,Object> resultMap = new HashMap<String,Object>();
	  try {
		  String cardName=req.getParameter("cardName");
		  String validNum = req.getParameter("validNum");
		  String expiryTime=req.getParameter("expiryTime");
		  String cardStatus=req.getParameter("cardStatus");
		  //String cardType=req.getParameter("cardType");
		  String cardAmount=req.getParameter("cardAmount");
		 /* String cardNumber=req.getParameter("cardNumber");*/
		  String cardNote=req.getParameter("cardNote");
		  Date createtime = new Date();
		  Date updatetime = new Date();
		  Map<String,Object> params = new HashMap<String,Object>();
		  params.put("cardName", cardName);
		  params.put("validNum", validNum);
		  params.put("cardStatus",cardStatus);
		 // params.put("cardType", cardType);
		  params.put("cardAmount", cardAmount);
		  /*params.put("cardNumber", cardNumber);*/
		  params.put("cardNote", cardNote);
		  params.put("createtime", createtime);
		  params.put("updatetime", updatetime);
		  if(null != expiryTime && !"".equals(expiryTime)){
			  params.put("expiryTime",  sdf.parse(expiryTime));
		  }
		  vipCardService.add(params);
		  resultMap.put("msg", 1);
	} catch (Exception e) {
		e.printStackTrace();
		resultMap.put("msg", 0);
	}
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping(value="/deleteCard")
  public Map<String,Object>deleteCard(HttpServletRequest req){
	  Map<String,Object> resultMap = new HashMap<String,Object>();
	  try {
		  String idStr = req.getParameter("id");
		  if(!MsStringUtil.isEmpty(idStr)){
			  HashMap<String, Object> params = new HashMap<String,Object>();
			  params.put("id", Integer.valueOf(idStr));
			  vipCardService.delete(params);
		  }
		  resultMap.put("msg", 1);
	} catch (Exception e) {
		e.printStackTrace();
		resultMap.put("msg", 0);
	}
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping(value="/updateCardStatus")
  public Map<String,Object>updateCardStatus(HttpServletRequest req){
	  Map<String,Object> resultMap = new HashMap<String,Object>();
	  try {
		String idStr = req.getParameter("id");
		String statusStr = req.getParameter("status");
		Map<String,Object> params = new HashMap<String,Object>();
	    if(!MsStringUtil.isEmpty(idStr)){
	    	params.put("id", Integer.valueOf(idStr));
	    }
	    if(!MsStringUtil.isEmpty(statusStr)){
	    	params.put("status", Integer.valueOf(statusStr));
	    }
	    vipCardService.updateCardStatus(params);
	    resultMap.put("msg", 1);
	} catch (Exception e) {
		e.printStackTrace();
		resultMap.put("msg", 0);
	}
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping(value="/updateCard")
  public Map<String,Object>updateCard(HttpServletRequest req){
	  Map<String,Object> resultMap = new HashMap<String,Object>();
	  try {
		  String cardName=req.getParameter("cardName");
		  String validNum = req.getParameter("validNum");
		  String expiryTime=req.getParameter("expiryTime");
		  String cardStatus=req.getParameter("cardStatus");
		  String cardType=req.getParameter("cardType");
		  String cardAmount=req.getParameter("cardAmount");
		  String cardNote=req.getParameter("cardNote");
		  String idStr = req.getParameter("id");
		  Date updatetime = new Date();
		  Map<String,Object> params = new HashMap<String,Object>();
		  params.put("id", Integer.valueOf(idStr));
		  params.put("expiryTime",sdf.parse(expiryTime));
		  params.put("cardName", cardName);
		  params.put("validNum", Integer.valueOf(validNum));
		  params.put("cardStatus",Integer.valueOf(cardStatus));
		  params.put("cardType", Integer.valueOf(cardType));
		  params.put("cardAmount", cardAmount);
		  params.put("cardNote", cardNote);
		  params.put("updatetime", updatetime);
		  vipCardService.update(params);
		  resultMap.put("msg", 1);
	} catch (Exception e) {
		e.printStackTrace();
		 resultMap.put("msg", 0);
	}
	  return  resultMap;
  }
  @ResponseBody
  @RequestMapping(value="/getDateById")
  public Map<String,Object>getDateById(HttpServletRequest req){
	  String idStr = req.getParameter("id");
	  try {
		  if(MsStringUtil.isEmpty(idStr)){
			  return null;
		  }else{
			  Map<String, Object> card = vipCardService.getDateById(Integer.valueOf(idStr));
			  return card;
		  }
	} catch (Exception e) {
		e.printStackTrace();
		return null;
	}
  }
  @ResponseBody
  @RequestMapping(value="/getEffectiveCard")
  public List<Map<String,Object>>getEffectiveCard(HttpServletRequest req,Integer cardStatus){
	  List<Map<String,Object>> effectiveCard = vipCardService.getEffectiveCard(cardStatus);
	  return effectiveCard;
	  
  }
}
