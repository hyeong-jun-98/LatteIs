package com.academy.latteis.interceptor;

import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.page.Page;
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

import static com.academy.latteis.util.LoginUtils.getCurrentMemberAccount;
import static com.academy.latteis.util.LoginUtils.isLogin;

@Configuration
@Log4j2
public class FreeBoardInterceptor implements HandlerInterceptor {

    // 인터셉터 전처리 메소드
    // 리턴값이 true일 경우 컨트롤러 진입을 허용하고
    // false일 경우 진입을 허용하지 않는다

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        log.info("board interceptor preHandle()");
        if (!isLogin(session)) {
            log.info("로그인이 필요한 서비스입니다.");

            response.sendRedirect("/user/login?message=no-login");
            return false;
        }
        return true;
    }

    // 인터셉터 후처리 메소드

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        // postHandle이 작동해야 하는 URI 목록
        List<String> uriList = Arrays.asList("/freeboard/edit", "/freeboard/delete", "/generation/edit", "/generation/delete");

        // 현재 요청 URI 정보 알아내기
        String requestURI = request.getRequestURI();
        log.info("requestURI - {}", requestURI);

        // 현재 요청 메소드 정보 확인
        String method = request.getMethod();

        // postHandle은 uriList 목록에 있는 URI에서만 작동하게 함
        if (uriList.contains(requestURI) && method.equalsIgnoreCase("GET")) {
            log.info("board interceptor postHandle()!");

            HttpSession session = request.getSession();

            // 컨트롤러의 메소드를 처리한 후 모델에 담긴 데이터의 맵
            Map<String, Object> modelMap = modelAndView.getModel();

            ValidateUserDTO dto = (ValidateUserDTO) modelMap.get("validate");
            Long boardNo = (Long) modelMap.get("boardNo");
            Page page = (Page) modelMap.get("page");

            log.info(requestURI.contains("/freeboard"));

            if (requestURI.contains("/freeboard")){
                // 수정하려는 게시글의 계정명 정보와 세션에 저장된 계정명 정보가 일치하지 않으면 리스트로 돌려보내라
                if (!isMine(session, dto.getUserEmail())) {
                    response.sendRedirect("/freeboard/detail/" + boardNo + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount() + "&msg=no-match");
                }
            }else {
                // 수정하려는 게시글의 계정명 정보와 세션에 저장된 계정명 정보가 일치하지 않으면 리스트로 돌려보내라
                if (!isMine(session, dto.getUserEmail())) {
                    response.sendRedirect("/generation/detail/" + boardNo + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount() + "&msg=no-match");
                }
            }
        }
    }

    private static boolean isMine(HttpSession session, String account) {
        return account.equals(getCurrentMemberAccount(session));
    }
}
