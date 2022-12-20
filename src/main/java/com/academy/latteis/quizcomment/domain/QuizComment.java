package com.academy.latteis.quizcomment.domain;

import lombok.*;

import java.util.Date;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class QuizComment {
    private Long quizCommentNo;
    private String quizCommentWriter;
    private String quizCommentContent;
    private Date quizCommentDate;
    private Long quizNo;
    private String userNickname;
}
