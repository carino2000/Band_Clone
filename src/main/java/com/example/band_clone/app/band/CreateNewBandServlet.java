package com.example.band_clone.app.band;

import com.example.band_clone.app.util.BandUtil;
import com.example.band_clone.app.util.TopicUtil;
import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import com.example.band_clone.app.vo.Topic;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/band-create")
public class CreateNewBandServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Topic> topics = TopicUtil.selectAllTopics();
        req.setAttribute("topics", topics);

        //req.getRequestDispatcher("/band/not-use-create-new-band.jsp").forward(req, resp);
        req.getRequestDispatcher("/band/create-band.jsp").forward(req, resp); //gpt가 해준거ㅠㅠ
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member m = (req.getSession().getAttribute("logonUser") == null ? null : (Member) req.getSession().getAttribute("logonUser"));
        if (m == null) {
            resp.sendRedirect("/log-in");
            return;
        }

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String[] topics = req.getParameterValues("topic");
        boolean isPrivate = req.getParameter("isPrivate") == null;

        String topic = "";
        for (String t : topics) {
            topic += t + " ";
        }

        Band band = new Band(name, description, isPrivate, topic, m.getId());

        int result = BandUtil.createNewBand(band);


        req.setAttribute("member", m);
        req.setAttribute("band", band);
        req.getRequestDispatcher("/band/create-band-success.jsp").forward(req, resp);
    }
}
