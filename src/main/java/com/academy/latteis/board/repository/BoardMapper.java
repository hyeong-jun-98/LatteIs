package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.common.Page;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시글 작성
    boolean write(Board board);

    // 게시글 전체 조회
    List<Board> findAll(Page page);

    // 전체 게시글 수 조회
    int getTotalCount();

}
