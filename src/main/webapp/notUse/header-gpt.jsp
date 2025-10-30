<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오전 9:55
  (디자인 개선 버전)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    :root{
        --header-bg: #ffffff;
        --accent: #3b82f6;
        --muted: #6b7280;
        --danger: #ef4444;
        --radius: 10px;
        --shadow: 0 6px 18px rgba(15,23,42,0.06);
    }

    /* 기본 레이아웃 */
    header.app-header{
        position: sticky;
        top: 0;
        z-index: 100;
        background: var(--header-bg);
        box-shadow: var(--shadow);
        padding: 10px 18px;
        display: flex;
        align-items: center;
        gap: 16px;
        justify-content: space-between;
        font-family: "Noto Sans KR", system-ui, -apple-system, Roboto, "Segoe UI", sans-serif;
    }
    .header-left, .header-center, .header-right {
        display:flex;
        align-items:center;
        gap:12px;
    }

    /* 로고 */
    .brand{
        display:flex;
        gap:10px;
        align-items:center;
        text-decoration: none;
        color:inherit;
    }
    .brand .logo {
        width:40px;
        height:40px;
        border-radius:8px;
        background: linear-gradient(135deg, #3b82f6, #6366f1);
        display:inline-flex;
        align-items:center;
        justify-content:center;
        color:#fff;
        font-weight:800;
        font-size:1.05rem;
        box-shadow:0 6px 18px rgba(59,130,246,0.14);
    }
    .brand .brand-name { font-weight:700; font-size:1rem; }

    /* 검색(중앙) */
    .header-center { flex:1; justify-content:center; }
    .search-wrap { width:60%; min-width:220px; max-width:520px; }
    .search-input{
        width:100%;
        padding:8px 12px;
        border-radius:999px;
        border:1px solid rgba(15,23,42,0.06);
        background:#fbfdff;
        outline:none;
        font-size:0.95rem;
    }
    .search-input:focus{box-shadow:0 6px 18px rgba(59,130,246,0.08);border-color:var(--accent)}

    /* 우측 영역(버튼 그룹) */
    .actions { display:flex; align-items:center; gap:8px; }
    .btn {
        display:inline-flex;
        align-items:center;
        gap:8px;
        padding:8px 10px;
        border-radius:10px;
        background:transparent;
        border:1px solid rgba(15,23,42,0.06);
        cursor:pointer;
        font-weight:600;
        color:#0b1220;
        text-decoration:none;
    }
    .btn.primary { background:var(--accent); color:#fff; border:none; }
    .btn.ghost { background:transparent; border:1px solid rgba(59,130,246,0.12); color:var(--accent); }

    .btn:focus, .btn:hover { transform: translateY(-2px); box-shadow:0 10px 24px rgba(2,6,23,0.06); }

    /* 알림 버튼 & 배지 */
    .alarm-btn { position:relative; width:44px; height:44px; border-radius:10px; display:inline-flex; align-items:center; justify-content:center; }
    .alarm-icon{ font-size:1.05rem; color:var(--muted); }
    .alarm-badge{
        position:absolute;
        top:6px; right:6px;
        min-width:20px; height:20px;
        padding:0 6px;
        background:var(--danger); color:#fff;
        font-size:0.72rem;
        line-height:20px;
        border-radius:999px;
        display:flex;
        align-items:center;
        justify-content:center;
        box-shadow:0 6px 12px rgba(239,68,68,0.16);
        pointer-events:none;
    }
    .alarm-badge.hidden{ display:none; }

    /* 알림 드롭다운 (간단) */
    .alarm-panel {
        position:absolute;
        right: 18px;
        top:62px;
        width:320px;
        max-height:380px;
        overflow:auto;
        background:#fff;
        border-radius:12px;
        box-shadow:0 18px 40px rgba(2,6,23,0.12);
        border:1px solid rgba(15,23,42,0.04);
        display:none;
    }
    .alarm-panel.open { display:block; }
    .alarm-panel .item { padding:10px 12px; border-bottom:1px solid rgba(15,23,42,0.04); font-size:0.95rem; }
    .alarm-panel .item:last-child { border-bottom:none; }
    .alarm-panel .item .time { color:var(--muted); font-size:0.8rem; }

    /* 모바일: 햄버거 */
    .hamburger { display:none; width:40px; height:40px; border-radius:8px; align-items:center; justify-content:center; cursor:pointer; }
    @media (max-width:880px){
        .header-center{ display:none; }
        .hamburger { display:flex; }
    }
    /* 버튼 그룹 토글 메뉴 (모바일) */
    .mobile-menu { display:none; position:absolute; right:10px; top:62px; background:#fff; border-radius:10px; box-shadow:0 18px 40px rgba(2,6,23,0.12); overflow:hidden; }
    .mobile-menu.open { display:block; }
    .mobile-menu a, .mobile-menu button { display:block; padding:10px 14px; border-bottom:1px solid rgba(15,23,42,0.04); text-align:left; width:220px; background:transparent; border:none; color:inherit; text-decoration:none; }
    .mobile-menu a:last-child, .mobile-menu button:last-child { border-bottom:none; }
</style>

<header class="app-header" role="banner">
    <div class="header-left">
        <a href="/band-main" class="brand" aria-label="홈으로 이동">
            <span class="logo" aria-hidden="true">가제</span>
            <span class="brand-name">가제는 게편</span>
        </a>
    </div>

    <div class="header-center" role="search" aria-label="사이트 검색">
        <div class="search-wrap">
            <%--검색기능 추가--%>
            <form action="/search" method="get" style="width:100%">
                <input class="search-input" name="q" type="search" placeholder="검색어 입력"/>
            </form>
        </div>
    </div>

    <div class="header-right">
        <div class="actions">
            <button class="hamburger" id="hamburger" aria-expanded="false" aria-label="메뉴 열기">
                <svg width="20" height="14" viewBox="0 0 20 14" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                    <rect width="20" height="2" rx="1" fill="#0b1220"></rect>
                    <rect y="6" width="20" height="2" rx="1" fill="#0b1220"></rect>
                    <rect y="12" width="20" height="2" rx="1" fill="#0b1220"></rect>
                </svg>
            </button>

            <c:choose>
                <c:when test="${auth}">
                    <!-- 알림 버튼 -->
                    <div style="position:relative;">
                        <button class="btn alarm-btn" id="alarmBtn" aria-haspopup="true" aria-expanded="false" aria-label="알림 열기">
                            <span class="alarm-icon" aria-hidden="true">&#128276;</span> <!-- 벨 아이콘(간단) -->
                            <c:choose>
                                <c:when test="${noticeCnt == 0}">
                                    <span class="alarm-badge hidden" aria-hidden="true"></span>
                                </c:when>
                                <c:when test="${noticeCnt >= 100}">
                                    <span class="alarm-badge" aria-live="polite" aria-atomic="true">99+</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="alarm-badge" aria-live="polite" aria-atomic="true">${noticeCnt}</span>
                                </c:otherwise>
                            </c:choose>
                        </button>

                        <!-- 간단한 알림 드롭다운: 실제 알림 내용은 서버에서 렌더링/또는 Ajax로 채우세요 -->
                        <div id="alarmPanel" class="alarm-panel" role="region" aria-label="알림 목록">
                            <!-- 서버에서 최근 알림 일부를 넘겨주면 아래처럼 반복 렌더링 -->
                            <c:forEach items="${recentNotices}" var="n">
                                <div class="item">
                                    <div>${n.title}</div>
                                    <div class="time">${n.timeAgo}</div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty recentNotices}">
                                <div class="item">새로운 알림이 없습니다.</div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 사용자 액션 그룹 -->
                    <div class="btn-group" style="display:flex;align-items:center;gap:8px;">
                        <span style="color:var(--muted);font-weight:600">${member.id}님</span>
                        <a href="/my/profile" class="btn">내 정보</a>
                        <a href="/band-main" class="btn ghost">밴드 메인</a>
                        <button class="btn" onclick="logoutConfirm()">로그아웃</button>
                    </div>

                </c:when>
                <c:otherwise>
                    <div class="actions">
                        <a href="/log-in" class="btn">로그인</a>
                        <a href="/sign-up" class="btn primary">회원가입</a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</header>

<!-- 모바일 메뉴(토글) -->
<div id="mobileMenu" class="mobile-menu" aria-hidden="true">
    <c:choose>
        <c:when test="${auth}">
            <a href="/my/profile">내 정보</a>
            <a href="/my/notice">알림 보기</a>
            <a href="/band-main">밴드 메인</a>
            <button onclick="logoutConfirm()" style="background:none;border:none;text-align:left;width:100%;padding:10px;">로그아웃</button>
        </c:when>
        <c:otherwise>
            <a href="/log-in">로그인</a>
            <a href="/sign-up">회원가입</a>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // 로그아웃 확인(원래 로직 유지)
    function logoutConfirm() {
        if (window.confirm("로그아웃 하시겠습니까?")) {
            alert("감사합니다!\n안녕히가세요");
            location.href = '/log-out';
        }
    }

    // 알림 패널 토글
    (function(){
        const alarmBtn = document.getElementById('alarmBtn');
        const alarmPanel = document.getElementById('alarmPanel');
        const hamburger = document.getElementById('hamburger');
        const mobileMenu = document.getElementById('mobileMenu');

        if (alarmBtn && alarmPanel) {
            alarmBtn.addEventListener('click', function(e){
                const open = alarmPanel.classList.toggle('open');
                alarmBtn.setAttribute('aria-expanded', open);
                // 닫을 때 포커스 유지 등 처리
            });

            // 클릭 외부영역 닫기
            document.addEventListener('click', function(e){
                if (!alarmPanel.contains(e.target) && !alarmBtn.contains(e.target)) {
                    alarmPanel.classList.remove('open');
                    alarmBtn.setAttribute('aria-expanded', 'false');
                }
            });
        }

        // 모바일 햄버거 토글
        if (hamburger && mobileMenu) {
            hamburger.addEventListener('click', function(){
                const open = mobileMenu.classList.toggle('open');
                hamburger.setAttribute('aria-expanded', open);
                mobileMenu.setAttribute('aria-hidden', !open);
            });

            // 닫기 on outside click
            document.addEventListener('click', function(e){
                if (!mobileMenu.contains(e.target) && !hamburger.contains(e.target)) {
                    mobileMenu.classList.remove('open');
                    hamburger.setAttribute('aria-expanded', 'false');
                    mobileMenu.setAttribute('aria-hidden', 'true');
                }
            });
        }
    })();
</script>
