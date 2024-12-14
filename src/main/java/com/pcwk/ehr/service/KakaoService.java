package com.pcwk.ehr.service;

import com.pcwk.ehr.dto.kakao.KakaoDTO;
import com.pcwk.ehr.repository.KakaoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class KakaoService {

    private final KakaoRepository kakaoRepository;

    public List<KakaoDTO> findLocationByCountry() {
        return kakaoRepository.findLocationByCountry();

    }
}
