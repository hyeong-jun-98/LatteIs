package com.academy.latteis.board.service;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardConvertDTO;
import com.academy.latteis.board.repository.BoardMapper;
import com.academy.latteis.common.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    // 게시글 작성
    public boolean writeService(Board board) {
        log.info("save service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.write(board);

        return flag;
    }

    // 게시글 전체 조회
    public Map<String, Object> findAllService(Page page) {
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<BoardConvertDTO> boardList = boardMapper.findAll(page);

        // 목록 중간 데이터 처리
        processConverting(boardList);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCount());
        return findDataMap;
    }

    private void processConverting(List<BoardConvertDTO> boardList) {
        for (BoardConvertDTO b : boardList) {
            convertDateFormat(b);
            substringTitle(b);
        }
    }

    // 날짜 형식 초기화 메소드
    private void convertDateFormat(BoardConvertDTO b){
        Date date = b.getRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd a hh:mm");
        b.setPrettierDate(sdf.format(date));
    }

    // 제목 단축 메소드
    private void substringTitle(BoardConvertDTO b){
        // 만약에 글제목이 10글자 이상이라면
        // 10글자만 보여주고 나머지는 ... 처리
        String title = b.getTitle();
        if (title.length()> 10){
            String subStr = title.substring(0, 10);
            b.setShortTitle(subStr + "...");
        }else {
            b.setShortTitle(title);
        }
    }

    // 게시글 상세보기
    public Board findOneService(Long boardNo) {
        log.info("findOne service start");

        Board board = boardMapper.findOne(boardNo);
        return board;
    }

    // 게시글 삭제
    public boolean removeService(Long boardNo) {
        log.info("remove service start");
        boolean flag = boardMapper.remove(boardNo);
        return flag;
    }

    // 게시글 수정
    public boolean editService(Board board) {
        log.info("edit service start");
        boolean flag = boardMapper.edit(board);
        return flag;
    }


}
