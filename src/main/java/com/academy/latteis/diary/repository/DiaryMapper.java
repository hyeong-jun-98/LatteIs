package com.academy.latteis.diary.repository;

import com.academy.latteis.diary.domain.Diary;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DiaryMapper {

    // 일기 작성
    boolean save(Diary diary);
    // 일기장 (전체조회)
    List <Diary> findAll();

    // 일기 상세 조회

    //일기 삭제

    // 일기 수정

    // 일기장 수 조회 (게시물 수)

    // 조회수 여부 (공개 비공개 선택 나중에 생각)

    // 파일 첨부 (사진)




}
