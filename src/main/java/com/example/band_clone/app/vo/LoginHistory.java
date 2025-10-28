package com.example.band_clone.app.vo;

import lombok.Getter;
import lombok.Setter;
import org.ocpsoft.prettytime.PrettyTime;

import java.time.LocalDateTime;
import java.util.Locale;

@Setter
@Getter
public class LoginHistory {
    int idx;
    String loginId;
    String loginIp;
    LocalDateTime loginAt;

    public LoginHistory() {
    }

    public LoginHistory(String loginId, String loginIp) {
        this.loginId = loginId;
        this.loginIp = loginIp;
    }

    public LoginHistory(String loginId, String loginIp, LocalDateTime loginAt) {
        this.loginId = loginId;
        this.loginIp = loginIp;
        this.loginAt = loginAt;
    }

    public String getPrettyLoginAt(){
        PrettyTime p = new PrettyTime(Locale.KOREA);
        return p.format(this.loginAt);
    }

}
