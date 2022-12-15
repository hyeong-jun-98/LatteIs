package com.academy.latteis.quiz.repository;

import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuizMapper {

    boolean write(Quiz quiz);

}
