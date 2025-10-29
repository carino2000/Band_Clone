package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.ArticleComment;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/band")
public class BandServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m == null) {
            resp.sendRedirect("/log-in");
            return;
        }
        int no = req.getParameter("no") == null ? -1 : Integer.parseInt(req.getParameter("no"));

        if (no == -1) {
            resp.sendRedirect("/band-main");
            return;
        } else { // 밴드 번호 받아서 해당 밴드 페이지 출력
            Band band = BandUtil.selectBandByNo(no);
            List<Article> articles = ArticleUtil.selectAllArticleByBandNo(no);


            System.out.println(articles.getFirst().getArticleComments().size());
            req.setAttribute("member", m);
            req.setAttribute("band", band);
            req.setAttribute("articles", articles);
            req.getRequestDispatcher("/band/article.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m == null) {
            resp.sendRedirect("/log-in");
            return;
        }

        int no = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));
        int articleNo = req.getParameter("articleNo") == null ? -1 : Integer.parseInt(req.getParameter("articleNo"));
        String comment = req.getParameter("comment") == null ? null : req.getParameter("comment");

        if(no == -1 || articleNo == -1 || comment == null) {
            resp.sendRedirect("/band-main");
            return;
        }else{
            ArticleComment ac = new ArticleComment(articleNo, m.getId(), comment);

            int result = ArticleUtil.insertCommentByArticleNo(ac);


            Band band = BandUtil.selectBandByNo(no);
            List<Article> articles = ArticleUtil.selectAllArticleByBandNo(no);

            req.setAttribute("member", m);
            req.setAttribute("band", band);
            req.setAttribute("articles", articles);
            req.getRequestDispatcher("/band/article.jsp").forward(req, resp);
        }

    }
}
