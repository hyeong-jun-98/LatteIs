package com.academy.latteis.board.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/generation")
public class GenerationController {

    @GetMapping("/list")
    public String getList(){
        log.info("controller request /generation/list GET!");

        return "generationboard/generation-list";
    }
}
