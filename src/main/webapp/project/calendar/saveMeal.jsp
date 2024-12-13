<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<%@ page import="com.project.dailyeat.calendar.MenuDAO, com.project.dailyeat.calendar.MenuDTO" %>
<%@ page import="com.project.dailyeat.users.UserDTO" %>
<%@ page import="com.project.dailyeat.util.JSFunction" %>
<%

    // 세션에서 로그인 사용자 정보 가져오기
    HttpSession session1 = request.getSession();
    UserDTO user = (UserDTO) session1.getAttribute("loginMember");

    // 로그인된 사용자 ID 가져오기
    String id = (user != null) ? user.getId() : null;

    // 폼에서 전달된 날짜 값 가져오기
    String date = request.getParameter("date");
    String postDate = (date != null && !date.isEmpty()) ? date : new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()); // 선택된 날짜 또는 현재 날짜

    String name = request.getParameter("name");

    double gram = 0;
    double calories = 0;
    double carbs = 0;
    double protein = 0;
    double fat = 0;
    double sugar = 0;
    double nat = 0;

    try {
        gram = (int) Double.parseDouble(request.getParameter("gram"));
        calories = (int) Double.parseDouble(request.getParameter("calories"));
        carbs = (int) Double.parseDouble(request.getParameter("carbs"));
        protein = (int) Double.parseDouble(request.getParameter("protein"));
        fat = (int) Double.parseDouble(request.getParameter("fat"));
        sugar = (int) Double.parseDouble(request.getParameter("sugar"));
        nat = (int) Double.parseDouble(request.getParameter("nat"));
    } catch (NumberFormatException e) {
        // 숫자 형식 오류 처리
        out.println("잘못된 숫자 형식입니다.");
        e.printStackTrace();
    }

    String selectedMealType = request.getParameter("mealType");
    if (selectedMealType == null || selectedMealType.isEmpty()) {
        throw new Exception("식사 유형이 선택되지 않았습니다.");
    }

    MenuDTO menuDTO = new MenuDTO();
    menuDTO.setId(id);
    menuDTO.setPostdate(postDate);
    menuDTO.setName(name);
    menuDTO.setGram(gram);
    menuDTO.setCalories(calories);
    menuDTO.setCarbs(carbs);
    menuDTO.setProtein(protein);
    menuDTO.setFat(fat);
    menuDTO.setSugar(sugar);
    menuDTO.setNat(nat);
    menuDTO.setSelectedMealType(selectedMealType);

    MenuDAO menuDAO = new MenuDAO();
    boolean success = menuDAO.insertMeal(menuDTO);
    menuDAO.close();

    if (success) {
        JSFunction.alertBack(response, "식단 정보가 성공적으로 저장되었습니다.");
    } else {
        JSFunction.alertBack(response, "식단 정보 저장에 실패했습니다.");
    }
%>
