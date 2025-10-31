package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Article;
import com.example.band_clone.app.vo.ArticleComment;
import org.apache.ibatis.session.SqlSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ArticleUtil {

    // -------------------------------------- insert --------------------------------------

    public static int insertCommentByArticleNo(ArticleComment articleComment) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.ArticleMapper.insertCommentByArticleNo", articleComment);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertCommentByArticleNo : " + e);
            return result;
        }
    }


    public static int insertNewArticleByBandNo(Article article) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.insert("mappers.ArticleMapper.insertNewArticleByBandNo", article);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in insertNewArticleByBandNo : " + e);
            return result;
        }
    }


    // -------------------------------------- select --------------------------------------

    public static List<Article> selectAllArticleByBandNo(int bandNo) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Article> list = sqlSession.selectList("mappers.ArticleMapper.selectAllArticleByBandNo", bandNo);
            if (list == null) {
                sqlSession.close();
                return new ArrayList<Article>(0);
            } else {
                List<Article> returnList = new ArrayList<Article>();
                for (Article article : list) {
                    List<ArticleComment> articleComments = selectArticleCommentsByArticleIdx(article.getIdx());
                    article.setArticleComments(articleComments);
                    returnList.add(article);
                }
                sqlSession.close();
                return returnList;
            }
        } catch (Exception e) {
            System.out.println("Error in selectAllArticleByBandNo : " + e);
            return null;
        }
    }

    public static List<ArticleComment> selectArticleCommentsByArticleIdx(int articleIdx) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<ArticleComment> list = sqlSession.selectList("mappers.ArticleMapper.selectArticleCommentsByArticleIdx", articleIdx);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectArticleCommentsByArticleIdx : " + e);
            return null;
        }
    }

    public static Article selectArticleByIdx(int idx) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            Article article = sqlSession.selectOne("mappers.ArticleMapper.selectArticleByIdx", idx);
            sqlSession.close();
            return article;
        } catch (Exception e) {
            System.out.println("Error in selectArticleByIdx : " + e);
            return null;
        }
    }


    // -------------------------------------- delete --------------------------------------

    public static int deleteArticleCommentByArticleIdx(int idx) {
        int result = -1;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.ArticleMapper.deleteArticleCommentByArticleIdx", idx);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteArticleCommentByArticleIdx: " + e);
        }
        return result;
    }


    public static int deleteArticleByidx(int idx) {
        int result = -1;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.ArticleMapper.deleteArticleByidx", idx);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteArticleByidx: " + e);
        }
        return result;
    }



    // -------------------------------------- update --------------------------------------

    public static int updateArticle(Article article) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.update("mappers.ArticleMapper.updateArticle", article);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in update Article : " + e);
            return result;
        }
    }


}
