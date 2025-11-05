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
import java.util.List;

@WebServlet("/my-posting")
public class ArticleMyPostingListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) req.getSession().getAttribute("logonUser");

        List<Article> articles = ArticleUtil.selectArticleByWriterId(m.getId());

        req.setAttribute("articles", articles);
        req.getRequestDispatcher("/band/my-posting.jsp").forward(req,resp);
    }
}