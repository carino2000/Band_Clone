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


    public String getPrettyWritingTime(){
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.createdAt);
    }


}
