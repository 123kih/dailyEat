package com.project.dailyeat.mvcboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/mvcboard/deleteReply")
public class ViewContentDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // 댓글 번호와 게시글 번호를 파라미터로 받아옴
        String replyNumStr = req.getParameter("replyNum");
        String boardnumStr = req.getParameter("boardnum");



        int replyNum = Integer.parseInt(replyNumStr);
        int boardnum = Integer.parseInt(boardnumStr);

        //ReplyDAO 객체 생성
        ReplyDAO replyDAO = new ReplyDAO();

        // 댓글 삭제
        int result = replyDAO.deleteReply(replyNum,boardnum);

        //자원해제
        replyDAO.close();

        if (result > 0) {
            // 댓글 삭제 성공 시 게시글 상세 페이지로 리다이렉트
            resp.sendRedirect("/mvcboard/view.do?num=" + boardnum);
        }else {
            //댓글 삭제 실패 시 에러 메시지 처리
            req.setAttribute("error", "댓글 삭제에 실패했습니다.");
        }

    }
}
