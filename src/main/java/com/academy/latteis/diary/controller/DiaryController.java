package com.academy.latteis.diary.controller;

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.common.page.DiaryPageMaker;
import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.domain.Good;
import com.academy.latteis.diary.dto.ValidateDiaryUserDTO;
import com.academy.latteis.diary.service.DiaryService;
import com.academy.latteis.user.domain.User;
import com.academy.latteis.util.LoginUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
//    @GetMapping("/list")
//    public String list(DiaryPage diaryPage, Model model, @ModelAttribute("msg") String msg) {
//        Map <String, Object> diaryMap = diaryService.findAllService(diaryPage);
//
//
//        DiaryPageMaker pm = new DiaryPageMaker(
//                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
//                , (Integer) diaryMap.get("tc"));
//
//        model.addAttribute("dList", diaryMap.get("dList"));
//        model.addAttribute("pm", pm);
//        model.addAttribute("diaryPage", "diaryPage");
//        return "diary/diary_list";
//    }

    // 일기 공개 목록 요청  [public]
    @GetMapping("/list")
        public String publicList(DiaryPage diaryPage, Model model, HttpSession session) {
        Map<String, Object> diaryPublicMap = diaryService.findPublicList(diaryPage);

        DiaryPageMaker pm = new DiaryPageMaker(
                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
                , (Integer) diaryPublicMap.get("tc"));

        model.addAttribute("dPList", diaryPublicMap.get("dPList"));
        model.addAttribute("pm", pm);
        session.setAttribute("topbar", "diary");
        return "diary/diary_list";
    }

    // 내가 쓴 일기 리스트 [My]
    @GetMapping("/myList")
    public String diaryMyList(HttpSession session, Model model, DiaryPage diaryPage) {

        User loginUser = (User) session.getAttribute("loginUser");
        String userNickname = loginUser.getUserNickname();

        log.info("로그인 정보 {}", loginUser);
        log.info("로그인 한 사람 닉네임 : {}", userNickname);

        Map<String, Object > diaryMyMap = diaryService.findMyListService(diaryPage, userNickname);

        DiaryPageMaker pm = new DiaryPageMaker(
                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
                , (Integer) diaryMyMap.get("tc"));

        model.addAttribute("dMList", diaryMyMap.get("dMList"));
        model.addAttribute("pm", pm);
        session.setAttribute("topbar", "page");
        return "diary/diary_list";
    }

    // 베스트 일기 리스트 [Best]
    @GetMapping("/bestList")
    public String diaryBestList(HttpSession session, DiaryPage diaryPage, Model model) {

//        User loginUser = (User) session.getAttribute("loginUser");
//        String userNickname = loginUser.getUserNickname();

        Map <String, Object> diaryBestMap = diaryService.findBestDiaryService(diaryPage);

        DiaryPageMaker pm = new DiaryPageMaker(
                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
                , (Integer) diaryBestMap.get("tc"));

        model.addAttribute("dBList", diaryBestMap.get("dBList"));
        model.addAttribute("pm", pm);
        session.setAttribute("topbar", "page");

        return "diary/diary_bestList";
    }







    // 일기 작성 화면 요청
    @GetMapping("/write")
    public String DiaryWrite(HttpSession session, Model model) {

        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("loginUser", loginUser);

        return "diary/diary_write";
    }

    // 일기 작성 화면
    @PostMapping("/write")
    public String DiaryWrite(Diary diary, HttpSession session) {

        log.info("/write POST - param: {}", diary);

        // 세션에 담아둔 로그인 정보 뽑기
        User loginUser = (User) session.getAttribute("loginUser");
        log.info("로그인 한 사람 닉네임 : {}", loginUser.getUserNickname());

        // 세션에서 닉네임 뽑기
        diary.setUserNickname(loginUser.getUserNickname());

       boolean flag = diaryService.saveService(diary);

        return flag ? "redirect:/diary/list" : "redirect:/";
    }

    // 일기 상세화면
    @GetMapping("/detail/{diaryNo}")
    public String content(@PathVariable Long diaryNo,DiaryPage diaryPage, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {

        log.info("/detail/{} GET!!", diaryNo);

        Diary diary = diaryService.findOneService(diaryNo,request, response);
        log.info("return data diary: {}", diary);

        User loginUser = (User) session.getAttribute("loginUser");
        log.info("로그인 유저 데이터 {}", loginUser);


        model.addAttribute("d", diary);
        model.addAttribute("diaryPage", diaryPage);
        model.addAttribute("user", loginUser);


        return "diary/diary_detail";
    }


    // 일기 삭제 확인
    @GetMapping("/delete")
    public String delete(@ModelAttribute("diaryPage") DiaryPage diaryPage, Long diaryNo, Model model, HttpSession session) {
        log.info("controller request {}", diaryNo);


        model.addAttribute("diaryNo", diaryNo);

        model.addAttribute("validate", diaryService.getUser(diaryNo));


        return  "diary/process-delete";
    }



    // 일기 삭제 확정
    @PostMapping("/delete")
    public String delete (Long diaryNo, RedirectAttributes ra, @ModelAttribute("diaryPage") DiaryPage diaryPage) {
        log.info("controller delete {}", diaryNo);

        return diaryService.removeService(diaryNo) ? "redirect:/diary/list" : "redirect:/";
    }


    // 수정 화면 요청
    @GetMapping("/modify")
    public String modify(Long diaryNo, Model model, HttpServletRequest request, HttpServletResponse response, DiaryPage diaryPage, HttpSession session) {
        log.info("controller diary/modify Get {}", diaryNo);
        Diary diary = diaryService.findOneService(diaryNo, request, response);

        log.info("find article {} ", diary);

        model.addAttribute("d", diary);
        model.addAttribute("diaryNo", diaryNo);
        model.addAttribute("diaryPage", diaryPage);
        model.addAttribute("validate", diaryService.getUser(diaryNo));
        log.info("validate {} ", diaryService.getUser(diaryNo));

        return "diary/diary-modify";
    }

    // 수정 처리 요청
    @PostMapping("/modify")
    public String modify(Diary diary) {
        log.info("controller request /diary/modify POST {}", diary);
         boolean flag = diaryService.modifyService(diary);
         return flag ? "redirect:/diary/detail/" + diary.getDiaryNo() : "redirect:/";

    }

    // 좋아요 하려고
    // redirect 할 때는 model이 리셋이되므로 RedirectAttribute로 넣어주어야 한다.
    @GetMapping("/goodCheck/{diaryNo}")
    public String goodCheck(HttpSession session, @PathVariable Long diaryNo, Model model, RedirectAttributes ra) {
        log.info("diaryGoodCheck controller {}", diaryNo);

        User loginUser = (User) session.getAttribute("loginUser");


        boolean goodCheck = diaryService.goodCheckService(diaryNo, (long) loginUser.getUserNo());
        ra.addFlashAttribute("goodCheck", goodCheck);
        log.info("좋아요 누를 때 {}, {}, {}", diaryNo, (long) loginUser.getUserNo(), goodCheck);

        model.addAttribute("loginUser", loginUser);

//        Good good = diaryService.findGoodCheckService(diaryNo, userNo);
//        log.info("좋아요 여부 뽑아오기 -컨트롤러 {},{}", diaryNo, userNo);
//
//        model.addAttribute("good", good);

        return "redirect:/diary/detail/" + diaryNo;
    }









}
