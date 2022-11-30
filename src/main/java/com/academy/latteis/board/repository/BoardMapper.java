package com.academy.latteis.board.repository;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardConvertDTO;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.dto.EditBoardDTO;
import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.common.search.Search;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시글 작성
    boolean writeFree(Board board);

    boolean writeGeneration(Board board);

    boolean writeKeyword(Board board);

    // 게시글 전체 조회
    List<BoardConvertDTO> findAllFree(Search search);

    List<BoardConvertDTO> findAllGeneration(@Param("search") Search search, @Param("generation") Long generation);

    List<BoardConvertDTO> findAllKeyword(@Param("search") Search search, @Param("topicNo") Long topicNo);

    // 게시글 상세보기
    List<BoardGoodDTO> findOne(Long boardNo);

    // 전체 게시글 수 조회
    int getTotalCountFree(Search search);

    int getTotalCountGeneration(Search search);

    // 게시글 삭제
    boolean remove(Long boardNo);

    // 게시글 수정
    boolean edit(EditBoardDTO board);

    // 조회수 처리
    void upHit(Long boardNo);

    // 게시물 번호로 게시글 작성자의 계정명과 권한 가져오기
    ValidateUserDTO findUserByBoardNo(Long boardNo);

    // 파일 첨부 기능 처리
    void addFile(String fileName);

    // 게시글 수정 시, 파일 추가
    void addFileByEdit(String fileName, Long boardNo);

    // 첨부파일 삭제 처리
    void deleteAllFile(Long boardNo);

    // 수정 글 첨부파일 삭제
    void editFileDelete(EditBoardDTO dto);

    // 게시물에 붙어있는 첨부파일 경로명 전부 조회
    List<String> findFileNames(Long boardNo);

    BoardGoodDTO findBestFree();

    BoardGoodDTO findBestKey();

    BoardGoodDTO findBest00();

    BoardGoodDTO findBest90();

    BoardGoodDTO findBest80();

    BoardGoodDTO findBest70();
}
