package com.example.band_clone.app.memberManagement.profile;


import com.example.band_clone.app.util.MemberUtil;
import com.example.band_clone.app.vo.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-page")
public class EditMemberInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (Member) (req.getSession().getAttribute("logonUser"));
        req.setAttribute("member", m);

        req.getRequestDispatcher("/profile/my-page.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id =  req.getParameter("id");
        String name = req.getParameter("name").isEmpty() ?  null : req.getParameter("name");
        String nickname = req.getParameter("nickname").isEmpty() ?  null : req.getParameter("nickname");
        String email = req.getParameter("email").isEmpty() ?  null : req.getParameter("email");
        boolean agree = Boolean.parseBoolean(req.getParameter("agree"));
        String ageStr = req.getParameter("age").isEmpty() ?  null : req.getParameter("age");
        int age = 0;
        String interest = req.getParameter("interest").isEmpty() ?  "없음" : req.getParameter("interest");

        if(name != null && nickname != null && email != null && ageStr != null) {
            age = Integer.parseInt(ageStr);
            Member m = new Member(id, email, agree, name, nickname, age, interest);
            int r = MemberUtil.updateMemberInfo(m);
            System.out.println("mypage post updateMemberInfo = " + r);
            resp.sendRedirect("/log-out?msg=profileEdit");
        }else{
            System.out.println("error in memberinfo edit");
            resp.sendRedirect("/my-page");
        }


    }
}
