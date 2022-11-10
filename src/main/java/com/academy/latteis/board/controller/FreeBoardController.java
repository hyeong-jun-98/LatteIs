package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.service.FreeBoardService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import com.academy.latteis.common.search.Search;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/freeboard")
public class FreeBoardController {

    private final FreeBoardService freeBoardService;

    // 게시글 목록 요청
    @GetMapping("/list")
    public String list(Search search, Model model) {
        log.info("controller request /freeboard/list GET! - page: {}", search);

        Map<String, Object> boardMap = freeBoardService.findAllService(search);
        log.debug("return data - {}", boardMap);

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(new Page(search.getPageNum(), search.getAmount()), (Integer) boardMap.get("totalCount"));

        model.addAttribute("boardList", boardMap.get("boardList"));
        model.addAttribute("pm", pm);
        model.addAttribute("search", search);

        return "freeboard/freeboard-list";
    }

    @GetMapping("/detail/{boardNo}")
    public String getDetail(@PathVariable Long boardNo, Model model, Page page,
                            HttpServletResponse response, HttpServletRequest request) {
        log.info("controller request /freeboard/detail GET! - {}", boardNo);
        Board board = freeBoardService.findOneService(boardNo, response, request);
        log.info("return data - {}", board);
        model.addAttribute("board", board);
        model.addAttribute("page", page);
        return "freeboard/freeboard-detail";
    }

    // 게시글 작성 화면
    @GetMapping("/write")
    public String write() {
        log.info("controller request /freeboard/write GET!");
        return "freeboard/freeboard-write";
    }

    // 게시글 작성 요청 처리
    @PostMapping("/write")
    public String write(Board board, RedirectAttributes ra) {
        log.info("controller request /freeboard/write POST!");

        boolean flag = freeBoardService.writeService(board);

        if (flag) ra.addFlashAttribute("msg", "write-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/list";
    }

    // 게시글 삭제
    @GetMapping("/delete")
    public String remove(Long boardNo, RedirectAttributes ra) {
        log.info("controller request /freeboard/delete GET! - {}", boardNo);

        boolean flag = freeBoardService.removeService(boardNo);
        if (flag) ra.addFlashAttribute("msg", "delete-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/freeboard/list";
    }

    // 게시글 수정 화면 요청
    @GetMapping("/edit/{boardNo}")
    public String edit(@PathVariable Long boardNo, Model model, Page page) {
        log.info("controller request /freeboard/edit GET! - {}", boardNo);
//        Board board = boardService.findOneService(boardNo);
//        model.addAttribute("board", board);
//        model.addAttribute("page", page);
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
