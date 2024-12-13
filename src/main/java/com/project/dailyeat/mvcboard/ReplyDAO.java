package com.project.dailyeat.mvcboard;

import com.project.dailyeat.common.DBConnPool;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReplyDAO extends DBConnPool {


    //댓글 추가
    public int insertReply(ReplyDTO dto) {
        int result = 0;

        try {
        // SQL 쿼리 준비
            String query = "INSERT INTO project.reply (boardnum, id , content, rdate, replynum) " +
                    "VALUES (?, ?, ?, SYSDATE, project.SEQ_REPLY_BNUM.NEXTVAL)";
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, dto.getBoardnum());
            psmt.setString(2, dto.getId());
            psmt.setString(3, dto.getContent());


            // 쿼리 실행 및 결과저장
            result = psmt.executeUpdate();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return result;


    }
    // 댓글 목록 조회
    public List<ReplyDTO> selectReplies(int boardnum) {
        List<ReplyDTO> replyList = new ArrayList<>();

        try {
            // SQL 쿼리 준비
            String query = "SELECT * FROM project.reply WHERE boardnum = ? ORDER BY rdate DESC";
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, boardnum);
            rs = psmt.executeQuery();

            // 결과 처리
            while (rs.next()) {
                ReplyDTO dto = new ReplyDTO();
                dto.setBoardnum(rs.getInt("boardnum"));
                dto.setId(rs.getString("id"));
                dto.setContent(rs.getString("content"));
                dto.setRdate(rs.getDate("rdate"));
                dto.setReplynum(rs.getInt("replynum"));
                replyList.add(dto);
            }



        }catch (SQLException e) {
            e.printStackTrace();
        }
        return replyList;

    }
    // 댓글 삭제
    public int deleteReply(int replyNum, int boardnum) {
        int result = 0;
        try {
            // SQL 쿼리 준비
            String query = "DELETE FROM project.reply WHERE replynum = ? ";
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, replyNum);


            // 쿼리 실행 및 결과 저장
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 특정 게시글의 댓글 수를 가져오는 메서드
    public int getReplyCount(int boardnum) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM project.reply WHERE boardnum = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, boardnum);
            rs = psmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
                System.out.println("boardnum: " + boardnum + " | 댓글 수: " + count); // 로그 출력
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }




}