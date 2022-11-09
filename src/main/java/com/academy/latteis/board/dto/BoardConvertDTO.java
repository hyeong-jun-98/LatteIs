package com.academy.latteis.board.dto;

import lombok.*;

import java.util.Date;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardConvertDTO {
    private Long boardNo;
    private String title;
    private String writer;
    private Date regdate;
    private Long hit;
    private Long good;

    // 커스텀 필드
    private String shortTitle;  // 줄임 제목
    private String prettierDate;    // 변경된 날짜 포맷 문자열

}
