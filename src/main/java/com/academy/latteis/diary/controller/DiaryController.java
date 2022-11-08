package com.academy.latteis.diary.controller;

import com.academy.latteis.diary.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@Log4j2
@RequiredArgsConstructor

public class DiaryController {

    private final DiaryService diaryService;

    // 게시물 쓰기 화면 요청
    @GetMapping("/diary/write")
    public String DiaryWrite() {


        return "diary/diary_write";
    }





}
