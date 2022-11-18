package com.academy.latteis.board.dto;

import lombok.*;

import java.util.Date;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardGoodDTO {
    private Long boardNo;
    private String title;
    private String writer;
    private String content;
    private Date regdate;
    private Long hit;
    private Long good;
    private String img;
    private String userNickname;

    // fk
    private Long topicNo;

    // good
    private String userNo;
}
