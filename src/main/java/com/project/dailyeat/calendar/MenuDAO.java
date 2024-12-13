package com.project.dailyeat.calendar;

import com.project.dailyeat.calendar.MenuDTO;
import com.project.dailyeat.common.DBConnPool;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MenuDAO extends DBConnPool {

    public MenuDAO() {
        super(); // 부모 클래스의 생성자 호출
    }

    // 식단 정보를 데이터베이스에 저장하는 메서드
    public boolean insertMeal(MenuDTO menuDTO) {
        String sql = "INSERT INTO project.menu (MENU_NUM, ID, POSTDATE, MENU, QUANTITY, KCAL, CARBO, PROTEIN, FAT, SUGAR, NATRIUM, MEAL_TYPE) " +
                "VALUES (project.SEQ_MENU_NUM.NEXTVAL, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement psmt = conn.prepareStatement(sql)) {
            psmt.setString(1, menuDTO.getId());
            psmt.setString(2, menuDTO.getPostdate());
            psmt.setString(3, menuDTO.getName());
            psmt.setDouble(4, menuDTO.getGram());
            psmt.setDouble(5, menuDTO.getCalories());
            psmt.setDouble(6, menuDTO.getCarbs());
            psmt.setDouble(7, menuDTO.getProtein());
            psmt.setDouble(8, menuDTO.getFat());
            psmt.setDouble(9, menuDTO.getSugar());
            psmt.setDouble(10, menuDTO.getNat());
            psmt.setString(11, menuDTO.getSelectedMealType());

            int result = psmt.executeUpdate();

            return result > 0; // 성공적으로 삽입되었는지 여부를 반환

        } catch (SQLException e) {
            System.out.println("식단 정보 삽입 실패");
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void close() {
        super.close(); // 부모 클래스의 close 메서드를 호출하여 자원 반납
    }
}
