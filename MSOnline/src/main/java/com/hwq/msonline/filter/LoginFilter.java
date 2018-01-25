package com.hwq.msonline.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * 登陆检测 过滤器
 * @author Administrator
 *
 */
public class LoginFilter implements Filter {
     String passUrl ="";
	@Override
	public void destroy() {
		System.out.println("登陆过滤器执行完毕。。。。。");

	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
               HttpServletRequest request = (HttpServletRequest)req; 
               HttpServletResponse response = (HttpServletResponse)res;
               HttpSession session = request.getSession();
               String[] purls = passUrl.split(";");
               for(String u:purls){
            	   if (u.equals(""))
                       continue;
                   if (request.getRequestURL().indexOf(u) >= 0) {
                       chain.doFilter(request, response);
                       return;
                   }
               }
              Object user = session.getAttribute("user");
              if(null != user){
            	  chain.doFilter(request, response);
              }else{
            	  response.sendRedirect(request.getContextPath()+"/user/toLogin.do");
              }
	}

	@Override
	public void init(FilterConfig conf) throws ServletException {
		System.out.println("登陆过滤器初始化......");
		passUrl = conf.getInitParameter("passUrl");

	}

}
