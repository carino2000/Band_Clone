package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Topic;
import com.example.band_clone.app.vo.UserMsg;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class UserMsgUtil {

// -------------------------------------- insert --------------------------------------

    public static int sendMessenger(UserMsg msg) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.UserMsgMapper.sendMessenger", msg);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in sendMessenger : " + e);
            return result;
        }
    }


// -------------------------------------- select --------------------------------------

    public static List<UserMsg> selectAllMyMsgById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<UserMsg> list = sqlSession.selectList("mappers.UserMsgMapper.selectAllMyMsgById", id);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectAllMyMsgById : " + e);
            return null;
        }
    }


    public static int countMyMsgById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int msgCnt = sqlSession.selectOne("mappers.UserMsgMapper.countMyMsgById", id);
            sqlSession.close();
            return msgCnt;
        } catch (Exception e) {
            System.out.println("Error in countMyMsgById : " + e);
            return -1;
        }
    }




// -------------------------------------- delete --------------------------------------

    public static int deleteMsgByIdx(int msgIdx) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            int result = sqlSession.update("mappers.UserMsgMapper.deleteMsgByIdx", msgIdx);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in deleteMsgByIdx : " + e);
            return -1;
        }
    }

    public static void deleteAllMyMsg(String id){
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.UserMsgMapper.deleteAllMyMsg", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyMsg: " + e);
        }
    }






// -------------------------------------- update --------------------------------------



}
