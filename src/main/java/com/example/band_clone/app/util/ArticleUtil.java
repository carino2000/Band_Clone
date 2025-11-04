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
            result = updateArticleCommentCnt(articleComment.getArticleNo());
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

    // 내가 쓴 글보기
    public static List<Article> selectArticleByWriterId(String writerId) {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Article> list = sqlSession.selectList("mappers.ArticleMapper.selectArticleByWriterId", writerId);
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectArticleByWriterId : " + e);
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


    public static int deleteArticleByIdx(int idx) {
        int result = -1;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.ArticleMapper.deleteArticleByIdx", idx);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteArticleByIdx: " + e);
        }
        return result;
    }

    public static int deleteMyCommentByIdx(int idx) {
        int result = -1;
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            result = session.delete("mappers.ArticleMapper.deleteMyCommentByIdx", idx);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteMyCommentByIdx: " + e);
        }
        return result;
    }


    public static void deleteAllMyComment(String id) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.ArticleMapper.deleteAllMyComment", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyComment: " + e);
        }
    }

    public static void deleteAllMyArticleComment(String id) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.ArticleMapper.deleteAllMyArticleComment", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyArticleComment: " + e);
        }
    }


    public static void deleteAllMyArticle(String id) {
        try {
            deleteAllMyArticleComment(id);

            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.ArticleMapper.deleteAllMyArticle", id);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteAllMyArticle: " + e);
        }
    }

    public static void deleteArticleCommentByBandNo(int bandNo) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.ArticleMapper.deleteArticleCommentByBandNo", bandNo);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteArticleCommentByBandNo: " + e);
        }
    }

    public static void deleteArticleByBandNo(int bandNo) {
        try {
            SqlSession session = MyBatisUtil.build().openSession(true);
            session.delete("mappers.ArticleMapper.deleteArticleByBandNo", bandNo);
            session.close();
        } catch (Exception e) {
            System.out.println("Error in deleteArticleByBandNo: " + e);
        }
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


    public static int updateArticleCommentCnt(int aritcleNo) {
        int result = -1;
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            result = sqlSession.update("mappers.ArticleMapper.updateArticleCommentCnt", aritcleNo);
            sqlSession.close();
            return result;
        } catch (Exception e) {
            System.out.println("Error in updateArticleCommentCnt : " + e);
            return result;
        }
    }

}
