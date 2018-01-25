package com.hwq.msonline.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.hwq.msonline.entity.NavMenu;
import com.hwq.msonline.service.MenuService;
import com.hwq.msonline.service.UserService;


@Controller
@RequestMapping(value="/user")
public class UserAction {
	
	@Resource(name="userService")
    private UserService userService;
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	@RequestMapping(value="/login")
	public String login(Model model,HttpServletRequest req,HttpServletResponse res){
		String username = req.getParameter("username");
		String pwd = req.getParameter("password");
		Map<String, Object> userMap = userService.getUserByName(username);
		/**
		 * req.getSession() //获取session
		 * req.getSession(boolean create )  
		 *    true :如果没有session 则创建
		 *    false:如果没有session 返回null
		 * SpringMVC Session 工具累 WebUtils.getSessionAttribute(HttpServletRequestrequest, String name) ��ȡ
		 *             WebUtils.setSessionAttribute(HttpServletRequest request, String name, Object value)����ֵ
		 */
		//Boolean bool = userMap.isEmpty();
		if(null != userMap){
			if(pwd.equals(userMap.get("password"))){
				WebUtils.setSessionAttribute(req, "user", userMap);//绑定用户信息到session
				List<Map<String, Object>> navMenus = menuService.getNavMenus(userMap);
				List<NavMenu>result=new ArrayList<NavMenu>();
				if(!navMenus.isEmpty()){
					for(Map<String,Object> menu:navMenus){
						Integer menuId = (Integer) menu.get("id");
						NavMenu navMenu = new NavMenu();
						navMenu.setId(menuId);
						navMenu.setMenuName(menu.get("menuName").toString());
						navMenu.setMenuUrl(null==menu.get("menuUrl")?"":menu.get("menuUrl").toString());
						Map<String,Object> p = new HashMap<String,Object>();
						p.put("userId", userMap.get("id"));
						p.put("menuId", menuId);
						//List<Map<String, Object>>  childMenus = menuService.getChildMenusByPid( (Integer)menu.get("id"));
						List<Map<String, Object>>  childMenus = menuService.getChildMenu(p);
						navMenu.setChildrenMenu(childMenus);
						result.add(navMenu);
					}
				}
				WebUtils.setSessionAttribute(req, "menus", result);
				return "main";
			}else{
				model.addAttribute("msg", "用户名或密码错误");
				return "index";
			}
		}else{
			model.addAttribute("msg", "用户名或密码错误");
			return "index";
		}
	}
	
	/**
	 * 
	 * @param model
	 * @return  跳转到登陆页面
	 * 
	 */
	@RequestMapping(value="/toLogin")
	public String toLogin(Model model){
		return "index";
	}
	@ResponseBody
	@RequestMapping("/userList")
	public Map<String,Object> userList(HttpServletRequest req ,HttpServletResponse res){
		String username = req.getParameter("username");
		Map<String,Object> params = new HashMap<String,Object>();
		if(!username.isEmpty()){
			params.put("username", username);
		}
		List<Map<String, Object>> dates = userService.getDates(params);
		Map<String,Object>result=new HashMap<String,Object>();
		result.put("datas",dates);
		return result;
	}
	@ResponseBody
	@RequestMapping("/addUser")
	public Map<String,Object>addUser(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String username = req.getParameter("username");
			String nickname = req.getParameter("nickname");
			String phone = req.getParameter("phone");
			String status = req.getParameter("status");
			String roleID = req.getParameter("roleID");
			String avatar = req.getParameter("avatar");
			String address = req.getParameter("address");
			String password = req.getParameter("password");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("username", username);
			params.put("nickname", nickname);
			params.put("phone", phone);
			params.put("status", Integer.valueOf(status));
			params.put("roleID", Integer.valueOf(roleID));
			params.put("avatar", avatar);
			params.put("address",address);
			params.put("createtime", new Date());
			params.put("updatetime", new Date());
			params.put("password", password);
			userService.add(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/updateUser")
	public Map<String,Object>updateUser(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			String username = req.getParameter("username");
			String nickname = req.getParameter("nickname");
			String phone = req.getParameter("phone");
			String status = req.getParameter("status");
			String roleID = req.getParameter("roleID");
			String avatar = req.getParameter("avatar");
			String address = req.getParameter("address");
			
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			params.put("username", username);
			params.put("nickname", nickname);
			params.put("phone", phone);
			params.put("status", Integer.valueOf(status));
			params.put("roleID", Integer.valueOf(roleID));
			params.put("avatar", avatar);
			params.put("address",address);
			params.put("updatetime", new Date());
			userService.update(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Map<String,Object>deleteUser(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			userService.delete(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@ResponseBody
	@RequestMapping("/updateUserStatus")
	public Map<String,Object>updateUserStatus(HttpServletRequest req){
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			String id = req.getParameter("id");
			String status = req.getParameter("status");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("id", Integer.valueOf(id));
			params.put("status", Integer.valueOf(status));
			userService.updateUserStatus(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	@RequestMapping("/toUserListPage")
	public String toUserListPage(){
		return "userList";
	}
	@ResponseBody
	@RequestMapping("/getDateById")
	public Map<String,Object>getDateById(HttpServletRequest req){
		String id = req.getParameter("id");
		Map<String, Object> user = userService.getDateById(Integer.valueOf(id));
		return user;
	}
	
	@ResponseBody
	@RequestMapping("/updateUserRole")
	public Map<String,Object>updateUserRole(HttpServletRequest req,Integer userId,Integer roleId){
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("userId", userId);
		params.put("roleId", roleId);
		Map<String,Object> msg = new HashMap<String,Object>();
		try {
			userService.updateUserRole(params);
			msg.put("msg", 1);
		} catch (Exception e) {
			e.printStackTrace();
			msg.put("msg", 0);
		}
		return msg;
	}
	/**
	 * 安全退出
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping("/safeExit")
	public String safeExit(HttpServletRequest req ,HttpServletResponse res){
		HttpSession session = req.getSession();
		Object user = session.getAttribute("user");
		if(null != user){
			session.removeAttribute("user");
			session.invalidate();
		}
		return "index";
	}
}
