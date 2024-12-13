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
    .suggestions {
        margin-top: 33px;
        border: 1px solid #ccc;
        max-height: 150px; /* 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 생성 */
        background-color: white;
        position: absolute;
        z-index: 1000;
        width: 100%;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }

    .suggestion-item {
        padding: 10px;
        cursor: pointer;
    }

    .suggestion-item:hover {
        background-color: #f0f0f0;
    }

    .result-button {
        padding: 20px 35px;
        background-color: #0d9bf1;
        font-size: 20px;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        position: absolute;
        bottom: -300px;
        right: 40px;
    }

    .result-button:hover {
        background-color: #3571FF;
    }
    .delete-button{
        background-color: #0d9bf1;
        border-radius: 100%;
    }
    .delete-button:hover {
        background-color: #3571FF;
    }
    .delete-button:active {
        background-color: #0d9bf1;
    }

</style>
<head>
    <meta charset="UTF-8">
    <title>식단 관리</title>
    <link rel="stylesheet" href="../../css/Calendar3.css">
    <script>
        let foodData = [];

        //여기추가
        let selectedMealType = '';
        let name = '';
        let gram = '';
        let calories = '';
        let carbs = '';
        let protein = '';
        let fat = '';
        let sugar = '';
        let nat = '';


        // API로부터 데이터를 가져오는 함수
        function fetchFoodData() {
            fetch('http://openapi.foodsafetykorea.go.kr/api/e570fcacc04041baa0be/I2790/xml/1/1000')
                .then(response => response.text())
                .then(data => {
                    console.log('API 데이터를 가져왔습니다:', data);
                    const parser = new DOMParser();
                    const xmlDoc = parser.parseFromString(data, "text/xml");
                    const items = xmlDoc.getElementsByTagName('row');

                    // 데이터를 파싱하고, 각 데이터에 접근할 때 요소가 존재하는지 확인
                    foodData = Array.from(items).map(item => {
                        const name = item.getElementsByTagName('DESC_KOR')[0]?.textContent || "정보 없음";
                        const gram = item.getElementsByTagName('SERVING_UNIT')[0]?.textContent || "0";
                        const calories = item.getElementsByTagName('NUTR_CONT1')[0]?.textContent || "0";
                        const carbs = item.getElementsByTagName('NUTR_CONT2')[0]?.textContent || "0";
                        const protein = item.getElementsByTagName('NUTR_CONT3')[0]?.textContent || "0";
                        const fat = item.getElementsByTagName('NUTR_CONT4')[0]?.textContent || "0";
                        const sugar = item.getElementsByTagName('NUTR_CONT5')[0]?.textContent || "0";
                        const nat = item.getElementsByTagName('NUTR_CONT6')[0]?.textContent || "0";

                        // 파싱한 데이터를 콘솔에 출력
                        console.log('음식:', name, '총내용량 단위:', gram ,'칼로리:', calories, '탄수화물:', carbs, '단백질:', protein, '지방:', fat
                            , '당류:', sugar, '나트륨:', nat,);

                        return {name, gram, calories, carbs, protein, fat, sugar, nat};
                    });

                    console.log('파싱된 음식 데이터:', foodData);
                })
                .catch(error => console.error('Error fetching food data:', error));
        }

        // 페이지 로드 시 데이터를 불러옴
        window.onload = fetchFoodData;

        //여기추가 식사 버튼 클릭 시 해당 식사 유형 선택
        document.addEventListener('DOMContentLoaded', function () {
            console.log('DOM이 완전히 로드되었습니다.');
            document.querySelectorAll('.bts-1').forEach(button => {
                button.addEventListener('click', function () {
                    selectedMealType = this.textContent.toLowerCase();
                    console.log('Selected Meal Type:', selectedMealType);
                });
            });
        });

        function updateSuggestions() {
            const searchQuery = document.getElementById('foodSearch').value.toLowerCase();
            console.log(searchQuery);

            const suggestionsDiv = document.querySelector('.suggestions');
            suggestionsDiv.innerHTML = '';

            if (searchQuery) {
                const filteredFood = foodData.filter(food => food.name.toLowerCase().includes(searchQuery));
                filteredFood.forEach(food => {
                    const suggestionItem = document.createElement('div');
                    suggestionItem.textContent = food.name;
                    suggestionItem.classList.add('suggestion-item');

                    // 연관 검색어 클릭 시 검색창에 입력
                    suggestionItem.onclick = function() {
                        document.getElementById('foodSearch').value = food.name;
                        suggestionsDiv.innerHTML = '';  // 클릭 후 연관 검색어 목록 비우기
                        searchFood(); // 검색 실행
                    };
                    suggestionsDiv.appendChild(suggestionItem);
                });
            }
        }

        function searchFood() {
            const searchQuery = document.getElementById('foodSearch').value.toLowerCase();
            const resultDiv = document.getElementById('searchResult');

            // 검색어와 대조하여 음식 데이터를 찾음
            let foundFood = foodData.find(food => food.name.toLowerCase() === searchQuery);
            console.log("foundFood : ", foundFood);
            if (foundFood) {
                // 데이터가 제대로 전달되는지 확인
                console.log('검색된 음식:', foundFood);

                resultDiv.innerHTML = `
                    <h3>음식 정보</h3>
                    <p><strong>이름:</strong> \${foundFood.name}</p>
                    <p><strong>총 내용량단위:</strong> \${foundFood.gram} g</p>
                    <p><strong>총 열량:</strong> \${foundFood.calories} kcal</p>
                    <p><strong>탄수화물:</strong> \${foundFood.carbs} g</p>
                    <p><strong>단백질:</strong> \${foundFood.protein} g</p>
                    <p><strong>지방:</strong> \${foundFood.fat} g</p>
                    <p><strong>당류:</strong> \${foundFood.sugar} g</p>
                    <p><strong>나트륨:</strong> \${foundFood.nat} g</p>

                `;
                // `input-fields`의 입력란에 음식 정보를 채움
                document.querySelector('#input-fields input:nth-of-type(2)').value = foundFood.name;
                document.querySelector('#input-fields input:nth-of-type(3)').value = foundFood.gram;
                document.querySelector('#input-fields input:nth-of-type(4)').value = foundFood.calories;
                document.querySelector('#input-fields input:nth-of-type(5)').value = foundFood.carbs;
                document.querySelector('#input-fields input:nth-of-type(6)').value = foundFood.protein;
                document.querySelector('#input-fields input:nth-of-type(7)').value = foundFood.fat;
                document.querySelector('#input-fields input:nth-of-type(8)').value = foundFood.sugar;
                document.querySelector('#input-fields input:nth-of-type(9)').value = foundFood.nat;
            } else {
                resultDiv.innerHTML = `<p>검색된 음식이 없습니다. 다시 시도해 주세요.</p>`;
                // 검색 결과가 없을 때 입력란 초기화
                document.querySelector('#input-fields input:nth-of-type(2)').value = '';
                document.querySelector('#input-fields input:nth-of-type(3)').value = '';
                document.querySelector('#input-fields input:nth-of-type(4)').value = '';
                document.querySelector('#input-fields input:nth-of-type(5)').value = '';
                document.querySelector('#input-fields input:nth-of-type(6)').value = '';
                document.querySelector('#input-fields input:nth-of-type(7)').value = '';
                document.querySelector('#input-fields input:nth-of-type(8)').value = '';
                document.querySelector('#input-fields input:nth-of-type(9)').value = '';
            }

            console.log('결과 HTML:', resultDiv.innerHTML); // 결과 HTML을 콘솔에 출력
        }

        function addFoodToMeal() {
            const isManualEntry = document.getElementById('manual-entry-checkbox').checked;

            if (isManualEntry) {
                // 직접 입력된 값 가져오기
                name = document.getElementById('manual-name').value;
                gram = document.getElementById('manual-gram').value;
                calories = document.getElementById('manual-calories').value;
                carbs = document.getElementById('manual-carbs').value;
                protein = document.getElementById('manual-protein').value;
                fat = document.getElementById('manual-fat').value;
                sugar = document.getElementById('manual-sugar').value;
                nat = document.getElementById('manual-nat').value;

                // 직접 입력된 음식 정보
                const newFood = {name, gram, calories, carbs, protein, fat, sugar, nat};
                foodData.push(newFood); // 직접 입력된 데이터도 배열에 추가
            } else {
                // 검색된 음식 정보
                const searchQuery = document.getElementById('foodSearch').value.toLowerCase();
                let foundFood = foodData.find(food => food.name.toLowerCase() === searchQuery);

                if (foundFood && selectedMealType) {
                    // 검색된 정보를 사용
                    name = foundFood.name;
                    gram = foundFood.gram;
                    calories = foundFood.calories;
                    carbs = foundFood.carbs;
                    protein = foundFood.protein;
                    fat = foundFood.fat;
                    sugar = foundFood.sugar;
                    nat = foundFood.nat;

                    // 데이터가 잘 전달되는지 확인
                    console.log('검색된 음식:', foundFood);
                } else {
                    alert('음식을 검색한 후 추가할 식사 유형을 선택하세요.');
                    return;
                }
            }

            if (name && calories && carbs && protein && fat && selectedMealType) {
                const mealSection = document.querySelector(`.\${selectedMealType}-content`);
                console.log('mealSection:', mealSection);

                if (mealSection) {
                    const caloriesSpan = mealSection.previousElementSibling.querySelector('.calories');
                    if (caloriesSpan) {
                        // 음식 항목을 식사 섹션에 추가
                        const foodEntry = document.createElement('p');
                        // foodEntry.textContent = `\${name} - \${calories} kcal`;
                        foodEntry.innerHTML = `
                        <button class="delete-button" data-item="\${name}"  data-calories="\${calories}">-</button>
                        \${name} - \${calories} kcal
                        `;
                        mealSection.appendChild(foodEntry);

                        // 총 칼로리 업데이트
                        let currentCalories = parseInt(caloriesSpan.textContent.replace('총 칼로리: ', '').replace(' kcal', ''));
                        currentCalories += parseInt(calories);
                        caloriesSpan.textContent = `총 칼로리: \${currentCalories} kcal`;
                    } else {
                        console.error('칼로리 스팬을 찾을 수 없습니다.');
                    }
                } else {
                    console.error('식사 섹션을 찾을 수 없습니다.');
                }


                // 입력 필드 초기화
                if (isManualEntry) {
                    document.getElementById('manual-name').value = '';
                    document.getElementById('manual-gram').value = '';
                    document.getElementById('manual-calories').value = '';
                    document.getElementById('manual-carbs').value = '';
                    document.getElementById('manual-protein').value = '';
                    document.getElementById('manual-fat').value = '';
                    document.getElementById('manual-sugar').value = '';
                    document.getElementById('manual-nat').value = '';
                }

                console.log(JSON.stringify({name: name , gram: gram , calories : calories, carbs : carbs, protein: protein, fat: fat, sugar : sugar, nat : nat, mealType: selectedMealType}));

        }


        document.addEventListener('click', function (event) {
            if (event.target && event.target.classList.contains('delete-button')) {
                const foodName = event.target.getAttribute('data-item');
                const foodCalories = parseInt(event.target.getAttribute('data-calories'));
                const mealSection = event.target.parentElement.parentElement;
                const caloriesSpan = mealSection.previousElementSibling.querySelector('.calories');

                if (mealSection && caloriesSpan) {
                    let currentCalories = parseInt(caloriesSpan.textContent.replace('총 칼로리: ', '').replace(' kcal', '')) || 0;
                    currentCalories -= foodCalories;
                    caloriesSpan.textContent = `총 칼로리: \${currentCalories} kcal`;

                    event.target.parentElement.remove();
                }
            }
        });
        }
        function handleSubmit() {
            const form = document.getElementById('mealForm');
            if (!selectedMealType) {
                alert('식사 유형을 선택하세요.');
                return;
            }
            form.elements['mealType'].value = selectedMealType;
            form.submit();
        }

    </script>
