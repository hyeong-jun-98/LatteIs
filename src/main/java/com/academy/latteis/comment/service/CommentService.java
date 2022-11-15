package com.academy.latteis.comment.service;

import com.academy.latteis.comment.domain.Comment;
import com.academy.latteis.comment.repository.CommentMapper;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.page.PageMaker;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j2
public class CommentService {
    private final CommentMapper commentMapper;

    // 댓글 작성
    public boolean writeService(Comment comment){
        log.info("comment write service start");

        boolean flag = commentMapper.write(comment);
        return flag;
    }

    // 댓글 목록 조회
    public Map<String, Object> findAllService(Long boardNo, Page page){
        PageMaker pageMaker = new PageMaker(page, getCommentCountService(boardNo));

        List<Comment> comment = commentMapper.findAll(boardNo, page);

        Map<String, Object> commentMap = new HashMap<>();
        commentMap.put("commentList", comment);
        commentMap.put("pageMaker", pageMaker);
        commentMap.put("count", commentMapper.getCommentCount(boardNo));

        return commentMap;
    }

    // 댓글 삭제
    public boolean removeService(Long commentNo){
        return commentMapper.remove(commentNo);
    }

    // 댓글 수정
    public boolean editService(Comment comment){
        return commentMapper.edit(comment);
    }

    // 댓글 수
    public int getCommentCountService(Long boardNo){
        return commentMapper.getCommentCount(boardNo);
    }
}
