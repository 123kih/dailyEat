let date = new Date();
let selectedDateElement = null;
let selectedDate = null; // 선택된 날짜 저장 변수

const renderCalendar = () => {
    const viewYear = date.getFullYear();
    const viewMonth = date.getMonth();

    // 캘린더 상단에 연도와 월 표시
    document.querySelector('.year-month').textContent = `${viewYear}년 ${viewMonth + 1}월`;

    // 지난 달 마지막 날짜와 요일, 이번 달 마지막 날짜와 요일 가져오기
    const prevLast = new Date(viewYear, viewMonth, 0);
    const thisLast = new Date(viewYear, viewMonth + 1, 0);

    const PLDate = prevLast.getDate();
    const PLDay = prevLast.getDay();
    const TLDate = thisLast.getDate();
    const TLDay = thisLast.getDay();

    // 날짜 배열 생성
    const prevDates = [];
    const thisDates = [...Array(TLDate + 1).keys()].slice(1);
    const nextDates = [];

    // 이전 달 날짜 계산
    if (PLDay !== 6) {
        for (let i = 0; i < PLDay + 1; i++) {
            prevDates.unshift(PLDate - i);
        }
    }

    // 다음 달 날짜 계산
    for (let i = 1; i < 7 - TLDay; i++) {
        nextDates.push(i);
    }

    // 날짜 배열 합치기
    const dates = prevDates.concat(thisDates, nextDates);

    // 날짜 HTML 코드 생성
    const firstDateIndex = dates.indexOf(1);
    const lastDateIndex = dates.lastIndexOf(TLDate);
    dates.forEach((date, i) => {
        const condition = i >= firstDateIndex && i < lastDateIndex + 1
            ? 'this'
            : 'other';

        const dataDate = `${viewYear}-${String(viewMonth + 1).padStart(2, '0')}-${String(date).padStart(2, '0')}`;
        dates[i] = `<div class="date" data-date="${dataDate}"><span class="${condition}">${date}</span></div>`;
    });

    // 날짜를 HTML에 그리기
    document.querySelector('.dates').innerHTML = dates.join('');

    // 오늘 날짜 강조 표시
    const today = new Date();
    if (viewMonth === today.getMonth() && viewYear === today.getFullYear()) {
        for (let date of document.querySelectorAll('.this')) {
            if (+date.innerHTML === today.getDate()) {
                date.classList.add('today');
                break;
            }
        }
    }

    // 날짜 클릭 이벤트 추가
    document.querySelectorAll('.date').forEach(dateWrapper => {
        dateWrapper.addEventListener('click', function () {
            // 클릭된 날짜의 data-date 속성 값 가져오기
            const dataDate = this.getAttribute('data-date'); // 선택된 날짜 저장

            // 현재 클릭된 날짜의 span 요소 선택
            const dateSpan = this.querySelector('span');

            // 이전에 선택된 날짜의 스타일 초기화
            if (selectedDateElement) {
                selectedDateElement.classList.remove('selected');
            }

            // 현재 클릭된 날짜의 스타일 변경
            dateSpan.classList.add('selected');

            // 선택된 날짜 요소 저장
            selectedDateElement = dateSpan;
            selectedDate = this.getAttribute('data-date'); // 선택된 날짜 저장

            // 모달 열기
            openModal(selectedDate);
        })
    })
}

renderCalendar();

// 지난 달로 이동하는 함수
const prevMonth = () => {
    date.setDate(1);
    date.setMonth(date.getMonth() - 1);
    renderCalendar();
}

// 다음 달로 이동하는 함수
const nextMonth = () => {
    date.setDate(1);
    date.setMonth(date.getMonth() + 1);
    renderCalendar();
}

// 오늘로 이동하는 함수
const goToday = () => {
    date = new Date();
    renderCalendar();
}

// 모달 영역
document.addEventListener('DOMContentLoaded', () => {
    const datesContainer = document.querySelector('.dates');
    const modal = document.getElementById('modal');
    const closeBtn = document.querySelector('.close-btn');
    const backBtn = document.querySelector('.back-btn');

    // 날짜를 클릭했을 때 모달을 열기
    datesContainer.addEventListener('click', (event) => {
        if (event.target.classList.contains('date')) {
            const date = event.target.getAttribute('data-date');
            openModal(date);
        }
    });

    // 모달을 열기
    window.openModal = function(date) {
        const iframe = document.querySelector('#modal iframe');
        iframe.src = `/project/calendar/Calendar_2.jsp?date=${date}`;
        modal.style.display = 'block';
    }

    // document.addEventListener('DOMContentLoaded', () => {
    //     renderCalendar();
    // });

    // 모달을 닫기
    function closeModal() {
        modal.style.display = 'none';
    }

    // 뒤로가기 버튼 클릭 시 이전 페이지로 이동
    function goBack() {
        window.history.back();
    }

    // 모달 닫기 버튼 클릭 시 모달 닫기
    closeBtn.addEventListener('click', closeModal);

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            closeModal();
        }
    });

    // 뒤로가기 버튼 클릭 시 페이지 이동
    backBtn.addEventListener('click', goBack);
});



