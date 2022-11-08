package com.academy.latteis;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
@Log4j2
public class HomeController {

    @GetMapping("/")
    public String home(Model model, HttpSession session){
        log.info("LatteIs에 오신 걸 환영합니다!!");
        return "index";
    }
}
