package com.academy.latteis.diary.dto;

import com.academy.latteis.user.domain.Auth;
import lombok.*;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class ValidateDiaryUserDTO {
    private String userEmail;

    private Auth auth;
}
