package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.service.BoardService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import com.academy.latteis.common.search.Search;
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
@RequestMapping(value = {"/freeboard", "/generation"})
public class BoardController {

    private final BoardService boardService;

    // 게시글 목록 요청
    @GetMapping("/list")
    public String list(Search search, Model model, @ModelAttribute("msg") String msg,
                       HttpServletRequest request, Long generation, HttpSession session) {

        String uri = request.getRequestURI();
        log.info("controller request {} GET! - page: {}", uri, search);

        Map<String, Object> boardMap;
        String toGeneration = null;

        if (uri.equals("/freeboard/list")) {     // 자유게시판 목록 요청이면
            boardMap = boardService.findAllFreeService(search);
            //탑바 고정 세션
            session.setAttribute("topbar", "free");
        } else {    // 연령대별 게시판 목록 요청이면
            boardMap = boardService.findAllGenerationService(search, generation);
            // 세션 정보 생성
            session.setAttribute("sessionGeneration", generation);     // 게시판의 generation 정보를 세션에 담아둠
            log.info("리스트 세션 정보는 {}", session.getAttribute("sessionGeneration"));

            //탑바 고정 세션
            session.setAttribute("topbar", "generation");

            if (generation == 9999) {   // 전체 연령대 게시판
                toGeneration = "generationboard/generation-list";
            } else if (generation == 2000) {    // 2000년대 게시판 요청일 때
                toGeneration = "generationboard/00-list";
            } else if (generation == 1990) {      // 1990년대 게시판 요청일 때
                toGeneration = "generationboard/90-list";
            } else if (generation == 1980) {      // 1980년대 게시판 요청일 때
                toGeneration = "generationboard/80-list";
            } else if (generation == 1970) {       // 1970년대 게시판 요청일 때
                toGeneration = "generationboard/70-list";
            }
        }

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(new Page(search.getPageNum(), search.getAmount()), (Integer) boardMap.get("totalCount"));

        model.addAttribute("boardList", boardMap.get("boardList"));
        model.addAttribute("pm", pm);
        model.addAttribute("search", search);

        return uri.equals("/freeboard/list") ? "freeboard/freeboard-list" : toGeneration;
    }

    // 게시글 상세보기
    @GetMapping("/detail/{boardNo}")
    public String getDetail(@PathVariable Long boardNo, Model model, Page page,
                            HttpServletResponse response, HttpServletRequest request, @ModelAttribute("msg") String msg) {

        log.info("controller request {} GET! - {}", request.getRequestURI(), boardNo);
        List<BoardGoodDTO> boardList = boardService.findOneService(boardNo, response, request);
        BoardGoodDTO board = boardList.get(0);  // boardList에서 아무거나 하나 뽑음

        model.addAttribute("boardList", boardList);
        model.addAttribute("board", board);
        model.addAttribute("page", page);

        return request.getRequestURI().equals("/freeboard/detail/" + boardNo) ? "freeboard/freeboard-detail" : "generationboard/generation-detail";
    }

    // 게시글 작성 화면
    @GetMapping("/write")
    public String write(HttpServletRequest request) {
        String uri = request.getRequestURI();
        log.info("controller request {} GET!", uri);

        return uri.equals("/freeboard/write") ? "freeboard/freeboard-write" : "generationboard/generation-write";
    }

    // 게시글 작성 요청 처리
    @PostMapping("/write")
    public String write(Board board, RedirectAttributes ra, HttpServletRequest request) {
        String uri = request.getRequestURI();   // 요청 uri
        log.info("controller request {} POST! - board={}", uri, board);

        boolean flag;
        HttpSession session = request.getSession();
        log.info("세션에 담긴 연령대 정보는 {}", session.getAttribute("sessionGeneration"));

        if (uri.equals("/generation/write")) {     // 연령대별 게시판 게시글 작성 요청이면 if문 안에 실행
            flag = boardService.writeGenerationService(board);
            if (flag) ra.addFlashAttribute("msg", "write-success");
            return flag ? "redirect:/generation/list?generation=" + session.getAttribute("sessionGeneration")
                    : "redirect:/generation/list?generation=" + session.getAttribute("sessionGeneration");
        }

        // 자유게시판 게시글 작성이면
        flag = boardService.writeFreeService(board);
        if (flag) ra.addFlashAttribute("msg", "write-success");
        return flag ? "redirect:/freeboard/list" : "redirect:/list";
    }

    // 게시글 삭제 확인 요청
    @GetMapping("/delete")
    public String remove(Long boardNo, Model model, @ModelAttribute("page") Page page, HttpServletRequest request) {
        log.info("controller request {} GET! - boardNo={}, generation={}", request.getRequestURI(), boardNo);

        model.addAttribute("boardNo", boardNo);
        model.addAttribute("validate", boardService.getUser(boardNo));

        return request.getRequestURI().equals("/freeboard/delete") ? "freeboard/process-delete" : "generationboard/process-delete";
    }

    // 게시글 삭제 확정 요청
    @PostMapping("/delete")
    public String remove(Long boardNo, RedirectAttributes ra, @ModelAttribute("page") Page page, HttpServletRequest request) {
        String uri = request.getRequestURI();
        log.info("controller request {} POST! - {}", uri);

        boolean flag = boardService.removeService(boardNo);
        if (flag) ra.addFlashAttribute("msg", "delete-success");

        HttpSession session = request.getSession();
        if (uri.equals("/generation/delete")) {
            return flag ? "redirect:/generation/list?generation=" + session.getAttribute("sessionGeneration")
                    : "redirect:/generation/list?generation=" + session.getAttribute("sessionGeneration");
        }
        return flag ? "redirect:/freeboard/list" : "redirect:/freeboard/list";
    }

    // 게시글 수정 화면 요청
    @GetMapping("/edit")
    public String edit(Long boardNo, Model model, Page page, HttpServletResponse response, HttpServletRequest request) {
        log.info("controller request {} GET! -  boardNo={}", request.getRequestURI(), boardNo);

        List<BoardGoodDTO> boardList = boardService.findOneService(boardNo, response, request);
        BoardGoodDTO boardGoodDTO = boardList.get(0);

        model.addAttribute("board", boardGoodDTO);
        model.addAttribute("boardNo", boardNo);
        model.addAttribute("page", page);
        model.addAttribute("validate", boardService.getUser(boardNo));

        return request.getRequestURI().equals("/freeboard/edit") ? "freeboard/freeboard-edit" : "generationboard/generation-edit";
    }

    // 게시글 수정 요청
    @PostMapping("/edit")
    public String edit(Board board, Page page, HttpServletRequest request) {
        String uri = request.getRequestURI();
        log.info("controller request {} POST!!", uri);

        HttpSession session = request.getSession();
        boolean flag = boardService.editService(board);
        if (uri.equals("/generation/edit")) {
            return flag ? "redirect:/generation/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount()
                    : "redirect:/generation/list";
        }
        return flag ? "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount()
                : "redirect:/freeboard/list";
    }
}