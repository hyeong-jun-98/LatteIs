package com.academy.latteis.user.repository;

import com.academy.latteis.user.domain.User;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserMapperTest {

    @Autowired
    UserMapper userMapper;

    @Test
    void getUser() {

        String userEmail = "djp9816@naver.com";
        String login = "latteis";

        User user = userMapper.findUser(userEmail, login);
        System.out.println(user);

    }
}