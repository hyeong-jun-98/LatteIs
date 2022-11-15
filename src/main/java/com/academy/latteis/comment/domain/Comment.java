package com.academy.latteis.comment.domain;

import lombok.*;

import java.util.Date;

@Setter @Getter @ToString
@NoArgsConstructor
@AllArgsConstructor
//@Builder    // 사용하면 값을 세팅할 때, 필요한 값들만 골라서 세팅할 수가 있음
public class Comment {
    private Long commentNo;
    private String commentWriter;
    private String commentContent;
    private Date commentDate;
    private Long boardNo;
    private String userNickname;
}
