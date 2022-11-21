package com.academy.latteis.diary.service;


import com.academy.latteis.diary.domain.Good;
import com.academy.latteis.diary.dto.ValidateDiaryUserDTO;
import com.academy.latteis.common.page.DiaryPage;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.repository.DiaryMapper;
import com.academy.latteis.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

        Map<String, Object> findDataMap = new HashMap<>();

        List<Diary> diaryList = diaryMapper.findAll(diaryPage);

        // 목록 중간 데이터 중간처리
        processConverting(diaryList);
        findDataMap.put("dList", diaryList);
        findDataMap.put("tc", diaryMapper.getTotalCount());

        return findDataMap;
    }

    // 공개된 일기 목록 with paging
    public Map <String, Object> findPublicList (DiaryPage diaryPage) {
        Map <String, Object> findDataMap = new HashMap<>();

        List <Diary> diaryPublicList = diaryMapper.findPublicList(diaryPage);
        processConverting(diaryPublicList);
        findDataMap.put("dPList", diaryPublicList);
        findDataMap.put("tc", diaryMapper.getTotalCount());


        return findDataMap;
    }


    // 내가 쓴 일기 목록 with paging
    public Map <String, Object> findMyListService(DiaryPage diaryPage, String userNickname) {
        Map <String, Object> findDataMap = new HashMap<>();

//        User loginUser = (User) session.getAttribute("loginUser");
//        userNickname = loginUser.getUserNickname();

        log.info("나의 잃기 페이징 {}", diaryPage);
        log.info("나의 잃기 서비스 닉네임 {}", userNickname);
        List <Diary> diaryMyList = diaryMapper.findMyList(diaryPage, userNickname);

        processConverting(diaryMyList);
        findDataMap.put("dMList", diaryMyList);
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
    public Diary findOneService(Long diaryNo, HttpServletRequest request, HttpServletResponse response) {
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
    public boolean modifyService(Diary diary) {
        log.info("modify service {}", diary);

        return diaryMapper.modify(diary);
    }

    //일기 true false 확인
    public boolean goodCheckService(Long diaryNo, Long userNo) {
        log.info("diaryGoodCheck service {}, {}", diaryNo, userNo);

//

        //1. 현재 추천상태를 확인한다.
        // check가 false, true, null 3개 중 하나가 들어옴
        String check = diaryMapper.goodCheck(diaryNo, userNo);
        log.info("service goodcheck - {}", check);

        // flag 기본 값은 false.
        boolean flag = false;

        // check가 null이면 건너뛰어
        if (check != null) {
            // check가 true일 경우에는 flag가 true로 바뀐다.
            // check가 false인 경우 flag는 그대로 false다.
            flag = check.equals("true");
        }


        // flag가 false or null 인 경우 실행
        if (!flag) {
            log.info("goodcheck service if문 작동");

            if (check == null) {
                diaryMapper.goodFirstUp(diaryNo, userNo);
            }
            diaryMapper.goodUpCheck(diaryNo, userNo);
            diaryMapper.goodUp(diaryNo);
            flag = true;
            log.info("if 작동 후 flag 상태 {}", flag);

            // flag가 true일 경우
        } else {
            log.info("goodcheck service else문 작동");

            diaryMapper.goodDownCheck(diaryNo, userNo);
            diaryMapper.goodDown(diaryNo);
            flag = false;

        }
        return flag;
    }

    // 닉네임으로 글쓴이 유저번호 가져오기
    public ValidateDiaryUserDTO getUser(Long diaryNo) {
        log.info("서비스에서 diaryNo {}", diaryNo);

      diaryMapper.findUserByDiaryNo(diaryNo);


        return diaryMapper.findUserByDiaryNo(diaryNo);
    }

//    // 좋아요 여부 가져오기
//    public Good findGoodCheckService(Long diaryNo, Long userNo) {
//
//        log.info("좋아요 여부 뽑아오기 -서비스 {},{}", diaryNo, userNo);
//
//        Good good = diaryMapper.findGoodCheck(diaryNo, userNo);
//
//        return good;
//    }


}
