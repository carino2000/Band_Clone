package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Member;
import com.example.band_clone.app.vo.Topic;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class TopicUtil {

// -------------------------------------- insert --------------------------------------



// -------------------------------------- select --------------------------------------

    public static List<Topic> selectAllTopics() {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Topic> list = sqlSession.selectList("mappers.TopicMapper.selectAllTopics");
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectAllTopics : " + e);
            return null;
        }
    }


// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------
}
