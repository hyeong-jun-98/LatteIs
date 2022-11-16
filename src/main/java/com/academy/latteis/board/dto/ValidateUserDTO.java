package com.academy.latteis.board.dto;

import com.academy.latteis.user.domain.Auth;
import lombok.*;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class ValidateUserDTO {
    private String userEmail;
    private Auth auth;
}
