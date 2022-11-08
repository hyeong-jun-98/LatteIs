package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.service.BoardService;
import com.academy.latteis.common.Page;
import com.academy.latteis.common.PageMaker;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/freeboard")
public class FreeBoardController {

    private final BoardService boardService;

    // 게시글 목록 요청
    @GetMapping("/list")
    public String list(Page page, Model model){
        log.info("controller request /freeboard/list GET! - page: {}", page);

        Map<String, Object> boardMap = boardService.findAllService(page);
        log.debug("return data - {}", boardMap);

        // 페이지 정보 생성
        PageMaker pm = new PageMaker(new Page(page.getPageNum(), page.getAmount()), (Integer) boardMap.get("totalCount"));

        model.addAttribute("boardList", boardMap.get("boardList"));
        model.addAttribute("pm", pm);

        return "freeboard/freeboard-list";
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

        boolean flag = boardService.writeService(board);

        if(flag)ra.addFlashAttribute("msg", "write-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/";
    }

}
