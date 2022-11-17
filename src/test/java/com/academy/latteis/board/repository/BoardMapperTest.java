package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.dto.ValidateUserDTO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

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

    @Test
    @DisplayName("")
    void findAccountTest() {
        //given

        //when
        ValidateUserDTO dto = mapper.findUserByBoardNo(333L);
        //then
        System.out.println("dto = " + dto);
    }

    @Test
    @DisplayName("")
    void findOneTest() {
        //given

        //when
        List<BoardGoodDTO> boardList = mapper.findOne(336L);
        //then
        System.out.println("board = " + boardList);
    }

}