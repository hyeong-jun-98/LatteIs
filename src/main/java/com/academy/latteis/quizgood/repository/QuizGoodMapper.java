package com.academy.latteis.quizgood.repository;

import com.academy.latteis.quizgood.domain.QuizGood;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QuizGoodMapper {
    // 좋아요
    boolean check(QuizGood quizGood);
    // 좋아요 취소
    boolean unCheck(QuizGood quizGood);

    // 좋아요 전체 삭제
    boolean removeByQuizNo(Long quizNo);

    // 좋아요 수
    int goodCnt(Long quizNo);

    // 로그인 계정의 좋아요 여부
    QuizGood goodOrNot(Long quizNo, Long userNo);

    void exitUser(int userNo);

    void exitUser2(String userNickname);
}
