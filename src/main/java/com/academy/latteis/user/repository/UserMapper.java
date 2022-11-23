package com.academy.latteis.user.repository;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.dto.AutoLoginDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface UserMapper {

    // 회원 가입 기능
    boolean save(User user);


    // 중복체크 기능
    // 체크타입: 계정 or 이메일
    // 체크값: 중복검사대상 값
    int isDuplicate(Map<String, Object> checkMap);

    // 회원정보 조회 기능
    User findUser(String userEmail, String login);

    // 자동로그인 쿠키정보 저장
    void saveAutoLoginValue(AutoLoginDTO dto);

    // 쿠키값(세션아이디)을 가지고 있는 회원정보 조회
    User findUserBySessionId(String sessionId);

}
