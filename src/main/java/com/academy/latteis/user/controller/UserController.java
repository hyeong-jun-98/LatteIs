package com.academy.latteis.user.controller;

import com.academy.latteis.user.domain.SNSLogin;
import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.dto.LoginDTO;
import com.academy.latteis.user.service.KakaoService;
import com.academy.latteis.user.service.LoginFlag;
import com.academy.latteis.user.service.UserService;
import com.academy.latteis.common.page.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.academy.latteis.util.LoginUtils.*;
import static com.academy.latteis.user.domain.OAuthValue.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

        private final UserService userService;
        private final KakaoService kakaoService;
        // 로그인 화면 요청
//        @GetMapping("/login")
//        public String loginform() {
//            return "/user/login";
//        }

        // 회원가입 화면 요청
        @GetMapping("/join")
        public String joinform() { return "/user/join"; }

        @PostMapping("/join")
        public String join(User user){
                log.info(user);
                String login = "latteis";
                boolean check = userService.saveUser(user, login);
                return check ? "/user/login" : "/";
        }

        @GetMapping("/check")
        @ResponseBody
        public ResponseEntity<Boolean> check(String loginType, String type, String value) {
                log.info("/member/check?loginType={}&type={}&value={} GET!! ASYNC",loginType, type, value);
                boolean flag = userService.checkSignUpValue(loginType ,type, value);
                return new ResponseEntity<>(flag, HttpStatus.OK);
        }

        @GetMapping("/login")
        public void signIn(@ModelAttribute("message") String message, HttpServletRequest request, Model model) {
                log.info("/member/sign-in GET! - forwarding to sign-in.jsp - {}", message);

                // 요청 정보 헤더 안에는 Referer라는 키가 있는데
                // 여기 안에는 이 페이지로 진입할 때 어디에서 왔는지 URI정보가 들어있음.
                String referer = request.getHeader("Referer");
                log.info("referer: {}", referer);
                request.getSession().setAttribute("referer", referer);


                request.getSession().setAttribute("redirectURI", referer);

                request.getSession().setAttribute("kakaoAppKey", KAKAO_APP_KEY);
                request.getSession().setAttribute("kakaoRedirect", KAKAO_REDIRECT_URI);

        }
        //로그인요청
        @PostMapping("/login")
        public String login(LoginDTO inputData
                , Model model
                , HttpSession session // 세션정보 객체
                , HttpServletResponse response
                            ,HttpServletRequest request
        ) {

                log.info("/member/sign-in POST - {}", inputData);

                String login = "latteis";
                String referer = (String) session.getAttribute("referer");
                log.info("referer 테스트 - {}", referer);
                String url = referer.substring(referer.indexOf("/"));
                log.info("자르기 테스트 - {}",url);
                inputData.setLogin(login);
//        log.info("session timeout : {}", session.getMaxInactiveInterval());

                // 로그인 서비스 호출
                LoginFlag flag = userService.login(inputData, session, response);

                if (flag == LoginFlag.SUCCESS) {
                        log.info("login success!!");
                        String redirectURI = (String) session.getAttribute("redirectURI");
                        return "redirect:"+url;
                }
                model.addAttribute("loginMsg", flag);
                return "/user/login";

        }

        @GetMapping("/logout")
        public String signOut(HttpServletRequest request, HttpServletResponse response) throws Exception {

                HttpSession session = request.getSession();

                if (isLogin(session)) {

                        // 만약 자동로그인 상태라면 해제한다.
                        if (hasAutoLoginCookie(request)) {
                                userService.autoLogout(getCurrentMemberAccount(session), request, response);
                        }

                        // SNS로그인 상태라면 해당 SNS 로그아웃처리를 진행
//                        SNSLogin from = (SNSLogin) session.getAttribute(LOGIN_FROM);
//                        switch (from) {
//                                case KAKAO:
//                                        kakaoService.logout((String) session.getAttribute("accessToken"));
//                                        break;
//                                case NAVER:
//                                        break;
//                                case GOOGLE:
//                                        break;
//                                case FACEBOOK:
//                                        break;
//                        }

                        // 1. 세션에서 정보를 삭제한다.
                        session.removeAttribute(LOGIN_FLAG);

                        // 2. 세션을 무효화한다.
                        session.invalidate();
                        return "redirect:/";
                }
                return "redirect:/user/login";
        }

        @GetMapping("/mypage")
        public String mypage(HttpSession session){
                User user = userService.findUser((User)session.getAttribute("loginUser"));
                session.setAttribute("loginUser", user);
                return "/user/mypage";
        }

        @GetMapping("/revise")
        public String getRevise(){ return "/user/revise";}

        @PostMapping("/revise")
        public String revise(User user, HttpSession session){
                User loginUser =(User) session.getAttribute("loginUser");
                user.setUserNo(loginUser.getUserNo());
                log.info(user);
                userService.revise(loginUser, user);
                session.setAttribute("loginUser", userService.findUser(loginUser));
                return "redirect:/user/mypage";
        }

        @GetMapping("/exit")
        public String exit(HttpSession session){
                User user = (User) session.getAttribute("loginUser");
                userService.exitUser(user);
                // 1. 세션에서 정보를 삭제한다.
                session.removeAttribute(LOGIN_FLAG);
                // 2. 세션을 무효화한다.
                session.invalidate();
                return "redirect:/";
        }

}
