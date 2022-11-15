package com.academy.latteis.user.dto;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LoginDTO {
    private String user_email;
    private String password;
    private boolean autologin;

}
