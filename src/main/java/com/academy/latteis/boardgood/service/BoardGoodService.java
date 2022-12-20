package com.academy.latteis.boardgood.service;

import com.academy.latteis.boardgood.domain.BoardGood;
import com.academy.latteis.boardgood.repository.BoardGoodMapper;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Log4j2
public class BoardGoodService {

    private final BoardGoodMapper boardGoodMapper;

    // 좋아요 체크 처리
    public boolean checkService(BoardGood boardGood){
        return boardGoodMapper.check(boardGood);
    }

    // 좋아요 취소 처리
    public boolean unCheckService(BoardGood boardGood){
        return boardGoodMapper.unCheck(boardGood);
    }

    // 좋아요 수 가져오기
    public int goodCntService(Long boardNo){
        return boardGoodMapper.goodCnt(boardNo);
    }

    public void exitUser(User user){
        log.info("게시글 좋아요 {}",user);
        boardGoodMapper.exitUser(user.getUserNo());
    }

    public void exitUser2(User user){
        boardGoodMapper.exitUser2(user.getUserNickname());
    }
}
