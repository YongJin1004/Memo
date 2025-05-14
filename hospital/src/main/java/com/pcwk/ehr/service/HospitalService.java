package com.pcwk.ehr.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.hospital.domain.HospitalVO;

public interface HospitalService {
	
	int doSave(HospitalVO inVO) throws SQLException;
	
	HospitalVO doSelectOne(String hospital_id) throws SQLException, NullPointerException;
	
	int doUpdate(HospitalVO inVO) throws SQLException;
	
	int doDelete(String hospital_id) throws SQLException;
	
	List<HospitalVO> doRetrieve(DTO dto);
	
	int getCount() throws SQLException;

	int getCountByCondition(String gu, String hospital_div) throws SQLException;
	
	List<HospitalVO> findGu() throws SQLException;
	
	List<HospitalVO> findHospitalDiv() throws SQLException;
	
	List<HospitalVO> findByGuAndDiv(DTO dto, String gu, String hospital_div) throws SQLException;
}
