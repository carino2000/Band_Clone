package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.BandMember;
import com.example.band_clone.app.vo.Member;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class BandUtil {


// -------------------------------------- insert --------------------------------------

    public static int createNewBand(Band band, String nickname) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.BandMapper.createNewBand", band);

            BandMember bandmember = new BandMember(band.getNo(), band.getMasterId(), nickname, true);
            BandMemberUtil.insertBandMemberByBandMember(bandmember);
            sqlSession.close();
            return result;

        } catch (Exception e) {
            System.out.println("Error in createNewBand : " + e);
            return result;
        }
    }


// -------------------------------------- select --------------------------------------

    public static List<Band> selectJoinedBandsById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Band> list = sqlSession.selectList("mappers.BandMapper.selectJoinedBandsById", id);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectJoinedBandsById : " + e);
            return null;
        }
    }

    public static Band selectBandByNo(int no) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            Band band = sqlSession.selectOne("mappers.BandMapper.selectBandByNo", no);
            sqlSession.close();
            return band;
        } catch (Exception e) {
            System.out.println("Error in selectBandByNo : " + e);
            return null;
        }
    }

    public static List<Band> selectAllBandsExceptMyBands(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Band> list = sqlSession.selectList("mappers.BandMapper.selectAllBandsExceptMyBands", id);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectAllBandsExceptMyBands : " + e);
            return null;
        }
    }


    public static List<Band> selectMyBandsById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Band> list = sqlSession.selectList("mappers.BandMapper.selectMyBandsById", id);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectMyBandsById : " + e);
            return null;
        }
    }


    public static List<Band> selectBandByKeyword(String keyword) {// 현병욱 수정중
        List<Band> list = null;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            list = session.selectList("", keyword);
            session.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectBandByKeyword: " + e);
            return null;
        }

    }

    /*
       // select * from article where content like '%#{}%' order by wroteAt desc limit 5 offset 5;
    public static List<Article> selectByKeyword(String keyword, int page) {//수정중
        List<Article> list = null;
        int offset = (page - 1) * 10;
        Map map = Map.of("keyword", keyword, "offset", offset);
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            list = session.selectList("mappers.ArticleMapper.selectByKeyword", map);
            session.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectByKeyword: " + e);
            return null;
        }

    }
     */


// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------

}

