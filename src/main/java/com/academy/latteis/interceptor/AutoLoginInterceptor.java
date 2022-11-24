package com.academy.latteis.interceptor;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.repository.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.academy.latteis.util.LoginUtils.*;

@Configuration
@RequiredArgsConstructor
@Log4j2
public class AutoLoginInterceptor implements HandlerInterceptor {

    private final UserMapper userMapper;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //1. 자동로그인 쿠키 탐색
        Cookie c = getAutoLoginCookie(request);
        User usercheck = (User)request.getSession().getAttribute("loginUser");
        log.info("로그인 값 탐색 {}", usercheck);
        log.info("쿠키 탐색 {}", c);

        //2. 자동로그인 쿠키가 발견될 경우 쿠키값을 읽어서 세션아이디를 확인
        if (c != null) {
            String sessionId = c.getValue();
            log.info(c.getValue());

            //3. 쿠키에 저장된 세션아이디와 같은 값을 가진 회원정보 조회
            User user = userMapper.findUserBySessionId(sessionId);
            log.info("인터셉터 로그인 유저 체크 {}", user);
            if (user != null) {
                // 4. 세션에 해당 회원정보를 저장
                request.getSession().setAttribute(LOGIN_FLAG, user);
            }
        }
        return true;
    }
}
