package com.project.dailyeat.mvcboard;

import java.sql.Date;

public class ReplyDTO {
    private int boardnum;
    private String id;
    private String content;
    private Date rdate;
    private int replynum;

    public int getBoardnum() {
        return boardnum;
    }

    public void setBoardnum(int boardnum) {
        this.boardnum = boardnum;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getRdate() {
        return rdate;
    }

    public void setRdate(Date rdate) {
        this.rdate = rdate;
    }

    public int getReplynum() {
        return replynum;
    }
    public void setReplynum(int replynum) {
        this.replynum = replynum;
    }

}
