package com.hwq.msonline.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 首页 Controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping("home")
public class HomePageAction {
	@RequestMapping(value="/homePage")
    public String toHomePage(HttpServletRequest req){
    	return "homePage";
    }
}
