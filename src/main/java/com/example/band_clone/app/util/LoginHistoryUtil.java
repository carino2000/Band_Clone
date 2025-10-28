package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.LoginHistory;
import org.apache.ibatis.session.SqlSession;

public class LoginHistoryUtil {

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


}
