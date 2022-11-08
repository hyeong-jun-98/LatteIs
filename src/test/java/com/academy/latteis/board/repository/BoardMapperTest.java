package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class BoardMapperTest {

    @Autowired
    BoardMapper mapper;

    @Test
    @DisplayName("300개의 게시물을 삽입해야 한다.")
    void bulkInsert() {
        Board board;
        for (int i = 1; i <= 300; i++) {
            board = new Board();
            board.setTitle("제목" + i);
            board.setWriter("길동이" + i);
            board.setContent("안녕하세용용이" + i);
            mapper.write(board);
        }
    }

}