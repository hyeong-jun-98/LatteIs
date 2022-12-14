package com.academy.latteis.boardgood.repository;

import com.academy.latteis.boardgood.domain.BoardGood;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardGoodMapper {

    // 좋아요
    boolean check(BoardGood boardGood);
    // 좋아요 취소
    boolean unCheck(BoardGood boardGood);

    // 좋아요 전체 삭제
    boolean removeByBoardNo(Long boardNo);

    // 좋아요 수
    int goodCnt(Long boardNo);

    void exitUser(int userNo);

    void exitUser2(String userNickname);
}
