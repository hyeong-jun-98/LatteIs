package com.academy.latteis.quiz.controller;

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.common.page.DiaryPageMaker;
import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.service.QuizService;
import com.academy.latteis.quizgood.service.QuizGoodService;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@Log4j2
@RequestMapping("/quiz")
@RequiredArgsConstructor
public class QuizController {

    private final QuizService quizService;
    private final QuizGoodService quizGoodService;

    // 작성화면 요청
    @GetMapping("/write")
    public String quizWrite() {
        log.info("controller /quiz/write GET");
        return "quiz/quiz-write";
    }

    // 퀴즈 작성 처리
    @PostMapping("/write")
    public String quizWrite(Quiz quiz) {
        boolean flag = quizService.writeService(quiz);
        return flag ? "redirect:/quiz/list" : "redirect:/quiz/list";
    }


    @GetMapping("/list")
    public String quizList(DiaryPage diaryPage, Model model, HttpSession session) {
        Map<String, Object> quizMap = quizService.findAllService(diaryPage);

        // 페이지 정보 생성
        DiaryPageMaker pm = new DiaryPageMaker(
                new DiaryPage(diaryPage.getPageNum(), diaryPage.getAmount())
                , (Integer) quizMap.get("tc"));




        // boardMap에서 boardList 꺼내기
        List<Quiz> quizList = (List<Quiz>) quizMap.get("quizList");





        // 반복문 돌려서 boardList 안에 있는 게시글에 각각 좋아요 정보를 넣어줌
        // 유저 정보의 등급을 작성자의 닉네임과 비교해서 넣어줌
        for (Quiz q : quizList) {
            q.setQuizGood((long) quizGoodService.goodCntService(q.getQuizNo()));
            q.setUserGrade(quizService.findQuizWriterGradeService(q.getQuizWriter()));
        }



//        model.addAttribute("userGrade", userGrade);
        model.addAttribute("quizList", quizList);
        model.addAttribute("pm", pm);
        session.setAttribute("topbar", "quiz");
        return "quiz/quiz_list";
    }

    @GetMapping("/detail/{quizNo}")
    public String quizDetail(@PathVariable Long quizNo, DiaryPage diaryPage, Model model
            , HttpServletResponse response, HttpServletRequest request, HttpSession session) {

        log.info(" quizDetailController quizNo {}", quizNo);

        Quiz quiz = quizService.findOneService(quizNo, response, request);

        model.addAttribute("q", quiz);
        model.addAttribute("diaryPage", diaryPage);
        model.addAttribute("user", (User)session.getAttribute("loginUser"));

        return "quiz/quiz_detail";
    }

    // 퀴즈 삭제 확인 요청
    @GetMapping("/delete")
    public String delete(Long quizNo, Model model, @ModelAttribute("diaryPage") DiaryPage diaryPage, HttpServletRequest request) {
        log.info("controller request {} GET! - quizNo={}", request.getRequestURI(), quizNo);
        model.addAttribute("quizNo", quizNo);
        model.addAttribute("validate", quizService.getUser(quizNo));

        return "quiz/process-delete";
    }

    // 퀴즈 삭제 확정 요청
    @PostMapping("/delete")
    public String delete(Long quizNo, RedirectAttributes ra, @ModelAttribute("diaryPage") DiaryPage diaryPage, HttpServletRequest request) {
        String uri = request.getRequestURI();
        log.info("controller request {} POST! - {}", uri);

        boolean flag = quizService.deleteService(quizNo);
        if (flag) ra.addFlashAttribute("msg", "delete-success");

        return "redirect:/quiz/list";
    }

    @GetMapping("/check")
    @ResponseBody
    public ResponseEntity<Quiz> check(String quizAnswer, int quizNo, HttpSession session) {
        log.info("quiz controller /quiz/check GET! - quizAnswer={}, qno={}", quizAnswer, quizNo);
        User user = (User) session.getAttribute("loginUser");
        Quiz quiz = quizService.answerCheck(quizAnswer, quizNo, user.getUserNickname());
        log.info("퀴즈는 {}", quiz);
        return new ResponseEntity<>(quiz, HttpStatus.OK);
    }





}






