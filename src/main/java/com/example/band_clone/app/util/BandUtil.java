package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.*;
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
            String param = "%" + keyword + "%";
            list = session.selectList("mappers.BandMapper.selectBandByKeyword", param);
            session.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectBandByKeyword: " + e);
            return null;
        }

    }

    public static List<Band> selectBandByKeywordAndPage(String keyword, int page) {
        try {
            List<Band> list = null;
            String param = "%" + keyword + "%";
            int offset = (page - 1) * 10;
            Map map = Map.of("keyword", param, "offset", offset);

            SqlSession session = MyBatisUtil.build().openSession(true);
            list = session.selectList("mappers.BandMapper.selectBandByKeywordAndPage", map);
            session.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectBandByKeywordAndPage: " + e);
            return null;
        }

    }


    public static List<BandStatus> convertToBandStatus(List<Band> keywordBandsByPage, String id) {
        List<Integer> list = null;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            list = session.selectList("mappers.BandMapper.checkJoinedBandNo", id);
            session.close();

            // strim 예습 느낌..?
            List<Integer> finalList = list;
            List<BandStatus> keywordBandStautsByPage = keywordBandsByPage.stream().map(band -> {
                BandStatus status = new BandStatus();
                status.setBand(band);
                status.setJoined(finalList.contains(band.getNo()));
                return status;
            }).toList();

            return keywordBandStautsByPage;
        } catch (Exception e) {
            System.out.println("Error in selectBandByKeyword: " + e);
            return null;
        }
    }


// -------------------------------------- delete --------------------------------------

    public static void deleteAllMyBand(String id) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.BandMapper.deleteAllMyBand", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyBand: " + e);
        }
    }


    public static int deleteBandByBandNo(int bandNo) {
        int result = -1;
        try {
            ArticleUtil.deleteArticleCommentByBandNo(bandNo);
            ArticleUtil.deleteArticleByBandNo(bandNo);
            BandMemberUtil.deleteBandMemberByBandNo(bandNo);

            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.BandMapper.deleteBandByBandNo", bandNo);
            session.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in deleteBandByBandNo: " + e);
            return result;
        }
    }


// -------------------------------------- update --------------------------------------

}

