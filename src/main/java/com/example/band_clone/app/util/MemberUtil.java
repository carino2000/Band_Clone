package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Member;
import org.apache.ibatis.session.SqlSession;


public class MemberUtil {

    public static int insertMemberInfo(Member m) {
        int result = 0;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.MemberInfoMapper.insertMemberInfo", m);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertMemberInfo : " + e);
            return result;
        }
    }



}
