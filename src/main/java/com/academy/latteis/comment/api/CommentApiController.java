package com.academy.latteis.comment.api;

import com.academy.latteis.comment.domain.Comment;
import com.academy.latteis.comment.service.CommentService;
import com.academy.latteis.common.page.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor    // 생성자 주입
@Log4j2
@RequestMapping("/api/v1/comment")
@CrossOrigin
public class CommentApiController {

    private final CommentService commentService;

    // 댓글 작성 요청
    @PostMapping("")
    public String write(@RequestBody Comment comment){
        log.info("/api/v1/comment POST! - {}", comment);
        boolean flag = commentService.writeService(comment);
        return flag ? "insert-success" : "insert-fail";
    }

    // 댓글 목록 요청
    @GetMapping("")
    public Map<String, Object> list(Long boardNo, Page page){
        log.info("/api/v1/comment GET! - bno={}, page={}", boardNo, page);

        Map<String, Object> comment = commentService.findAllService(boardNo, page);
        return comment;
    }

}
