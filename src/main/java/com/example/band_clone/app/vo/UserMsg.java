package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.Locale;

@Getter
@Setter
public class UserMsg {

    int idx;
    String writerId;
    String recipientId;
    String content;
    LocalDateTime wroteAt;

    public UserMsg() {
    }

    public UserMsg(String writerId, String content) {
        this.writerId = writerId;
        this.content = content;
    }

    public UserMsg(String writerId, String recipientId, String content) {
        this.writerId = writerId;
        this.recipientId = recipientId;
        this.content = content;
    }

    public String getPrettyWroteAt() {
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.wroteAt);
    }

}
