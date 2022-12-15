package com.academy.latteis.quiz.api;

import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.service.QuizService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor    // 생성자 주입
@Log4j2
@RequestMapping("/api/quiz")
@CrossOrigin    // CORS를 적용하는 어노테이션
public class QuizApiController {

//    private final QuizService quizService;
//
//    @PostMapping("")
//    public ResponseEntity<String> quizWrite(Quiz quiz){
//        log.info("restcontroller /api/quiz POST - {}", quiz.getFile().getOriginalFilename());
//
//        String fileName = quiz.getFile().getOriginalFilename();
//        quiz.setFileName(fileName);
//
//        boolean b = quizService.writeService(quiz);
//        log.info("그림 작성 결과는 {}", b);
//
//        return new ResponseEntity<>("good", HttpStatus.OK);
//    }
}
