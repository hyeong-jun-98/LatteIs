package com.academy.latteis.board.service;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.repository.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    public boolean writeService(Board board){
        log.info("save service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.write(board);

        return flag;
    }
}
