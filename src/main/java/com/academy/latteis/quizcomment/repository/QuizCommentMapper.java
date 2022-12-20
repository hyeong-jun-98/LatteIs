package com.academy.latteis.quizcomment.repository;

import com.academy.latteis.common.page.Page;
import com.academy.latteis.quizcomment.domain.QuizComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface QuizCommentMapper {
    // 댓글 입력
    boolean write(QuizComment quizComment);

    // 댓글 목록 조회
    List<QuizComment> findAll(@Param("quizNo") Long quizNo,
                              @Param("page") Page page);

    // 댓글 삭제
    boolean remove(Long quizCommentNo);

    // 댓글 전체 삭제
    boolean removeByQuizNo(Long quizNo);

    // 댓글 수정
    boolean edit(QuizComment quizComment);

    // 댓글 수
    int getQuizCommentCount(Long quizNo);

    void exitUser(String userNickname);

    void reviseUser(String beforeUserNickname, String afterUserNickname);
}
