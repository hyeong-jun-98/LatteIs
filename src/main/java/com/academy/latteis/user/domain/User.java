package com.academy.latteis.user.domain;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int user_no;
    private String user_nickname;
    private String user_name;
    private String user_email;
    private String password;
    private int user_year;
}
