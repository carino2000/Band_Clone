package com.example.band_clone.app.memberManagement.signin;

import com.example.band_clone.app.util.LoginHistoryUtil;
import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.util.ValidateUtil;
import com.example.band_clone.app.vo.LoginHistory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/log-in")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/membership/log-in.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id") == null ? null : req.getParameter("id");
        String pw =  req.getParameter("pw") == null ? null : req.getParameter("pw");
        String keepLogin = req.getParameter("keepLogin");
        String ip = req.getRemoteAddr();

        int result = MemberUtil.login(id, pw);

        if (result == 1) { //로그인 성공!

            // 접속 로그 남기기
            LoginHistory user = new LoginHistory(id, ip);
            int r = LoginHistoryUtil.insertLoginHistory(user);

            if (keepLogin != null) { // 자동 로그인 선택했다면 쿠키 발급
                Cookie cookie = new Cookie("keepLogin", id);
                cookie.setMaxAge(60 * 60 * 24 * 30); // 한 달
                resp.addCookie(cookie);
            }

            //세션 쥐어주기
            req.getSession().setAttribute("logonUser", MemberUtil.selectMemberById(id));
            resp.sendRedirect("/band-main");

        } else { // 로그인 실패
            String mainError = ValidateUtil.setErrMsg(result);

            req.setAttribute("id", id);
            req.setAttribute("pw", pw);
            req.setAttribute("mainError", mainError);

            req.getRequestDispatcher("/membership/log-in-fail.jsp").forward(req, resp);
        }


    }
}
