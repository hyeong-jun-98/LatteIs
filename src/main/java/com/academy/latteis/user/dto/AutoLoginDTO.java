package com.academy.latteis.user.dto;

import lombok.*;

import java.util.Date;
@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AutoLoginDTO {
    private String user_email;
    private String session_id;
    private Date limit_time;
}
