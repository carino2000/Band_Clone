package com.example.band_clone.app.band;

import com.example.band_clone.app.util.ArticleUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/comment/delete")
public class CommentDeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) req.getSession().getAttribute("logonUser");

        int bandNo = Integer.parseInt(req.getParameter("bandNo"));
        int idx = Integer.parseInt(req.getParameter("idx"));
        String writerId =  req.getParameter("writerId") == null ? "" : req.getParameter("writerId");

        int result = -1;
        if(m.getId().equals(writerId)){
            result = ArticleUtil.deleteMyCommentByIdx(idx);
        }

        if(result == 1){
            resp.sendRedirect("/band?msg=2&no=" + bandNo);
            return;
        }


        resp.sendRedirect("/band?&no=" + bandNo);

    }
}
