package com.academy.latteis.comment.api;

import com.academy.latteis.comment.domain.Comment;
import com.academy.latteis.comment.service.CommentService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequiredArgsConstructor    // 생성자 주입
@Log4j2
@RequestMapping("/api/v1/comment")
@CrossOrigin    // CORS를 적용하는 어노테이션
public class CommentApiController {

    private final CommentService commentService;

    // 댓글 작성 요청
    @PostMapping("")
    public String write(@RequestBody Comment comment, HttpSession session){
        log.info("/api/v1/comment POST! - {}", comment);

        // 세션에서 로그인 정보 받아오기
        User loginUser = (User) session.getAttribute("loginUser");

        // 받아온 로그인 정보에서 닉네임 꺼내기
        comment.setUserNickname(loginUser.getUserNickname());

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

    // 댓글 삭제 요청
    @DeleteMapping("")
    public String removeComment(Long commentNo){
        log.info("/api/v1/comment DELETE! - {}", commentNo);

        boolean flag = commentService.removeService(commentNo);
        return flag ?  "del-success" : "del-fail";
    }

    // 댓글 수정 요청
    @PutMapping("{cno}")
    public String editComment(@PathVariable("cno") Long commentNo, @RequestBody Comment comment){
        log.info("/api/v1//comment PUT! - commentNo = {}, comment = {}", commentNo, comment);

        boolean flag = commentService.editService(comment);

        return flag ? "edit-success" : "edit-fail";
    }


}
