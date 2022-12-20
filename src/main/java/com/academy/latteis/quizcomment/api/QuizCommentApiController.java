package com.academy.latteis.quizcomment.api;

import com.academy.latteis.comment.domain.Comment;
import com.academy.latteis.comment.service.CommentService;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.quizcomment.domain.QuizComment;
import com.academy.latteis.quizcomment.service.QuizCommentService;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("api/v1/quiz-comment")
public class QuizCommentApiController {
    private final QuizCommentService quizCommentService;

    // 댓글 작성 요청
    @PostMapping("")
    public String write(@RequestBody QuizComment quizComment, HttpSession session){
        log.info("/api/v1/quiz-comment POST! - {}", quizComment);

        // 세션에서 로그인 정보 받아오기
        User loginUser = (User) session.getAttribute("loginUser");

        // 받아온 로그인 정보에서 닉네임 꺼내기
        quizComment.setUserNickname(loginUser.getUserNickname());

        boolean flag = quizCommentService.writeService(quizComment);
        return flag ? "insert-success" : "insert-fail";
    }

    // 댓글 목록 요청
    @GetMapping("")
    public Map<String, Object> list(Long quizNo, Page page){
        log.info("/api/v1/quiz-comment GET! - qno={}, page={}", quizNo, page);

        Map<String, Object> commentMap = quizCommentService.findAllService(quizNo, page);
        return commentMap;
    }

    // 댓글 삭제 요청
    @DeleteMapping("")
    public String removeComment(Long quizCommentNo){
        log.info("/api/v1/quiz-comment DELETE! - {}", quizCommentNo);

        boolean flag = quizCommentService.removeService(quizCommentNo);
        return flag ?  "del-success" : "del-fail";
    }

    // 댓글 수정 요청
    @PutMapping("{cno}")
    public String editComment(@PathVariable("cno") Long quizCommentNo, @RequestBody QuizComment quizComment){
        log.info("/api/v1//comment PUT! - commentNo = {}, comment = {}", quizCommentNo, quizComment);

        boolean flag = quizCommentService.editService(quizComment);

        return flag ? "edit-success" : "edit-fail";
    }


}
