package com.academy.latteis.diary.domain;

import lombok.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

@Setter @Getter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class Diary {

    private long diaryNo;
    private String emotion;
    private String diaryContent;
    private Date diaryRegdate;
    private String diaryShow;
    private long diaryGood;
    private String userNickname;



    // 커스텀 데이터 필드
    private String shortTitle; // 줄임 제목
    private String prettierDate; // 변경된 날짜포맷 문자열
    private boolean newArticle; // 신규 게시물 여부


    public Diary (ResultSet rs) throws SQLException {
        this.diaryNo = rs.getLong("diary_no");
        this.emotion = rs.getString("emotion");
        this.diaryContent = rs.getString("diary_content");
        this.diaryRegdate = rs.getTimestamp("diary_regdate");
        this.diaryShow = rs.getString("diary_show");
        this.diaryGood = rs.getLong("diary_good");
        this.userNickname = rs.getString("user_nickname");
    }

}
