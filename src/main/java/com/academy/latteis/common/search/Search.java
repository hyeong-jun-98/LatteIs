package com.academy.latteis.common.search;

import com.academy.latteis.common.page.Page;
import lombok.*;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class Search extends Page {
    private String type;    // 검색 조건
    private String keyword;     // 검색어

    @Override
    public int getStart() {
        return super.getStart();
    }
}
