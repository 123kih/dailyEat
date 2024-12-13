<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<style>
    @font-face {
        font-family: 'NanumSquareRound';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    * {
        font-family: 'NanumSquareRound','sans-serif';
    }
    body {
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    /* 1 - 홈파트 */
    .home-section {
        margin: 70px;
        text-align: center;
        padding: 40px 20px;
        background-color: #F4F7FD;
        width: 100%;
        height: 600px;

        /* 배경 이미지 */
        background-image: url("../../image/home_background3.jpg");
        background-repeat: no-repeat;



        /* 배경 크기 조정 */
        background-size: cover; /* 배경 이미지를 섹션에 맞게 조정 */

    }

    .home-section > h1 {
        margin-top: 260px;
    }
    /*시작하기 버튼 */
    #start-button {
        padding: 15px 100px;
        margin-top: 80px;
        margin-left: 5px;
        background-color: #0d9bf1;
        border-radius: 35px; /* 각을 둥글게 설정 */
        color: white;
        font-size: 20px;
    }
    /*시작하기 버튼 마우스 올렸을 때*/
    #start-button:hover {
        background-color: #3571FF;
    }
    /* 2 - 설명파트 */
    .usage-section {
        text-align: center;
        padding: 40px;
        background-color: #FFFFFF;
        width: 60%;
    }

    /* 단계별 설명 스타일 */
    .steps {
        display: flex;
        justify-content: space-around;
        margin-top: 20px;
        position: relative; /* 선을 상대적으로 배치하기 위해 추가 */
        margin-top: 80px;
    }

    .step {
        width: 80%;
        margin: 10px 0;
        text-align: center;
        position: relative; /* 선을 상대적으로 배치하기 위해 추가 */
        margin-bottom: 80px; /* 각 step 사이의 간격 조정 */
        padding: 0px 80px;    /*  step 사이 거리 조정*/
    }

    .step > h3 {
        margin-top: 20px;
        margin-bottom: 40px;
    }

    .step-number {
        font-size: 25px;
        color: white;
        background-color: #d7d4d4; /* 회색 배경 */
        width: 60px;
        height: 60px;
        line-height: 60px; /* 숫자를 원 안에 수직으로 가운데 정렬 */
        border-radius: 50%; /* 원형으로 만들기 */
        display: inline-block;
        text-align: center; /* 숫자를 원 안에 수평으로 가운데 정렬 */
    }

    .step:not(:last-child)::after {
        content: '';
        position: absolute;
        top: 15%;
        right: -40px; /* 선의 위치 조정 */
        width: 80px; /* 선의 길이 조정 */
        height: 2px; /* 선의 두께 조정 */
        background-color: #C4C4C4; /* 회색 선 색상 */
        transform: translateY(-50%);
    }

    @media screen and (max-width: 768px) {
        .steps {
            flex-direction: column;
            align-items: center;
        }

        .step {
            width: 80%;
            margin: 10px 0;
            margin-bottom: 40px; /* 모바일에서도 간격 유지 */
        }

        .step:not(:last-child)::after {
            right: auto;
            left: 50%;
            top: calc(100% + 20px); /* 선을 아래쪽으로 배치 */
            width: 2px; /* 선을 세로로 조정 */
            height: 40px; /* 선의 높이 조정 */
            transform: translateX(-50%);
        }
    }
</style>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<!-- 1 - 홈파트 -->
<div class="home-section">
    <h1><b>기억하기 힘든 하루의 모든 정보를 <br> 한 곳에서 확인하세요</b></h1>
    <button id="start-button">시작하기</button>
</div>

<!-- 2 - 설명파트 -->
<section class="usage-section">
    <h2>어떻게 사용할까요?</h2>
    <p>기억하기 힘든 하루의 식단과 운동 정보를 한눈에 보기 쉽게 정리하고 관리하세요.</p>
    <div class="steps">
        <div class="step">
            <span class="step-number">01</span>
            <h3>회원가입</h3>
            <p>간단한 회원가입 절차 후 사용</p>
        </div>
        <div class="step">
            <span class="step-number">02</span>
            <h3>나의 기록</h3>
            <p>자신의 식단 및 운동 시간을 기록하고,<br>트렌드 추적</p>
        </div>
        <div class="step">
            <span class="step-number">03</span>
            <h3>커뮤니티</h3>
            <p>공유와 소통을 통해 서로 도움을 <br>주고받을 수 있는 공간</p>
        </div>
    </div>
</section>

<!--맨 아래-->
<footer>
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>

<script src="/js/Home.js"></script>

<script>
    document.getElementById("start-button").addEventListener("click", function () {
        // 로그인 상태 확인 (Java 서버에서 세션 값을 JSP로 전달)
        var isLoggedIn = '<%= session.getAttribute("loginMember") != null %>';

        if (isLoggedIn === "true") {
            // 로그인되어 있으면 Calendar.jsp로 이동
            window.location.href = "../calendar/Calendar.jsp";
        } else {
            // 로그인되어 있지 않으면 알림창 띄우기
            alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
            window.location.href = "../login/LoginMain.jsp";  // 로그인 페이지로 이동
        }
    })
</script>

</body>
</html>
