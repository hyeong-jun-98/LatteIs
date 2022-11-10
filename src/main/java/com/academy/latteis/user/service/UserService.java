package com.academy.latteis.user.service;

import com.academy.latteis.user.domain.User;
import com.academy.latteis.user.repository.UserMapper;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;

    public boolean saveUser(User user){
        boolean loginCheck = userMapper.save(user);
        return loginCheck;
    }
}
