package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

@Getter
@Setter
public class Band {
    int no;
    String name;
    String description;
    Boolean isPrivate;
    String topic;
    String masterId;
    LocalDateTime createdAt;

    // 아래는 bandMember 테이블 사용할 때
    int idx;
    int bandNo;
    String memberId;

    public Band() {
    }

    public Band(String name, String description, Boolean isPrivate, String topic, String masterId) {
        this.name = name;
        this.description = description;
        this.isPrivate = isPrivate;
        this.topic = topic;
        this.masterId = masterId;
    }

    public Band(String name, String description, Boolean isPrivate, String topic) {
        this.name = name;
        this.description = description;
        this.isPrivate = isPrivate;
        this.topic = topic;
    }

    public String getPrettyCreatedAt() {
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.createdAt);
    }

    public List<String> getPrettyTopic() {
        String[] topics = this.topic.trim().split("\\s+");
        List<String> topicList = new ArrayList<String>();

        for (String topic : topics) {
            switch (topic) {
                case "music":
                    topicList.add("음악");
                    break;
                case "photography":
                    topicList.add("사진");
                    break;
                case "painting":
                    topicList.add("그림");
                    break;
                case "animal":
                    topicList.add("동물");
                    break;
                case "health":
                    topicList.add("건강");
                    break;
                case "trip":
                    topicList.add("여행");
                    break;
                case "nature":
                    topicList.add("꽃/나무/자연");
                    break;
                case "hobby":
                    topicList.add("취미");
                    break;
                case "company":
                    topicList.add("회사");
                    break;
                case "game":
                    topicList.add("게임");
                    break;
                case "exercise":
                    topicList.add("운동");
                    break;
                case "life":
                    topicList.add("사는얘기");
                    break;
                case "gathering":
                    topicList.add("모임&스터디");
                    break;
                case "feedback":
                    topicList.add("자랑&피드백");
                    break;
                case "it":
                    topicList.add("IT");
                    break;
                case "programming":
                    topicList.add("프로그래밍");
                    break;
                case "etc":
                    topicList.add("기타");
                    break;
                default:
                    topicList.add("none");
                    break;
            }
        }

        return topicList;
    }


}