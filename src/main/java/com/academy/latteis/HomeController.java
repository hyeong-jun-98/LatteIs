package com.academy.latteis;

import com.academy.latteis.diary.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

import static com.academy.latteis.util.LoginUtils.*;

@Controller
@RequiredArgsConstructor
@Log4j2
public class HomeController {
    private final DiaryService diaryService;

    @GetMapping("/")
    public String home(Model model, HttpSession session, HttpServletRequest request){


        log.info("LatteIs에 오신 걸 환영합니다!!");
        log.info("로그아웃 후 쿠키 확인 {}", getAutoLoginCookie(request));

        Map<String, Object> diaryBestOneMap = diaryService.findBestOneService();
        log.info("홈 컨트롤러 베스트 하나 매핑 {}", diaryBestOneMap);

        model.addAttribute("dBOne", diaryBestOneMap.get("dBOne"));
        session.setAttribute("topbar", "home");


        return "index";
    }
}
