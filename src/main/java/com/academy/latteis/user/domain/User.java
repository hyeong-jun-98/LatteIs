package com.academy.latteis.user.domain;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int userNo;
    private String userNickname;
    private String userName;
    private String userEmail;
    private String password;
    private String userYear;
    private Auth auth;
    private String login;
    private String userGrade;
    private long userScore;
}
