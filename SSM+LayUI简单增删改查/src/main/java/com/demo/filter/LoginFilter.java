package com.demo.filter;

import com.demo.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 过滤器，判断用户是否登录
 */
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //将request和response强转成htt...
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        //获取session
        HttpSession ss = req.getSession();
        User user = (User)ss.getAttribute("user");

        if(req.getServletPath().equals("/index.jsp") && user == null) {
            //重定向到登录
            resp.sendRedirect(req.getContextPath()+"/pages/login.jsp");
        }else if(req.getServletPath().equals("/pages/login.jsp") && user != null) {
            //用户已登录，直接跳转到首页
            resp.sendRedirect(req.getContextPath()+"/index.jsp");
        }else{
            //放行
            chain.doFilter(request,response);
        }
    }

    @Override
    public void destroy() {

    }
}
