document.addEventListener('DOMContentLoaded', function () {
    const navToggle = document.getElementById('nav-toggle');
    const navList = document.getElementById('nav-list');
    const startButton = document.getElementById('start-button');
    const loginButton = document.querySelector('.login-button');

    navToggle.addEventListener('click', function () {
        // 'navToggle' 요소에 클릭 이벤트 리스너를 추가
        navList.classList.toggle('active');
        // navList 요소의 클래스 목록에서 active 클래스를 토글
        // active 클래스가 요소에 없으면 추가하고 있으면 제거
    });

    // 네비바 로그인 버튼 눌렀을 때 이벤트
    loginButton.addEventListener('click', function (e) {
        e.preventDefault();
        window.location.href = '#'; // 로그인 페이지로 이동
    });


});



