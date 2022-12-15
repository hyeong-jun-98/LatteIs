package com.academy.latteis;

import com.academy.latteis.board.domain.Topic;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.service.BoardService;
import com.academy.latteis.diary.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

import static com.academy.latteis.util.LoginUtils.*;

@Controller
@RequiredArgsConstructor
@Log4j2
public class HomeController {
    private final DiaryService diaryService;
    private final BoardService boardService;

    public static String topicName;


    @GetMapping("/")
    public String home(Model model, HttpSession session, HttpServletRequest request){


        log.info("LatteIs에 오신 걸 환영합니다!!");
        log.info("로그아웃 후 쿠키 확인 {}", getAutoLoginCookie(request));

        Map<String, Object> diaryBestOneMap = diaryService.findBestOneService();
        log.info("홈 컨트롤러 베스트 하나 매핑 {}", diaryBestOneMap);

        Map<String, Object> boardBestMap = boardService.findBestBoard();
        log.info(boardBestMap);
        model.addAttribute("dBOne", diaryBestOneMap.get("dBOne"));
        model.addAttribute("bf", boardBestMap.get("free"));
        model.addAttribute("bk", boardBestMap.get("key"));
        model.addAttribute("b00", boardBestMap.get("gene00"));
        model.addAttribute("b90", boardBestMap.get("gene90"));
        model.addAttribute("b80", boardBestMap.get("gene80"));
        model.addAttribute("b70", boardBestMap.get("gene70"));
        session.setAttribute("topbar", "home");

        session.setAttribute("topicName", topicName);

        return "index";
    }
}
