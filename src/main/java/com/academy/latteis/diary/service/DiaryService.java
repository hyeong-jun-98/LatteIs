package com.academy.latteis.diary.service;


import com.academy.latteis.diary.repository.DiaryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class DiaryService {
    private final DiaryMapper diaryMapper;



}
