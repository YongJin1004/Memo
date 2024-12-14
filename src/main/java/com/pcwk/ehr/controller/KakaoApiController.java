package com.pcwk.ehr.controller;

import com.pcwk.ehr.dto.kakao.KakaoDTO;
import com.pcwk.ehr.service.KakaoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/kakao")
@RequiredArgsConstructor
public class KakaoApiController {

    private final KakaoService kakaoService;
    @GetMapping("/find/location")
    public List<KakaoDTO> findLocation() {
        return kakaoService.findLocationByCountry();
    }
}
