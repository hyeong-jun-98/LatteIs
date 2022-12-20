package com.academy.latteis.quizgood.api;

import com.academy.latteis.boardgood.domain.BoardGood;
import com.academy.latteis.quizgood.domain.QuizGood;
import com.academy.latteis.quizgood.service.QuizGoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

@RestController
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/api/v1/quiz-good")
public class QuizGoodApiController {

    private final QuizGoodService quizGoodService;

    // 좋아요 체크 요청 처리
    @PostMapping("")
    public String goodCheck(@RequestBody QuizGood quizGood) {
        log.info("/api/v1/quiz-good POST!! - {}", quizGood);

        boolean flag = quizGoodService.checkService(quizGood);

        return flag ? "check-success" : "check-fail";
    }

    // 좋아요 요청 처리
    @DeleteMapping("")
    public String goodUnCheck(@RequestBody QuizGood quizGood) {
        log.info("/api/v1/quiz-good DELETE! - {}", quizGood);

        boolean flag = quizGoodService.unCheckService(quizGood);

        return flag ? "uncheck-success" : "uncheck-fail";
    }

    // 좋아요 수 가져오기
    @GetMapping("")
    public int getGoodCount(Long quizNo) {
        log.info("/api/v1/quiz-good GET! - {}", quizNo);

        int cnt = quizGoodService.goodCntService(quizNo);
        log.info("좋아요 수 - {}", cnt);

        return cnt;
    }

    @GetMapping("/check")
    public boolean goodOrNot(Long quizNo, Long userNo) {
        log.info("/api/v1/quiz-good/check GET! - quizNo={}, userNo={}", quizNo, userNo);
        return quizGoodService.goodOrNotService(quizNo, userNo);
    }


}
