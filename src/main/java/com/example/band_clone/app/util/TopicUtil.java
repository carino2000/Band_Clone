package com.example.band_clone.app.util;

import com.example.band_clone.app.vo.Band;
import com.example.band_clone.app.vo.Member;
import com.example.band_clone.app.vo.Topic;
import org.apache.ibatis.session.SqlSession;

import java.util.*;

public class TopicUtil {

// -------------------------------------- insert --------------------------------------


// -------------------------------------- select --------------------------------------

    public static List<Topic> selectAllTopics() {
        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Topic> list = sqlSession.selectList("mappers.TopicMapper.selectAllTopics");
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in selectAllTopics : " + e);
            return null;
        }
    }


    public static String findMyMostTopic(String id) {

        try {
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<String> list = sqlSession.selectList("mappers.TopicMapper.findMyMostTopic", id);
            List<String> myTopics = new ArrayList<String>();
            for (String str : list) {
                String[] strArr = str.trim().split("\\s+");
                myTopics.addAll(Arrays.asList(strArr));
            }

            Map<String, Integer> map = new HashMap<String, Integer>();
            for (String str : myTopics) {
                map.put(str, map.getOrDefault(str, 0) + 1);
            }
            String mostTopic = null;
            String subTopic = null;
            int count = 0;
            for (Map.Entry<String, Integer> entry : map.entrySet()) {
                if (count < entry.getValue()) {
                    count = entry.getValue();
                    subTopic = mostTopic;
                    mostTopic = entry.getKey();
                }
            }

            if (mostTopic.equals("etc")) {
                mostTopic = subTopic;
            }
            sqlSession.close();
            return mostTopic;
        } catch (Exception e) {
            System.out.println("Error in findMyMostTopic : " + e);
            return null;
        }

    }


    public static List<Band> recommendBandByMostTopic(String id) {
        try {
            String mostTopic = "%" + findMyMostTopic(id) + "%";
            SqlSession sqlSession = MyBatisUtil.build().openSession(true);
            List<Band> list = sqlSession.selectList("mappers.TopicMapper.recommendBandByMostTopic", mostTopic);
            if (list.size() < 5) {
                List<Band> allBand = BandUtil.selectAllBandsExceptMyBands(id);
                int listSize = list.size();
                job:
                for (int i = 0; i < 5 - listSize; i++) {
                    int num = (int)(Math.random() * allBand.size());
                    for(Band band : list) {
                        if(band.getName().equals(allBand.get(num).getName())) {
                            i--;
                            continue job;
                        }
                    }
                    list.add(allBand.get(num));
                }
            }
            sqlSession.close();
            return list;
        } catch (Exception e) {
            System.out.println("Error in recommendBandByMostTopic : " + e);
            return null;
        }
    }


// -------------------------------------- delete --------------------------------------


// -------------------------------------- update --------------------------------------
}
