package com.academy.latteis.diary.repository;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.domain.Good;
import com.academy.latteis.diary.dto.ValidateDiaryUserDTO;
import com.academy.latteis.user.domain.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DiaryMapperTest {

    @Autowired
    DiaryMapper mapper;

    // 수정
    @Test
    void modifyTest() {
        Diary diary = new Diary();
        diary.setDiaryContent("zzz수정");
        diary.setDiaryNo(2L);
        diary.setEmotion("GOOD");
        diary.setDiaryShow("공개");
        boolean flag = mapper.modify(diary);

        assertTrue(flag);
    }

    // 삽입
    @Test
    void insertTest() {
        Diary diary = new Diary();

        diary.setUserNickname("HJ");
        diary.setDiaryContent("테슽");
        diary.setDiaryShow("테슽");
        diary.setEmotion("테슽");

        boolean flag = mapper.save(diary);
        assertTrue(flag);

    }

    // 일기 true false 체크

    @Test
    void goodCheck() {

        Long diaryNo = 22L;
        Long userNo = 9L;

        String goodCheck = mapper.goodCheck(diaryNo, userNo);
        System.out.println(goodCheck);

    }


    // 일기 좋아요 체크 (전과 0)
    // false -> true : 좋아요를 눌렀을 때 true로 변신!
    @Test
    void goodUpCheck() {
        Long diaryNo = 22L;
        Long userNo = 9L;

        Good good = new Good();
        good.setGoodCheck("true");

        boolean flag = mapper.goodUpCheck(diaryNo, userNo);
        assertTrue(flag);

    }


    // 일기 좋아요 체크 (전과 1)
    // true -> false : 좋아요를 눌렀을 때 false로 변신!
    @Test
    void goodDownCheck() {
        Long diaryNo = 22L;
        Long userNo = 9L;

        Good good = new Good();
        good.setGoodCheck("false");

        boolean flag = mapper.goodDownCheck(diaryNo, userNo);
        assertTrue(flag);

    }

    // 일기 좋아요 + 1
    @Test
    void goodUp() {
        Long diaryNo = 22L;

        Diary diary = new Diary();

        diary.setDiaryGood(diaryNo);

        boolean flag = mapper.goodUp(diaryNo);
        assertTrue(flag);
    }

    // 좋아요 취소

    @Test
    void goodDown() {
        Long diaryNo = 22L;

        Diary diary = new Diary();
        diary.setDiaryNo(diaryNo);

        boolean flag = mapper.goodDown(diaryNo);
        assertTrue(flag);
    }


    // 좋아요 여부 뽑아오기
    @Test
    void findGoodCheck() {
        Long diaryNo = 22L;
        Long userNo = 9L;

        Good good = new Good();
//        good.setGoodCheck();
    }

//    // 내가 쓴 일기
//    @Test
//    void findMyList() {
//
//        String userNickname = "IUUI";
//
//        Diary diary = new Diary();
//        boolean flag = mapper.findMyList(userNickname);
//        assertEquals();
//
//    }



}