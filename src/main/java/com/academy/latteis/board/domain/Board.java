package com.academy.latteis.board.domain;

import lombok.*;

import java.util.Date;

@Setter @Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board {
    private Long boardNo;
    private String title;
    private String writer;
    private String content;
    private Date regDate;
    private Long hit;
    private Long good;
    private String img;

    // fk
    private Long topicNo;
}
