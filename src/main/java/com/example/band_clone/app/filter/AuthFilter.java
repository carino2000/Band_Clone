package com.example.band_clone.app.filter;

import com.example.band_clone.app.vo.Member;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter extends HttpFilter {
    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        String requestURI = req.getRequestURI();
        if(requestURI.equals("/log-in") || requestURI.equals("/sign-up") || requestURI.equals("/index") || requestURI.startsWith("/static")){
            chain.doFilter(req,resp);
            return;
        }

        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m != null) {
            chain.doFilter(req, resp);
        } else {
            resp.sendRedirect("/log-in");
        }
    }
}
