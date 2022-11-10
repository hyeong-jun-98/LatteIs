package com.academy.latteis.comment.repository;

import com.academy.latteis.comment.domain.Comment;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CommentMapperTest {

    @Autowired
    CommentMapper commentMapper;

    @Test
    @DisplayName("댓글 1000개를 랜덤 게시물에 등록해야 한다")
    void writeTest(){
        for (int i=1; i <= 1000; i++){
            long bno = (long) (Math.random() * 200 + 1);

            Comment comment = new Comment();
            comment.setBoardNo(bno);
            comment.setCommentContent("댓글"+i);
            comment.setCommentWriter("이하람바보"+i);

            commentMapper.write(comment);
        }
    }

    @Test
    @DisplayName("댓글 100개를 300번 게시물에 등록해야한다")
    void bulkWriteTest(){
        for (int i=1; i<=200;i++){
            long bno = 300L;

            Comment comment = new Comment();
            comment.setBoardNo(bno);
            comment.setCommentWriter("도쥬니"+i);
            comment.setCommentContent("댓글"+i);

            commentMapper.write(comment);
        }
    }
}