package com.academy.latteis.quiz.repository;

import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuizMapper {

    // 퀴즈 작성
    boolean write(Quiz quiz);

    // 퀴즈 리스트
    List <Quiz> findAll(DiaryPage diaryPage);

    // 퀴즈 총 개수
    int getTotalCount();

    // 퀴즈 삭제
    boolean delete(Long quizNo);

    // 조회수 처리
    void upHit(Long quizNo);

    // 좋아요 수

    // 퀴즈 하나
    Quiz findOne(Long quizNo);

    int answerCheck(String quizAnswer);

    void correctAnswer(int quizNo);

    void correctUser(String userNickname, int quizNo);

    // 퀴즈 출제자 등급 나타내기
    String findQuizWriterGrade (String quizWriter);

    // 게시물 번호로 게시글 작성자의 계정명과 권한 가져오기
    ValidateUserDTO findUserByQuizNo(Long quizNo);

}
