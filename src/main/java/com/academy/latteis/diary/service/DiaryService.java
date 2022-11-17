package com.academy.latteis.diary.service;


import com.academy.latteis.common.page.DiaryPage;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.domain.Good;
import com.academy.latteis.diary.repository.DiaryMapper;
import com.academy.latteis.user.domain.User;
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
    public Map<String, Object> findAllService(DiaryPage diaryPage) {

        Map <String, Object> findDataMap  = new HashMap<>();

        List <Diary> diaryList = diaryMapper.findAll(diaryPage);

        // 목록 중간 데이터 중간처리
        processConverting(diaryList);
        findDataMap.put("dList", diaryList);
        findDataMap.put("tc", diaryMapper.getTotalCount());

        return findDataMap;
    }

    // 날짜변환
    private void processConverting(List<Diary> diaryList) {
        for (Diary d : diaryList) {
            convertDateFormat(d);
        }
    }

    // 날짜 변환
    private void convertDateFormat(Diary d) {
        Date date = d.getDiaryRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 a hh:mm");
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
    public boolean modifyService (Diary diary) {
        log.info("modify service {}", diary);

        return diaryMapper.modify(diary);
    }

    //일기 true false 확인
    public boolean goodCheckService(Long diaryNo, Long userNo) {
        log.info("diaryGoodCheck service {}, {}", diaryNo, userNo);

//

        //1. 현재 추천상태를 확인한다.
        boolean flag = false;
        String check = diaryMapper.goodCheck(diaryNo, userNo);


        // true면 boolean 타입의 true로 바꿔줌
        if(check == null) {
            diaryMapper.goodFirstUp(diaryNo, userNo);
            diaryMapper.goodUpCheck(diaryNo, userNo);
            diaryMapper.goodUp(diaryNo);
        } else {
            flag = check.equals("true");

            if (flag) { //추천상태면
                diaryMapper.goodDownCheck(diaryNo, userNo);
                diaryMapper.goodDown(diaryNo);
            } else {   // 추천상태가 아니면
                diaryMapper.goodUpCheck(diaryNo, userNo);
                diaryMapper.goodUp(diaryNo);
            }

        }
        return flag;
    }


//    // 일기 추천 체크 (누르지 않은 상태)
//    // false -> true : 좋아요를 눌렀을 때 true로 변신!
//    public boolean diaryGoodUpCheck(Long diaryNo, Long userNo) {
//        log.info("diaryGoodUpCheck service {}, {}", diaryNo, userNo);
//
//        return diaryMapper.goodUpCheck(diaryNo, userNo);
//    }
//
//    // 일이 추천 체크 (누른 상태)
//    // true -> false : 좋아요를 눌렀을 때 false로 변신!
//    public boolean diaryGoodDownCheck(Long diaryNo, Long userNo) {
//        log.info("diaryGoodDownCheck service {}, {}", diaryNo, userNo);
//
//        return diaryMapper.goodDownCheck(diaryNo, userNo);
//    }
//
//
//    // 일기 추천 + 1
//    public boolean diaryGoodUp (Long diaryNo) {
//        log.info("diaryGoodUp service {}", diaryNo);
//
//        return diaryMapper.goodUp(diaryNo);
//    }
//
//    // 일기 추천 - 1
//    public boolean diaryGoodDown (Long diaryNo) {
//        log.info("diaryGoodDown service {}", diaryNo);
//
//        return diaryMapper.goodDown(diaryNo);
//    }




}
