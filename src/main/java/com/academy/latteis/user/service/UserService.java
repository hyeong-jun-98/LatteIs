package com.academy.latteis.user.service;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.dto.AutoLoginDTO;
import com.academy.latteis.user.dto.LoginDTO;
import com.academy.latteis.user.repository.UserMapper;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.academy.latteis.user.service.LoginFlag.*;
import static com.academy.latteis.util.LoginUtils.*;

@Service
@Log4j2
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;

    private final BCryptPasswordEncoder encoder;

    //회원가입
    public boolean saveUser(User user){
        user.setPassword(encoder.encode(user.getPassword()));
        boolean loginCheck = userMapper.save(user);
        return loginCheck;
    }
    //중복체크
    public boolean checkSignUpValue(String type, String value) {
        Map<String, Object> checkMap = new HashMap<>();
        checkMap.put("type", type);
        checkMap.put("value", value);

        return userMapper.isDuplicate(checkMap) == 1;
    }

    public LoginFlag login(LoginDTO inputData, HttpSession session, HttpServletResponse response) {
        // 회원가입 여부 확인
        User foundUser = userMapper.findUser(inputData.getUser_email());
        log.info(foundUser);
        if (foundUser != null) {
            if (encoder.matches(inputData.getPassword(), foundUser.getPassword())) {
                // 로그인 성공
                // 세션에 사용자 정보기록 저장
                session.setAttribute("loginUser", foundUser);

                // 세션 타임아웃 설정
                session.setMaxInactiveInterval(60 * 60); // 1시간

                // 자동 로그인 처리
                if (inputData.isAutologin()) {
                    log.info("checked auto login user!!");
                    keepLogin(foundUser.getUser_email(), session, response);
                }


                return SUCCESS;
            } else {
                // 비번 틀림
                return NO_PW;
            }
        } else {
            // 아이디 없음
            return NO_ACC;
        }
    }
    private void keepLogin(String user_email, HttpSession session, HttpServletResponse response) {
        // 1. 자동로그인 쿠키 생성 - 쿠키의 값으로 현재 세션의 아이디를 저장
        String session_id = session.getId();
        Cookie c = new Cookie(LOGIN_COOKIE, session_id);
        // 2. 쿠키 설정 (수명, 사용 경로)
        int limitTime = 60 * 60 * 24 * 90; // 90일에 대한 초
        c.setMaxAge(limitTime);
        c.setPath("/"); // 전체경로
        // 3. 로컬에 쿠키 전송
        response.addCookie(c);

        // 4. DB에 쿠키값과 수명 저장
        // 자동로그인 유지시간(초)을 날짜로 변환
        long nowTime = System.currentTimeMillis();
        Date limitDate = new Date(nowTime + ((long) limitTime * 1000));

        AutoLoginDTO dto = new AutoLoginDTO(user_email, session_id, limitDate);

        userMapper.saveAutoLoginValue(dto);
    }

    // 자동로그인 해제
    public void autoLogout(String user_email, HttpServletRequest request, HttpServletResponse response) {

        //1. 자동로그인 쿠키를 불러온 뒤 수명을 0초로 세팅해서 클라이언트에 돌려보낸다
        Cookie c = getAutoLoginCookie(request);
        if (c != null) {
            c.setMaxAge(0);
            response.addCookie(c);

            //2. 데이터베이스 처리
            AutoLoginDTO dto = new AutoLoginDTO(user_email, "none", new Date());
            userMapper.saveAutoLoginValue(dto);
        }
    }
}