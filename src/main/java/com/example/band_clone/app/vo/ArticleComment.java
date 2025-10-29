package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.Locale;

@Getter
@Setter
public class ArticleComment {
    int idx;
    int articleNo;
    String writerId;
    String comment;
    LocalDateTime writingTime;

    public ArticleComment() {
    }

    public ArticleComment(int articleNo, String writerId, String comment) {
        this.articleNo = articleNo;
        this.writerId = writerId;
        this.comment = comment;
    }

    public String getPrettyWritingTime(){
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.writingTime);
    }

}
