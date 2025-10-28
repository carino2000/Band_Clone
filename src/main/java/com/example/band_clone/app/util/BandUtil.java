package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class BandUtil {




// -------------------------------------- insert --------------------------------------

    public static int createNewBand(Band band) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.BandMapper.createNewBand", band);
            BandMemberUtil.insertBandMemberByBandNo(band.getNo(), band.getMasterId());
            sqlSession.close();
            return result;

        } catch (Exception e) {
            System.out.println("Error in createNewBand : " + e);
            return result;
        }
    }




// -------------------------------------- select --------------------------------------

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




// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------

}

