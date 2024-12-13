package com.project.dailyeat.mvcboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //게시물 불러오기
        MVCBoardDAO dao = new MVCBoardDAO();
        String num = req.getParameter("num");

        //조회수 증가
        dao.updateVisitCount(num);

        // 게시글 상세보기
        MVCBoardDTO dto = dao.selectView(num);

        // 댓글 목록 불러오기
        ReplyDAO replyDAO = new ReplyDAO();
        List<ReplyDTO> replies = replyDAO.selectReplies(Integer.parseInt(num));

        // 댓글 수 계산
        int replyCount = replyDAO.getReplyCount(Integer.parseInt(num));


        // 자원 해제
        dao.close();
        replyDAO.close();

        //줄바꿈 처리
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));

        //첨부파일 확장자 확인하고 이미지 타입 확인
        String ext = null;
        String fileName = dto.getSfile();

        //이미지이름.png
        if (fileName != null) {
            ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        }

        String[] mimeStr = {"png", "jpg", "gif"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;

        if (mimeList.contains(ext)) {
            isImage = true;
        }



        // 데이터 요청 속성에 설정
        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.setAttribute("replies", replies);
        req.setAttribute("replyCount", replyCount);



        // JSP 페이지로 포워딩
        req.getRequestDispatcher("/project/community/View.jsp").forward(req, resp);
    }
}
