package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.Band;
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
        String keyword = req.getParameter("keyword") == null ? "" : req.getParameter("keyword");

        List<Band> keywordBands = BandUtil.selectBandByKeyword(keyword);


        req.setAttribute("keyword" ,  keyword);
        req.setAttribute("keywordBands", keywordBands);
        req.getRequestDispatcher("/band/search.jsp").forward(req, resp);
    }
}
