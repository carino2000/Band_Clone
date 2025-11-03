<%-- band-create.jsp (그린 테마, 안정 동작 버전) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>밴드 만들기</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 그린 테마, 동작 우선 inline 스타일 */
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; background:#f6fff6; margin:0; padding:18px; color:#0b2b12; }
        .wrap { max-width:900px; margin:18px auto; padding:20px; box-sizing:border-box; }
        .card { background:#ffffff; border-radius:12px; padding:20px; box-shadow:0 8px 24px rgba(5,80,20,0.06); border:1px solid rgba(7,90,10,0.06); }
        h1 { margin:0 0 8px 0; color:#0f3e13; font-size:22px; }
        p.lead { margin:6px 0 16px 0; color:#226022; }

        label small { font-size:13px; color:#133a18; font-weight:700; }

        .input { width:100%; padding:10px 12px; border-radius:8px; border:1px solid #e6f3ea; background:#fbfffb; box-sizing:border-box; }
        .textarea { width:100%; min-height:120px; padding:12px; border-radius:8px; border:1px solid #e6f3ea; background:#fbfffb; box-sizing:border-box; resize:vertical; }

        .btn {
            display:inline-flex; align-items:center; gap:8px;
            padding:10px 14px; border-radius:10px; border:none; cursor:pointer; font-weight:700;
        }
        .btn-primary {
            background:linear-gradient(180deg,#2bd34c,#1aa61f); color:#fff; box-shadow:0 8px 20px rgba(26,166,31,0.14);
        }
        .btn-ghost {
            background:transparent; border:1px solid #e6f3ea; color:#155322;
        }

        .helper { font-size:13px; color:#4b6b4b; margin-top:6px; }

        /* chips */
        .chips { display:flex; flex-wrap:wrap; gap:8px; margin-top:8px; }
        .chip {
            padding:8px 12px; border-radius:999px; background:#f3fff3; border:1px solid rgba(12,80,18,0.06);
            cursor:pointer; user-select:none; font-weight:600; color:#154f22;
        }
        .chip[aria-pressed="true"] { background: linear-gradient(180deg,#7ef07f,#2bd34c); color:#05280a; box-shadow:0 8px 20px rgba(26,166,31,0.12); transform:translateY(-2px); }

        .selected-count { display:inline-block; padding:6px 10px; border-radius:999px; background:#eefbe9; color:#1a7f2a; font-weight:700; margin-left:8px; }

        @media (max-width:760px){
            .wrap { padding:12px; }
            .chips { gap:6px; }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <div class="card">
        <h1>새 밴드 만들기</h1>
        <p class="lead">함께 활동할 주제를 선택하고, 밴드를 만들어 보세요.</p>

        <form id="bandCreateForm" action="<c:url value='/band-create'/>" method="post">
            <!-- 밴드 이름 -->
            <div style="margin-top:12px;">
                <label for="name"><small>밴드 이름</small></label>
                <div style="margin-top:8px;">
                    <input id="name" name="name" class="input" type="text" placeholder="밴드 이름을 입력하세요" required/>
                </div>
            </div>

            <!-- 설명 -->
            <div style="margin-top:12px;">
                <label for="description"><small>밴드 설명</small></label>
                <div style="margin-top:8px;">
                    <input id="description" name="description" class="input" type="text" placeholder="간단한 밴드 소개를 입력하세요" required/>
                </div>
            </div>

            <!-- 토픽 (칩 UI) -->
            <div style="margin-top:14px;">
                <label><small>토픽 (하나 이상 선택)</small></label>
                <div class="helper">밴드의 주요 관심사를 하나 이상 선택하세요. (복수 선택 가능)</div>

                <!-- 숨은 multi select: 서버에서 request.getParameterValues("topic")로 받습니다 -->
                <select id="topicSelect" name="topic" multiple style="display:none;"></select>

                <!-- 칩 컨테이너 -->
                <div id="topicList" class="chips" role="list" aria-label="토픽 목록"></div>

                <div style="margin-top:10px;">
                    <span class="helper">선택된 항목</span>
                    <span id="selectedCount" class="selected-count">0</span>
                </div>
            </div>

            <!-- 닉네임 -->
            <div style="margin-top:14px;">
                <label for="nickname"><small>밴드 내 닉네임 (선택)</small></label>
                <div style="margin-top:8px;">
                    <input id="nickname" name="nickname" class="input" type="text" placeholder="밴드 내에서 사용할 닉네임을 입력하세요 (선택)"/>
                </div>
            </div>

            <!-- 비공개 여부 -->
            <div style="margin-top:14px;">
                <label class="helper"><small>밴드 공개 설정</small></label>
                <div style="margin-top:8px; display:flex; gap:12px; align-items:center;">
                    <label style="display:inline-flex; align-items:center; gap:8px; cursor:pointer;">
                        <input type="checkbox" id="isPrivate" name="isPrivate" value="true" style="width:18px; height:18px; accent-color:#1aa61f;"/>
                        비공개 밴드로 설정 (비회원은 게시글을 볼 수 없음)
                    </label>
                </div>
            </div>

            <!-- 제출 -->
            <div style="margin-top:18px; display:flex; gap:12px; justify-content:flex-end;">
                <a href="<c:url value='/band-main'/>" class="btn btn-ghost" role="button">취소</a>
                <button type="submit" class="btn btn-primary">밴드 만들기</button>
            </div>
        </form>
    </div>
</div>

<script>
    (function(){
        // 서버에서 topics 리스트를 안전하게 JS로 전달
        const topics = [
            <c:forEach var="t" items="${topics}" varStatus="st">
            {
                value: '${fn:replace(fn:escapeXml(t.code), "'", "\\'")}',
                label: '${fn:replace(fn:escapeXml(t.name), "'", "\\'")}'
            }<c:if test="${!st.last}">,</c:if>
            </c:forEach>
        ];

        const listEl = document.getElementById('topicList');
        const selectEl = document.getElementById('topicSelect');
        const countEl = document.getElementById('selectedCount');
        const form = document.getElementById('bandCreateForm');

        const selected = new Set();

        function renderChip(item) {
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'chip';
            btn.setAttribute('role','button');
            btn.setAttribute('aria-pressed','false');
            btn.setAttribute('data-value', item.value);
            btn.innerText = item.label;

            btn.addEventListener('click', function(){
                toggle(item.value, btn);
            });
            btn.addEventListener('keydown', function(e){
                if(e.key === 'Enter' || e.key === ' '){
                    e.preventDefault();
                    btn.click();
                }
            });

            return btn;
        }

        function toggle(value, btn){
            if(selected.has(value)){
                selected.delete(value);
                btn.setAttribute('aria-pressed','false');
            } else {
                selected.add(value);
                btn.setAttribute('aria-pressed','true');
            }
            syncSelect();
            renderCount();
        }

        function syncSelect(){
            // clear select
            selectEl.innerHTML = '';
            selected.forEach(v => {
                const opt = document.createElement('option');
                opt.value = v;
                opt.selected = true;
                selectEl.appendChild(opt);
            });
        }

        function renderCount(){
            countEl.innerText = selected.size;
        }

        // 초기 칩 렌더링
        topics.forEach(t => {
            const chip = renderChip(t);
            listEl.appendChild(chip);
        });

        // 폼 제출 전 검증
        form.addEventListener('submit', function(e){
            // name, description 체크
            const name = document.getElementById('name').value.trim();
            const desc = document.getElementById('description').value.trim();
            if(name.length < 2){
                alert('밴드 이름은 최소 2글자 이상 입력해주세요.');
                document.getElementById('name').focus();
                e.preventDefault();
                return;
            }
            if(desc.length < 3){
                alert('밴드 설명은 최소 3글자 이상 입력해주세요.');
                document.getElementById('description').focus();
                e.preventDefault();
                return;
            }

            if(selected.size === 0){
                alert('토픽을 하나 이상 선택해주세요.');
                e.preventDefault();
                return;
            }

            // 선택값은 이미 syncSelect()로 select에 반영되어 있으므로 제출 OK
        });

        // (선택) 서버 초기값 복원 예시: 서버에서 CSV로 전달 시
        // <c:if test="${not empty selectedTopics}">
        // const serverSelected = '${fn:replace(selectedTopics,"'","\\'")}'; // 서버에서 "code1,code2"
        // serverSelected.split(',').forEach(v => {
        //   const btn = listEl.querySelector('[data-value="'+v+'"]');
        //   if(btn){ btn.click(); }
        // });
        // </c:if>
    })();
</script>
</body>
</html>
