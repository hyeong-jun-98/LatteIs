package com.academy.latteis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class LatteIsApplication {

    public static void main(String[] args) {
        SpringApplication.run(LatteIsApplication.class, args);
    }

}
