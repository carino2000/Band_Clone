<%-- main.jsp (수정본) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>band main</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
    <style>
        /* 최소한의 레이아웃 보완: 기존 스타일 유지하면서 텍스트박스/버튼/정렬 안정화 */
        .main { display:flex; gap:16px; max-width:1200px; margin:20px auto; padding:0 12px; box-sizing:border-box; }
        .col { display:flex; flex-direction:column; gap:12px; }
        .col.side { flex:1; min-width:220px; }
        .col.center { flex:4; min-width:480px; }
        .recommend-list { list-style:none; padding:0; margin:0; }
        .recommend-list li { margin-top:1rem; }
        .search-wrap { padding:0.5rem 0; text-align:center; }
        .search-input { width:200px; max-width:100%; padding:8px 10px; box-sizing:border-box; border:1px solid #ddd; border-radius:6px; }
        .btn-link { display:inline-block; padding:8px 12px; border-radius:6px; text-decoration:none; background:#1ec800; color:#fff; border:none; cursor:pointer; }
        .article-item { padding:12px 0; border-bottom:1px solid #f0f0f0; }
        .article-topic { font-size:12px; color:#777; margin-right:6px; margin-bottom: 3px}
        .article-link { text-decoration:none; color:#222; }
        @media (max-width:920px) { .main { flex-direction:column; } .col.side{min-width:unset;} }
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
        <div>
            <h3><c:out value="${member.id}"/>님의 맞춤 밴드</h3>
            <ul class="recommend-list">
                <c:forEach var="one" items="${recommend}">
                    <li>
                        <a href="<c:url value='/band'/>?no=${one.no}">
                            <c:out value="${one.name}"/>
                        </a>
                    </li>
                </c:forEach>
                <c:if test="${empty recommend}">
                    <li>추천 밴드가 없습니다.</li>
                </c:if>
            </ul>
        </div>

        <!-- 전체 밴드 보기 (a 태그를 버튼처럼 사용) -->
        <div style="padding:0.5rem 0;">
            <a href="<c:url value='/band-search'/>" class="btn-link">전체 밴드 보기</a>
        </div>
    </div>


    <!-- 중앙 -->
    <div class="col center">
        <!-- 이미지 배너 자리(빈 div 유지) -->
        <div style="min-height:120px; border-radius:8px; background:linear-gradient(90deg,#f6fff0,#eafbe8); display:flex; align-items:center; justify-content:center;">
            <strong>이미지 배너 자리</strong>
        </div>

        <!-- 내가 만든 밴드 -->
        <div>
            <p style="margin-top:20px; display:flex; align-items:center; gap:12px; padding:10px 14px; background:linear-gradient(90deg,#f6fff0,#eef9ea); border-radius:8px; border:1px solid #e6f4df; color:#1b5a20; font-weight:700; box-shadow:0 2px 6px rgba(27,90,32,0.06);">
                <span style="font-size:18px; line-height:1;">📥</span>
                <span style="font-size:15px; letter-spacing:-0.2px;">내가 만든 밴드</span>
                <span style="margin-left:auto; font-size:13px; color:#6b7f6b; font-weight:500;"></span>
            </p>
            <c:forEach items="${myBands}" var="one">
                <div class="article-item">
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic"><c:out value="${topic}"/></span>
                            </c:forEach>
                            <div>
                                <span><c:out value="${one.masterId}"/>님의 밴드</span>
                                <span>&middot; <small><c:out value="${one.prettyCreatedAt}"/>에 창설됨</small></span>
                            </div>
                        </div>
                        <div>
                            <a href="<c:url value='/band'/>?no=${one.no}" class="article-link">
                                <span style="font-size:1.1rem; font-weight:500;"><br/><c:out value="${one.name}"/></span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty myBands}">
                <div>만든 밴드가 없습니다.</div>
            </c:if>
        </div>

        <!-- 내가 가입한 밴드 -->
        <div>
            <p style="margin-top:20px; display:flex; align-items:center; gap:12px; padding:10px 14px; background:linear-gradient(90deg,#f6fff0,#eef9ea); border-radius:8px; border:1px solid #e6f4df; color:#1b5a20; font-weight:700; box-shadow:0 2px 6px rgba(27,90,32,0.06);">
                <span style="font-size:18px; line-height:1;">📥</span>
                <span style="font-size:15px; letter-spacing:-0.2px;">내가 가입한 밴드</span>
                <span style="margin-left:auto; font-size:13px; color:#6b7f6b; font-weight:500;">가입 상태 · 최근 활동 확인</span>
            </p>

            <c:forEach items="${joinedBands}" var="one">
                <div class="article-item">
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic"><c:out value="${topic}"/></span>
                                <c:if test="${!st.last}"><span class="article-topic">|</span></c:if>
                            </c:forEach>
                            <div>
                                <span><c:out value="${one.masterId}"/>님의 밴드</span>
                                <span>&middot; <small><c:out value="${one.prettyCreatedAt}"/>에 창설
                                    <c:if test="${!one.approved}"> (가입 승인 대기 중)</c:if>
                                </small></span>
                            </div>
                        </div>
                        <div >
                            <a href="<c:url value='/band'/>?no=${one.no}" class="article-link">
                                <span style="font-size:1.1rem; font-weight:500;"><c:out value="${one.name}"/></span>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty joinedBands}">
                <div>가입한 밴드가 없습니다.</div>
            </c:if>
        </div>
    </div>

    <!-- 오른쪽 빈 칸(유지) -->
    <div class="col side" style="min-width:200px;">
        <!-- 필요하면 위젯 추가 -->
    </div>
</div>

</body>
</html>
