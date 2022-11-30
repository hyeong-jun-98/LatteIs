package com.academy.latteis.board.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class EditBoardDTO {
    private Long boardNo;
    private String title;
    private String writer;
    private String content;

    private List<MultipartFile> files;
    private List<String> editFileNames;
    private String editFileName;
}
