package com.academy.latteis.quiz.domain;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Blob;
import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Quiz {
    private Long quizNo;
    private String quizWriter;
    private String quizAnswer;
    private Long quizGood;
    private Date quizRegdate;
    private Long quizHit;
    private String userNickname;
    private String quizCheck;
    private Long quizScore;
    private String fileName;
    private String whoCorrect;

    private String shortTitle;  // 줄임 제목
    private String prettierDate;    // 변경된 날짜 포맷 문자열
    private boolean newPost;  // 새 게시물 표시

    private String userGrade;  // 등급 

}

