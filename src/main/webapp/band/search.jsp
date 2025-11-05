<%-- main.jsp (검증된 수정본) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>band main</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 최소 레이아웃 보정 (기존 style.css가 있으면 중복 가능) */
        .main { display:flex; gap:16px; max-width:1200px; margin:20px auto; padding:0 12px; box-sizing:border-box; align-items:flex-start; }
        .col { display:flex; flex-direction:column; gap:12px; }
        .col.side { flex:1; min-width:220px; }
        .col.center { flex:4; min-width:480px; }
        .search-wrap { padding:0.5rem 0; text-align:center; }
        .search-input { width:200px; max-width:100%; padding:8px 10px; box-sizing:border-box; border:1px solid #ddd; border-radius:6px; }
        .btn-link { display:inline-block; padding:8px 12px; border-radius:6px; text-decoration:none; background:#1ec800; color:#fff; border:none; cursor:pointer; }
        .article-item { padding:12px 0; border-bottom:1px solid #f0f0f0; }
        .article-topic { font-size:12px; color:#777; margin-right:6px; }
        .article-link { text-decoration:none; color:#222; }
        @media (max-width:920px) { .main { flex-direction:column; } .col.side{min-width:unset;} }

        .recommend-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .recommend-list li {
            margin-top: 0.5rem;
        }

        .recommend-list a {
            display: inline-block;
            width: 180px;             /* ✅ 표시할 최대 너비 지정 (조정 가능) */
            white-space: nowrap;      /* 줄바꿈 방지 */
            overflow: hidden;         /* 넘친 부분 숨기기 */
            text-overflow: ellipsis;  /* ... 으로 표시 */
            text-decoration: none;
            color: #333;
            font-size: 0.9rem;
            line-height: 1.4;
            transition: color 0.2s;
            vertical-align: middle;
        }

        .recommend-list a:hover {
            color: #007bff;
        }

        .recommend-title {
            font-size: 1rem;
            color: #444;
            margin-bottom: 0;
            padding-bottom: 0.3rem;
            border-bottom: 2px solid #ddd; /* ✅ h3 아래에 얇은 선 */
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<c:choose>
    <c:when test="${msg == 1}">
        <script>window.alert("회원 탈퇴가 정상적으로 처리되었습니다.");</script>
    </c:when>
    <c:when test="${msg == 2}">
        <script>window.alert("밴드 삭제가 정상적으로 처리되었습니다.");</script>
    </c:when>
</c:choose>

<div class="main">
    <!-- 왼쪽: 추천 밴드 -->
    <div class="col side">
        <h3 class="recommend-title">
            <c:out value="${member.id}"/>님의 맞춤 밴드
        </h3>

        <ul class="recommend-list">
            <c:forEach var="one" items="${recommend}">
                <li>
                    <a href="<c:url value='/band'/>?no=${one.no}" title="${one.name}">
                        <c:out value="${one.name}"/>
                    </a>
                </li>
            </c:forEach>
            <c:if test="${empty recommend}">
                <li>추천 밴드가 없습니다.</li>
            </c:if>
        </ul>

        <!-- 전체 보기 버튼 -->
        <div style="padding-top:10px;">
            <a href="<c:url value='/band-search'/>" class="btn-link">전체 밴드 보기</a>
        </div>
    </div>


    <!-- 중앙 -->
    <div class="col center">
        <div>
            <!-- 섹션 제목: JSTL로 분기 -->
            <c:choose>
                <c:when test="${empty keyword}">
                    <p style="margin-top:20px; display:flex; align-items:center; gap:12px; padding:8px 12px; border-radius:6px; background:#f6fff0; color:#1b5a20; font-weight:700;">
                        <span>📚 전체 밴드 노출</span>
                    </p>
                </c:when>
                <c:otherwise>
                    <p style="margin-top:20px; display:flex; align-items:center; gap:12px; padding:8px 12px; border-radius:6px; background:#fff8e8; color:#6b4b12; font-weight:700;">
                        <span>🔎 <c:out value="${fn:escapeXml(keyword)}"/>에 대한 검색 결과</span>
                    </p>
                </c:otherwise>
            </c:choose>

            <!-- 결과 리스트 -->
            <c:forEach items="${keywordBands}" var="one">
                <div class="article-item">
                    <div style="display:flex; justify-content:space-between;">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic"><c:out value='${topic}'/></span>
                            </c:forEach>
                            <div>
                                <span><small><c:out value='${one.masterId}'/>님의 밴드</small></span>
                                <span>&middot; <small><c:out value='${one.prettyCreatedAt}'/>에 창설됨</small></span>
                                <span><small><c:if test="${one.joined}"> - ✅(맴버)</c:if></small></span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <a href="<c:url value='/band'><c:param name='no' value='${one.no}'/></c:url>" class="article-link">
                            <span style="font-size:1.1rem; font-weight:500;"><c:out value='${one.name}'/></span>
                        </a>
                    </div>
                </div>
            </c:forEach>
            <div style="padding: 1.5rem 0; margin-top: 2rem; text-align: center">
                <form action="/band-search" method="get">
                    <input type="hidden" name="keyword" value="${keyword}">
                    <c:forEach var="i" begin="1" end="${maxPage}">
                        <button
                                type="submit"
                                name="currentPage"
                                value="${i}"
                                class=${i == currentPage ? 'active-page-link' : ''}>${i}</button>
                    </c:forEach>
                </form>
            </div>

            <c:if test="${empty keywordBands}">
                <div style="padding:12px; margin-top:8px; border-radius:6px; border:1px dashed #eee; background:#fff;">
                    검색 결과가 없습니다.
                </div>
            </c:if>
        </div>
    </div>

    <!-- 오른쪽 빈 칸 -->
    <div class="col side" style="min-width:200px;">
        <!-- 여기에 위젯 추가 가능 -->
    </div>
</div>

<script>
    function keywordConfirm(event) {
        var input = document.getElementById("keyword");
        if(!input) return true;

        var keyword = input.value.trim();

        // 허용: 빈 검색 허용하지 않음 — 필요하면 빈검색 허용으로 변경
        if (keyword === "") {
            alert("빈칸으로 검색할 수 없습니다. 정보를 입력해주세요.");
            input.focus();
            event.preventDefault();
            return false;
        }

        // 한글/영문/숫자 3자 이상 규칙
        var regex = /^[a-zA-Z0-9가-힣]{3,}$/;
        if (!regex.test(keyword)) {
            alert("영어, 숫자, 한글 중 3글자 이상 입력해야 검색이 가능합니다.");
            input.focus();
            event.preventDefault();
            return false;
        }

        return true;
    }
</script>

</body>
</html>
