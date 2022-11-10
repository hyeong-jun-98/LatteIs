package com.academy.latteis.user.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

        // 로그인 화면 요청
        @GetMapping("/loginform")
        public String loginform() {
            return "/user/loginform";
        }

        // 회원가입 화면 요청
        @GetMapping("/joinform")
        public String joinform() { return "/user/joinform"; }

//        @GetMapping("/detail/{boardNo}")
//        public String getDetail(@PathVariable Long boardNo, Model model, Page page) {
//            log.info("controller request /freeboard/detail GET! - {}", boardNo);
//            Board board = boardService.findOneService(boardNo);
//            log.info("return data - {}", board);
//            model.addAttribute("board", board);
//            model.addAttribute("page", page);
//            return "freeboard/freeboard-detail";
//        }
//
//        // 게시글 작성 화면
//        @GetMapping("/write")
//        public String write() {
//            log.info("controller request /freeboard/write GET!");
//            return "freeboard/freeboard-write";
//        }
//
//        // 게시글 작성 요청 처리
//        @PostMapping("/write")
//        public String write(Board board, RedirectAttributes ra) {
//            log.info("controller request /freeboard/write POST!");
//
//            boolean flag = boardService.writeService(board);
//
//            if (flag) ra.addFlashAttribute("msg", "write-success");
//
//            return flag ? "redirect:/freeboard/list" : "redirect:/list";
//        }
//
//        // 게시글 삭제
//        @GetMapping("/delete")
//        public String remove(Long boardNo, RedirectAttributes ra) {
//            log.info("controller request /freeboard/delete GET! - {}", boardNo);
//
//            boolean flag = boardService.removeService(boardNo);
//            if (flag) ra.addFlashAttribute("msg", "delete-success");
//
//            return flag ? "redirect:/freeboard/list" : "redirect:/freeboard/list";
//        }
//
//        // 게시글 수정 화면 요청
//        @GetMapping("/edit/{boardNo}")
//        public String edit(@PathVariable Long boardNo, Model model, Page page) {
//            log.info("controller request /freeboard/edit GET! - {}", boardNo);
//            Board board = boardService.findOneService(boardNo);
//            model.addAttribute("board", board);
//            model.addAttribute("page", page);
//            return "/freeboard/freeboard-edit";
//        }
//
//        // 게시글 수정 요청
//        @PostMapping("/edit")
//        public String edit(Board board, Page page) {
//            log.info("controller request /freeboard/edit POST!!");
//            boolean flag = boardService.editService(board);
//            return flag ? "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount()
//                    : "redirect:/freeboard/detail/" + board.getBoardNo() + "?pageNum=" + page.getPageNum() + "&amount=" + page.getAmount();
//        }


}
