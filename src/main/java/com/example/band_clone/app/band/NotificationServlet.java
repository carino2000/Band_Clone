package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandMemberUtil;
import com.example.band_clone.app.util.NotificationUtil;
import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/my/notice")
public class NotificationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        List<BandMember> requestList = NotificationUtil.selectAllRequest(m.getId());

        req.setAttribute("requestList", requestList);
        req.getRequestDispatcher("/band/my-notice.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        boolean approve = Boolean.parseBoolean(req.getParameter("approve"));
        String bandNo = req.getParameter("bandNo");
        String memberId = req.getParameter("memberId");
        if(bandNo == null || memberId == null){
            resp.sendRedirect("/my/notice");
            return;
        }

        if (approve) {
            int result = NotificationUtil.updateApprovedBandMember(Integer.parseInt(bandNo), memberId);
            if(result == -1){
                System.out.println("Error in NotificationServlet");
            }
            resp.sendRedirect("/my/notice");
        }else{ //승인 거절 코드 작성란

        }



    }
}
