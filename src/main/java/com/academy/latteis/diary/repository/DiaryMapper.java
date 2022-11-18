package com.academy.latteis.diary.repository;

import com.academy.latteis.common.page.DiaryPage;

import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.diary.domain.Good;
import com.academy.latteis.diary.dto.ValidateDiaryUserDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DiaryMapper {

    // 일기 작성
    boolean save(Diary diary);

//    // 좋아요 테이블 작성
//    boolean saveGood(Good good);

    // 일기장 (전체조회)
    //List <Diary> findAll();
    
    //  일기장 페이징 처리
    List <Diary> findAll(DiaryPage diaryPage);

    // 일기 상세 조회
    Diary findOne(Long diaryNo);

    //일기 삭제
    boolean remove(Long diaryNo);

    // 일기 수정
    boolean modify(Diary diary);

    // 일기장 수 조회 (게시물 수)
    int getTotalCount();

    // 일기 true, false 체크
    String goodCheck(Long diaryNo, Long userNo);

    // 일기 추천  (좋아요 전과 0범 (누른적 없음))
    // false -> true : 좋아요를 눌렀을 때 true로 변신!
    boolean goodUpCheck (Long diaryNo, Long userNo);

    // 일기 추천  (좋아요 전과 1범 (누른적 있음))
    // true -> false : 좋아요를 눌렀을 때 false로 변신!
    boolean goodDownCheck(Long diaryNo, Long userNo);

    // 일기 추천 (처음)
    boolean goodFirstUp(Long diaryNo, Long userNo);

    // 일기 추천 + 1
    boolean goodUp(Long diaryNo);

    // 일기 추천 - 1
    boolean goodDown(Long diaryNo);

    // 일기 작성자로 userNo 가져오기
    ValidateDiaryUserDTO findUserByDiaryNo (Long diaryNo);

    // 일기 좋아요 체크여부 가져오기
    Good findGoodCheck(Long diaryNo, Long userNo);







}
