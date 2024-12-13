package com.project.dailyeat.users;

import com.project.dailyeat.common.DBConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private DBConnPool dbConnPool;

    public UserDAO() {
        dbConnPool = new DBConnPool();
    }

    // 닉네임 업데이트 메서드
    public boolean updateNickname(String id, String newNickname) {
        String query = "UPDATE project.users SET nickname=? WHERE id=?";
        Connection conn = null;
        PreparedStatement psmt = null;
        boolean isUpdated = false;

        try {
            conn = dbConnPool.conn;  // DBConnPool에서 커넥션 가져오기
            psmt = conn.prepareStatement(query);
            psmt.setString(1, newNickname);
            psmt.setString(2, id);
            int affectedRows = psmt.executeUpdate();
            isUpdated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
        }

        return isUpdated;
    }

    // 사용자 ID로 사용자 정보를 조회하는 메서드
    public UserDTO getUserByID(String id) {
        String query = "SELECT id, email, nickname, password FROM project.users WHERE id = ?";
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        UserDTO dto = null;

        try {
            conn = dbConnPool.conn;  // DBConnPool에서 커넥션 가져오기
            psmt = conn.prepareStatement(query);
            psmt.setString(1, id);
            rs = psmt.executeQuery();
            if (rs.next()) {
                String eamil = rs.getString("email");
                String nickname = rs.getString("nickname");
                String password = rs.getString("password");
                dto = new UserDTO(id, eamil, nickname, password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dto;
    }

    //비밀번호 업데이트 메서드
    public boolean updatePassword(String id, String newPassword) {
        String query = "UPDATE project.users SET password=? WHERE id=?";
        Connection conn = null;
        PreparedStatement psmt = null;
        boolean isUpdated = false;

        try {
            conn = dbConnPool.conn;// DBConnPool에서 커넥션 가져오기
            psmt = conn.prepareStatement(query);
            psmt.setString(1, newPassword);// 비밀번호는 일반적으로 암호화된 상태로 저장됨
            psmt.setString(2, id);
            int affectedRows = psmt.executeUpdate();
            isUpdated = affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    public void close(){
        dbConnPool.close();
    }

    //회원 정보 삭제
    public boolean deleteUser(String id) {
        boolean result = false;

        try {
            String query = "DELETE FROM project.users WHERE id=?";
            dbConnPool.psmt = dbConnPool.conn.prepareStatement(query);
            dbConnPool.psmt.setString(1, id);
            int rowsAffected = dbConnPool.psmt.executeUpdate();
            result = (rowsAffected > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            //자원 해제
            dbConnPool.close();
        }
        return result;
    }
}
