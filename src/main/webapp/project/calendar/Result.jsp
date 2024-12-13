<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>result</title>
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
        body {
            background-color: #F4F7FD;
        }
        .container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 20px;
        }
        .left-container {
            width: 30%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 30px;
            height: 500px;
        }
        .left-item {
            margin-bottom: 15px;
            font-size: 18px;
        }
        .right-container {
            width: 60%;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        .right-item {
            width: 45%;
            margin: 20px 0;
        }
        .nutrition-info {
            font-size: 14px;
            margin-bottom: 10px;
        }
        canvas {
            width: 100% !important;
            max-width: 400px;
            height: auto !important;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
<div class="container">
    <div class="left-container">
        <h3>총 영양 성분</h3>
        <div class="left-item">칼로리: <span id="totalCalories"></span> kcal</div>
        <div class="left-item">탄수화물: <span id="totalCarbs"></span> g</div>
        <div class="left-item">단백질: <span id="totalProtein"></span> g</div>
        <div class="left-item">지방: <span id="totalFat"></span> g</div>
        <div>
            <h3>총 비율</h3>
            <canvas id="totalRatioChart"></canvas>
        </div>
    </div>

    <div class="right-container">
        <div class="right-item">
            <h3>아침 식단</h3>
            <div class="nutrition-info">
                칼로리: <span id="morningCalories"></span> kcal<br>
                탄수화물: <span id="morningCarbs"></span> g<br>
                단백질: <span id="morningProtein"></span> g<br>
                지방: <span id="morningFat"></span> g
            </div>
            <canvas id="morningChart"></canvas>
        </div>
        <div class="right-item">
            <h3>점심 식단</h3>
            <div class="nutrition-info">
                칼로리: <span id="lunchCalories"></span> kcal<br>
                탄수화물: <span id="lunchCarbs"></span> g<br>
                단백질: <span id="lunchProtein"></span> g<br>
                지방: <span id="lunchFat"></span> g
            </div>
            <canvas id="lunchChart"></canvas>
        </div>
        <div class="right-item">
            <h3>저녁 식단</h3>
            <div class="nutrition-info">
                칼로리: <span id="dinnerCalories"></span> kcal<br>
                탄수화물: <span id="dinnerCarbs"></span> g<br>
                단백질: <span id="dinnerProtein"></span> g<br>
                지방: <span id="dinnerFat"></span> g
            </div>
            <canvas id="dinnerChart"></canvas>
        </div>
        <div class="right-item">
            <h3>간식</h3>
            <div class="nutrition-info">
                칼로리: <span id="snackCalories"></span> kcal<br>
                탄수화물: <span id="snackCarbs"></span> g<br>
                단백질: <span id="snackProtein"></span> g<br>
                지방: <span id="snackFat"></span> g
            </div>
            <canvas id="snackChart"></canvas>
        </div>
    </div>
</div>

<script>
    const charts = {};

    function drawStackedBarChart(ctx, data) {
        if (charts[ctx.canvas.id]) {
            charts[ctx.canvas.id].destroy();
        }

        charts[ctx.canvas.id] = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['영양소'],
                datasets: [
                    {
                        label: '탄수화물',
                        data: [data.carbs],
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    },
                    {
                        label: '단백질',
                        data: [data.protein],
                        backgroundColor: 'rgba(255, 206, 86, 0.6)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1
                    },
                    {
                        label: '지방',
                        data: [data.fat],
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                responsive: true,
                indexAxis: 'y',
                plugins: {
                    legend: { display: true },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.raw !== null) {
                                    label += context.raw + 'g'; // 실제 값을 g 단위로 표시
                                }
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        stacked: true,
                        ticks: {
                            callback: function(value) {
                                return value + 'g'; // X축의 라벨을 g로 표시
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        stacked: true
                    }
                }
            }
        });
    }

    const exampleData = {
        morning: {calories: 350, carbs: 45, protein: 20, fat: 10},
        lunch: {calories: 600, carbs: 80, protein: 30, fat: 20},
        dinner: {calories: 500, carbs: 60, protein: 25, fat: 15},
        snack: {calories: 200, carbs: 30, protein: 10, fat: 5}
    };

    function calculateTotal(data) {
        return {
            calories: data.morning.calories + data.lunch.calories + data.dinner.calories + data.snack.calories,
            carbs: data.morning.carbs + data.lunch.carbs + data.dinner.carbs + data.snack.carbs,
            protein: data.morning.protein + data.lunch.protein + data.dinner.protein + data.snack.protein,
            fat: data.morning.fat + data.lunch.fat + data.dinner.fat + data.snack.fat
        };
    }

    const totalData = calculateTotal(exampleData);

    document.getElementById('totalCalories').textContent = totalData.calories;
    document.getElementById('totalCarbs').textContent = totalData.carbs;
    document.getElementById('totalProtein').textContent = totalData.protein;
    document.getElementById('totalFat').textContent = totalData.fat;

    document.getElementById('morningCalories').textContent = exampleData.morning.calories;
    document.getElementById('morningCarbs').textContent = exampleData.morning.carbs;
    document.getElementById('morningProtein').textContent = exampleData.morning.protein;
    document.getElementById('morningFat').textContent = exampleData.morning.fat;

    document.getElementById('lunchCalories').textContent = exampleData.lunch.calories;
    document.getElementById('lunchCarbs').textContent = exampleData.lunch.carbs;
    document.getElementById('lunchProtein').textContent = exampleData.lunch.protein;
    document.getElementById('lunchFat').textContent = exampleData.lunch.fat;

    document.getElementById('dinnerCalories').textContent = exampleData.dinner.calories;
    document.getElementById('dinnerCarbs').textContent = exampleData.dinner.carbs;
    document.getElementById('dinnerProtein').textContent = exampleData.dinner.protein;
    document.getElementById('dinnerFat').textContent = exampleData.dinner.fat;

    document.getElementById('snackCalories').textContent = exampleData.snack.calories;
    document.getElementById('snackCarbs').textContent = exampleData.snack.carbs;
    document.getElementById('snackProtein').textContent = exampleData.snack.protein;
    document.getElementById('snackFat').textContent = exampleData.snack.fat;

    window.onload = function () {
        drawStackedBarChart(
            document.getElementById('morningChart').getContext('2d'),
            { carbs: exampleData.morning.carbs, protein: exampleData.morning.protein, fat: exampleData.morning.fat }
        );
        drawStackedBarChart(
            document.getElementById('lunchChart').getContext('2d'),
            { carbs: exampleData.lunch.carbs, protein: exampleData.lunch.protein, fat: exampleData.lunch.fat }
        );
        drawStackedBarChart(
            document.getElementById('dinnerChart').getContext('2d'),
            { carbs: exampleData.dinner.carbs, protein: exampleData.dinner.protein, fat: exampleData.dinner.fat }
        );
        drawStackedBarChart(
            document.getElementById('snackChart').getContext('2d'),
            { carbs: exampleData.snack.carbs, protein: exampleData.snack.protein, fat: exampleData.snack.fat }
        );
        drawStackedBarChart(
            document.getElementById('totalRatioChart').getContext('2d'),
            totalData
        );
    };
   
</script>

</body>
</html>
