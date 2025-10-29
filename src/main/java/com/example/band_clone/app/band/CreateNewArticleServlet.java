package com.example.band_clone.app.band;

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
        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m == null) {
            resp.sendRedirect("/log-in");
            return;
        }

        int bandNo = req.getParameter("bandNo") == null ? -1 : Integer.parseInt(req.getParameter("bandNo"));
        String content =  req.getParameter("content") ==  null ? null : req.getParameter("content");



    }
}
