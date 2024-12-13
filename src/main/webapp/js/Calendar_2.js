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
