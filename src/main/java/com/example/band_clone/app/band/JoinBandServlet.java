package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandMemberUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/band/join")
public class JoinBandServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        int bandNo = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));

        req.setAttribute("band", BandUtil.selectBandByNo(bandNo));
        req.setAttribute("member", m);
        req.getRequestDispatcher("/band/join-form.jsp").forward(req, resp);
        /*
            멤버 정보 불러오기
            밴드 가입 서류 작성하기
            서브밋
            밴드.마스터 맴버에게 신청 보냄

            확인하면 해당 맴버 정보, 서류 출력
            수락하면 밴드맴버 테이블에 반영
         */
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        int bandNo = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));
        if (bandNo == -1) {
            resp.sendRedirect("/band/join");
            return;
        }

        String nickname = req.getParameter("nickname");
        if (nickname == null || nickname.equals("")){
            nickname = m.getNickname();
        }

        String greeting = req.getParameter("greeting") == null ? null : req.getParameter("greeting");

        BandMember bandMember = new BandMember(bandNo, m.getId(), nickname, false, greeting);

        int result = BandMemberUtil.insertBandMemberByBandMember(bandMember);
        if (result == -1) {
            System.out.println("JoinBandServlet post Error !!");
            resp.sendRedirect("/band/join");
        }else{
            req.setAttribute("nickname", nickname);
            req.getRequestDispatcher("/band/request-success.jsp").forward(req, resp);
        }
        //여기서부터 짜기
    }
}
