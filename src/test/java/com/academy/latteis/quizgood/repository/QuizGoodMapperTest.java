package com.academy.latteis.quizgood.repository;

import com.academy.latteis.quizgood.domain.QuizGood;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class QuizGoodMapperTest {

    @Autowired
    QuizGoodMapper mapper;

    @Test
    @DisplayName("")
    void goodOrNotTest() {


        QuizGood quizGood = mapper.goodOrNot(17L, 48L);

        System.out.println(quizGood.toString());

    }

}