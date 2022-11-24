package com.academy.latteis.interceptor;

import com.academy.latteis.user.domain.User;
import lombok.extern.log4j.Log4j2;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Configuration
@Log4j2
public class HomeInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        String redirect=null;
        log.info("인터셉터 유저 탐색 {}", user);
        if(user!=null) {
            if (user.getUserNickname() == null && user.getUserEmail() != null) {
                session.invalidate();
                redirect = "/user/login";
            }
            else{
                return true;
            }
            response.sendRedirect(redirect);
            return false;
        }
        return true;

    }
}
