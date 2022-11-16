package kr.co.seoulit.account.sys.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.seoulit.account.sys.base.service.BaseService;
import kr.co.seoulit.account.sys.base.service.BaseServiceImpl;
import kr.co.seoulit.account.sys.base.to.CodeBean;
import kr.co.seoulit.account.sys.base.to.DetailCodeBean;
import kr.co.seoulit.account.sys.common.exception.DataAccessException;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/base")
public class CodeListController{
	@Autowired
    private BaseService baseService;
	   
	@PostMapping("/detailcodelist")
 public ArrayList<DetailCodeBean> findDetailCodeList(@RequestBody DetailCodeBean detailCodeBean) {
     
         ArrayList<DetailCodeBean> detailCodeList = baseService.findDetailCodeList(detailCodeBean);
       
     return detailCodeList;

 }
	@GetMapping("/codelist")
 public ArrayList<CodeBean> findCodeList() {
     
         ArrayList<CodeBean> codeList = baseService.findCodeList();

         
     return codeList;
 }
}
