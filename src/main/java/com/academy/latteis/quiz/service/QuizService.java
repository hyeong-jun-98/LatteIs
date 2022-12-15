package com.academy.latteis.quiz.service;

import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.repository.QuizMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class QuizService {

    private final QuizMapper quizMapper;

    public boolean writeService(Quiz quiz) {
        log.info("quiz write service start - {}", quiz);
        boolean flag = quizMapper.write(quiz);

        return flag;
    }

    public List<Quiz> findAllQuiz(){
        List<Quiz> quizList = quizMapper.findAllQuiz();
        return quizList;
    }

}
