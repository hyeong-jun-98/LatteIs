package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 글작성
    boolean write(Board board);

    // 글 전체 조회
    List<Board> findAll();

}
