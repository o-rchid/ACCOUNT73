package kr.co.seoulit.account.posting.business.controller;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import kr.co.seoulit.account.posting.business.service.BusinessService;
import kr.co.seoulit.account.posting.business.service.BusinessServiceImpl;
import kr.co.seoulit.account.posting.business.to.JournalDetailBean;
import kr.co.seoulit.account.sys.common.exception.DataAccessException;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/posting")
public class JournalDetailController {

	@Autowired
	private BusinessService businessService;

	ModelAndView mav = null;
	ModelMap map = new ModelMap();

	@GetMapping("/journaldetaillist")
	public ArrayList<JournalDetailBean> findJournalDetailList(@RequestParam String journalNo) {
//		System.out.println(journalNo);
		ArrayList<JournalDetailBean> journalDetailList = businessService.findJournalDetailList(journalNo);

		return journalDetailList;
	}

	@PostMapping("/journaldetailmodification")
	public void modifyJournalDetail(@RequestBody JournalDetailBean journalDetailBean){

		businessService.modifyJournalDetail(journalDetailBean);

	}
//        여기 modify 인데 리턴값이 있고 그 런턴을 반환하지도 않음 이상함(choi)

}
