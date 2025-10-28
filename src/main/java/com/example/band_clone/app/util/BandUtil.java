package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class BandUtil {

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

}
