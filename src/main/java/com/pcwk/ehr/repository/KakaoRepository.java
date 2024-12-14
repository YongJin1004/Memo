package com.pcwk.ehr.repository;

import com.pcwk.ehr.dto.kakao.KakaoDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface KakaoRepository {
    List<KakaoDTO> findLocationByCountry();
}
