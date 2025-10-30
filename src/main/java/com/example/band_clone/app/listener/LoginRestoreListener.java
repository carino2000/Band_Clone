package com.example.band_clone.app.listener;

import com.example.band_clone.app.util.LoginHistoryUtil;
import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.util.NotificationUtil;
import com.example.band_clone.app.vo.LoginHistory;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletRequestEvent;
import jakarta.servlet.ServletRequestListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

@WebListener
public class LoginRestoreListener implements ServletRequestListener {
    @Override
    public void requestInitialized(ServletRequestEvent sre) {

        HttpServletRequest req = (HttpServletRequest) sre.getServletRequest();
        String ip = req.getRemoteAddr();

        Cookie found = null;
        Cookie[] cookies = req.getCookies() == null ? new Cookie[0] : req.getCookies();
        for (Cookie c : cookies) {
            if (c.getName().equals("keepLogin")) {
                found = c;
            }
        }

        if (found != null) { // 로그인 유지 체크 상태 (쿠키 체크)
            String id = found.getValue();

            // 자동로그인 할 때 접속 로그 남기기
            LoginHistory user = new LoginHistory(id, ip);
            int r = LoginHistoryUtil.insertLoginHistory(user);

            //세션 쥐어주기 (로그인 성공 시 절차)
            req.getSession().setAttribute("logonUser", MemberUtil.selectMemberById(id));
        }

        //-------------------------------------------

        if (req.getSession().getAttribute("logonUser") == null) {
            req.setAttribute("auth", false);
        } else {
            req.setAttribute("auth", true);
            Member m = (Member) req.getSession().getAttribute("logonUser");
            int noticeCnt = NotificationUtil.countMyNoticeById(m.getId());

            req.setAttribute("noticeCnt", noticeCnt);
            req.setAttribute("member", m);


        }
    }
}
