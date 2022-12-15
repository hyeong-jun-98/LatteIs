package com.academy.latteis.quiz.repository;

import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuizMapper {

    boolean write(Quiz quiz);

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.dto.ValidateDiaryUserDTO;
import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface QuizMapper {

    // 퀴즈 리스트
    List <Quiz> findAll(DiaryPage diaryPage);

    // 퀴즈 총 개수
    int getTotalCount();

    // 퀴즈 하나
    Quiz findOne(Long quizNo);

}
