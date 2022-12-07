package com.academy.latteis.board.domain;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Board {
    private Long boardNo;
    private String title;
    private String writer;
    private String content;
    private Date regdate;
    private Long hit;
    private Long good;
    private String userNickname;
    private Long generation;
    private String topicName;

    private List<MultipartFile> files;
    private List<String> editFileNames;


}
