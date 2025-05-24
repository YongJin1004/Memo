package com.pcwk.ehr.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/kakao")
@RequiredArgsConstructor
public class KakaoController {


    @GetMapping("/polygon")
    public String kakao() {
        return "polygon";
    }

}
