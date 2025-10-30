package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Topic;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NotificationUtil {

// -------------------------------------- insert --------------------------------------


// -------------------------------------- select --------------------------------------




// -------------------------------------- count --------------------------------------

    public static int countMyNoticeById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int noticeCnt = sqlSession.selectOne("mappers.BandJoinRequest.countMyNoticeById", id);
            sqlSession.close();
            return noticeCnt;
        } catch (Exception e) {
            System.out.println("Error in countMyNoticeById : " + e);
            return -1;
        }
    }


// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------
}
