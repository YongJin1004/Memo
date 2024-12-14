package com.pcwk.ehr.dto.kakao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class KakaoDTO {

    private double WGS84LAT; // 경도
    private double WGS84LON; // 위도

}
