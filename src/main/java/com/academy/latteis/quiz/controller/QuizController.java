package com.academy.latteis.quiz.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequestMapping("/quiz")
public class QuizController {

    @GetMapping("/write")
    public String toQuiz(){
        return "quiz/quiz-write";
    }

    @GetMapping("/list")
    public String quizList(){





        return "quiz/quiz_list";
    }
}






