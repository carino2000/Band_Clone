package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/band-main")
public class BandMainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m == null) {
            resp.sendRedirect("/log-in");
            return;
        }


        List<Band> myBands = BandUtil.selectMyBandsById(m.getId());
        req.setAttribute("myBands", myBands);
        req.getRequestDispatcher("/band/main.jsp").forward(req, resp);


    }
}
