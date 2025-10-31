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

@WebServlet("/article/edit")
public class ArticleEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        int idx = Integer.parseInt(req.getParameter("idx"));
        Article article = ArticleUtil.selectArticleByIdx(idx);
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));

        if (article != null && m.getId().equals(article.getWriterId())) {
            req.setAttribute("article", article);
            req.setAttribute("bandNo", bandNo);
            req.getRequestDispatcher("/band/article/edit.jsp").forward(req, resp);
        } else {
            System.out.println("Error int ArticleEditServlet");
            resp.sendRedirect("/band-main");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) req.getSession().getAttribute("logonUser");

        int idx = Integer.parseInt(req.getParameter("idx"));
        String id = req.getParameter("id");
        String content = req.getParameter("content");
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));


        Article article = new Article();
        article.setIdx(idx);
        article.setWriterId(id);
        article.setContent(content);

        int r = 0;

        if (m.getId().equals(article.getWriterId())) {
            r = ArticleUtil.updateArticle(article);
            resp.sendRedirect("/band?msg=1&no=" + bandNo);
        } else {
            System.out.println("id doesn't match in ArticleEditServlet");
            r = -1;
            resp.sendRedirect("/band-main");
        }


    }
}
