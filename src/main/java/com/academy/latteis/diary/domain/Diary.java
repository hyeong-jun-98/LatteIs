package com.academy.latteis.diary.domain;

import lombok.*;

import java.util.Date;

@Setter @Getter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class Diary {

    private long diary_no;
    private long emotion;
    private String diary_content;
    private Date diary_regdate;
    private long diary_show;
    private long diary_good;


}
