package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.util.BandMemberUtil;
import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.vo.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/band")
public class BandServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        boolean articleNotExists = false;
        boolean isNotMember = true;
        boolean isApproved = false;


        int no = req.getParameter("no") == null ? -1 : Integer.parseInt(req.getParameter("no"));
        Band band = BandUtil.selectBandByNo(no);

        if (no == -1 || band == null) {
            resp.sendRedirect("/band-main");
            return;
        }

        List<Article> articles = ArticleUtil.selectAllArticleByBandNo(no);

        if (articles == null || articles.isEmpty()) {
            articleNotExists = true;
        }

        List<BandMember> bandMember = BandMemberUtil.selectBandMemberByBandNo(no);
        if (bandMember == null || bandMember.isEmpty()) {
            System.out.println("Not exist bandMember Error !!");
            resp.sendRedirect("/band-main");
            return;
        }

        for (BandMember b : bandMember) {
            if (b.getMemberId().equals(m.getId())) {
                isNotMember = false;
                if (b.isApproved())
                    isApproved = true;
                break;
            }
        }

        List<BandMember> memberList = new ArrayList<BandMember>();
        for (BandMember b : bandMember) {
            if (b.isApproved()) {
                memberList.add(b);
            }
        }

        req.setAttribute("memberList", memberList);
        req.setAttribute("isApproved", isApproved);
        req.setAttribute("isNotMember", isNotMember);
        req.setAttribute("isPrivate", band.getIsPrivate());
        req.setAttribute("articleNotExists", articleNotExists);

        req.setAttribute("member", m);
        req.setAttribute("band", band);
        req.setAttribute("articles", articles);
        req.getRequestDispatcher("/band/article.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));

        int no = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));
        int articleNo = req.getParameter("articleNo") == null ? -1 : Integer.parseInt(req.getParameter("articleNo"));
        String comment = req.getParameter("comment") == null ? null : req.getParameter("comment");

        if (no == -1 || articleNo == -1 || comment == null) {
            resp.sendRedirect("/band-main");
            return;
        } else {
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
