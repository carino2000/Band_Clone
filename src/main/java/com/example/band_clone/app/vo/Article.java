package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;

@Getter
@Setter
public class Article {

    int idx;
    int bandNo;
    String writerId;
    String content;
    LocalDateTime wroteAt;
    int viewCnt;
    int likeCnt;
    int commentCnt;

    List<ArticleComment> articleComments;


    public Article() {
    }


    public Article(int bandNo, String writerId, String content) {
        this.bandNo = bandNo;
        this.writerId = writerId;
        this.content = content;
    }

    public String getPrettyWroteAt() {
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.wroteAt);
    }


}
