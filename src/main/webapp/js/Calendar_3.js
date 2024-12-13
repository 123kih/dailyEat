// 모든 버튼을 선택
const buttons = document.querySelectorAll('.bts');
// 각 버튼에 클릭 이벤트 추가
buttons.forEach(button => {
    button.addEventListener('click', () => {
        // 모든 버튼에서 active 클래스 제거
        buttons.forEach(btn => btn.classList.remove('active'));
        // 클릭된 버튼에만 active 클래스 추가
        button.classList.add('active');
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const checkbox = document.getElementById('manual-entry-checkbox');
    const inputFields = document.getElementById('input-fields');

    // 체크박스 상태에 따라 input-fields 활성화/비활성화
    checkbox.addEventListener('change', () => {
        if (checkbox.checked) {
            inputFields.classList.add('visible');
        } else {
            inputFields.classList.remove('visible');
        }
    });

    // 페이지 로드 시 기본 상태 설정
    if (checkbox.checked) {
        inputFields.classList.add('visible');
    } else {
        inputFields.classList.remove('visible');
    }
});

//캘린더 2번
function toggleMeal(element) {
    const arrow = element.querySelector('.arrow');
    const nextContent = element.nextElementSibling;

    // 화살표 회전 토글
    arrow.classList.toggle('open');

    // 내용 표시/숨기기 토글
    if (nextContent && nextContent.classList.contains('meal-content')) {
        nextContent.style.display = nextContent.style.display === 'block' ? 'none' : 'block';
    }
}

