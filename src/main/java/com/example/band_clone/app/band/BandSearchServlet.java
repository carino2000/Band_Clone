package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.util.TopicUtil;
import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/band-search")
public class BandSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        String keyword = req.getParameter("keyword") == null ? "" : req.getParameter("keyword");

        List<Band> keywordBands = BandUtil.selectBandByKeyword(keyword);
        List<Band> recommend = TopicUtil.recommendBandByMostTopic(m.getId());

        req.setAttribute("recommend", recommend);
        req.setAttribute("keyword" ,  keyword);
        req.setAttribute("keywordBands", keywordBands);
        req.getRequestDispatcher("/band/search.jsp").forward(req, resp);
    }
}
