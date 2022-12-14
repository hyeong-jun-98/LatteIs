package com.academy.latteis.comment.repository;

import com.academy.latteis.comment.domain.Comment;
import com.academy.latteis.common.page.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentMapper {

    // 댓글 입력
    boolean write(Comment comment);

    // 댓글 목록 조회
    List<Comment> findAll(@Param("boardNo") Long boardNo,
                          @Param("page") Page page);

    // 댓글 삭제
    boolean remove(Long commentNo);

    // 댓글 전체 삭제
    boolean removeByBoardNo(Long boardNo);

    // 댓글 수정
    boolean edit(Comment comment);

    // 댓글 수
    int getCommentCount(Long boardNo);

    void exitUser(String userNickname);

    void exitUser2(String userNickname);

    void reviseUser(String beforeUserNickname, String afterUserNickname);
}
