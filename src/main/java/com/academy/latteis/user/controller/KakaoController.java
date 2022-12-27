package com.academy.latteis.user.controller;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.dto.KaKaoUserInfoDTO;
import com.academy.latteis.user.repository.UserMapper;
import com.academy.latteis.user.service.KakaoService;

import com.academy.latteis.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
    private final UserMapper userMapper;



    // 카카오 인증서버가 보내준 인가코드를 받아서 처리할 메서드
    @GetMapping(KAKAO_REDIRECT_URI)
    public String kakaoLogin(String code, HttpSession session, HttpServletRequest request) throws Exception {

        String referer = (String) session.getAttribute("referer");
        String url = referer.substring(referer.indexOf("/"));

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
        return "redirect:"+url;
    }
    @GetMapping("/kakaoinfo")
    public String kakaoInfo(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("loginUser");
        log.info(request.getHeader("Referer"));
        String referer = (String) session.getAttribute("referer");
        String url = referer.substring(referer.indexOf("/"));
        log.info(session.getAttribute("loginUser"));
        String login = "kakao";
        User loginUser = null;

        if(user.getUserEmail()!=null) {//카카오 이메일 동의
            loginUser = userMapper.findUser(user.getUserEmail(),login);
            if(loginUser==null){//카카오 이메일 동의+첫 로그인
                return "/user/kakao_nickname";
            }else {//카카오 이메일 비동의 + n번째 로그인
                session.setAttribute("loginUser", loginUser);
                return "redirect:"+url;
            }
        }
        else{//카카오 이메일 비동의
            loginUser = userMapper.findUser((String)session.getAttribute("kakaoEmail"),login);
            if(loginUser==null){//카카오 이메일 비동의+첫 로그인
                return "/user/kakao_email";
            }else {//카카오 이메일 비동의 + n번째 로그인
                session.setAttribute("loginUser", loginUser);
                return "redirect:"+url;
            }
        }

    }
    @PostMapping("/kakaoemail")
    public String kakaoEmail(HttpSession session, User user) throws Exception{
        User kakaouser = (User) session.getAttribute("loginUser");
        String login = "kakao";
        user.setUserName(kakaouser.getUserName());
        log.info("user check {}",user);
        user = kakaoService.kakaoJoin(user, login);
        session.setAttribute("loginUser", user);
        String referer = (String) session.getAttribute("referer");
        log.info("referer 테스트 - {}", referer);
        String url = referer.substring(referer.indexOf("/"));
        log.info("자르기 테스트 - {}",url);
        return "redirect:"+url;
    }

    @PostMapping("/kakaonickname")
    public String kakaoNickname(HttpSession session, User user) throws Exception{
        User kakaouser = (User) session.getAttribute("loginUser");
        String login = "kakao";
        user.setUserName(kakaouser.getUserName());
        user.setUserEmail(kakaouser.getUserEmail());
        log.info("user check {}",user);
        user = kakaoService.kakaoJoin(user, login);
        session.setAttribute("loginUser", user);
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

    @GetMapping("/kakao/email")
    @ResponseBody
    public void check(String userEmail, HttpSession session) {
        log.info("로컬스토리지 이메일 {}", userEmail);
        session.setAttribute("kakaoEmail", userEmail);

    }
}