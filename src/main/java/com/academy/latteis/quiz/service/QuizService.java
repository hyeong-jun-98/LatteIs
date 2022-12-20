package com.academy.latteis.quiz.service;

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.diary.domain.Diary;
import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.repository.QuizMapper;
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
public class QuizService {

    private final QuizMapper quizMapper;

    // 일기장 목록 (paging)
    public Map<String, Object> findAllService(DiaryPage diaryPage) {
        log.info("quiz findAllService");
        Map<String, Object> findDataMap = new HashMap<>();

        List<Quiz> quizList = quizMapper.findAll(diaryPage);

        processConverting(quizList);
        findDataMap.put("qList", quizList);
        findDataMap.put("tc", quizMapper.getTotalCount());

        return findDataMap;
    }


    // 퀴즈 하나 가져오기
    @Transactional
    public Quiz findOneService(Long quizNo) {
        log.info("quiz findOneService {}", quizNo);

        Quiz quiz = quizMapper.findOne(quizNo);

        return quiz;
    }


    // 날짜변환
    private void processConverting(List<Quiz> quizList) {
        for (Quiz q : quizList) {
            convertDateFormat(q);
        }
    }

    // 날짜 변환
    private void convertDateFormat(Quiz q) {
        Date date = q.getQuizRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy년 MM월 dd일 a hh:mm");
        q.setPrettierDate(sdf.format(date));
    }

    // 퀴즈 작성
    public boolean writeService(Quiz quiz) {
        log.info("quiz write service start");
        boolean flag = quizMapper.write(quiz);

        return flag;
    }

    // 퀴즈 삭제
    public boolean deleteService(Long quizNo){
        log.info("quiz delete service start");
        return quizMapper.delete(quizNo);
    }


}
