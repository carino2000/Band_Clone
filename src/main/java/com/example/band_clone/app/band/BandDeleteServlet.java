package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandMemberUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/band-delete")
public class BandDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        String masterId = req.getParameter("masterId");

        if (m.getId().equals(masterId)) {
            int result = BandUtil.deleteBandByBandNo(bandNo);
            if (result == 1) {
                resp.sendRedirect("/band-main?msg=delete");
            } else {
                System.out.println("Error in BandDeleteServlet");
                resp.sendRedirect("/band-main");
            }
        }

    }
}
