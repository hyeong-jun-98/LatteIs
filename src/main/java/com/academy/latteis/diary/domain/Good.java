package com.academy.latteis.diary.domain;

import lombok.*;

import java.sql.ResultSet;
import java.sql.SQLException;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Good {
    private long goodNo;
    private long userNo;
    private long diaryNo;
    private String goodCheck;


    public Good(ResultSet rs) throws SQLException {
        this.goodNo = rs.getLong("good_no");
        this.userNo = rs.getLong("user_no");
        this.diaryNo = rs.getLong("diary_no");
        this.goodCheck = rs.getString("goodCheck");
    }

}