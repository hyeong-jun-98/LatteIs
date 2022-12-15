package com.academy.latteis.quiz.repository;

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuizMapper {

    boolean write(Quiz quiz);

    // 퀴즈 리스트
    List <Quiz> findAll(DiaryPage diaryPage);

    // 퀴즈 총 개수
    int getTotalCount();

    // 퀴즈 하나
    Quiz findOne(Long quizNo);

}
