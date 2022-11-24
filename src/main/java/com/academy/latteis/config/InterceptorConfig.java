package com.academy.latteis.config;

import com.academy.latteis.interceptor.*;


import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 다양한 인터셉터들을 관리하는 설정 클래스
@Configuration
@RequiredArgsConstructor
public class InterceptorConfig implements WebMvcConfigurer {

    private final BoardInterceptor boardInterceptor;
    private final AfterLoginInterceptor afterLoginInterceptor;
    private final AutoLoginInterceptor autoLoginInterceptor;
    private final DiaryInterceptor diaryInterceptor;
    private final HomeInterceptor homeInterceptor;

    // 인터셉터 설정 추가 메서드
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 게시판 인터셉터 설정
        registry.addInterceptor(boardInterceptor)
                .addPathPatterns("/freeboard/*", "/generation/*")
                .excludePathPatterns("/freeboard/list", "/freeboard/content", "/generation/list", "/generation/content");

        // 일기장 인터셉터 설정
        registry.addInterceptor(diaryInterceptor)
                .addPathPatterns("/diary/*")
                .excludePathPatterns("/diary/list", "/diary/detail", "/diary/bestList");

        // 애프터 로그인 인터셉터 설정
        registry.addInterceptor(afterLoginInterceptor)
                .addPathPatterns("/user/login", "/user/join");

        // 홈 화면 인터샙터 설정
        registry.addInterceptor(homeInterceptor)
                        .addPathPatterns("/");
        // 자동 로그인 인터셉터 설정
        registry.addInterceptor(autoLoginInterceptor)
                .addPathPatterns("/","/**");
    }
}
