package com.project.dailyeat.mvcboard;

import com.project.dailyeat.common.DBConnPool;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MVCBoardDAO extends DBConnPool {
    public MVCBoardDAO() {
        super();
    }

    //검색 조건에 맞는 게시물 개수 변환
    public int selectCount(Map<String, Object> map){
        int totalCount = 0;
        String query = "SELECT count(*) FROM project.board";
        if (map.get("searchWord") != null){
            query += " WHERE " + map.get("searchField") + " ";
            query += " LIKE '%" +map.get("searchWord") + "%'";
        }

        try {
            System.out.println("오류 없는지 확인");
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("MVC BOARD selectCount 에서 오류발생");
        }

    return totalCount;
    }

    //검색 조건에 맞는 게시물 목록 반환 (페이징 기능 O)
    public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {
        List<MVCBoardDTO> boardList = new ArrayList<>();

        String query = "SELECT *"
                + " FROM (SELECT tb.*, rownum rNum"
                + " FROM (SELECT * "
                + " FROM project.board";
        if (map.get("searchWord") != null){
            query += " WHERE " + map.get("searchField") + " ";
            query += " LIKE '%" +map.get("searchWord") + "%'";
        }
        query += " ORDER BY num desc"
                + " ) tb"
                + " )"
                +" WHERE rNum BETWEEN ? AND ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());

            System.out.println("start : " + map.get("start"));
            System.out.println("end : " + map.get("end"));

            rs = psmt.executeQuery();
            ReplyDAO replyDAO = new ReplyDAO();
            while (rs.next()){
                //한 row 의 내용을 DTO에 저장
                MVCBoardDTO dto= new MVCBoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setOfile(rs.getString("ofile"));
                dto.setSfile(rs.getString("sfile"));
                dto.setDowncount(rs.getInt("downcount"));
                dto.setPass(rs.getString("pass"));
                dto.setVisitcount(rs.getInt("visitcount"));


                //댓글 수 설정
                int replyCount = replyDAO.getReplyCount(dto.getNum());
                dto.setReplyCount(replyCount);  // BoardDTO 에 댓글 수 설정
                boardList.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("mvcboard selectListPage 오류 발생");
        }

        return boardList;
    }




    //게시글 작성
    public int insertWrite(MVCBoardDTO dto) {
        int result = 0;

        try {
            String query = "INSERT INTO project.board ( "
                    + " num, id, title, content, ofile, sfile, pass)"
                    + " VALUES ( "
                    + " project.seq_board_num.nextval, ?, ?, ?, ?, ?, ?)";

            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setString(6, dto.getPass());

            result = psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("insertWrite 오류 발생");
        }

        return result;
    }

    //게시글 상세보기
    public MVCBoardDTO selectView(String num) {
        MVCBoardDTO dto = new MVCBoardDTO();

        String query ="SELECT * FROM project.board WHERE num = ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);

            rs = psmt.executeQuery();

            if (rs.next()){
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setOfile(rs.getString("ofile"));
                dto.setSfile(rs.getString("sfile"));
                dto.setDowncount(rs.getInt("downcount"));
                dto.setPass(rs.getString("pass"));
                dto.setVisitcount(rs.getInt("visitcount"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MVCBoard selectView 오류발생");
        }

        return dto;
    }

    //조회수
    public void updateVisitCount(String num) {
        //쿼리문
        String query = "UPDATE project.board "
                + " SET visitcount = visitcount + 1"
                + " WHERE num = ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);
            rs = psmt.executeQuery();

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("mvcboard updateVisitCount 오류 발생");
        }
    }

    //입력한 비밀번호가 지정한 num 게시물의 비밀번호와 일치하는지 여부 확인
    public boolean confirmPassword(String pass, String num) {
        boolean isCorr = false;

        try {
            String query = "SELECT COUNT(*) FROM project.board" +
                    " WHERE pass = ? AND num = ?";
            psmt = conn.prepareStatement(query);
            psmt.setString(1, pass);
            psmt.setString(2, num);
            rs = psmt.executeQuery();

            rs.next();
            if (!(rs.getInt(1) == 0)) {
                isCorr = true;
            }

        } catch (Exception e) {
            isCorr = false;
            System.out.println("confirmPassword 오류 발생");
        }

        return isCorr;
    }

    //게시글 수정
    public int updatePost(MVCBoardDTO dto) {
        int result = 0;

        try {
            String query = "UPDATE project.board" +
                    " SET title = ?, id = ?, content = ?," +
                    " ofile = ?, sfile = ?" +
                    " WHERE num = ? AND PASS = ?";

            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getId());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
            psmt.setInt(6, dto.getNum());
            psmt.setString(7, dto.getPass());

            result = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("updatePost 오류 발생");
        }
        return result;
    }

    //게시글 삭제
    public int deletePost(String num) {
        int result = 0;

        try {
            String query = "DELETE FROM project.board WHERE num = ?";

            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);
            result = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("deletePost 오류 발생");
        }

        return result;
    }


    public List<MVCBoardDTO> getBoardList() {
        List<MVCBoardDTO> mvcBoardDTOList = new ArrayList<>();
        String query = "SELECT * FROM project.board order by num desc"; // 게시글 목록 조회 쿼리

        try {
            psmt = conn.prepareStatement(query);
            rs = psmt.executeQuery();

            ReplyDAO replyDAO = new ReplyDAO(); // 댓글 DAO 생
            while (rs.next()) {
                MVCBoardDTO dto = new MVCBoardDTO();
                dto.setNum(rs.getInt("num")); // 게시글 번호 설정
                dto.setId(rs.getString("id"));  // 작성자 ID 설정
                dto.setTitle(rs.getString("title")); // 제목 설정
                dto.setPostdate(rs.getDate("postdate")); // 작성일 설정
                dto.setVisitcount(rs.getInt("visitcount"));  // 조회수 설정

                //댓글 수 설정
                int replyCount = replyDAO.getReplyCount(dto.getNum());
                dto.setReplyCount(replyCount);  // BoardDTO 에 댓글 수 설정

                mvcBoardDTOList.add(dto); // 리스트에 추가
            }


        }catch (Exception e){
            e.printStackTrace();
        } finally {
            close(); // 자원 반납
        }
        return mvcBoardDTOList;
    }




}
