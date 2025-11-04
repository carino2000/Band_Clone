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

    public  static int selectBandMemberCount() {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int cnt = sqlSession.selectOne("mappers.BandMemberMapper.selectBandMemberCount");
            sqlSession.close();
            return cnt;
        } catch (Exception e) {
            System.out.println("Error in selectBandMemberCount : " + e);
            return 0;
        }
    }


// -------------------------------------- delete --------------------------------------

    public static int deleteMemberById(int bandNo, String id) {
        int result = -1;
        Map map = Map.of("bandNo", bandNo, "id", id);
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.BandMemberMapper.deleteMemberById", map);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteMemberById: " + e);
        }
        return result;
    }


    public static void deleteAllMyBandMember(String id) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.BandMemberMapper.deleteAllMyBandMember", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyBandMember: " + e);
        }
    }

    public static int leaveBand(String id, int bandNo) {
        int result = -1;
        try {
            Map map = Map.of("bandNo", bandNo, "id", id);
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.BandMemberMapper.leaveBand", map);
            session.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in leaveBand: " + e);
            return result;
        }
    }

    public static void deleteBandMemberByBandNo(int bandNo) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.BandMemberMapper.deleteBandMemberByBandNo", bandNo);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteBandMemberByBandNo: " + e);
        }
    }


// -------------------------------------- update --------------------------------------

}
