package com.example.band_clone.app.memberManagement.profile;

import com.example.band_clone.app.util.UserMsgUtil;
import com.example.band_clone.app.vo.Member;
import com.example.band_clone.app.vo.UserMsg;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/send-messenger")
public class SendMessengerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        String recipientId = req.getParameter("recipientId") == null ? "" : req.getParameter("recipientId");
        String content = req.getParameter("content") == null ? "none" : req.getParameter("content");

        UserMsg msg = new UserMsg(m.getId(), recipientId, content);

        int result = UserMsgUtil.sendMessenger(msg);

        if (result != 1) {
            System.out.println("Error in SendMessengerServlet");
        }
        resp.sendRedirect("/my/notice");
    }
}
