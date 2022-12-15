package com.academy.latteis.quiz.controller;

import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.common.page.DiaryPageMaker;
import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.service.QuizService;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/quiz")
public class QuizController {

    private final QuizService quizService;

    @GetMapping("/write")
    public String quizWrite(){
        log.info("controller /quiz/write GET");
        return "quiz/quiz-write";
    }

    @GetMapping("/list")
    public String quizList(DiaryPage diaryPage, Model model){
        Map<String, Object> quizMap = quizService.findAllService(diaryPage);

        DiaryPageMaker pm = new DiaryPageMaker(
                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
                , (Integer) quizMap.get("tc"));

        log.info("quizListController {}", quizMap);

        model.addAttribute("qList", quizMap.get("qList"));
        model.addAttribute("pm", pm);


        return "quiz/quiz_list";
    }

    @GetMapping("/detail/{quizNo}")
    public String quizDetail(@PathVariable Long quizNo, DiaryPage diaryPage, Model model, HttpSession session) {

        log.info(" quizDetailController quizNo {}", quizNo);

        Quiz quiz  = quizService.findOneService(quizNo);
        log.info(" quizDetailController quizNo {}", quiz);

        User loginUser = (User) session.getAttribute("loginUser");
        log.info("로그인 유저 데이터 {}", loginUser);

        model.addAttribute("q", quiz);
        model.addAttribute("diaryPage", diaryPage);
        model.addAttribute("user", loginUser);


        return "quiz/quiz_detail";
    }



}






