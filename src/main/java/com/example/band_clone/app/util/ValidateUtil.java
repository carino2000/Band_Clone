package com.example.band_clone.app.util;

public class ValidateUtil {
//    public static boolean isDuplicateId(String id) {
//        if (selectMemberById(id) != null) {
//            return true;
//        } else {
//            return false;
//        }
//    }

//    public static boolean isDuplicateNickName(String nickname) {
//        if (selectMemberByNickName(nickname) != null) {
//            return true;
//        } else {
//            return false;
//        }
//    }

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
}
