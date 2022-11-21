package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.service.FreeBoardService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import com.academy.latteis.common.search.Search;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
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
@RequiredArgsConstructor
@RequestMapping("/freeboard")
public class FreeBoardController {

    private final FreeBoardService freeBoardService;

    // 게시글 목록 요청
    @GetMapping("/list")
    public String list(Search search, Model model, @ModelAttribute("msg") String msg, HttpSession session) {
        log.info("controller request /freeboard/list GET! - page: {}", search);

        Map<String, Object> boardMap = freeBoardService.findAllService(search);
        log.info("return data - {}", boardMap);

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(new Page(search.getPageNum(), search.getAmount()), (Integer) boardMap.get("totalCount"));

        model.addAttribute("boardList", boardMap.get("boardList"));
        model.addAttribute("pm", pm);
        model.addAttribute("search", search);
        session.setAttribute("topbar", "free");

        return "freeboard/freeboard-list";
    }

    @GetMapping("/detail/{boardNo}")
    public String getDetail(@PathVariable Long boardNo, Model model, Page page,
                            HttpServletResponse response, HttpServletRequest request,
                            HttpSession session, @ModelAttribute("msg") String msg
    ) {
        log.info("controller request /freeboard/detail GET! - {}", boardNo);
        List<BoardGoodDTO> boardList = freeBoardService.findOneService(boardNo, response, request);
        BoardGoodDTO board = boardList.get(0);
        log.info("return data - {}", board);
        log.info("boardList는 - {}", boardList);

        User loginUser = (User) session.getAttribute("loginUser");
        log.info("로그인 유저 데이터 - {}", loginUser);

        model.addAttribute("boardList", boardList);
        model.addAttribute("board", board);
        model.addAttribute("page", page);
        model.addAttribute("user", loginUser);
        return "freeboard/freeboard-detail";
    }

    // 게시글 작성 화면
    @GetMapping("/write")
    public String write(Model model, HttpSession session) {
        log.info("controller request /freeboard/write GET!");

        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("user", loginUser);

        return "freeboard/freeboard-write";
    }

    // 게시글 작성 요청 처리
    @PostMapping("/write")
    public String write(Board board, RedirectAttributes ra, HttpSession session) {
        log.info("controller request /freeboard/write POST!");

        // 세션에 담아둔 로그인 정보 뽑기
        User loginUser = (User) session.getAttribute("loginUser");
        log.info("로그인 한 사람의 닉네임은 - {}", loginUser.getUserNickname());

        // 세션에서 뽑은 닉네임 넣기
        board.setUserNickname(loginUser.getUserNickname());

        boolean flag = freeBoardService.writeService(board);
        if (flag) ra.addFlashAttribute("msg", "write-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/list";
    }

    // 게시글 삭제 확인 요청
    @GetMapping("/delete")
    public String remove(Long boardNo, Model model, @ModelAttribute("page") Page page) {
        log.info("controller request /freeboard/delete GET! - {}", boardNo);

        model.addAttribute("boardNo", boardNo);
        model.addAttribute("validate", freeBoardService.getUser(boardNo));

        return "freeboard/process-delete";
    }

    // 게시글 삭제 확정 요청
    @PostMapping("/delete")
    public String delete(Long boardNo, RedirectAttributes ra, @ModelAttribute("page") Page page) {
        log.info("controller request /freeboard/delete POST! - {}", boardNo);

        boolean flag = freeBoardService.removeService(boardNo);

        if (flag) ra.addFlashAttribute("msg", "delete-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/freeboard/list";
    }

    // 게시글 수정 화면 요청
    @GetMapping("/edit")
    public String edit(Long boardNo, Model model, Page page
            , HttpServletResponse response, HttpServletRequest request) {
        log.info("controller request /freeboard/edit GET! - {}", boardNo);
        List<BoardGoodDTO> boardList = freeBoardService.findOneService(boardNo, response, request);

        BoardGoodDTO board = boardList.get(0);

        model.addAttribute("board", board);
        model.addAttribute("boardNo", board.getBoardNo());
        model.addAttribute("page", page);
        model.addAttribute("validate", freeBoardService.getUser(boardNo));
        return "/freeboard/freeboard-edit";
    }

    // 게시글 수정 요청
    @PostMapping("/edit")
    public String edit(Board board, Page page) {
        log.info("controller request /freeboard/edit POST!!");
        boolean flag = freeBoardService.editService(board);
        return flag ? "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount()
                : "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount();
    }

}