</head>
<body>
<div class="container">
    <form id="mealForm" method="post" action="saveMeal.jsp">
    <div class="left-section">
        <h2>하루 식사량을 입력해주세요</h2>
        <p>음식 검색어를 입력하시고 Enter 키나 확인 버튼을 눌러주세요.</p>

        <div class="meal-buttons">
            <button type="button" class="bts bts-1">아침</button>
            <button type="button" class="bts bts-1">점심</button>
            <button type="button" class="bts bts-1">저녁</button>
            <button type="button" class="bts bts-1">간식</button>
            <button type="button" class="bts" onclick="addFoodToMeal()">추가하기</button>
            <button type="button" onclick="handleSubmit()">저장하기</button>
        </div>

        <div class="search-bar" style="position: relative;">
            <input type="text" id="foodSearch" placeholder="음식 검색" oninput="updateSuggestions()">
            <button type="button" class="search-button" onclick="searchFood()">&#128269;</button>
            <div class="suggestions"></div>
        </div>

        <p>** 검색창에 없는 경우 직접 입력해주세요.</p>
        <p>** 검색한 음식의 정보 수정을 원한다면 밑에 있는 버튼을 클릭해 창을 열고 수정 후 추가하기 버튼을 클릭하세요.</p>
        <div class="manual-entry">
            <label>직접 입력하기</label>
            <label class="switch">
                <input type="checkbox" id="manual-entry-checkbox">
                <span class="slider"></span>
            </label>
        </div>

        <div id="input-fields" class="input-fields">
            <p>날짜</p>
            <input type="text" name="date" value="<%= date %>">
            <p>메뉴 이름:</p>
            <input type="text" name="name" id="manual-name">
            <p>총 내용량 단위:</p>
            <input type="text" name="gram" id="manual-gram">
            <p>총 칼로리:</p>
            <input type="text" name="calories" id="manual-calories">
            <p>탄수화물:</p>
            <input type="text" name="carbs" id="manual-carbs">
            <p>단백질:</p>
            <input type="text" name="protein" id="manual-protein">
            <p>지방:</p>
            <input type="text" name="fat" id="manual-fat">
            <p>당류:</p>
            <input type="text" name="sugar" id="manual-sugar">
            <p>나트륨:</p>
            <input type="text" name="nat" id="manual-nat">
            <input type="hidden" name="mealType" value="">
        </div>
    </div>
    </form>
    <div class="right-section">
        <div class="meal-info">
            <h2>나의 식단정보</h2>
            <p>음식 검색을 통해 음식을 추가하실 수 있습니다. 모든 음식을 입력하셨다면 입력 완료 버튼을 눌러주세요.</p>

            <div class="meal-entry" onclick="toggleMeal(this)" style="margin-bottom: 20px">
                <img src="../../image/morning.png" alt="아침 식단">
                <p>아침 식단을 등록하세요</p>
                <span class="calories morning-calories">총 칼로리: 0</span>
                <img class="arrow" src="/image/down.png" alt="화살표">
            </div>
            <div class="meal-content 아침-content">
                <p>추가 정보가 여기에 표시됩니다.</p>
            </div>

            <div class="meal-entry" onclick="toggleMeal(this)" style="margin-bottom: 20px">
                <img src="../../image/lunch.png" alt="점심 식단">
                <p>점심 식단을 등록하세요</p>
                <span class="calories lunch-calories">총 칼로리: 0</span>
                <img class="arrow" src="/image/down.png" alt="화살표">
            </div>
            <div class="meal-content 점심-content">
                <p>추가 정보가 여기에 표시됩니다.</p>
            </div>

            <div class="meal-entry" onclick="toggleMeal(this)" style="margin-bottom: 20px">
                <img src="../../image/dinner.png" alt="저녁 식단">
                <p>저녁 식단을 등록하세요</p>
                <span class="calories dinner-calories">총 칼로리: 0</span>
                <img class="arrow" src="/image/down.png" alt="화살표">
            </div>
            <div class="meal-content 저녁-content">
                <p>추가 정보가 여기에 표시됩니다.</p>
            </div>

            <div class="meal-entry" onclick="toggleMeal(this)" style="margin-bottom: 20px">
                <img src="../../image/snack.png" alt="간식">
                <p>간식 식단을 등록하세요</p>
                <span class="calories snack-calories">총 칼로리: 0</span>
                <img class="arrow" src="/image/down.png" alt="화살표">
            </div>
            <div class="meal-content 간식-content">
                <p>추가 정보가 여기에 표시됩니다.</p>
            </div>
        </div>
<%--        <button class="result-button" onclick="saveToDatabase()">저장하기</button>--%>
        <button type="button" class="result-button" onclick="goToResult()">결과보기</button>
    </div>

</div>

<!-- 검색 결과를 표시할 부분 -->
<div id="searchResult" style="display: none"></div>

<script src="/js/Calendar_3.js"></script>
<script>
    function goToResult() {
        window.location.href = '../calendar/Result.jsp'; // Result.jsp 으로 이동
    }
</script>
</body>
</html>
