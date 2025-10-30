package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Member;
import org.apache.ibatis.session.SqlSession;


public class MemberUtil {

    public static int login(String id, String pw) {
        Member member = selectMemberById(id);
        if (member == null) {
            return 505;
        } else if (!(member.getPw().equals(pw))) {
            return 506;
        } else {
            return 1;
        }
    }

    // -------------------------------------- insert --------------------------------------

    public static int insertMember(Member member) {
        int result = 0;
        if (member == null)
            return 504;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);

            if (ValidateUtil.isDuplicateId(member.getId())) {
                result = 500; //중복 아이디
            } else if (ValidateUtil.isDuplicateNickName(member.getNickname())) {
                result = 501; //중복 닉네임
            } else if (ValidateUtil.isNotValidId(member.getId())) {
                result = 502; //아이디 조건 부적합
            } else if (ValidateUtil.isNotValidPw(member.getPw())) {
                result = 503; //비밀번호 조건 부적합
            }  else if(ValidateUtil.isNotValidEmail(member.getEmail())) {
                result = 504;
            }else {
                result = sqlSession.insert("mappers.MemberInfoMapper.insertMemberInfo", member);
            }
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertMemberInfo : " + e);
            return result;
        }
    }


    // -------------------------------------- select --------------------------------------

    public static Member selectMemberById(String id) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            Member member = sqlSession.selectOne("mappers.MemberInfoMapper.selectMemberById", id);
            sqlSession.close();
            return member;
        } catch (Exception e) {
            System.out.println("Error in select member by loginId : " + e);
            return null;
        }
    }

    public static Member selectMemberByNickName(String nickname) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            Member member = sqlSession.selectOne("mappers.MemberInfoMapper.selectMemberByNickName", nickname);
            sqlSession.close();
            return member;
        } catch (Exception e) {
            System.out.println("Error in select member by nickname : " + e);
            return null;
        }
    }


    // -------------------------------------- delete --------------------------------------


    // -------------------------------------- update --------------------------------------

}
