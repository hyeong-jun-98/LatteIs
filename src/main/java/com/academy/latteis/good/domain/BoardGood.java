package com.academy.latteis.good.domain;

import lombok.*;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardGood {
    private Long boardGoodNo;
    private Long userNo;
    private Long boardNo;
    private String goodCheck;
}
