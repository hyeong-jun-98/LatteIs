package com.academy.latteis.common;

import com.academy.latteis.HomeController;
import com.academy.latteis.board.controller.BoardController;
import com.academy.latteis.board.domain.Topic;
import com.academy.latteis.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Component
@Log4j2
@RequiredArgsConstructor
public class TopicScheduler {

    private final BoardService boardService;
    public Long topicNo = 1L;

//    @Scheduled(cron = "0 0 0 * * *")    // 매일 00시 정각
    @Scheduled(fixedDelay = 1000 * 60 * 10)
    public void getTopic() {
        if (topicNo > 4){
            topicNo = 1L;
        }
        Topic topic = boardService.getTopicOneService(topicNo);
        log.info("topicNo={}, topicName={}", topic.getTopicNo(), topic.getTopicName());

        HomeController.topicName = topic.getTopicName();
        BoardController.topicName = topic.getTopicName();

        topicNo++;
    }
}
