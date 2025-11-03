package com.example.band_clone.app.memberManagement.profile;

import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/delete-membership")
public class DeleteMemberInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) req.getSession().getAttribute("logonUser");

        MemberUtil.deleteMemberById(m.getId());
        resp.sendRedirect("/log-out?msg=deleteMember");

    }
}
