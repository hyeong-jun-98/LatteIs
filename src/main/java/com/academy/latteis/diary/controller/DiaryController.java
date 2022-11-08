package com.academy.latteis.diary.controller;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@Log4j2
@RequiredArgsConstructor
public class DiaryController {

    private final DiaryService diaryService;

    // 일기장 리스트 화면
    @GetMapping("/diary/list")
    public String DiaryList() {


        return "diary/diary_list";
    }

    // 일기 작성 화면 요청
    @GetMapping("/diary/write")
    public String DiaryWrite(HttpSession session, RedirectAttributes ra) {


        return "diary/diary_write";
    }

    // 일기 작성 화면
    @PostMapping("/diary/write")
    public String DiaryWrite(Diary diary, RedirectAttributes ra, HttpSession session) {

        log.info("/write POST - param: {}", diary);

       boolean flag = diaryService.saveService(diary);

        return flag ? "redirect:/diary/list" : "redirect:/";
    }





}
