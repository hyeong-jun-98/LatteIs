package com.academy.latteis.user.dto;

import lombok.*;

import java.util.Date;
@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AutoLoginDTO {
    private String userEmail;
    private String sessionId;
    private Date limitTime;
}
