package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.service.BoardService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import com.academy.latteis.common.search.Search;
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
@RequiredArgsConstructor
@RequestMapping(value = {"/freeboard", "/generation", "/keyword"})
public class BoardController {

    private final BoardService boardService;

    // 게시글 목록 요청
    @GetMapping("/list")
    public String list(Search search, Model model, @ModelAttribute("msg") String msg,
                       HttpServletRequest request, Long generation, HttpSession session) {

        String uri = request.getRequestURI();
        log.info("controller request {} GET! - page: {}", uri, search);

        Map<String, Object> boardMap;
        String where = null;

        if (uri.equals("/freeboard/list")) {     // 자유게시판 목록 요청이면
            boardMap = boardService.findAllFreeService(search);
            //탑바 고정 세션
            session.setAttribute("topbar", "free");
            where = "freeboard/freeboard-list";
        } else if(uri.equals("/generation/list")){    // 연령대별 게시판 목록 요청이면
            boardMap = boardService.findAllGenerationService(search, generation);
            // 세션 정보 생성
            session.setAttribute("sessionGeneration", generation);     // 게시판의 generation 정보를 세션에 담아둠
            log.info("리스트 세션 정보는 {}", session.getAttribute("sessionGeneration"));

            //탑바 고정 세션
            session.setAttribute("topbar", "generation");

            if (generation == 9999) {   // 전체 연령대 게시판
                where = "generationboard/generation-list";
            } else if (generation == 2000) {    // 2000년대 게시판 요청일 때
                where = "generationboard/00-list";
            } else if (generation == 1990) {      // 1990년대 게시판 요청일 때
                where = "generationboard/90-list";
            } else if (generation == 1980) {      // 1980년대 게시판 요청일 때
                where = "generationboard/80-list";
            } else if (generation == 1970) {       // 1970년대 게시판 요청일 때
                where = "generationboard/70-list";
            }
        } else{
            long topicNo =1;
            boardMap = boardService.findAllKeywordService(search, topicNo);
            session.setAttribute("topbar", "keyword");
            where = "keywordboard/keyword-list";
            session.setAttribute("keyword", "1");
        }

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(new Page(search.getPageNum(), search.getAmount()), (Integer) boardMap.get("totalCount"));

        model.addAttribute("boardList", boardMap.get("boardList"));
        model.addAttribute("pm", pm);
        model.addAttribute("search", search);

//        model.addAttribute("generation", generation);
//        model.addAttribute("page", "free");
        return where;
    }

    // 게시글 상세보기
    @GetMapping("/detail/{boardNo}")
    public String getDetail(@PathVariable Long boardNo, Model model, Page page,
                            HttpServletResponse response, HttpServletRequest request, @ModelAttribute("msg") String msg) {
        String url = request.getRequestURI();
        String where = null;
        log.info("controller request {} GET! - {}", request.getRequestURI(), boardNo);
        List<BoardGoodDTO> boardList = boardService.findOneService(boardNo, response, request);
        BoardGoodDTO board = boardList.get(0);  // boardList에서 아무거나 하나 뽑음

        model.addAttribute("boardList", boardList);
        model.addAttribute("board", board);
        model.addAttribute("page", page);

        if(url.equals("/freeboard/detail/" + boardNo)){
            where = "freeboard/freeboard-detail";
        } else if (url.equals("/generation/detail/" + boardNo)) {
            where = "generationboard/generation-detail";
        }else{
            where = "keywordboard/keyword-detail";
        }
        return where;
    }

    // 게시글 작성 화면
    @GetMapping("/write")
    public String write(HttpServletRequest request) {
        String uri = request.getRequestURI();
        log.info("controller request {} GET!", uri);
        String where=null;
        if(uri.equals("/freeboard/write")){
            where = "freeboard/freeboard-write";
        } else if(uri.equals("/generation/write")){
            where = "generationboard/generation-write";
        } else{
            where = "keywordboard/keyword-write";
        }
        return where;
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
        //키워드 글 작성
        if (uri.equals("/keyword/write")){
            log.info(request.getSession().getAttribute("keyword"));
            board.setTopicNo(Long.parseLong((String) request.getSession().getAttribute("keyword")));
            flag = boardService.writeKeywordService(board);
            if (flag) ra.addFlashAttribute("msg", "write-success");
            return flag ? "redirect:/keyword/list" : "redirect:/list";
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
        String uri = request.getRequestURI();
        model.addAttribute("boardNo", boardNo);
        model.addAttribute("validate", boardService.getUser(boardNo));
        String where=  null;
        if(uri.equals("/freeboard/delete")){
            where = "freeboard/process-delete";
        }else if(uri.equals("/generation/delete")){
            where = "generationboard/process-delete";
        }else{
            where = "keywordboard/process-delete";
        }

        return where;
    }

    // 게시글 삭제 확정 요청
    @PostMapping("/delete")
    public String remove(Long boardNo, RedirectAttributes ra, @ModelAttribute("page") Page page, HttpServletRequest request) {
        String uri = request.getRequestURI();
        String where = null;
        log.info("controller request {} POST! - {}", uri);

        boolean flag = boardService.removeService(boardNo);
        if (flag) ra.addFlashAttribute("msg", "delete-success");

        HttpSession session = request.getSession();
        if(uri.equals("/freeboard/delete")){
            where = "redirect:/freeboard/list";
        }else if(uri.equals("/generation/delete")){
            where = "redirect:/generation/list?generation=" + session.getAttribute("sessionGeneration");
        }else{
            where = "redirect:/keywordboard/list";
        }

        return where;
    }

    // 게시글 수정 화면 요청
    @GetMapping("/edit")
    public String edit(Long boardNo, Model model, Page page, HttpServletResponse response, HttpServletRequest request) {
        log.info("controller request {} GET! -  boardNo={}", request.getRequestURI(), boardNo);
        String uri = request.getRequestURI();
        String where = null;
        List<BoardGoodDTO> boardList = boardService.findOneService(boardNo, response, request);
        BoardGoodDTO boardGoodDTO = boardList.get(0);

        model.addAttribute("board", boardGoodDTO);
        model.addAttribute("boardNo", boardNo);
        model.addAttribute("page", page);
        model.addAttribute("validate", boardService.getUser(boardNo));
        if(uri.equals("/freeboard/edit")){
            where = "freeboard/freeboard-edit";
        }else if(uri.equals("/generation/edit")){
            where = "generationboard/generation-edit";
        }else {
            where = "keywordboard/keyword-edit";
        }
        return where;
    }

    // 게시글 수정 요청
    @PostMapping("/edit")
    public String edit(Board board, Page page, HttpServletRequest request) {
        String uri = request.getRequestURI();
        String where = null;
        log.info("controller request {} POST!!", uri);

        HttpSession session = request.getSession();
        boolean flag = boardService.editService(board);
        if (uri.equals("/freeboard/edit")) {
            where = "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount();
        }else if(uri.equals("/generation/edit")){
            where = "redirect:/generation/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount();
        }else{
            where = "redirect:/keyword/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount();
        }
        return where;
    }

    // 특정 게시물에 붙은 첨부파일 경로 리스트를 클라이언트에게 비동기 전송
    @GetMapping("/file/{boardNo}")
    @ResponseBody
    public ResponseEntity<List<String>> getFiles(@PathVariable Long boardNo){
        List<String> files = boardService.getFiles(boardNo);
        log.info("/freeboard/file/{} GET! ASYNC - {}", boardNo, files);

        return new ResponseEntity<>(files, HttpStatus.OK);
    }
}