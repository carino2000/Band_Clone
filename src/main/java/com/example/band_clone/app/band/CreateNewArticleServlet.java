package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/band/new-article")
public class CreateNewArticleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        int bandNo = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));
        String content = req.getParameter("content") == null ? null : req.getParameter("content");

        if (bandNo == -1) {
            resp.sendRedirect("/band-main");
        } else if (content == null) {
            resp.sendRedirect("/band?no=" + bandNo);
        } else {
            Article article = new Article(bandNo, m.getId(), content);
            int result = ArticleUtil.insertNewArticleByBandNo(article);
            resp.sendRedirect("/band?no=" + bandNo);
        }


    }
}
