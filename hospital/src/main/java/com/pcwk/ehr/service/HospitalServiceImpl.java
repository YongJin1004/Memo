package com.pcwk.ehr.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.dao.HospitalDao;
import com.pcwk.ehr.hospital.domain.HospitalVO;

@Service
public class HospitalServiceImpl implements HospitalService{
	
	final Logger log = LogManager.getLogger(getClass());
	
	@Autowired
	HospitalDao hospdao;
	
	public HospitalServiceImpl() {

	}

	@Override
	public int doSave(HospitalVO inVO) throws SQLException {
		return hospdao.doSave(inVO);
	}

	@Override
	public HospitalVO doSelectOne(String hospital_id) throws SQLException, NullPointerException {
		return hospdao.doSelectOne(hospital_id);
	}

	@Override
	public int doUpdate(HospitalVO inVO) throws SQLException {
		return hospdao.doUpdate(inVO);
	}

	@Override
	public int doDelete(String hospital_id) throws SQLException {
		return hospdao.doDelete(hospital_id);
	}

	@Override
	public List<HospitalVO> doRetrieve(DTO dto) {
		return hospdao.doRetrieve(dto);
	}

	@Override
	public int getCount() throws SQLException {
		return hospdao.getCount();
	}

	@Override
	public List<HospitalVO> findGu() throws SQLException {
		return hospdao.findGu();
	}

	@Override
	public List<HospitalVO> findHospitalDiv() throws SQLException {
		return hospdao.findHospitalDiv();
	}

	@Override
	public List<HospitalVO> findByGuAndDiv(DTO dto, String gu, String hospital_div) throws SQLException {
		return hospdao.findByGuAndDiv(dto, gu, hospital_div);
	}

	@Override
	public int getCountByCondition(String gu, String hospital_div) throws SQLException {
		return hospdao.getCountByCondition(gu, hospital_div);
	}
	
	
	
}
