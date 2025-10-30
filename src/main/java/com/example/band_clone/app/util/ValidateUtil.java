package com.example.band_clone.app.util;

public class ValidateUtil {
    public static boolean isDuplicateId(String id) {
        if (MemberUtil.selectMemberById(id) != null) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean isDuplicateNickName(String nickname) {
        if (MemberUtil.selectMemberByNickName(nickname) != null) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean isNotValidEmail(String email) {
        if (email.matches("[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isNotValidId(String id) {
        if (id.matches("[a-zA-Z0-9!@#$%^&*]{4,15}")) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isNotValidPw(String pw) {

        if (pw.matches("(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,15}")) {
            return false;
        } else {
            return true;
        }

        /*
        if (pw == null || pw.length() < 6) {
            return true;
        }

        boolean hasAlpha = false;
        boolean hasDigit = false;

        for (int i = 0; i < pw.length(); i++) {
            char c = pw.charAt(i);

            if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
                hasAlpha = true;
            } else if (c >= '0' && c <= '9') {
                hasDigit = true;
            } else {
                return true;
            }
        }

        return !(hasAlpha && hasDigit);
         */
    }

    public static String setErrMsg(int result) {
        String mainError = null;
        switch (result) {
            case 500:
                System.out.println("loginId duplicated");
                mainError = "중복되는 아이디가 존재합니다.";
                break;
            case 501:
                System.out.println("nickname duplicated");
                mainError = "중복되는 별명이 존재합니다.";
                break;
            case 502:
                System.out.println("loginId is Not ValidId");
                mainError = "아이디를 조건에 맞게 입력해주세요.";
                break;
            case 503:
                System.out.println("pw is Not ValidId");
                mainError = "비밀번호를 조건에 맞게 입력해주세요.\n(영문, 숫자, 특수문자를 포함한 6~15자)";
                break;
            case 504:
                System.out.println("insertMember method is null");
                mainError = "Member 객체가 null입니다.";
                break;
            case 505:
                System.out.println("ID does not exist");
                mainError = "존재하지 않는 아이디입니다";
                break;
            case 506:
                System.out.println("PW does not match");
                mainError = "잘못된 비밀번호입니다.";
                break;
            case 507:
                System.out.println("Article insert error");
                mainError = "오류! Article 등록 실패";
                break;
            case 508:
                System.out.println("ArticleLike insert error");
                mainError = "오류! ArticleLike 정보 추가 실패";
                break;
            case 509:
                System.out.println("password mismatch");
                mainError = "현재 비밀번호가 일치하지 않습니다.";
                break;
            case 510:
                System.out.println("password same");
                mainError = "새로운 비밀번호가 기존 비밀번호와 동일합니다.";
                break;
            case 511:
                System.out.println("email is Not ValidId");
                mainError = "이메일을 규격에 맞게 작성해주세요";
                break;
        }
        return mainError;
    }
}
