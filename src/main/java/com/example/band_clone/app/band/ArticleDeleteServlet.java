package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.ArticleComment;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/article/delete")
public class ArticleDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) req.getSession().getAttribute("logonUser");
        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        int idx = Integer.parseInt(req.getParameter("idx"));

        Article article = ArticleUtil.selectArticleByIdx(idx);
        int r1 = 0;
        int r2 = 0;
        if (article != null && m.getId().equals(article.getWriterId())) {// 여기서부터
            r1 = ArticleUtil.deleteArticleCommentByArticleIdx(idx);
            r2 = ArticleUtil.deleteArticleByidx(idx);
            System.out.println("ArticleDeleteServlet : r = " + r1);
            System.out.println("ArticleDeleteServlet : r = " + r2);
        } else {
            System.out.println("id doesn't match in ArticleDeleteServlet");
            r2 = -1;
        }


        resp.sendRedirect("/band?msg=1&no=" + bandNo);
    }
}
