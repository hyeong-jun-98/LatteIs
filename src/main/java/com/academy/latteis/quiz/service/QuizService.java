package com.academy.latteis.quiz.service;

import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.quiz.domain.Quiz;
import com.academy.latteis.quiz.repository.QuizMapper;
import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.repository.UserMapper;
import com.academy.latteis.quizcomment.repository.QuizCommentMapper;
import com.academy.latteis.quizgood.repository.QuizGoodMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    private final QuizCommentMapper quizCommentMapper;
    private final QuizGoodMapper quizGoodMapper;
    private final UserMapper userMapper;

    // 일기장 목록 (paging)
    public Map<String, Object> findAllService(DiaryPage diaryPage) {
        log.info("quiz findAllService");
        Map<String, Object> findDataMap = new HashMap<>();

        List<Quiz> quizList = quizMapper.findAll(diaryPage);

        processConverting(quizList);
        findDataMap.put("quizList", quizList);
        findDataMap.put("tc", quizMapper.getTotalCount());

        return findDataMap;
    }


    // 퀴즈 하나 가져오기
    @Transactional
    public Quiz findOneService(Long quizNo, HttpServletResponse response, HttpServletRequest request) {
        log.info("quiz findOneService {}", quizNo);

        Quiz quiz = quizMapper.findOne(quizNo);

        // 해당 게시물 번호에 해당하는 쿠키가 있는지 확인
        // 쿠키가 없으면 조회수를 상승시켜주고 쿠키를 만들어서 클라이언트에 전송
        upHit(quizNo, response, request);
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

        // 댓글 먼저 모두 삭제
        quizCommentMapper.removeByQuizNo(quizNo);

        // 좋아요도 삭제
        quizGoodMapper.removeByQuizNo(quizNo);

        // 원본 게시물 삭제
        return quizMapper.delete(quizNo);
    }

    // 조회수 상승 처리
    private void upHit(Long quizNo, HttpServletResponse response, HttpServletRequest request) {
        // 먼저 쿠키를 조회함 => 해당 이름의 쿠키가 있으면 쿠키가 들어올 것이고, 없다면 null이 들어올 것임
        Cookie foundCookie = WebUtils.getCookie(request, "q" + quizNo);

        if (foundCookie == null) {   // 쿠키가 없다면~~
            quizMapper.upHit(quizNo); // 조회수 상승 시키고
            Cookie cookie = new Cookie("q" + quizNo, String.valueOf(quizNo));   // 쿠키 생성
            cookie.setMaxAge(60);   // 쿠키 수명을 1분으로 설정
            cookie.setPath("/");   // 쿠키 작동 범위

            response.addCookie(cookie);   // 클라이언트에게 쿠키 전송
        }
    }


    public Quiz answerCheck(String quizAnswer, int quizNo, String userNickname){
        if(quizMapper.answerCheck(quizAnswer)>0){
            quizMapper.correctAnswer(quizNo);
            quizMapper.correctUser(userNickname, quizNo);
            log.info(quizNo);
            log.info((long)quizNo);
            Quiz quiz= quizMapper.findOne((long)quizNo);
            int beforeScore = userMapper.getScore(userNickname);
            int score = userMapper.getScore(userNickname);
            score +=quiz.getQuizScore().intValue();
            int beforeWriterScore = userMapper.getScore(quiz.getQuizWriter());
            int writerScore = userMapper.getScore(quiz.getQuizWriter());
            writerScore += 500;
            //문제를 맞춘사람
            userMapper.plusScore(userNickname,score);
            //문제를 출제한 사람
            userMapper.plusScore(quiz.getQuizWriter(), writerScore);
            score = userMapper.getScore(userNickname);
            writerScore = userMapper.getScore(quiz.getQuizWriter());
            quiz.setLevelUp(0);
            //맞춘 사람 레벨업
            if(score>=5000&&beforeScore<5000){
                userMapper.levelUp(userNickname, "유치원생");
                quiz.setLevelUp(1);
            }else if(score>=8000&&beforeScore<8000){
                userMapper.levelUp(userNickname, "초등학생");
                quiz.setLevelUp(2);
            }else if(score>=14000&&beforeScore<14000){
                userMapper.levelUp(userNickname, "중학생");
                quiz.setLevelUp(3);
            }else if(score>=17000&&beforeScore<17000){
                userMapper.levelUp(userNickname, "고등학생");
                quiz.setLevelUp(4);
            }else if(score>=20000&&beforeScore<20000){
                userMapper.levelUp(userNickname, "대학생");
                quiz.setLevelUp(5);
            }else if(score>=24000&&beforeScore<24000){
                userMapper.levelUp(userNickname, "졸업생");
                quiz.setLevelUp(6);
            }
            //작성자 레벨업
            if(writerScore>=5000&&beforeWriterScore<5000){
                userMapper.levelUp(quiz.getQuizWriter(), "유치원생");
            }else if(writerScore>=8000&&beforeWriterScore<8000){
                userMapper.levelUp(quiz.getQuizWriter(), "초등학생");
            }else if(writerScore>=14000&&beforeWriterScore<14000){
                userMapper.levelUp(quiz.getQuizWriter(), "중학생");
            }else if(writerScore>=17000&&beforeWriterScore<17000){
                userMapper.levelUp(quiz.getQuizWriter(), "고등학생");
            }else if(writerScore>=20000&&beforeWriterScore<20000){
                userMapper.levelUp(quiz.getQuizWriter(), "대학생");
            }else if(writerScore>=24000&&beforeWriterScore<24000){
                userMapper.levelUp(quiz.getQuizWriter(), "졸업생");
            }
            return quiz;
        }else{
            Quiz quiz= quizMapper.findOne((long)quizNo);
            return quiz;
        }
    }

    // 게시글 번호로 작성자 회원정보 가져오기
    public ValidateUserDTO getUser(Long quizNo) {
        log.info("quiz service start - quizNo = {}", quizNo);
        return quizMapper.findUserByQuizNo(quizNo);
    }

    //  퀴즈 작성자 등급 가져오기
    public String findQuizWriterGradeService (String quizWriter) {

        log.info("findQuizWriterGrade Service {}", quizWriter);
        return quizMapper.findQuizWriterGrade(quizWriter);
    }



}
