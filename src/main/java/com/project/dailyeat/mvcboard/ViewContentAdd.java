package com.project.dailyeat.mvcboard;

import com.project.dailyeat.users.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/mvcboard/insertReply")
public class ViewContentAdd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");


        String content = req.getParameter("content");
        String boardnumParam = req.getParameter("boardnum");

        //게시글 번호가 유효한지 확인
        if (content == null || boardnumParam == null || content.trim().isEmpty()) {
            resp.sendRedirect("/mvcboard/view.do?num=" + boardnumParam + "&error=emptyContent"); // 에러처리
        return;
        }

        int boardnum;

        try {
            boardnum = Integer.parseInt(boardnumParam);
        }catch (NumberFormatException e) {
            resp.sendRedirect("/mvcboard/view.do?error=invalidBoardnum");
            return;
        }


        // 세션에서 UserDTO 객체 가져오기
        UserDTO user = (UserDTO) req.getSession().getAttribute("loginMember");

        // 로그인 여부 확인
        if (user != null) {
            String userId = user.getId(); //UserDTO 에서 가져오기

            // 댓글 DTO 객체 생성 및 설정
            ReplyDTO reply = new ReplyDTO();
            reply.setContent(content.trim());//댓글 내용
            reply.setBoardnum(boardnum);//게시글 번호
            reply.setId(userId); //작성자 ID


            // DAO를 통해 댓글 삽입
            ReplyDAO replyDAO = new ReplyDAO();
            replyDAO.insertReply(reply);
            // 성공 후 해당 게시글 페이지로 리다이렉트
            resp.sendRedirect("/mvcboard/view.do?num=" + boardnum);
        } else {
            // 로그인이 안 되어 있을 경우 로그인 페이지로 리다이렉트
            resp.sendRedirect("/LoginMain.jsp?error=notLoggedIn");
        }
    }
}

