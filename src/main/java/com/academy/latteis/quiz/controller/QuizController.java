package com.academy.latteis.quiz.controller;

import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.service.QuizService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@Log4j2
@RequestMapping("/quiz")
@RequiredArgsConstructor
public class QuizController {

    private static final String UPLOAD_PATH = "/usr/local/upload";

    private final QuizService quizService;

    @GetMapping("/write")
    public String quizWrite(){
        log.info("controller /quiz/write GET");
        return "quiz/quiz-write";
    }

    @PostMapping("/write")
    public void quizWrite(Quiz quiz){
        log.info(quiz);
        quizService.writeService(quiz);
    }


    @GetMapping("/list")
    public String quizList(Model model){
        List<Quiz> quizList = quizService.findAllQuiz();
        model.addAttribute("qPList",quizList);
        return "quiz/quiz_list";
    }
}






