package com.project.dailyeat.users;


import com.project.dailyeat.common.DBConnPool;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SignUpDAO extends DBConnPool {

    //사용자가 입력한 데이터 DB에 추가
    public int insertUsers(SignUpDTO dto) {
        int result = 0;
        String query = "INSERT INTO project.users VALUES(?, ?, ?, ?)";


        try (PreparedStatement psmt = conn.prepareStatement(query)){
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getPassword());
            psmt.setString(3, dto.getNickname());
            psmt.setString(4, dto.getEmail());
            result = psmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //사용자 ID 중복 확인
    public boolean checkId(String id) {
        String query = "SELECT COUNT(*) FROM project.users WHERE id=?";
        try (PreparedStatement psmt = conn.prepareStatement(query)) {
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;//0이면 사용 가능
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //사용자 닉네임 중복 확인
    public boolean checkNickname(String nickname) {
        String query = "SELECT COUNT(*) FROM project.users WHERE nickname=?";
        try (PreparedStatement psmt = conn.prepareStatement(query)) {
            psmt.setString(1, nickname);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;//0이면 사용 가능
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
