package com.pcwk.ehr.controller;

import com.pcwk.ehr.dto.kakao.KakaoDTO;
import com.pcwk.ehr.service.KakaoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/kakao")
@RequiredArgsConstructor
public class KakaoController {


    @GetMapping("/test")
    public String kakao() {
        return "test";
    }

}
