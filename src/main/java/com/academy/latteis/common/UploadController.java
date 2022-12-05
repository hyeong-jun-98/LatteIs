package com.academy.latteis.common;

import com.academy.latteis.util.FileUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@Log4j2
public class UploadController {

    // 업로드 파일 저장 경로
    private static final String UPLOAD_PATH = "/usr/local/upload";

    // 비동기 요청 파일 업로드 처리
    @PostMapping("/ajax-upload")
    @ResponseBody
    public ResponseEntity<List<String>> ajaxUpload(List<MultipartFile> files, String fileName) {
        log.info("/ajax-upload POST! - {}, {}", files.get(0), fileName);

        // 클라이언트에게 전송할 파일경로 리스트
        List<String> fileNames = new ArrayList<>();

        // 클라이언트가 전송한 파일 업로드하기
        for (MultipartFile file : files) {
            String fullPath = FileUtils.uploadFile(file, UPLOAD_PATH);
            fileNames.add(fullPath);
        }

        return new ResponseEntity<>(fileNames, HttpStatus.OK);
    }

    // 파일 데이터 로드 요청 처리
    /*
     * 비동기 통신 응답시 ResponseEntity를 쓰는 이유는
     * 이 객체를 응답 body정보 이외에도 header정보를 포함할 수 있고
     * 추가로 응답 상태코드도 제어 가능하다
     * */
    @GetMapping("/loadFile")
    @ResponseBody
    public ResponseEntity<byte[]> loadFile(String fileName) {
        log.info("/loadFile GET - {}", fileName);

        // 클라이언트가 요청하는 파일의 진짜 바이트 데이터를 갖다줘야함

        // 1. 요청 파일을 찾아서 file객체로 포장
        File f = new File(UPLOAD_PATH + fileName);
        if (!f.exists()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        // 2. 해당 파일을 InputStream을 통해 불러온다
        try (FileInputStream fis = new FileInputStream(f)) {

            // 3. 클라이언트에게 순수 이미지를 응답해야 하므로 MIME TYPE을 응답헤더에 설정
            // ex) image/jpeg, image/png, image/gif
            // 확장자를 추출해야함
            String ext = FileUtils.getFileExtension(fileName);  // 확장자를 추출
            MediaType mediaType = FileUtils.getMediaType(ext);  // 미디어 타입 추출

            // 응답 헤더에 미디어 타입 설정
            HttpHeaders headers = new HttpHeaders();
            if (mediaType != null) {     // 이미지라면
                headers.setContentType(mediaType);
            } else {    // 이미지가 아니라면 다운로드 가능하게 설정
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

                // 파일명을 원래대로 복구
                fileName = fileName.substring(fileName.lastIndexOf("_") + 1);

                // 파일명이 한글인 경우 인코딩 재설정
                String encoding = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");

                // 헤더에 위 내용들 추가
                headers.add("Content-Disposition"
                        , "attachment; fileName=\"" + encoding + "\"");
            }

            // 4. 파일 순수데이터 바이트 배열에 저장
            byte[] rawData = IOUtils.toByteArray(fis);

            // 5. 비동기통신에서 데이터 응답할 때 ResponseEntity 객체를 사용
            return new ResponseEntity<>(rawData, headers, HttpStatus.OK);   // 클라이언트에 파일 데이터 응답

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    // 서버에 있는 파일 삭제 요청처리
    @DeleteMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){
        log.info("/deleteFile DELETE! - {}", fileName);
        try {
            File delFile = new File(UPLOAD_PATH + fileName);
            if (!delFile.exists()) return new ResponseEntity<>(HttpStatus.OK);

            delFile.delete();

            return new ResponseEntity<>("file-del-success", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
