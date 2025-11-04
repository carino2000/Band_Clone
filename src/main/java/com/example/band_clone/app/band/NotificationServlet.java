package com.example.band_clone.app.band;

import com.example.band_clone.app.util.*;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Member;
import com.example.band_clone.app.vo.UserMsg;
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
        List<UserMsg> magList = UserMsgUtil.selectAllMyMsgById(m.getId());
        List<Member> memberList = MemberUtil.selectAllMembersExceptMe(m.getId());

        req.setAttribute("memberList", memberList);
        req.setAttribute("msgList", magList);
        req.setAttribute("requestList", requestList);
        req.getRequestDispatcher("/band/my-notice.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        boolean deleteMsg = Boolean.parseBoolean(req.getParameter("deleteMsg"));
        if (deleteMsg) {
            int msgIdx = Integer.parseInt(req.getParameter("msgIdx"));
            int result = UserMsgUtil.deleteMsgByIdx(msgIdx);
        }


        boolean approve = Boolean.parseBoolean(req.getParameter("approve"));
        String bandNo = req.getParameter("bandNo");
        String memberId = req.getParameter("memberId");
        if (bandNo == null || memberId == null) {
            resp.sendRedirect("/my/notice");
            return;
        }
        int no = Integer.parseInt(bandNo);
        Band band = BandUtil.selectBandByNo(no);

        if (approve) {
            int result = NotificationUtil.updateApprovedBandMember(no, memberId);
            if (result == -1) {
                System.out.println("Approve Error in NotificationServlet");
            }
            resp.sendRedirect("/my/notice");
        } else { //승인 거절 코드 작성란
            String refuseReason = "[" + band.getName() + "]밴드의 가입 요청이 거절되었습니다.";
            UserMsg userMsg = new UserMsg(m.getId(), memberId, refuseReason);
            int result1 = NotificationUtil.insertUserMsg(userMsg);
            int result2 = BandMemberUtil.deleteMemberById(no, memberId);
            if (result1 != 1 || result2 != 1) {
                System.out.println("Refuse Error in NotificationServlet");
            }
            resp.sendRedirect("/my/notice");
        }


    }
}
