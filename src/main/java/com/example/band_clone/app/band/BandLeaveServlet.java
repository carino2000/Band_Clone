package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandMemberUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/band-leave")
public class BandLeaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        int result = BandMemberUtil.leaveBand(m.getId(), bandNo);
        if (result == 1) {
            resp.sendRedirect("/band-main?msg=leave");
        } else {
            System.out.println("Error in BandLeaveServlet");
            resp.sendRedirect("/band-main");
        }


    }
}
