package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.Locale;

@Getter
@Setter
public class Band {
    int no;
    String bandName;
    String description;
    Boolean isPrivate;
    String topic;
    String masterId;
    LocalDateTime createdAt;

    // 아래는 bandMember 테이블
    int idx;
    int bandNo;
    String memberId;

    public Band() {
    }

    public Band(String bandName, String description, Boolean isPrivate, String topic, String masterId) {
        this.bandName = bandName;
        this.description = description;
        this.isPrivate = isPrivate;
        this.topic = topic;
        this.masterId = masterId;
    }

    public Band(String bandName, String description, Boolean isPrivate, String topic) {
        this.bandName = bandName;
        this.description = description;
        this.isPrivate = isPrivate;
        this.topic = topic;
    }

    public String getPrettyWritingTime(){
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.createdAt);
    }

    public String getPrettyTopic(){
        if(this.topic.equals("life")){
            return "사는 얘기";
        }else if(this.topic.equals("gathering")){
            return "모임/스터디";
        }else if(this.topic.equals("feedback")){
            return "피드백";
        }else{
            return this.topic;
        }
    }


}
