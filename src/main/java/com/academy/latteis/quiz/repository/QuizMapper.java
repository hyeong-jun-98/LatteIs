package com.academy.latteis.quiz.repository;

import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuizMapper {

    boolean write(Quiz quiz);
    List<Quiz> findAllQuiz();
}
