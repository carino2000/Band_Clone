package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.LoginHistory;
import com.example.band_clone.app.vo.Topic;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class LoginHistoryUtil {


// -------------------------------------- insert --------------------------------------

    public static int insertLoginHistory(LoginHistory user) {
        int result = 0;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.LoginHistoryMapper.insertLoginHistory", user);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertLoginHistory : " + e);
            return result;
        }
    }

// -------------------------------------- select --------------------------------------


    public static List<LoginHistory> selectHistoryById(String id) {
        List<LoginHistory> list = null;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            list = session.selectList("mappers.LoginHistoryMapper.selectByLoginId", id);
            session.close();
            return list;

        } catch (IOException e) {
            System.out.println("Error in selectHistoryById : " + e);
            return list;

        }
    }


    public static List<LoginHistory> selectHistoryByIdAndPage(String id, int page) {
        List<LoginHistory> list = null;
        int offset = (page - 1) * 20;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            Map map = Map.of("id", id, "offset", offset);
            list = session.selectList("mappers.LoginHistoryMapper.selectByLoginIdAndPage", map);
            session.close();
            return list;
        } catch (IOException e) {
            System.out.println("Error in selectHistoryByIdAndPage : " + e);
            return list;

        }
    }

// -------------------------------------- delete --------------------------------------

    public static void deleteAllMyLoginHistory(String id) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.LoginHistoryMapper.deleteAllMyLoginHistory", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyLoginHistory: " + e);
        }
    }





// -------------------------------------- update --------------------------------------


}
