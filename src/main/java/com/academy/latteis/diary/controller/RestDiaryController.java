package com.academy.latteis.diary.controller;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.service.DiaryService;
import com.academy.latteis.user.domain.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/api/v1/diaryGood")
public class RestDiaryController {

    private final DiaryService diaryService;

    // 좋아요 하려고
    // redirect 할 때는 model이 리셋이되므로 RedirectAttribute로 넣어주어야 한다.
    @GetMapping("/{diaryNo}")
    @ResponseBody
    public ResponseEntity<?> goodCheck(HttpSession session, @PathVariable Long diaryNo, Model model, RedirectAttributes ra, HttpServletRequest request, HttpServletResponse response) {
        log.info("diaryGoodCheck RestController {}", diaryNo);

        User loginUser = (User) session.getAttribute("loginUser");

        Diary diary = diaryService.findOneService(diaryNo, request, response);

        log.info("diaryGood {}", diary.getDiaryGood());
        boolean goodCheck = diaryService.goodCheckService(diaryNo, (long) loginUser.getUserNo());
        ra.addFlashAttribute("goodCheck", goodCheck);

        log.info("좋아요 누를 때 {}, {}, {}", diaryNo, (long) loginUser.getUserNo(), goodCheck);

        int totalGoodCount = diaryService.findGoodCountService(diaryNo);
        log.info("findGoodCount RestController {}", totalGoodCount);

//        model.addAttribute("goodCount", totalGoodCount);
        model.addAttribute("d", diary);
        model.addAttribute("user", loginUser);

        return new ResponseEntity<>(new GoodResponseDto(goodCheck, totalGoodCount), HttpStatus.OK);
    }

    @Setter@Getter
    @AllArgsConstructor
    public static class GoodResponseDto {
        private boolean goodCheck;
        private int totalGoodCount;
    }

}
