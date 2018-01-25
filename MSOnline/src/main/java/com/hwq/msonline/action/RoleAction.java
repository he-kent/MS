package com.hwq.msonline.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwq.msonline.entity.MenuTree;
import com.hwq.msonline.service.RoleService;


@Controller
@RequestMapping(value="/role")
public class RoleAction {
	
	@Resource(name="roleService")
    private RoleService roleService;
	/**
	 * 
	 * @param model
	 * @return  跳转到角色页面
	 * 
	 */
	@RequestMapping(value="/toRolePage")
	public String toRolePage(Model model){
		return "roleList";
	}
	@ResponseBody
	@RequestMapping("/roleList")
	public Map<String,Object> roleList(HttpServletRequest req ,HttpServletResponse res){
		String rolename = req.getParameter("rolename");
		String statuStr = req.getParameter("status");
		Map<String,Object> params = new HashMap<String,Object>();
		if(null != rolename && !"".equals(rolename)){
			params.put("rolename", rolename);
		}
		if(null != statuStr && !"".equals(statuStr)){
			params.put("status",Integer.valueOf(statuStr));
		}
		List<Map<String, Object>> dates = roleService.getDates(params);
		Map<String,Object>result=new HashMap<String,Object>();
		result.put("datas",dates);
		return result;
	}
	@ResponseBody
	@RequestMapping("/addRole")
	public Map<String,Object>addUser(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String rolename = req.getParameter("rolename");
			String status = req.getParameter("status");
		
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("rolename", rolename);
			params.put("status", Integer.valueOf(status));
			params.put("createtime", new Date());
			params.put("updatetime", new Date());
			roleService.add(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/updateRole")
	public Map<String,Object>updateRole(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			String rolename = req.getParameter("rolename");
			String status = req.getParameter("status");
			
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			params.put("rolename", rolename);
			params.put("status", Integer.valueOf(status));
			params.put("updatetime", new Date());
			roleService.update(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/deleteRole")
	public Map<String,Object>deleteRole(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			roleService.delete(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/updateRoleStatus")
	public Map<String,Object>updateUserStatus(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			String status = req.getParameter("status");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			params.put("status", Integer.valueOf(status));
			roleService.updateRoleStatus(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/getDateById")
	public Map<String,Object>getDateById(HttpServletRequest req){
		String id = req.getParameter("id");
		Map<String, Object> role = roleService.getDateById(Integer.valueOf(id));
		return role;
	}
	
	@ResponseBody
	@RequestMapping("/getMenuTree")
	public List<MenuTree> getMenuTree(HttpServletRequest req){
		String roleIdStr = req.getParameter("roleId");
		Integer roleId =Integer.valueOf(roleIdStr);
		List<MenuTree> menuTree = roleService.getMenuTree(roleId);
		return menuTree;
	}
	@ResponseBody
	@RequestMapping("/savePermission")
	public Map<String,Object>savePermission(HttpServletRequest req,@RequestParam("menuIds")String menuIds){
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String roleIdStr = req.getParameter("roleId");
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("roleId", Integer.valueOf(roleIdStr));
		params.put("menuIds", menuIds);
		try {
			roleService.savePermission(params);
			resultMap.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", 0);
		}
		return resultMap;
		
	}
}
