package com.academy.latteis.quizcomment.service;

import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import com.academy.latteis.quizcomment.domain.QuizComment;
import com.academy.latteis.quizcomment.repository.QuizCommentMapper;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j2
public class QuizCommentService {

    private final QuizCommentMapper quizCommentMapper;

    // 댓글 작성
    public boolean writeService(QuizComment quizComment) {
        log.info("comment write service start");

        boolean flag = quizCommentMapper.write(quizComment);
        return flag;
    }

    // 댓글 목록 조회
    public Map<String, Object> findAllService(Long quizNo, Page page) {
        PageMaker pageMaker = new PageMaker(page, getCommentCountService(quizNo));

        List<QuizComment> quizCommentList = quizCommentMapper.findAll(quizNo, page);

        Map<String, Object> commentMap = new HashMap<>();
        commentMap.put("quizCommentList", quizCommentList);
        commentMap.put("pageMaker", pageMaker);
        commentMap.put("count", quizCommentMapper.getQuizCommentCount(quizNo));

        return commentMap;
    }

    // 댓글 삭제
    public boolean removeService(Long quizCommentNo) {
        return quizCommentMapper.remove(quizCommentNo);
    }

    // 댓글 수정
    public boolean editService(QuizComment quizComment) {
        return quizCommentMapper.edit(quizComment);
    }

    // 댓글 수
    public int getCommentCountService(Long quizNo) {
        return quizCommentMapper.getQuizCommentCount(quizNo);
    }

    public void exitUser(User user) {
        log.info("댓글 {}", user);
        quizCommentMapper.exitUser(user.getUserNickname());
    }

    public void reviseUser(String beforeUserNickname, String afterUsernickname) {
        quizCommentMapper.reviseUser(beforeUserNickname, afterUsernickname);
    }

}
