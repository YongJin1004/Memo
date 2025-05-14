package com.pcwk.ehr.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.SearchVO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.hospital.domain.HospitalVO;
import com.pcwk.ehr.service.HospitalService;

@Controller
@RequestMapping("hospital")
public class HospitalController {

	final Logger log = LogManager.getLogger(getClass());

	@Qualifier("hospitalServiceImpl")
	@Autowired
	private HospitalService hospService;

	public HospitalController() {
		log.debug("┌─────────────────────────────────────────┐");
		log.debug("│ **HospitalController**                  │");
		log.debug("└─────────────────────────────────────────┘");
	}

	@GetMapping("hospital_reg_index")
	public String hospitalRegIndex() {
		log.debug("hospitalRegIndex method called");
		return "hospital/hospital_reg";
	}


	@GetMapping("/hospital/{name}")
	public String getHospitalDetails(@PathVariable("id") String hospitalId, Model model) throws Exception {
		log.debug("doSeleteOne - hospitalId:{}", hospitalId);
		HospitalVO hospital = hospService.doSelectOne(hospitalId);

		model.addAttribute("hospital", hospital);
		return "hospital/hospital_mng";
	}

	@PutMapping("/hospital")
	@ResponseBody
	public String updateHospital(@Validated @RequestBody HospitalVO hospital) throws SQLException {
		log.debug("doUpdate - hospital:{}", hospital);

		int flag = hospService.doUpdate(hospital);

		String message = generateMessage(hospital.getHospital_name(), flag, "수정");

		log.debug("doUpdate result - flag:{}, message:{}", flag, message);
		return new Gson().toJson(new MessageVO(flag, message));
	}


	@DeleteMapping("/hospital/{name}")
	@ResponseBody
	public String deleteHospital(@PathVariable("id") String hospitalId) throws Exception {
		log.debug("doDelete - hospital:{}", hospitalId);
		int flag = hospService.doDelete(hospitalId);

		String message = generateMessage(hospitalId, flag, "삭제");

		log.debug("doDelete result - flag:{}, message:{}", flag, message);
		return new Gson().toJson(new MessageVO(flag, message));
	}

	@RequestMapping(value = "/hospital", method = RequestMethod.POST)
	@ResponseBody
	public String saveHospital(@Validated @RequestBody HospitalVO hospital) throws SQLException {
		log.debug("doSave - hospital:{}", hospital);

		int flag = hospService.doSave(hospital);

		String message = generateMessage(hospital.getHospital_name(), flag, "등록");

		log.debug("doSave result - flag:{}, message:{}", flag, message);
		return new Gson().toJson(new MessageVO(flag, message));

	}

	@GetMapping("/hospital/list")
	public String doRetrieve(HttpServletRequest req, Model model) throws Exception {
		String viewName = "hospital/hospital_list";
		SearchVO search = new SearchVO();

		log.debug("doRetrieve - hospital");

		String pageNoString = StringUtil.nvl(req.getParameter("pageNo"), "1");
		String pageSizeString = StringUtil.nvl(req.getParameter("pageSize"), "10");

		int pageNo = Integer.parseInt(pageNoString);
		int pageSize = Integer.parseInt(pageSizeString);

		search.setPageNo(pageNo);
		search.setPageSize(pageSize);

		log.debug("PageNo: {}, PageSize: {}", pageNo, pageSize);

		List<HospitalVO> list = hospService.doRetrieve(search);
		List<HospitalVO> guList = hospService.findGu();
		List<HospitalVO> hospitalDivList = hospService.findHospitalDiv();

		int totalCnt = hospService.getCount();

		log.debug("totalCnt: {}", totalCnt);
		log.debug("guList: {}", guList);
		log.debug("hospitalDivList: {}", hospitalDivList);

		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		model.addAttribute("guList", guList);
		model.addAttribute("hospitalDivList", hospitalDivList);

		return viewName;
	}

	@GetMapping("/hospital/find/condition")
	@ResponseBody
	public Map<String, Object> findByGuAndDiv(@RequestParam(value = "gu", required = false) String gu,
											  @RequestParam(value = "hospitalDiv", required = false) String hospitalDiv,
											  HttpServletRequest req) throws Exception {
		SearchVO search = new SearchVO();

		log.debug("doRetrieve - hospital");

		String pageNoString = StringUtil.nvl(req.getParameter("pageNo"), "1");
		String pageSizeString = StringUtil.nvl(req.getParameter("pageSize"), "10");

		int pageNo = Integer.parseInt(pageNoString);
		int pageSize = Integer.parseInt(pageSizeString);

		search.setPageNo(pageNo);
		search.setPageSize(pageSize);  

		log.debug("PageNo: {}, PageSize: {}", pageNo, pageSize);
  
		List<HospitalVO> list = hospService.findByGuAndDiv(search, gu, hospitalDiv);

		int totalCnt = hospService.getCountByCondition(gu, hospitalDiv);

		log.debug("totalCnt: {}\n", totalCnt);
		log.debug("list: {}\n", list);

		Map<String, Object> response = new HashMap<>();
		response.put("totalCnt", totalCnt);	
		response.put("list", list);

		return response;
	}


	
	//메세지
	private String generateMessage(String hospitalId, int flag, String action) {
	    return flag == 1 ? hospitalId + "가 " + action + "되었습니다.": hospitalId + "가 " + action + "되지 않았습니다.";
	}
	
}
