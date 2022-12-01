package com.academy.latteis.good.repository;

import com.academy.latteis.good.domain.BoardGood;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class GoodMapperTest {

    @Autowired
    GoodMapper mapper;

    // 좋아요 체크
    @Test
    @DisplayName("좋아요 체크 후 카운트를 가져왔을 때 1이어야 한다.")
    void goodInsertTest() {
        //given
        BoardGood boardGood = new BoardGood();
        boardGood.setUserNo(20L);
        boardGood.setBoardNo(334L);
        System.out.println(boardGood);
        //when
        boolean check = mapper.check(boardGood);
        //then
        if (check) {
            int cnt = mapper.goodCnt(334L);
            assertEquals(1, cnt);
        }
    }

    // 좋아요 취소
    @Test
    @DisplayName("")
    void uncheckTest() {
        BoardGood boardGood = new BoardGood();
        boardGood.setUserNo(3L);
        boardGood.setBoardNo(336L);
        boolean check = mapper.unCheck(boardGood);

        if (check) {
            int cnt = mapper.goodCnt(336L);
            assertEquals(0, cnt);
        }
    }


    // 좋아요 수 테스트
    @Test
    @DisplayName("336번 글에 있는 좋아요 수를 가져온다")
    void getGoodCountTest() {
        BoardGood boardGood = new BoardGood();
        boardGood.setBoardNo(336L);
        System.out.println(boardGood);
        System.out.println(mapper.goodCnt(boardGood.getBoardNo()));
    }

}