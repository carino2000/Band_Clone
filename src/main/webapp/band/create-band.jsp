<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>sign-up</title>
    <link rel="stylesheet" href="/css/style.css"/>
    <style>
        /* ---------- 기본 레이아웃(간단) ---------- */
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; background: #fff; color: #111; margin: 0; padding: 18px; }
        .signup-wrap { display: flex; justify-content: center; align-items: flex-start; padding-top: 18px; }
        .signup { width: 760px; max-width: 100%; }
        .text-center { text-align: center; }
        .text-gray { color: #6b7280; }
        .mt-1 { margin-top: 8px; }
        label small { font-size: 13px; color: #111; font-weight: 600; }
        .input { width: 100%; padding: 10px 12px; border: 1px solid #e5e7eb; border-radius: 8px; box-sizing: border-box; }
        .bt-submit { margin-top: 16px; padding: 10px 16px; border-radius: 8px; background:#2b6ef6;color:white;border:none;cursor:pointer;font-weight:600; }
        /* helper text */
        .helper { font-size:13px;color:#64748b;margin-bottom:10px; }

        /* ---------- 토픽 칩 UI (인라인 포함, 필요하면 style.css로 이동) ---------- */
        :root{
            --gap: 8px;
            --chip-padding: 10px 14px;
            --chip-radius: 12px;
            --chip-bg: #f4f6fb;
            --chip-border: rgba(20,30,60,0.06);
            --chip-shadow: 0 4px 10px rgba(16,24,40,0.06);
            --accent: #2b6ef6;
            --accent-strong: #1649d8;
            --text: #0f1724;
            --muted: #64748b;
        }

        .field { margin-top: 12px; }
        .chips { display:flex;flex-wrap:wrap;gap:var(--gap);align-items:center; }
        .chip {
            display:inline-flex;align-items:center;gap:8px;
            padding:var(--chip-padding);border-radius:var(--chip-radius);
            background:var(--chip-bg);border:1px solid var(--chip-border);
            box-shadow:var(--chip-shadow);cursor:pointer;user-select:none;
            transition:transform .12s ease,box-shadow .12s ease,background .12s ease;
            font-size:14px;color:var(--text);min-width:80px;justify-content:center;
        }
        .chip[aria-pressed="true"]{
            background:linear-gradient(180deg,var(--accent),var(--accent-strong));
            color:#fff;border-color:transparent;box-shadow:0 8px 22px rgba(43,110,246,0.22);transform:translateY(-2px) scale(1.02);
        }
        .chip:focus{outline:3px solid rgba(43,110,246,0.12);outline-offset:3px}
        .chip:active{transform:translateY(0)}
        .count-badge{display:inline-block;padding:4px 8px;border-radius:999px;background:#eef2ff;color:var(--accent-strong);font-weight:600;font-size:13px;margin-left:6px}
        select.hidden-multi{display:none}
        @media (max-width:420px){ .chip{font-size:13px;padding:8px 10px;min-width:68px} }

        /* ---------- 체크박스(왼쪽 정렬) ---------- */
        .form-row { margin-top: 10px; }
        .form-row .mt-1 { margin-top: 6px; }
        .checkbox-inline {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #111;
            cursor: pointer;
            padding: 6px 8px;
            border-radius: 8px;
            transition: background-color 0.12s ease, box-shadow 0.12s ease;
        }
        .checkbox-inline:hover { background-color: #fbfdff; box-shadow: 0 1px 3px rgba(2,6,23,0.03); }
        .checkbox-inline input[type="checkbox"] { width: 16px; height: 16px; margin: 0; accent-color: #2b6ef6; }

        /* 작은 화면에서 레이아웃 유지 */
        @media (max-width:600px){
            .signup { padding: 8px; }
        }
    </style>
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

            <div class="form-row">
                <label for="description"><small>밴드 설명</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="description" id="description" placeholder="밴드 소개말을 작성해주세요." required/>
                </div>
            </div>

            <!-- === 멀티 토픽 선택 (칩 UI) === -->
            <div class="field">
                <label><small>토픽</small></label>
                <div class="helper">밴드의 주된 관심사를 하나 이상 선택해주세요. (복수 선택 가능)</div>

                <!-- 숨긴 select: 서버에서 기존처럼 'topic' 파라미터로 다중값을 받을 수 있게 함 -->
                <select id="topicSelect" name="topic" class="hidden-multi" multiple></select>

                <!-- 버튼(칩) 목록이 렌더링될 곳 -->
                <div id="topicList" class="chips" role="list" aria-label="토픽 선택 목록"></div>

                <div aria-live="polite" id="selectedCount" style="margin-top:10px" class="helper">선택된 항목: <span class="count">0</span></div>
            </div>
            <!-- === 토픽 블록 끝 === -->

            <!-- 체크박스: 왼쪽 정렬로 다른 input들과 동일한 흐름 -->
            <div class="form-row">
                <label for="isPrivate"><small>밴드 비공개 설정</small></label>
                <div class="mt-1">
                    <label class="checkbox-inline" for="isPrivate">
                        <input type="checkbox" class="" name="isPrivate" id="isPrivate" value="true"/>
                        밴드 비공개
                    </label>
                </div>
            </div>

            <div class="text-gray mt-1">
                밴드 공개 설정을 선택하시면 밴드 맴버가 아닌 사람들에게도 게시글이 보여집니다.
            </div>

            <div>
                <button class="bt-submit" type="submit">내 밴드 만들기</button>
            </div>
        </form>
    </div>
</div>

<script>
    (function(){
        // 토픽 목록 — 필요시 서버에서 JSTL로 주입 가능
        const topics = [
            {value:'music', label:'음악'},
            {value:'photography', label:'사진'},
            {value:'painting', label:'그림'},
            {value:'animal', label:'동물'},
            {value:'health', label:'건강'},
            {value:'trip', label:'여행'},
            {value:'nature', label:'꽃/나무/자연'},
            {value:'hobby', label:'취미'},
            {value:'company', label:'회사'},
            {value:'game', label:'게임'},
            {value:'exercise', label:'운동'},
            {value:'life', label:'사는얘기'},
            {value:'gathering', label:'모임&스터디'},
            {value:'feedback', label:'자랑&피드백'},
            {value:'it', label:'IT'},
            {value:'etc', label:'기타'}
        ];

        const list = document.getElementById('topicList');
        const select = document.getElementById('topicSelect');
        const countNode = document.querySelector('#selectedCount .count');

        const selected = new Set();

        function createChip(t){
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'chip';
            btn.setAttribute('role','button');
            btn.setAttribute('aria-pressed','false');
            btn.setAttribute('data-value', t.value);
            btn.tabIndex = 0;
            btn.innerText = t.label;

            btn.addEventListener('click', () => toggleSelection(t.value, btn));
            btn.addEventListener('keydown', (e) => {
                if(e.key === ' ' || e.key === 'Enter'){
                    e.preventDefault();
                    btn.click();
                }
            });

            return btn;
        }

        function toggleSelection(value, btn){
            if(selected.has(value)){
                selected.delete(value);
                btn.setAttribute('aria-pressed','false');
            } else {
                selected.add(value);
                btn.setAttribute('aria-pressed','true');
            }
            syncHiddenSelect();
            renderCount();
        }

        function syncHiddenSelect(){
            while(select.firstChild) select.removeChild(select.firstChild);
            selected.forEach(v => {
                const opt = document.createElement('option');
                opt.value = v;
                opt.selected = true;
                select.appendChild(opt);
            });
        }

        function renderCount(){
            countNode.innerText = String(selected.size);
        }

        // 초기 버튼 그리기
        topics.forEach(t => {
            const chip = createChip(t);
            list.appendChild(chip);
        });

        // 폼 제출시 기본 동작 유지: 서버에서는 request.getParameterValues("topic")로 받습니다.
        const form = document.querySelector('.signup-form');
        form.addEventListener('submit', (e) => {
            if(selected.size === 0){
                e.preventDefault();
                alert('하나 이상의 토픽을 선택해주세요.');
                return;
            }
            // 기본 제출 흐름 유지 (action="/band-create"로 전송)
        });

        // --- 옵션: 서버에서 초기 선택값이 제공되면 복원하는 예시 ---
        // 예: JSTL로 서버 문자열을 주입한 경우 아래 주석 해제 후 사용
        /*
        (function restoreFromServer(){
          const serverValue = '${param.selectedTopics}'; // 서버에서 "music,game" 같은 문자열로 전달 가능
      if(serverValue){
        const arr = serverValue.split(',');
        arr.forEach(v => {
          const btn = list.querySelector('[data-value=\"' + v + '\"]');
          if(btn){
            selected.add(v);
            btn.setAttribute('aria-pressed','true');
          }
        });
        syncHiddenSelect();
        renderCount();
      }
    })();
    */
    })();
</script>
</body>
</html>
