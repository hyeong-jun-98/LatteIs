package com.academy.latteis.quizgood.service;

import com.academy.latteis.quizgood.domain.QuizGood;
import com.academy.latteis.quizgood.repository.QuizGoodMapper;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Log4j2
public class QuizGoodService {

    private final QuizGoodMapper quizGoodMapper;

    // 좋아요 체크 처리
    public boolean checkService(QuizGood quizGood) {
        return quizGoodMapper.check(quizGood);
    }

    // 좋아요 취소 처리
    public boolean unCheckService(QuizGood quizGood) {
        return quizGoodMapper.unCheck(quizGood);
    }

    // 좋아요 수 가져오기
    public int goodCntService(Long quizNo) {
        return quizGoodMapper.goodCnt(quizNo);
    }

    // 로그인 계정의 좋아요 여부
    public boolean goodOrNotService(Long quizNo, Long userNo){
        log.info("start goodOrNotService - quizNo={}, userNo={}", quizNo, userNo);
        QuizGood quizGood = quizGoodMapper.goodOrNot(quizNo, userNo);
        log.info("좋아요 누른 사람은 {}", quizGood);

        boolean flag = false;

        if (quizGood != null){
            flag = true;
        }

        return flag;
    }

    public void exitUser(User user) {
        log.info("게시글 좋아요 {}", user);
        quizGoodMapper.exitUser(user.getUserNo());
    }

    public void exitUser2(User user) {
        quizGoodMapper.exitUser2(user.getUserNickname());
    }

}
