package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.BandMember;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class BandMemberUtil {


// -------------------------------------- insert --------------------------------------


    public static int insertBandMemberByBandMember(BandMember bandMember) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.BandMemberMapper.insertBandMemberByBandMember", bandMember);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertBandMemberByBandMember : " + e);
            return result;
        }
    }


// -------------------------------------- select --------------------------------------

    public static List<BandMember> selectBandMemberByBandNo(int bandNo) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<BandMember> list = sqlSession.selectList("mappers.BandMemberMapper.selectBandMemberByBandNo", bandNo);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectBandMemberByBandNo : " + e);
            return null;
        }
    }

    public static boolean isApprovedMember(int bandNo, String id) {
        Map map = Map.of("bandNo", bandNo, "id", id);
        boolean b = false;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            b = sqlSession.selectOne("mappers.BandMemberMapper.isApprovedMember", map);
            sqlSession.close();
            return b;
        } catch (Exception e) {
            System.out.println("Error in isApprovedMember : " + e);
            return false;
        }
    }


// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------

}
