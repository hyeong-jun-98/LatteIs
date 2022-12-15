package com.academy.latteis.quiz.domain;

import lombok.*;

import java.util.Date;

@Setter @Getter @ToString
@AllArgsConstructor @NoArgsConstructor
public class Quiz {

    private Long quizNo;
    private String quizWriter;
    private String quizContent;
    private String quizAnswer;
    private long quizGood;
    private Date quizRegdate;
    private long quizHit;
    private String userNickname;
    private String quizCheck;
    private long quizScore;


    // 커스텀 데이터 필드
    private String shortTitle; // 줄임 제목
    private String prettierDate; // 변경된 날짜포맷 문자열
    private boolean newArticle; // 신규 게시물 여부

}
