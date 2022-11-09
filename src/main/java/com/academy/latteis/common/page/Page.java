package com.academy.latteis.common.page;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
@AllArgsConstructor
// 페이지 정보 클래스
public class Page {
    private int pageNum;    // 페이지 번호
    private int amount; // 한 페이지 당 배치할 게시물 수

    public Page() {
        this.pageNum = 1;
        this.amount = 10;
    }

    // amount에 대해서 페이지 당 게시글 인덱스 처리
    // 만약 1페이지면 인덱스 0번부터 10개 => 0 ~ 9
    //2페이지면 인덱스 10부터 10개 => 10 ~19
    //3페이지면 인덱스 20부터 10개 => 20 ~ 30
    public int getStart() {
        return (pageNum - 1) * amount;
    }

    // 페이지 번호 지정
    public void setPageNum(int pageNum) {
        if (pageNum <= 0 || pageNum > Integer.MAX_VALUE) {   // 접속할 수 있는 페이지를 넘어가면...
            this.pageNum = 1;   // 1페이지로 가도록 설정
            return;
        }
        this.pageNum = pageNum;
    }

    // 한 페이지 당 보여질 게시글 수 지정
    public void setAmount(int amount) {
        if (amount < 10 || amount > 100) {// amount를 엄청 크게 설정해서 접근하는 것을 막기위해...
            this.amount = 10;   // url에 9999로 설정하고 접속해도 10으로 됨
            return;
        }
        this.amount = amount;
    }
}
