package com.academy.latteis.interceptor;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.repository.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.academy.latteis.util.LoginUtils.*;

@Configuration
@RequiredArgsConstructor
public class AutoLoginInterceptor implements HandlerInterceptor {

    private final UserMapper userMapper;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //1. 자동로그인 쿠키 탐색
        Cookie c = getAutoLoginCookie(request);

        //2. 자동로그인 쿠키가 발견될 경우 쿠키값을 읽어서 세션아이디를 확인
        if (c != null) {
            String sessionId = c.getValue();

            //3. 쿠키에 저장된 세션아이디와 같은 값을 가진 회원정보 조회
            User user = userMapper.findUserBySessionId(sessionId);

            if (user != null) {
                // 4. 세션에 해당 회원정보를 저장
                request.getSession().setAttribute(LOGIN_FLAG, user);
            }
        }
        return true;
    }
}
