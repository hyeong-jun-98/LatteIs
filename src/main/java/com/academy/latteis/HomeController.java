package com.academy.latteis;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import static com.academy.latteis.util.LoginUtils.*;

@Controller
@Log4j2
public class HomeController {

    @GetMapping("/")
    public String home(Model model, HttpSession session, HttpServletRequest request){
        session.setAttribute("topbar", "home");

        log.info("LatteIs에 오신 걸 환영합니다!!");
        log.info("로그아웃 후 쿠키 확인 {}", getAutoLoginCookie(request));
        return "index";
    }
}
