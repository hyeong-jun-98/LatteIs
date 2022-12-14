package com.academy.latteis.quiz.controller;

import com.academy.latteis.quiz.domain.Quiz;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@Log4j2
@RequestMapping("/quiz")
public class QuizController {

    private static final String UPLOAD_PATH = "/usr/local/upload";

    @GetMapping("/write")
    public String quizWrite(){
        log.info("controller /quiz/write GET");
        return "quiz/quiz-write";
    }

    @GetMapping("/list")
    public String quizList(){





        return "quiz/quiz_list";
    }
}






