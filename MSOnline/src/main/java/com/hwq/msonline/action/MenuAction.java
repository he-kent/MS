package com.hwq.msonline.action;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.service.MenuService;
import com.hwq.msonline.util.MsStringUtil;
import com.sun.xml.internal.ws.resources.HttpserverMessages;

/**
 * 
 * @author Administrator
 *�˵�����
 */
@Controller
@RequestMapping("/menu")
public class MenuAction {
	
	@Autowired
     private MenuService menuService;
	 
	 @RequestMapping("/toMenuListPage")
	 public String  toMenuListPage(Model model,HttpServletRequest request,HttpServletResponse response){
		 return "menuList";
	 }
	@ResponseBody
	@RequestMapping("/menuList")
	 public Map<String,Object>getMenuList(Model model,HttpServletRequest request,HttpServletResponse response){
		Map<String,Object>params = new HashMap<String,Object>();
		List<Map<String, Object>> dates = menuService.getAllMenus(params);
		Map<String,Object>resultMap= new HashMap<String,Object>();
		resultMap.put("datas", dates);
		 return resultMap;
	 }
	
	@ResponseBody
	@RequestMapping("/getChildMenusByPid")
	public List<Map<String,Object>> getChildMenusByPid(Model model,HttpServletRequest request,HttpServletResponse response){
		String pidStr = request.getParameter("id");
		if(pidStr.isEmpty()){
			return null;
		}
		Integer pid = Integer.valueOf(pidStr);
		List<Map<String, Object>> dates = menuService.getChildMenusByPid(pid);
		return dates;
	}
	
	/**
	 * 
	 * @param mmodel
	 * @param req
	 * @param res
	 * @return 添加菜单
	 */
	@ResponseBody
	@RequestMapping("/addMenu")
	public Map<String,Object>addMenu(Model mmodel,HttpServletRequest req,HttpServletResponse res){
		Map<String,Object> msg = new HashMap<String,Object>();
	    try {
			String menuName = req.getParameter("menuName");
			String menuUrl = req.getParameter("menuUrl");
			String menuStatuStr = req.getParameter("menuStatu");
			String pidStr = req.getParameter("pid");
			Integer menuStatu= Integer.valueOf(menuStatuStr);
			Integer pid = Integer.valueOf(pidStr);
			Map<String,Object>params = new HashMap<String,Object>();
			params.put("menuName", menuName);
			params.put("menuUrl", menuUrl);
			params.put("menuStatu", menuStatu);
			params.put("pid", pid);
			params.put("createTime", new Date());
			params.put("updateTime", new Date());
			menuService.add(params);
			msg.put("msg", "1");
			return msg;
		} catch (NumberFormatException e) {
			e.printStackTrace();
			msg.put("msg", "0");
			return msg;
		}
	}
	
	@RequestMapping("/updateMenu")
	@ResponseBody
	public Map<String,Object> updateMenu(Model model,HttpServletRequest req,HttpServletResponse response){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String rowId = req.getParameter("rowId");
			Integer id = Integer.valueOf(rowId);
			String menuName = req.getParameter("menuName");
			String menuUrl = req.getParameter("menuUrl");
			String menuStatuStr = req.getParameter("menuStatu");
			String pidStr = req.getParameter("pid");
			Integer menuStatu= Integer.valueOf(menuStatuStr);
			Integer pid = Integer.valueOf(pidStr);
			Map<String,Object>params = new HashMap<String,Object>();
			params.put("id", id);
			params.put("menuName", menuName);
			params.put("menuUrl", menuUrl);
			params.put("menuStatu", menuStatu);
			params.put("pid", pid);
			params.put("updateTime", new Date());
			menuService.update(params);
			msg.put("msg", "1");
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
			return msg;
		}
	}
	
	@RequestMapping("/updateMenuStatu")
	@ResponseBody
	public Map<String,Object>updateMenuStatu(HttpServletRequest req){
		String idStr = req.getParameter("id");
		String statuStr = req.getParameter("statu");
		Integer id = Integer.valueOf(idStr);
		Integer statu= Integer.valueOf(statuStr);
		Map<String,Object>msg=new HashMap<String,Object>();
		try {
			Map<String,Object> params=  new HashMap<String,Object>();
			params.put("id", id);
			params.put("statu", statu);
			menuService.updateMenuStatu(params);
			msg.put("msg", 1);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
            msg.put("msg", 0);
            return msg;
		}
	}
	
	@RequestMapping("/getDateById")
	@ResponseBody
	public Map<String,Object>getDateById(HttpServletRequest req){
		try {
			String idStr = req.getParameter("id");
			if(MsStringUtil.isEmpty(idStr)){
				return null;
			}else{
				Map<String, Object> date = menuService.getDateById(Integer.valueOf(idStr));
				return date;
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return null;
		}
	}
}
