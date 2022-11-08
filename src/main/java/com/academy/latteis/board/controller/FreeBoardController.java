package com.academy.latteis.board.controller;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/freeboard")
public class FreeBoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public String list() {
        log.info("controller request /freeboard/list GET!");

        return "freeboard/freeboard-list";
    }

    @GetMapping("/write")
    public String write() {
        log.info("controller request /freeboard/write GET!");
        return "freeboard/freeboard-write";
    }

    @PostMapping("/write")
    public String write(Board board, RedirectAttributes ra) {

        boolean flag = boardService.writeService(board);

        if(flag)ra.addFlashAttribute("msg", "write-success");

        return flag ? "redirect:/freeboard/list" : "redirect:/";
    }

}
