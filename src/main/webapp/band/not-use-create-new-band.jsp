<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>sign-up</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<div class="signup-wrap">
    <div class="signup">
        <a href="/">로고</a>
        <h2 class="text-center">가제에 오신것을 환영합니다.</h2>

        <p class="text-center text-gray">
            가제는 소프트웨어 개발자를 위한 지식공유 플랫폼입니다.
        </p>
        <form class="signup-form" action="/band-create" method="post">
            <div>
                <label for="bandName"><small>밴드 이름</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="bandName" id="bandName" placeholder="밴드 이름 입력" required autofocus/>
                </div>
            </div>
            <div>
                <label for="description"><small>밴드 설명</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="description" id="description" placeholder="밴드 소개말을 작성해주세요."
                           required/>
                </div>
            </div>

            <div style="margin-top: 5px">
                <label>토픽</label>
                <div>
                    <select name="topic" class="input-100">
                        <option value="">밴드의 주된 관심사를 선택해주세요.</option>

                        <option value="music">음악</option>
                        <option value="photography">사진</option>
                        <option value="painting">그림</option>
                        <option value="animal">동물</option>
                        <option value="health">건강</option>
                        <option value="trip">여행</option>
                        <option value="nature">꽃/나무/자연</option>
                        <option value="hobby ">취미</option>
                        <option value="company">회사</option>
                        <option value="game">게임</option>
                        <option value="exercise">운동</option>

                        <option value="life">사는얘기</option>
                        <option value="gathering">모임&스터디</option>
                        <option value="feedback">자랑&피드백</option>
                        <option value="IT">IT</option>

                        <option value="etc">기타</option>

                    </select>
                </div>
            </div>

            <div>
                <label for="agree"><small>밴드 공개 설정</small></label>
                <div class="mt-1">
                    <input type="checkbox" class="input" name="agree" id="agree" value="true"/> 밴드 공개
                </div>
            </div>
            <div class="text-gray mt-1">
                밴드 공개 설정을 선택하시면 밴드 맴버가 아닌 사람들에게도 게시글이 보여집니다.
            </div>

            <div>
                <button class="bt-submit">내 밴드 만들기</button>
            </div>
        </form>

    </div>

</div>
</body>
</html>
