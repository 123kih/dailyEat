package com.project.dailyeat.users;

import com.project.dailyeat.common.DBConnPool;

import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class LoginDAO {
    private DBConnPool dbConnPool;

    public LoginDAO() {
        dbConnPool = new DBConnPool();
    }

    public UserDTO userLogin(LoginDTO dto) {
        UserDTO user = null;
        String query = "SELECT * FROM PROJECT.USERS WHERE id=? AND password=?";

        try {
            PreparedStatement psmt = dbConnPool.conn.prepareStatement(query);
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getPassword());

            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                //로그인 성공 시 UserDTO 객체 생성 및 값 설정
                user = new UserDTO();
                user.setId(rs.getString("id"));
                user.setPassword(rs.getString("password"));
                user.setNickname(rs.getString("nickname"));
                user.setEmail(rs.getString("email"));
            }
            rs.close();
            psmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            dbConnPool.close();
        }
        return user;
    }
}
