package com.academy.latteis.diary.repository;

import com.academy.latteis.common.page.DiaryPage;

import com.academy.latteis.diary.domain.Diary;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DiaryMapper {

    // 일기 작성
    boolean save(Diary diary);
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
    // 조회수 여부 (공개 비공개 선택 나중에 생각)

    // 파일 첨부 (사진)






}
