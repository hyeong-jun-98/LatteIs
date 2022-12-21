package com.academy.latteis.interceptor;

import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.page.DiaryPage;
import lombok.extern.log4j.Log4j2;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.academy.latteis.util.LoginUtils.*;

@Configuration
@Log4j2
public class QuizInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info("quiz interceptor preHandle()");

        HttpSession session = request.getSession();
        if (!isLogin(session)) {
            log.info("로그인이 필요한 서비스입니다.");

            response.sendRedirect("/user/login?message=no-login");
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        // postHandle이 작동해야 하는 URI 목록
        List<String> uriList = Arrays.asList("/quiz/delete");

        // 현재 요청 URI 정보 알아내기
        String requestURI = request.getRequestURI();
        log.info("requiestURI - {}", requestURI);

        // 현재 요청 메소드 정보 확인
        String method = request.getMethod();

        // postHandle은 uriList 목록에 있는 URI에서만 작동하게 함
        if (uriList.contains(requestURI) && method.equalsIgnoreCase("GET")) {
            log.info("quiz interceptor postHandle()");

            HttpSession session = request.getSession();

            // 컨트롤러의 메소드를 처리한 후 모델에 담긴 데이터의 맵
            Map<String, Object> modelMap = modelAndView.getModel();

            ValidateUserDTO dto = (ValidateUserDTO) modelMap.get("validate");
            Long quizNo = (Long) modelMap.get("quizNo");
            DiaryPage diaryPage = (DiaryPage) modelMap.get("page");

            if (isAdmin(session)) {
                log.info("인터셉터 : 관리자");
                return;
            }

            if (!isMine(session, dto.getUserEmail())) {
                response.sendRedirect("/quiz/detail/" + quizNo + "?pageNum=" + diaryPage.getPageNum() + "&amount=" + diaryPage.getAmount() + "&msg=no-match");
            }
        }
    }

    private boolean isAdmin(HttpSession session) {
        return getCurrentMemberAuth(session).equals("ADMIN");
    }

    private static boolean isMine(HttpSession session, String account) {
        return account.equals(getCurrentMemberAccount(session));
    }
}
