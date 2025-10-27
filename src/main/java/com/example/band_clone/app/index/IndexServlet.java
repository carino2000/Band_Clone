package com.example.band_clone.app.index;

import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = new Member("qwer", "qwer", "qwer", true, "qwer", "qwer", 12, "qwer");

        MemberUtil.insertMemberInfo(m);

    }
}
