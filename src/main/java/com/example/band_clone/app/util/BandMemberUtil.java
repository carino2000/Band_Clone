package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class BandMemberUtil {


// -------------------------------------- insert --------------------------------------

    public static int insertBandMemberByBandNo(int bandNo, String memberId) {
        int result = -1;
        Map map = Map.of("bandNo", bandNo, "memberId", memberId);
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.BandMemberMapper.insertBandMemberByBandNo", map);
            sqlSession.close();
            return result;

        } catch (Exception e) {
            System.out.println("Error in insertBandMemberByBandNo : " + e);
            return result;
        }
    }

//    public static int insertBandMemberByBandName(String BandName, String memberId) {
//        int result = -1;
//        Map map = Map.of("BandName", BandName, "memberId", memberId);
//        try {
//            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
//            result = sqlSession.insert("mappers.BandMemberMapper.insertBandMemberByBandName", map);
//            sqlSession.close();
//            return result;
//
//        } catch (Exception e) {
//            System.out.println("Error in insertBandMemberByBandNo : " + e);
//            return result;
//        }
//    }


// -------------------------------------- select --------------------------------------

    public static List<Band> selectMemberByBandNo(int bandNo) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Band> list = sqlSession.selectList("mappers.BandMemberMapper.selectMemberByBandNo", bandNo);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectMemberByBandNo : " + e);
            return null;
        }
    }




// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------

}
