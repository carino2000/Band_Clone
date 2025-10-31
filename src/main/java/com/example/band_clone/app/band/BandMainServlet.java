package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandMemberUtil;
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
import java.util.Map;

@WebServlet("/band-main")
public class BandMainServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        String keyword = req.getParameter("keyword") == null ? "" : req.getParameter("keyword");
        List<Band> otherBands = BandUtil.selectAllBandsExceptMyBands(m.getId());
        List<Band> joinedBands = BandUtil.selectJoinedBandsById(m.getId());
        List<Band> myBands = BandUtil.selectMyBandsById(m.getId());
        List<Band> keywordBands = BandUtil.selectBandByKeyword(keyword);


        for (Band b : joinedBands) {
            b.setApproved(BandMemberUtil.isApprovedMember(b.getNo(), m.getId()));
        }



        req.setAttribute("keywordBands", keywordBands);
        req.setAttribute("myBands", myBands);
        req.setAttribute("joinedBands", joinedBands);
        req.setAttribute("otherBands", otherBands);
        req.getRequestDispatcher("/band/main.jsp").forward(req, resp);


    }
}
