package com.academy.latteis.good.api;

import com.academy.latteis.good.domain.BoardGood;
import com.academy.latteis.good.service.GoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/api/v1/good")
@CrossOrigin    // CORS를 적용하는 어노테이션
public class GoodApiController {

    private final GoodService goodService;

    // 좋아요 체크 요청 처리
    @PostMapping("")
    public String goodCheck(@RequestBody BoardGood boardGood) {
        log.info("/api/v1/good POST!! - {}", boardGood);

        boolean flag = goodService.checkService(boardGood);

        return flag ? "check-success" : "check-fail";
    }

    // 좋아요 요청 처리
    @DeleteMapping("")
    public String goodUnCheck(@RequestBody BoardGood boardGood) {
        log.info("/api/v1/good DELETE! - {}", boardGood);

        boolean flag = goodService.unCheckService(boardGood);

        return flag ? "uncheck-success" : "uncheck-fail";
    }

    // 좋아요 수 가져오기
    @GetMapping("")
    public int getGoodCount(Long boardNo) {
        log.info("/api/v1/good GET! - {}", boardNo);

        int cnt = goodService.goodCntService(boardNo);
        log.info("좋아요 수 - {}", cnt);

        return cnt;
    }

}
