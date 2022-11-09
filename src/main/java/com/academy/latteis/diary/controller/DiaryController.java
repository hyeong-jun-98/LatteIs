package com.academy.latteis.diary.controller;

import com.academy.latteis.common.Page;
import com.academy.latteis.common.PageMaker;
import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/diary")
public class DiaryController {

    private final DiaryService diaryService;

//    // 일기장 목록 화면
//    @GetMapping("/list")
//    public String DiaryList(Model model) {
////       List<Diary> diaryList = diaryService.findAllService();
//
////        model.addAttribute("dList", diaryList);
//
//        return "diary/diary_list";
//    }

    // 일기 목록 요청
    @GetMapping("/list")
    public String list(Page page, Model model) {
        Map <String, Object> diaryMap = diaryService.findAllService(page);
        PageMaker pm = new PageMaker(
                new Page(page.getPageNum(), page.getAmount())
                , (Integer) diaryMap.get("tc"));

        model.addAttribute("dList", diaryMap.get("dList"));
        model.addAttribute("pm", pm);

        return "diary/diary_list";
    }

    // 일기 작성 화면 요청
    @GetMapping("/write")
    public String DiaryWrite(HttpSession session, RedirectAttributes ra) {


        return "diary/diary_write";
    }

    // 일기 작성 화면
    @PostMapping("/write")
    public String DiaryWrite(Diary diary, RedirectAttributes ra, HttpSession session) {

        log.info("/write POST - param: {}", diary);

       boolean flag = diaryService.saveService(diary);

        return flag ? "redirect:/diary/list" : "redirect:/";
    }

    // 일기 상세화면
    @GetMapping("/detail/{diaryNo}")
    public String content(@PathVariable Long diaryNo, Model model) {

        log.info("/detail/{} GET!!", diaryNo);

        Diary diary = diaryService.findOneService(diaryNo);

        log.info("return data diary: {}", diary);
        model.addAttribute("d", diary);

        return "diary/diary_detail";
    }
    // 일기 삭제 확인
    @GetMapping("delete")
    public String delete(@ModelAttribute("diaryNo") Long diaryNo, Model model) {
        log.info("controller request {}", diaryNo);


        return  "diary/process-delete";
    }



    // 일기 삭제 확정
    @PostMapping("/delete")
    public String delete (Long diaryNo) {
        log.info("controller delete {}", diaryNo);

        return diaryService.removeService(diaryNo) ? "redirect:/diary/list" : "redirect:/";
    }







}
