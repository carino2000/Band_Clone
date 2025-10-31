package com.example.band_clone.app.memberManagement.signin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/log-out")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Cookie cookie = null;
        Cookie[] cookies = req.getCookies() == null ? new Cookie[0] : req.getCookies();
        for (Cookie c : cookies) {
            if (c.getName().equals("keepLogin")) {
                cookie = c;
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
        }
        req.getSession().removeAttribute("logonUser");

        //나중에 회원탈퇴? 같은거 할 때 살리기

        if(req.getParameter("msg") != null){
            if(req.getParameter("msg").equals("profileEdit")){
                resp.sendRedirect("/index?msg=1");
                return;
            }
        }


        resp.sendRedirect("/index");
    }
}
