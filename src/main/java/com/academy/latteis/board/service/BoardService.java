package com.academy.latteis.board.service;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.repository.BoardMapper;
import com.academy.latteis.common.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    // 게시글 작성
    public boolean writeService(Board board){
        log.info("save service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.write(board);

        return flag;
    }

    // 게시글 전체 조회
    public Map<String, Object> findAllService(Page page){
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<Board> boardList = boardMapper.findAll(page);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCount());
        return findDataMap;
    }

    // 게시글 상세보기
    public Board findOneService(Long boardNo){
        log.info("findOne service start");

        Board board = boardMapper.findOne(boardNo);
        return board;
    }

    // 게시글 삭제
    public boolean removeService(Long boardNo){
        log.info("remove service start");
        boolean flag = boardMapper.remove(boardNo);
        return flag;
    }

    // 게시글 수정
    public boolean editService(Board board){
        log.info("edit service start");
        boolean flag=boardMapper.edit(board);
        return flag;
    }


}
