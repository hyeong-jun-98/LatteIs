package com.academy.latteis.good.service;

import com.academy.latteis.good.domain.BoardGood;
import com.academy.latteis.good.repository.GoodMapper;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Log4j2
public class GoodService {

    private final GoodMapper goodMapper;

    // 좋아요 체크 처리
    public boolean checkService(BoardGood boardGood){
        return goodMapper.check(boardGood);
    }

    // 좋아요 취소 처리
    public boolean unCheckService(BoardGood boardGood){
        return goodMapper.unCheck(boardGood);
    }

    // 좋아요 수 가져오기
    public int goodCntService(Long boardNo){
        return goodMapper.goodCnt(boardNo);
    }

    public void exitUser(User user){
        log.info("게시글 좋아요 {}",user);
        goodMapper.exitUser(user.getUserNo());
    }
}
