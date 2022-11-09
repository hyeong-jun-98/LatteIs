package com.academy.latteis.diary.service;


import com.academy.latteis.common.Page;
import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.repository.DiaryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class DiaryService {

    private final DiaryMapper diaryMapper;

    // 일기장 작성
    @Transactional
    public boolean saveService(Diary diary) {
        // 게시물 내용 DB 저장
        boolean flag = diaryMapper.save(diary);
        return flag;
    }

    // 일기장 목록 with paging
    public Map<String, Object> findAllService(Page page) {

        Map <String, Object> findDataMap  = new HashMap<>();

        List <Diary> diaryList = diaryMapper.findAll(page);

        // 목록 중간 데이터 중간처리
        processConverting(diaryList);
        findDataMap.put("dList", diaryList);
        findDataMap.put("tc", diaryMapper.getTotalCount());

        return findDataMap;
    }

    private void processConverting(List<Diary> diaryList) {
        for (Diary d : diaryList) {
            convertDateFormat(d);
        }
    }


    private void convertDateFormat(Diary d) {
        Date date = d.getDiaryRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd a hh:mm");
        d.setPrettierDate(sdf.format(date));
    }

    // 일기장 상세화면
    @Transactional
    public Diary findOneService(Long diaryNo) {
        Diary diary = diaryMapper.findOne(diaryNo);
        return diary;
    }

    // 일기 삭제
    @Transactional
    public boolean removeService(Long diaryNo) {
        log.info("remove service start {}", diaryNo);
        boolean remove = diaryMapper.remove(diaryNo);

        return remove;
    }



    // 일기 수정





}
