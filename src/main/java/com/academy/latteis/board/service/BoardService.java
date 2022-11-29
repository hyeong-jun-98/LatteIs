package com.academy.latteis.board.service;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardConvertDTO;
import com.academy.latteis.board.dto.BoardGoodDTO;
import com.academy.latteis.board.dto.ValidateUserDTO;
import com.academy.latteis.board.repository.BoardMapper;
import com.academy.latteis.comment.repository.CommentMapper;
import com.academy.latteis.common.search.Search;
import com.academy.latteis.good.repository.GoodMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    private final CommentMapper commentMapper;
    private final GoodMapper goodMapper;

    // 게시글 작성
    @Transactional
    public boolean writeFreeService(Board board) {
        log.info("save free service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.writeFree(board);

        // 첨부파일 저장
        List<String> fileNames = board.getFileNames();
        log.info("fileNames is {}", fileNames);
        if (fileNames != null && fileNames.size() > 0) {
            for (String fileName : fileNames) {
                // 첨부파일 내용 DB에 저장
                boardMapper.addFile(fileName);
            }
        }

        return flag;
    }

    @Transactional
    public boolean writeGenerationService(Board board) {
        log.info("save generation service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.writeGeneration(board);

        // 첨부파일 저장
        List<String> fileNames = board.getFileNames();
        if (fileNames != null && fileNames.size() > 0) {
            for (String fileName : fileNames) {
                // 첨부파일 내용 DB에 저장
                boardMapper.addFile(fileName);
            }
        }

        return flag;
    }

    public boolean writeKeywordService(Board board) {
        boolean flag = boardMapper.writeKeyword(board);
        return flag;
    }

    // 게시글 전체 조회
    public Map<String, Object> findAllFreeService(Search search) {
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<BoardConvertDTO> boardList = boardMapper.findAllFree(search);

        // 반복문 돌려서 boardList 안에 있는 게시글에 각각 좋아요 정보를 넣어줌
        for (BoardConvertDTO b : boardList) {
            b.setGood((long) goodMapper.goodCnt(b.getBoardNo()));
        }

        // 목록 중간 데이터 처리
        processConverting(boardList);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCountFree(search));
        return findDataMap;
    }

    public Map<String, Object> findAllGenerationService(Search search, Long generation) {
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<BoardConvertDTO> boardList = boardMapper.findAllGeneration(search, generation);

        // 반복문 돌려서 boardList 안에 있는 게시글에 각각 좋아요 정보를 넣어줌
        for (BoardConvertDTO b : boardList) {
            b.setGood((long) goodMapper.goodCnt(b.getBoardNo()));
        }

        // 목록 중간 데이터 처리
        processConverting(boardList);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCountGeneration(search));
        return findDataMap;
    }

    public Map<String, Object> findAllKeywordService(Search search, Long topicNo) {
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<BoardConvertDTO> boardList = boardMapper.findAllKeyword(search, topicNo);

        for (BoardConvertDTO b : boardList) {
            b.setGood((long) goodMapper.goodCnt(b.getBoardNo()));
        }

        // 목록 중간 데이터 처리
        processConverting(boardList);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCountGeneration(search));
        return findDataMap;
    }

    private void processConverting(List<BoardConvertDTO> boardList) {
        for (BoardConvertDTO b : boardList) {
            convertDateFormat(b);
            substringTitle(b);
            setCommentCount(b);
            checkNewPost(b);
        }
    }

    // 날짜 형식 초기화 메소드
    private void convertDateFormat(BoardConvertDTO b) {
        Date date = b.getRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd a hh:mm");
        b.setPrettierDate(sdf.format(date));
    }

    // 제목 단축 메소드
    private void substringTitle(BoardConvertDTO b) {
        // 만약에 글제목이 10글자 이상이라면
        // 10글자만 보여주고 나머지는 ... 처리
        String title = b.getTitle();
        if (title.length() > 10) {
            String subStr = title.substring(0, 10);
            b.setShortTitle(subStr + "...");
        } else {
            b.setShortTitle(title);
        }
    }

    // 신규 게시물 여부
    private void checkNewPost(BoardConvertDTO b) {
        // 게시물의 작성일자와 현재 시간을 비교해서 신규 게시물인지를 판단한다

        // 게시물의 작성시간
        long regDateTime = b.getRegdate().getTime();

        // 현재 시간 얻기
        long currTime = System.currentTimeMillis();

        // 현재 시간에서 게시물 뺌
        long diff = currTime - regDateTime;

        // 신규 게시물 제한 시간
        long limitTime = 60 * 5 * 1000;

        if (diff < limitTime) {
            b.setNewPost(true);
        }
    }

    // 댓글 수 가져오기
    private void setCommentCount(BoardConvertDTO b) {
        b.setCommentCount(commentMapper.getCommentCount(b.getBoardNo()));
    }

    // 게시글 상세보기
    public List<BoardGoodDTO> findOneService(Long boardNo, HttpServletResponse response, HttpServletRequest request) {
        log.info("findOne service start- {}", boardNo);

        List<BoardGoodDTO> boardList = boardMapper.findOne(boardNo);
        log.info("findOne service end- {}", boardNo);
        // 해당 게시물 번호에 해당하는 쿠키가 있는지 확인
        // 쿠키가 없으면 조회수를 상승시켜주고 쿠키를 만들어서 클라이언트에 전송
        makeHit(boardNo, response, request);

        return boardList;
    }
    public Map<String, Object> findBestBoard(){
        Map <String, Object> findBest = new HashMap<>();
        findBest.put("free", boardMapper.findBestFree());
        findBest.put("key", boardMapper.findBestKey());
        findBest.put("gene00", boardMapper.findBest00());
        findBest.put("gene90", boardMapper.findBest90());
        findBest.put("gene80", boardMapper.findBest80());
        findBest.put("gene70", boardMapper.findBest70());

        return findBest;
    }

    // 조회수 상승 처리
    private void makeHit(Long boardNo, HttpServletResponse response, HttpServletRequest request) {
        // 먼저 쿠키를 조회함 => 해당 이름의 쿠키가 있으면 쿠키가 들어올 것이고, 없다면 null이 들어올 것임
        Cookie foundCookie = WebUtils.getCookie(request, "b" + boardNo);

        if (foundCookie == null) {   // 쿠키가 없다면~~
            boardMapper.upHit(boardNo); // 조회수 상승 시키고
            Cookie cookie = new Cookie("b" + boardNo, String.valueOf(boardNo));   // 쿠키 생성
            cookie.setMaxAge(60);   // 쿠키 수명을 1분으로 설정
            cookie.setPath("/");   // 쿠키 작동 범위

            response.addCookie(cookie);   // 클라이언트에게 쿠키 전송
        }
    }

    // 게시글 삭제
    @Transactional
    public boolean removeService(Long boardNo) {
        log.info("remove service start");

        // 댓글 먼저 모두 삭제
        commentMapper.removeByBoardNo(boardNo);

        // 좋아요도 삭제
        goodMapper.removeByBoardNo(boardNo);

        // 첨부파일도 삭제
        boardMapper.deleteFile(boardNo);

        // 원본 게시물 삭제
        boolean flag = boardMapper.remove(boardNo);
        return flag;
    }

    // 게시글 수정
    @Transactional
    public boolean editService(Board board) {
        log.info("edit service start");
        boolean flag = boardMapper.edit(board);

        // 첨부파일 저장
        List<String> fileNames = board.getFileNames();
        log.info("fileNames is {}", fileNames);

        if (fileNames != null && fileNames.size() > 0) {
            // 첨부파일 DB에서 삭제 후
            boardMapper.deleteFile(board.getBoardNo());

            for (String fileName : fileNames) {
                log.info("파일 이름은 {}", fileName);
                // 첨부파일 내용 DB에 저장
                boardMapper.addFileByEdit(fileName, board.getBoardNo());
            }
        } else if(fileNames == null){   // 게시글 수정 시, 이미지가 없으면
            // 수정했을 때, 사진이 아무것도 없다는 뜻이니까 첨부파일 DB에서 전부 삭제
            boardMapper.deleteFile(board.getBoardNo());
        }
        return flag;
    }

    // 게시글 번호로 작성자 회원정보 가져오기
    public ValidateUserDTO getUser(Long boardNo) {
        return boardMapper.findUserByBoardNo(boardNo);
    }

    // 첨부파일 목록 가져오기
    public List<String> getFiles(Long boardNo) {
        return boardMapper.findFileNames(boardNo);
    }
}
