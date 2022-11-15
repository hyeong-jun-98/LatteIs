package com.academy.latteis.diary.repository;

import com.academy.latteis.diary.domain.Diary;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DiaryMapperTest {

    @Autowired DiaryMapper mapper;

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
}