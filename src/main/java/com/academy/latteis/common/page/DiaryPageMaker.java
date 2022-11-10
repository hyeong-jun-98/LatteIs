package com.academy.latteis.common.page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 페이지 렌더링 정보 생성
public class DiaryPageMaker {
    // 한번에 그려낼 페이지 수
    private static final  int PAGE_COUNT = 12;

    // 렌더링 시 페이지 시작값, 페이지 끝값
    private int beginPage, endPage, finalPage;

    // 이전, 다음 버튼 활성화 여부
    private boolean prev, next;

    // 현재 위치한 페이지 정보
    private DiaryPage diaryPage;

    // 총 게시물 수
    private int totalCount;

    // 생성자
    public DiaryPageMaker(DiaryPage diaryPage, int totalCount){
        this.diaryPage = diaryPage;   // 현재 페이지 초기화
        this.totalCount = totalCount;   // 총 게시물 초기화
        makePageInfo();
    }

    // 페이지 정보 생성 알고리즘
    private void makePageInfo(){
        // 1. endPage 계산
        // 올림처리 (현재 위치한 페이지번호 / 한 화면에 배치할 페이지수 ) *  한 화면에 배치할 페이지 수
        this.endPage = (int)(Math.ceil(diaryPage.getPageNum() / (double)PAGE_COUNT)* PAGE_COUNT);

        // 2. beginPage 계산
        this.beginPage = endPage - PAGE_COUNT + 1;

        /*
         * 총 게시물 수 237개, 한 화면당 10개의 게시물
         *
         * 1 ~ 10 페이지 구간 : 게시물 100개
         * 11 ~ 20 : 게시물 100개
         * 21 ~ 24 : 게시물 37개
         *
         * => 마지막 페이지 구간에서는 보정이 필요하다...
         *
         * 마지막 구간 끝페이지 보정 공식
         * => 올림처리(총 게시물 수 / 한 페이지 당 배치할 게시물 수)
         * */
        // 3. finePage 계산
        int realEnd = (int) Math.ceil((double)totalCount / diaryPage.getAmount());

        this.finalPage = realEnd;

        // 그렇다면 끝 페이지 보정은 언제??
        // 마지막 페이지 구간에서 일어날 수도, 아닐 수도...
        if (realEnd < endPage){
            this.endPage = realEnd;
        }

        // 이전 버튼 활성화 여부
        this.prev = beginPage > 1;

        // 다음 버튼 활성화 여부
        this.next = endPage < realEnd;

    }
}
