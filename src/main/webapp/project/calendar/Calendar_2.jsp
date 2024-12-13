<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<html>
<%
  String date = request.getParameter("date");
  if (date == null || date.isEmpty()) {
    // 날짜 값이 없을 때 처리
    out.println("날짜 값이 없습니다.");
  } else {
    // 날짜 값이 있을 때 처리
    out.println("선택한 날짜: " + date);
  }
%>
<style>
  @font-face {
    font-family: 'NanumSquareRound';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
    font-weight: normal;
    font-style: normal;
  }
  * {
    font-family: 'NanumSquareRound', 'sans-serif';
  }

</style>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>나의 식단정보</title>
  <link rel="stylesheet" href="../../css/Calendar2.css">
</head>
<body>
<div class="container">
  <div class="left-section">
    <!-- Left section is empty -->
  </div>

  <div class="right-section">
    <div class="meal-info">
      <h2>나의 식단정보</h2>
      <p>음식 검색을 통해 음식을 추가하실 수 있습니다. 모든 음식을 입력하셨다면 입력 완료 버튼을 눌러주세요.</p>

      <div class="meal-entry" onclick="toggleMeal(this)">
        <img src="../../image/morning.png" alt="아침 식단">
        <p>아침 식단을 등록하세요</p>
        <span class="calories">총 칼로리: 0</span>
        <img class="arrow" src="/image/down.png" alt="화살표">
      </div>
      <div class="meal-content">
        <p>추가 정보가 여기에 표시됩니다.</p>
      </div>

      <div class="meal-entry" onclick="toggleMeal(this)">
        <img src="../../image/lunch.png" alt="점심 식단">
        <p>점심 식단을 등록하세요</p>
        <span class="calories">총 칼로리: 0</span>
        <img class="arrow" src="/image/down.png" alt="화살표">
      </div>
      <div class="meal-content">
        <p>추가 정보가 여기에 표시됩니다.</p>
      </div>

      <div class="meal-entry" onclick="toggleMeal(this)">
        <img src="../../image/dinner.png" alt="저녁 식단">
        <p>저녁 식단을 등록하세요</p>
        <span class="calories">총 칼로리: 0</span>
        <img class="arrow" src="/image/down.png" alt="화살표">
      </div>
      <div class="meal-content">
        <p>추가 정보가 여기에 표시됩니다.</p>
      </div>

      <div class="meal-entry" onclick="toggleMeal(this)">
        <img src="../../image/snack.png" alt="간식">
        <p>간식 식단을 등록하세요</p>
        <span class="calories">총 칼로리: 0</span>
        <img class="arrow" src="/image/down.png" alt="화살표">
      </div>
      <div class="meal-content">
        <p>추가 정보가 여기에 표시됩니다.</p>
      </div>
    </div>

    <button class="add-button" onclick="goToCalendar3()">+</button>
  </div>
</div>

<script src="/js/Calendar_2.js"></script>
<script>
  function goToCalendar3() {
    const selectedDate = '<%= request.getParameter("date") %>';
    if (selectedDate) {
      window.location.href = '../calendar/Calendar_3.jsp?date=<%= request.getParameter("date") %>'; // Calendar_3.jsp 으로 이동
    }else {
      alert('날짜 값이 없습니다.');
    }
  }
</script>
</body>
</html>
