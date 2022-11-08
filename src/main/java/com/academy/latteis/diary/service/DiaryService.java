package com.academy.latteis.diary.service;


import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.repository.DiaryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class DiaryService {

    private final DiaryMapper diaryMapper;

    // 게시물 등록 요청 중간처리
    @Transactional
    public boolean saveService(Diary diary) {

        // 게시물 내용 DB 저장
        boolean flag = diaryMapper.save(diary);

        return flag;
    }






}
