<%-- my-loginHistory.jsp (간단/가벼운 버전) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>내 접속 기록</title>

    <style>
        /* 최소한의 깔끔한 스타일 (그린 계열 유지) */
        :root {
            --g-dark: #083214;
            --g-mid: #1a7f2a;
            --g-muted: #557a54;
            --bg: #f6fff6;
            --accent: #2bd34c;
        }

        html, body {
            height: 100%;
        }

        body {
            margin: 0;
            font-family: Arial, "Noto Sans KR", sans-serif;
            background: var(--bg);
            color: var(--g-dark);
        }

        .wrap {
            max-width: 960px;
            margin: 18px auto;
            padding: 12px;
            box-sizing: border-box;
        }

        .banner {
            height: 80px;
            background: #eefef0;
            border: 1px solid #e6f2e6;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--g-mid);
            font-weight: 700;
            margin-bottom: 14px;
        }

        h1 {
            font-size: 1.1rem;
            color: var(--g-dark);
            margin: 8px 0 12px 0;
        }

        .list {
            background: #fff;
            border: 1px solid #e6efe6;
            border-radius: 8px;
            overflow: hidden;
        }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 12px;
            border-bottom: 1px solid #f0f6f0;
            box-sizing: border-box;
        }

        .row:last-child {
            border-bottom: none;
        }

        .left {
            display: flex;
            flex-direction: column;
        }

        .ip {
            font-weight: 700;
            color: var(--g-mid);
        }

        .time {
            color: var(--g-muted);
            font-size: 13px;
            margin-top: 4px;
        }

        .ua {
            color: var(--g-muted);
            font-size: 13px;
            max-width: 360px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: right;
        }

        .pager {
            text-align: center;
            padding: 14px 8px;
        }

        .pager button {
            margin: 0 6px;
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid transparent;
            background: transparent;
            cursor: pointer;
            font-weight: 700;
            color: var(--g-dark);
        }

        .pager button.active {
            background: var(--accent);
            color: #fff;
            border-color: #1aa61f;
        }

        @media (max-width: 640px) {
            .row {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .ua {
                max-width: 100%;
                text-align: left;
                white-space: normal;
            }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap" role="main" aria-labelledby="titleMyHistory">
    <div class="banner">내 접속 기록</div>

    <h1 id="titleMyHistory"><c:out value="${member.nickname != null ? member.nickname : member.id}"/>님의 접속 기록</h1>

    <div class="list" role="region" aria-label="접속기록 목록">
        <!-- 서블릿에서 history 리스트를 항상 넣어준다고 가정 -->
        <c:forEach items="${history}" var="one">
            <div class="row" role="article">
                <div class="left">
                    <div class="ip">IP: <c:out value="${one.loginIp}"/></div>
                    <div class="time"><c:out value="${one.prettyLoginAt}"/> - <small>(<c:out value="${one.loginAt}"/>)</small></div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="pager" role="navigation" aria-label="페이지 네비게이션">
        <c:forEach var="i" begin="1" end="${maxPage}">
            <c:url var="pageUrl" value="/my-loginHistory">
                <c:param name="page" value="${i}"/>
            </c:url>

            <c:if test="${i == currentPage}">
                <button type="button" class="active" aria-current="page" onclick="location.href='${pageUrl}'"><c:out
                        value="${i}"/></button>
            </c:if>
            <c:if test="${i != currentPage}">
                <button type="button" onclick="location.href='${pageUrl}'"><c:out value="${i}"/></button>
            </c:if>
        </c:forEach>
    </div>
</div>

</body>
</html>