package com.academy.latteis.board.domain;

import lombok.*;

import java.util.Date;
import java.util.List;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board {
    private Long boardNo;
    private String title;
    private String writer;
    private String content;
    private Date regdate;
    private Long hit;
    private Long good;
    private String userNickname;
    private Long generation;

    // fk
    private Long topicNo;

    // 첨부파일들의 이름 목록
    private List<String> fileNames;
}
