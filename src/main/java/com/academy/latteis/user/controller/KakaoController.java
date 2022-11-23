package com.academy.latteis.user.controller;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.dto.KaKaoUserInfoDTO;
import com.academy.latteis.user.service.KakaoService;

import com.academy.latteis.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.method.annotation.HttpEntityMethodProcessor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import static com.academy.latteis.user.domain.OAuthValue.*;
import static com.academy.latteis.util.LoginUtils.*;
import static com.academy.latteis.user.domain.SNSLogin.*;

@Controller
@Log4j2
@RequiredArgsConstructor
public class KakaoController {

    private final KakaoService kakaoService;
    private final UserService userService;

    @GetMapping("/kakao-test")
    public void kakoTest(Model model) {
        log.info("forward to kakao-test.jsp!");
        model.addAttribute("appKey", KAKAO_APP_KEY);
        model.addAttribute("redirectUri", KAKAO_REDIRECT_URI);
    }

    // 카카오 인증서버가 보내준 인가코드를 받아서 처리할 메서드
    @GetMapping(KAKAO_REDIRECT_URI)
    public String kakaoLogin(String code, HttpSession session, HttpServletRequest request) throws Exception {
        log.info("{} GET!! code - {}", KAKAO_REDIRECT_URI, code);
        // 인가코드를 통해 액세스토큰 발급받기
        // 우리서버에서 카카오서버로 통신을 해야함.
        String accessToken = kakaoService.getAccessToken(code);

        // 액세스 토큰을 통해 사용자 정보 요청(프로필사진, 닉네임 등)
        KaKaoUserInfoDTO userInfo = kakaoService.getKakaoUserInfo(accessToken);

        // 로그인 처리
        if (userInfo != null) {
            User user = new User();
            user.setUserEmail(userInfo.getEmail());
            user.setUserName(userInfo.getNickName());
            session.setAttribute(LOGIN_FLAG, user);
            session.setAttribute("profile_path", userInfo.getProfileImg());
            session.setAttribute(LOGIN_FROM, KAKAO);
            session.setAttribute("accessToken", accessToken);
            session.setAttribute("loginUser", user);
            log.info("test {}", user);
            return "redirect:/kakaoinfo";
        }

        String referer = (String) session.getAttribute("referer");
        log.info("referer 테스트 - {}", referer);
        String url = referer.substring(referer.indexOf("/"));
        log.info("자르기 테스트 - {}",url);
        return "redirect:"+url;
    }
    @GetMapping("kakaoinfo")
    public String kakaoInfo(HttpServletRequest request){
        HttpSession session = request.getSession();
        log.info(request.getHeader("Referer"));
        log.info(session.getAttribute("loginUser"));
        String login = "kakao";
        boolean check = kakaoService.kakaoLogin(session, login);
        log.info("true? false? {}", check);
        String referer = (String) session.getAttribute("referer");
        log.info("referer 테스트 - {}", referer);
        if(referer !=null) {
            String url = referer.substring(referer.indexOf("/"));
            log.info("자르기 테스트 - {}",url);
            return check ? "redirect:"+url : "/user/kakao_nickname";
        }
        return check ? "redirect:/" : "/user/kakao_nickname";

    }
    @PostMapping("/kakaonickname")
    public String kakaoNickname(HttpSession session, User user) throws Exception{
        User kakaouser = (User) session.getAttribute("loginUser");
        String login = "kakao";
        user.setUserName(kakaouser.getUserName());
        user.setUserEmail(kakaouser.getUserEmail());
        session.setAttribute("loginUser", user);
        log.info("user check {}",user);
        kakaoService.kakaoJoin(user, login);
        String referer = (String) session.getAttribute("referer");
        log.info("referer 테스트 - {}", referer);
        String url = referer.substring(referer.indexOf("/"));
        log.info("자르기 테스트 - {}",url);
        return "redirect:"+url;
    }

    // 카카오 로그아웃
    @GetMapping("/kakao/logout")
    public String kakaoLogout(HttpSession session) throws Exception {

        // 카카오 로그아웃 처리
        kakaoService.logout((String) session.getAttribute("accessToken"));

        // 우리 서비스 로그아웃
        session.invalidate();

        return "redirect:/user/login";
    }
}
