package com.academy.latteis.board.dto;

import lombok.*;

import java.util.Date;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class BestBoardDTO {
    private String content;
    private String commentCount;
    private String goodCount;
}
