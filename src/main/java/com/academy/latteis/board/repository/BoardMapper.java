package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardConvertDTO;
import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.search.Search;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시글 작성
    boolean write(Board board);

    // 게시글 전체 조회
    List<BoardConvertDTO> findAll(Search search);

    // 게시글 상세보기
    Board findOne(Long boardNo);

    // 전체 게시글 수 조회
    int getTotalCount(Search search);

    // 게시글 삭제
    boolean remove(Long boardNo);

    // 게시글 수정
    boolean edit(Board board);

    // 조회수 처리
    void upHit(Long boardNo);

    // 게시물 번호로 게시글 작성자의 계정명과 권한 가져오기
    ValidateUserDTO findUserByBoardNo(Long boardNo);
}
