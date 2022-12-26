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
    private Long generation;
    private String topicName;

    // good
    private String userNo;  // 좋아요를 누가 눌렀냐..

    private String prettierDate;    // 변경된 날짜 포맷 문자열

}
