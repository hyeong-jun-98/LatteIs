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
//    private Blob quizContent;
    private String quizAnswer;
    private Long quizGood;
    private Date quizRegdate;
    private Long quizHit;
    private String userNickname;
    private String quizCheck;
    private Long quizScore;

    private String fileName;

    private MultipartFile file;
}
