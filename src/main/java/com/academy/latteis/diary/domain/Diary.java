package com.academy.latteis.diary.domain;

import lombok.*;

import java.util.Date;

@Setter @Getter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class Diary {

    private long diaryNo;
    private String emotion;
    private String diaryContent;
    private Date diaryRegdate;
    private String diaryShow;
    private long diaryGood;


}
