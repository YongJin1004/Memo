package com.pcwk.ehr.hospital.domain;

import com.pcwk.ehr.cmn.DTO;

public class HospitalVO extends DTO{
	
	public String hospital_id       ;
	public String hospital_name     ;
	public String hospital_addr     ;
	public String hospital_div      ; //병원 종류 (ex: 한의원, 의원, 치과의원, 한방병원)
	public String hospital_etc      ; //특이사항
	public String hospital_mapimg   ; //근처 위치
	public String hospital_tel      ; 
	public String hospital_lon      ; //경도
	public String hospital_lat      ; //위도
	public String hospital_time_mon ;
	public String hospital_time_tue ;
	public String hospital_time_wed ;
	public String hospital_time_thu ;
	public String hospital_time_fri ;
	public String hospital_time_sat ;
	public String hospital_time_sun ;
	public String hospital_time_hol ; //공휴일
	
	public String hospital_gu;
	
	public HospitalVO() {

	}

	public String getHospital_gu() {
		return hospital_gu;
	}



	public void setHospital_gu(String hospital_gu) {
		this.hospital_gu = hospital_gu;
	}



	public String getHospital_id() {
		return hospital_id;
	}


	public void setHospital_id(String hospital_id) {
		this.hospital_id = hospital_id;
	}


	public String getHospital_name() {
		return hospital_name;
	}


	public void setHospital_name(String hospital_name) {
		this.hospital_name = hospital_name;
	}


	public String getHospital_addr() {
		return hospital_addr;
	}


	public void setHospital_addr(String hospital_addr) {
		this.hospital_addr = hospital_addr;
	}


	public String getHospital_div() {
		return hospital_div;
	}


	public void setHospital_div(String hospital_div) {
		this.hospital_div = hospital_div;
	}


	public String getHospital_etc() {
		return hospital_etc;
	}


	public void setHospital_etc(String hospital_etc) {
		this.hospital_etc = hospital_etc;
	}


	public String getHospital_mapimg() {
		return hospital_mapimg;
	}


	public void setHospital_mapimg(String hospital_mapimg) {
		this.hospital_mapimg = hospital_mapimg;
	}


	public String getHospital_tel() {
		return hospital_tel;
	}


	public void setHospital_tel(String hospital_tel) {
		this.hospital_tel = hospital_tel;
	}


	public String getHospital_lon() {
		return hospital_lon;
	}


	public void setHospital_lon(String hospital_lon) {
		this.hospital_lon = hospital_lon;
	}


	public String getHospital_lat() {
		return hospital_lat;
	}


	public void setHospital_lat(String hospital_lat) {
		this.hospital_lat = hospital_lat;
	}


	public String getHospital_time_mon() {
		return hospital_time_mon;
	}


	public void setHospital_time_mon(String hospital_time_mon) {
		this.hospital_time_mon = hospital_time_mon;
	}


	public String getHospital_time_tue() {
		return hospital_time_tue;
	}


	public void setHospital_time_tue(String hospital_time_tue) {
		this.hospital_time_tue = hospital_time_tue;
	}


	public String getHospital_time_wed() {
		return hospital_time_wed;
	}


	public void setHospital_time_wed(String hospital_time_wed) {
		this.hospital_time_wed = hospital_time_wed;
	}


	public String getHospital_time_thu() {
		return hospital_time_thu;
	}


	public void setHospital_time_thu(String hospital_time_thu) {
		this.hospital_time_thu = hospital_time_thu;
	}


	public String getHospital_time_fri() {
		return hospital_time_fri;
	}


	public void setHospital_time_fri(String hospital_time_fri) {
		this.hospital_time_fri = hospital_time_fri;
	}


	public String getHospital_time_sat() {
		return hospital_time_sat;
	}


	public void setHospital_time_sat(String hospital_time_sat) {
		this.hospital_time_sat = hospital_time_sat;
	}


	public String getHospital_time_sun() {
		return hospital_time_sun;
	}


	public void setHospital_time_sun(String hospital_time_sun) {
		this.hospital_time_sun = hospital_time_sun;
	}


	public String getHospital_time_hol() {
		return hospital_time_hol;
	}


	public void setHospital_time_hol(String hospital_time_hol) {
		this.hospital_time_hol = hospital_time_hol;
	}

	@Override
	public String toString() {
		return "HospitalVO [hospital_id=" + hospital_id + ", hospital_name=" + hospital_name + ", hospital_addr="
				+ hospital_addr + ", hospital_div=" + hospital_div + ", hospital_etc=" + hospital_etc
				+ ", hospital_mapimg=" + hospital_mapimg + ", hospital_tel=" + hospital_tel + ", hospital_lon="
				+ hospital_lon + ", hospital_lat=" + hospital_lat + ", hospital_time_mon=" + hospital_time_mon
				+ ", hospital_time_tue=" + hospital_time_tue + ", hospital_time_wed=" + hospital_time_wed
				+ ", hospital_time_thu=" + hospital_time_thu + ", hospital_time_fri=" + hospital_time_fri
				+ ", hospital_time_sat=" + hospital_time_sat + ", hospital_time_sun=" + hospital_time_sun
				+ ", hospital_time_hol=" + hospital_time_hol + ", hospital_gu=" + hospital_gu + ", getNo()=" + getNo()
				+ ", getTotalCnt()=" + getTotalCnt() + "]";
	}

}
