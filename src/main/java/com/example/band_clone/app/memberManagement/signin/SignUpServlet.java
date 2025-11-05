package com.example.band_clone.app.memberManagement.signin;

import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.util.ValidateUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/sign-up")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/membership/sign-up.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("id") == null ? null : req.getParameter("id");
        String pw = req.getParameter("pw") == null ? null : req.getParameter("pw");
        String email = req.getParameter("email") == null ? null : req.getParameter("email");
        String name = req.getParameter("name") == null ? null : req.getParameter("name");
        String nickname = req.getParameter("nickname") == null ? null : req.getParameter("nickname");
        int age = req.getParameter("age") == null ? -1 : Integer.parseInt(req.getParameter("age"));
        String interest = req.getParameter("interest") == null ? "없음" : req.getParameter("interest");
        boolean agree = req.getParameter("agree") != null;

        String mainError = null;
        Member m = null;

        if (id == null || pw == null || email == null || name == null || nickname == null || !(age >= 0 && age <= 100)) {
            mainError = "예상치 못한 오류!\n입력하신 값이 정상적으로 처리되지 않았습니다";
        } else {
            m = new Member(id, pw, email, agree, name, nickname, age, interest);
            int result = MemberUtil.insertMember(m);
            mainError = result != 1 ? ValidateUtil.setErrMsg(result) : null;
        }

        if (mainError == null) {
            req.setAttribute("nickname", nickname);
            req.getRequestDispatcher("/membership/sign-up-success.jsp").forward(req, resp);
        }else{
            req.setAttribute("mainError", mainError);
            req.setAttribute("member", m);
            req.getRequestDispatcher("/membership/sign-up-fail.jsp").forward(req, resp);
        }


    }
}
