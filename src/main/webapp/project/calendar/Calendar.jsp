<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 기록</title>
    <link rel="stylesheet" href="/css/Calendar.css">
    
</head>
<body>
<jsp:include page="/project/include/navbar.jsp"/>
<br/>
<main id="container">
    <!--나의 기록 설명-->
    <div class="info">
        <h2>나의 기록</h2>
        <p>기록하고 싶은 날짜를 클릭해주세요.</p>
    </div>

    <!--캘린더-->
    <div class="calendar">
        <!--캘린더 상단-->
        <div class="header">
            <!--선택한 년, 월 표시-->
            <div class="year-month"></div>
            <!-- 날짜 이동 버튼 -->
            <div class="nav">
                <button class="nav-btn go-prev" onclick="prevMonth()">&lt;</button>
                <button class="nav-btn go-today" onclick="goToday()">Today</button>
                <button class="nav-btn go-next" onclick="nextMonth()">&gt;</button>
            </div>
        </div>
        <!--달력 메인 화면-->
        <div class="main">
            <!--월~금-->
            <div class="days">
                <div class="day">일</div>
                <div class="day">월</div>
                <div class="day">화</div>
                <div class="day">수</div>
                <div class="day">목</div>
                <div class="day">금</div>
                <div class="day">토</div>
            </div>
            <!--1일~31일까지-->
            <div class="dates"></div>
        </div>
    </div>

    <!-- 모달 창 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <%--뒤로가기 버튼--%>
            <span class="back-btn" onclick="goBack()">&larr;</span>
            <%--닫기 버튼--%>
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <%--모달 내용--%>
            <iframe src="../calendar/Calendar_2.jsp" frameborder="0"></iframe>
        </div>
    </div>

    <script src="/js/Calendar.js"></script>

</main>

<br/>
<jsp:include page="/project/include/footer.jsp"/>
</body>
</html>
