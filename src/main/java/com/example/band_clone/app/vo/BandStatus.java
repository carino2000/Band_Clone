package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.util.List;
import java.util.Locale;

@Setter
@Getter
public class BandStatus {
    private Band band;
    private boolean joined;

    // 편의 위임 메서드들 (JSP에서 기존처럼 one.name 등 쓰려면 필요)
    public int getNo() { return band == null ? 0 : band.getNo(); }
    public String getName() { return band == null ? null : band.getName(); }
    public String getDescription() { return band == null ? null : band.getDescription(); }
    public Boolean getIsPrivate() { return band == null ? null : band.getIsPrivate(); }
    public String getTopic() { return band == null ? null : band.getTopic(); }
    public String getMasterId() { return band == null ? null : band.getMasterId(); }
    public java.time.LocalDateTime getCreatedAt() { return band == null ? null : band.getCreatedAt(); }

    // 만약 Band에 prettyCreatedAt, prettyTopic 같은 헬퍼가 없다면,
    // DTO에서 계산해 제공할 수 있음:
    public String getPrettyCreatedAt() {
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.band.createdAt);
    }

    // prettyTopic이 List<String>이라 가정할 때
    public List<String> getPrettyTopic() {
        return band == null ? java.util.Collections.emptyList() : band.getPrettyTopic();
    }
}
