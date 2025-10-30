package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Topic;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class NotificationUtil {

// -------------------------------------- insert --------------------------------------


// -------------------------------------- select --------------------------------------

    public static List<BandMember> selectAllRequest(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<BandMember> list = sqlSession.selectList("mappers.BandMemberMapper.selectAllRequest", id);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectAllRequest : " + e);
            return null;
        }
    }


// -------------------------------------- count --------------------------------------

    public static int countMyNoticeById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int noticeCnt = sqlSession.selectOne("mappers.BandMemberMapper.countMyNoticeById", id);
            sqlSession.close();
            return noticeCnt;
        } catch (Exception e) {
            System.out.println("Error in countMyNoticeById : " + e);
            return -1;
        }
    }


// -------------------------------------- delete --------------------------------------


    // -------------------------------------- update --------------------------------------
    public static int updateApprovedBandMember(int bandNo, String id) {
        Map map = Map.of("bandNo", bandNo, "id", id);
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int result = sqlSession.update("mappers.BandMemberMapper.updateApprovedBandMember", map);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in updateApprovedBandMember : " + e);
            return -1;
        }
    }


}
