package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.Locale;

@Getter
@Setter
public class BandMember {
    int idx;
    int bandNo;
    String memberId;
    String memberNickname;
    boolean isApproved;
    String greeting;
    LocalDateTime requestAt;

    String bandName; // join 용

    public BandMember() {}

    public BandMember(int bandNo, String memberId, String memberNickname, boolean isApproved, String greeting) {
        this.bandNo = bandNo;
        this.memberId = memberId;
        this.memberNickname = memberNickname;
        this.isApproved = isApproved;
        this.greeting = greeting;
    }

    public BandMember(int bandNo, String memberId, String memberNickname, boolean isApproved) {
        this.bandNo = bandNo;
        this.memberId = memberId;
        this.memberNickname = memberNickname;
        this.isApproved = isApproved;
    }

    public String getPrettyRequestAt(){
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.requestAt);
    }

}

